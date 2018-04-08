//
//  KeyViewController.m
//  ITherm
//
//  Created by Anveshak on 3/31/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import "KeyViewController.h"
#import "AbsViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "KeyAgendaTableViewCell.h"
#import "KeyAgenda.h"
#import "Constant.h"
@interface KeyViewController ()

@end

@implementation KeyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"In VIEW did load ....");
    [_indicator startAnimating];
    _que=[[NSOperationQueue alloc]init];
    
    self.images.layer.masksToBounds=YES;
    self.images.layer.borderColor=[UIColor blackColor].CGColor;
    self.images.layer.borderWidth=1.1;
    self.images.layer.shadowColor=[UIColor redColor].CGColor;
    
    self.images.layer.cornerRadius = self.images.frame.size.width / 2;
    self.images.clipsToBounds = YES;
    
    [self getLikes];
    [self getCommentCount];
    [self getComments];
    
    [self keynoteparsing];
    [self keynoteparsing1];
    
    _tableView.delegate=self;
    _tableView.dataSource=self;
    
    _imgarr=[[NSMutableArray alloc]init];
    _commentarr=[[NSMutableArray alloc]init];
    _usernamearr=[[NSMutableArray alloc]init];
    _datearr=[[NSMutableArray alloc]init];
    
    _comments.delegate =self;
    _keynotecommentarr=[[NSMutableArray alloc]init];
    
    self.session_id.text=self.sessionidstr;
    self.location.text=self.locationstr;
    self.starttime.text=self.starttimestr;
    self.endtime.text=self.endtimestr;
    self.session_name.text=self.keynotetiltestr;

    NSLog(@"absssss  KEY==%@",_abstractstr);
    
    [[NSUserDefaults standardUserDefaults]setValue:self.starttimestr forKey:@"keystarttime"];
    NSLog(@"keystarttime = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"keystarttime"]);
    
    [[NSUserDefaults standardUserDefaults]setValue:self.endtimestr forKey:@"keyendtime"];
    NSLog(@"keyendtime = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"keyendtime"]);
    
    [[NSUserDefaults standardUserDefaults]setValue:self.locationstr forKey:@"keylocation"];
    NSLog(@"keylocation = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"keylocation"]);

    
    [[NSUserDefaults standardUserDefaults]setValue:self.sessionidstr forKey:@"sessionid"];
    NSLog(@"sessionid = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"]);
   
    _popUpView.hidden=YES;
    self.popUpView.layer.cornerRadius = 5;
    self.popUpView.layer.shadowOpacity = 0.8;
    self.popUpView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    
    [self.tableView setSeparatorColor:[UIColor clearColor]];
    
    _comments.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    _comments.layer.borderWidth=1.0;
    
    self.postBtn.layer.masksToBounds=YES;
    self.postBtn.layer.borderColor=[UIColor colorWithRed:20.0/255.0 green:72.0/255.0 blue:114.0/255.0 alpha:1.0].CGColor;
    self.postBtn.layer.borderWidth=1.1;
    self.postBtn.layer.cornerRadius=5;
    
    
    
    self.viewMap.layer.masksToBounds=YES;
    self.viewMap.layer.borderColor=[UIColor colorWithRed:20.0/255.0 green:72.0/255.0 blue:114.0/255.0 alpha:1.0].CGColor;
    self.viewMap.layer.borderWidth=1.1;
    self.viewMap.layer.cornerRadius=10;
}

-(void)viewWillAppear:(BOOL)animated
{
    
    NSLog(@"In VIEW will appear....");

    int i=[_indxpath intValue];
    NSString *tempimgstr=[_kimgarray objectAtIndex:i];
    
    [_images sd_setImageWithURL:[NSURL URLWithString:tempimgstr]
                 placeholderImage:[UIImage imageNamed:@"default.png"]];

    [_indicator stopAnimating];
    
    [self.tableView reloadData];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"showKeydescAbs"])
    {
        AbsViewController *ab=[segue destinationViewController];
        ab.absStr=_abstract.text;
    }
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _keynotecommentarr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    KeyAgendaTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    KeyAgenda *ktemp=[_keynotecommentarr objectAtIndex:indexPath.row];
    
    cell.name.text=ktemp.name;
    cell.comments.text=ktemp.comments;
    cell.date1.text=ktemp.date1;
//    NSString *kImgLink=[_imgarr objectAtIndex:indexPath.row];
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        // retrive image on global queue
//        UIImage * img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:kImgLink]]];
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            
//            // assign cell image on main thread
//            cell.images.image = img;
//        });
//    });
    
    NSLog(@"keynote commentss ==== %@",cell.comments);
    NSLog(@"comment date ==== %@",cell.date1);
    
    
    [_indicator stopAnimating];
    
    return cell;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return  YES;
}
- (IBAction)addComments:(id)sender {
    
    NSString *emailid=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
    if (emailid==NULL) {
        UIAlertController * alert=[UIAlertController
                                   
                                   alertControllerWithTitle:@"Alert!" message:@"Please login to add comments"preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"OK"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action)
                                    {
                                        NSLog(@"you pressed ok, please button");
                                        
                                    }];
        
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    else {
    _tempcomment = _comments.text;
    if(_tempcomment.length!=0)
    {
        _comments.text=@"";
        [self addComment];
    }
    else{
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Alert!" message:@"Please enter comment first" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alertView dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        
        [alertView addAction:ok];
        self.comments.text=@"";
        [self presentViewController:alertView animated:YES completion:nil];
    }
    }
}
-(void)keynoteparsing
{
    
    NSString *savedvalue2=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
    NSString *savedsessionid=[[NSUserDefaults standardUserDefaults]stringForKey:@"sessionid"];
    
    NSString *myst=[NSString stringWithFormat:@"emailid=%@&session_id=%@",savedvalue2,savedsessionid];
    NSLog(@"session_id.......%@",myst);
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:keynote_info]];
    
    // NSURL * url = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/keynote_info.php"];//local
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSURLSessionDataTask *task=[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                {
                                    
                                    if(data==nil)
                                    {
                                        NSLog(@"Data is nil");
                                    }
                                    else
                                    {
                                        NSLog(@"%@",response);
                                        NSDictionary *outerdic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                        
                                        
                                        NSArray *keyarr=[outerdic objectForKey:@"keynotes"];
                                        
                                        for(NSDictionary *temp in keyarr)
                                        {
                                            NSString *str1=[temp objectForKey:@"session_id"];
                                            NSString *str2=[temp objectForKey:@"added"];
                                            
                                            if([str1 isEqualToString:_tempsessionid])
                                            {
                                                _keynamestr=str1;
                                                _addedstr=str2;
                                                
                                                
                                                if ([_addedstr isEqualToString:@"false"]) {
                                                    NSLog(@"Tempdata is .....");
                                                    [_addMyScheduleBtn setImage:[UIImage imageNamed:@"add-other.png"] forState:UIControlStateNormal];
                                                    [_addMyScheduleBtn setUserInteractionEnabled:YES];
                                                }
                                                else{
                                                    NSLog(@"Show blue tick.......");
                                                    [_addMyScheduleBtn setImage:[UIImage imageNamed:@"added-other.png"] forState:UIControlStateNormal];
                                                    [_addMyScheduleBtn setUserInteractionEnabled:NO];
                                                }
                                                
                                                
                                                
                                                [_indicator stopAnimating];
                                                
                                                
                                            }
                                        }
                                        
                                    }
                                    
                                }];
    [task resume];
    
}
-(void)keynoteparsing1
{

    NSBlockOperation *op1=[NSBlockOperation blockOperationWithBlock:^{
   
    NSURL * urlstr = [NSURL URLWithString:[mainUrl stringByAppendingString:keynote1]];
        
    // NSString *urlstr=@"http://192.168.1.100/phpmyadmin/itherm/keynote1.php";
        
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:urlstr];
    NSURLSessionConfiguration *configuration=[NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session=[NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                {
                                    
                                    if(data==nil)
                                    {
                                        NSLog(@"Data is nil");
                                    }
                                    else
                                    {
                                        NSLog(@"response key==%@",response);
                                        NSDictionary *outerdic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                        
                                        NSArray *keyarr=[outerdic objectForKey:@"keynotes"];
                                       for(NSDictionary *temp in keyarr)
                                        {
                                            NSString *str1=[temp objectForKey:@"name"];
                                            NSString *str2=[temp objectForKey:@"university"];
                                            NSString *str3=[temp objectForKey:@"session_name"];
                                            NSString *str4=[temp objectForKey:@"images"];
                                            NSString *str5=[temp objectForKey:@"abstract"];
                                            NSString *str6=[temp objectForKey:@"session_id"];
                                            
                                            if([str6 isEqualToString:_sessionidstr])
                            {
                            _namestr=str1;
                            _universitystr=str2;
                            _sess_namestr=str3;
                                                
                        if([_abstractstr isEqual:[NSNull null]])
                                                {
                                                    _abstractstr=@"--";
                                                }
                                                else
                                                {
                                   _abstractstr=str5;
                                                }
                                                NSString *tempimgstr=str4;
                                                [_images sd_setImageWithURL:[NSURL URLWithString:tempimgstr]
                                                             placeholderImage:[UIImage imageNamed:@"default.png"]];
                                                [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                                                    _name.text=_namestr;
                                                    
                                                    if([_universitystr isEqual:[NSNull null]])
                                                    {
                                                        _university.text=@"--";
                                                    }
                                                    else
                                                    {
                                                    _university.text=_universitystr;
                                                    }
                                                    
                                                    _session_name.text=_sess_namestr;
                                                    
                                                    if([_abstractstr isEqual:[NSNull null]])
                                                    {
                                                        _abstract.text=@"--";
                                                    }
                                                    else
                                                    {
                            _abstract.text=_abstractstr;
                                                    }
                                                }];
                                            }
                                        }
                                       
                                    }
                                   
                                }];
    [task resume];
  }];
    
    [_que addOperation:op1];
}

-(void)addComment{
    
    NSString *savedValue=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
     NSString *savedsessionid=[[NSUserDefaults standardUserDefaults]stringForKey:@"sessionid"];
    
    //_tempcomment = _comments.text;
    
    NSString *myst=[NSString stringWithFormat:@"emailid=%@&session_id=%@&comment=%@",savedValue,savedsessionid,_tempcomment];
    NSLog(@"my string keynotes add comments=%@",myst);
    
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    
    NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:add_keynote_comment]];
    
   // NSURL *url=[NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/add_keynote_comment.php"];

    
    NSMutableURLRequest *urlrequest=[NSMutableURLRequest requestWithURL:url];
    [urlrequest setHTTPMethod:@"POST"];
    [urlrequest setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
    NSError *error=nil;
    if(error)
    {
        NSLog(@"%@",error.description);
    }
    
    NSURLSessionDataTask *task=[session dataTaskWithRequest:urlrequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                {
                                    if (error)
                                    {
                                        NSLog(@"%@",error.description);
                                    }
                                    NSString *text=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                    NSLog(@"data=%@",text);
                                    NSError *error1=nil;
                                    NSDictionary *responsedict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error1];
                                    if(error1)
                                    {
                                        NSLog(@"error 1 is %@",error1.description);
                                    }
                                    self.success=[responsedict objectForKey:@"success"];
                                    
                                    
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        
                                        if([self.success isEqualToString:@"1"])
                                        {
                                            [self getComments];
                                            [self getCommentCount];
                                            
                                            if([_comments isEqual:[NSNull null]])
                                            {
                                                _comments.text=@"--";
                                            }
                                            else
                                            {
                                                _comments.text=_tempcomment;
                                            }
                                            _tempcomment = _comments.text;
                                  _comments.text=@"";
                                            // [_send setUserInteractionEnabled:NO];
                                            NSLog(@"Success....");
                                            
                                            
                                        }
                                        else
                                        {
                                            NSLog(@"Failure....");
                                            
                                        }
                                    });
                                    
                                    
                                    NSLog(@"json = %@",responsedict);
                                    
                                    
                                }];
    [task resume];
}



-(void)getComments{
    
    [_keynotecommentarr removeAllObjects];
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSString *savedsessionid=[[NSUserDefaults standardUserDefaults]stringForKey:@"sessionid"];
    
    NSString *myst2=[NSString stringWithFormat:@"session_id=%@",savedsessionid];
    
    NSLog(@"GET  Session ID.....:%@",myst2);
    
    NSURL * url2 = [NSURL URLWithString:[mainUrl stringByAppendingString:get_keynote_comments]];
    
  //  NSURL * url2 = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/get_keynote_comments.php"];
  
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url2];
    
    
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[myst2 dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask *task=[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                {
                                    
                                    if(data==nil)
                                    {
                                        NSLog(@"Data is nil");
                                    }
                                    else
                                    {
                                        NSLog(@"%@",response);
                                        
                                        NSDictionary *outerdic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                        
                                        
                                        NSArray *keyarr =[outerdic objectForKey:@"comments"];
                                        
                                        NSLog(@"%@kEY ARRRAY.....",keyarr);
                                        for(NSDictionary *temp in keyarr)
                                        {
                                            KeyAgenda *f=[[KeyAgenda alloc]init];
                                            f.name=temp[@"user"];
                                        //f.comments=temp[@"comment"];
                                            f.date1=temp[@"date"];
                                            
                                           
                                            
                                            NSString *str=@" \"";
                                            f.comments=[str stringByAppendingFormat:@"%@%@",temp[@"comment"],str];
                                            
                                             [_keynotecommentarr addObject:f];
                                
                                        }
                                    }
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        [_tableView reloadData];
                                        [self scrollViewHeight];
                                    });
                                
                                }];
    
    [task resume];
   
}
-(void)scrollViewHeight{
    [self.tableView layoutIfNeeded];
    CGFloat tbleViewHeight = self.tableView.contentSize.height;
    [self.consContainerHeight setConstant:tbleViewHeight];

}
-(NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section   {
    
    NSString *message = @"";
    
    NSInteger numberOfRowsInSection = [self tableView:self.tableView numberOfRowsInSection:section ];
    
    if (numberOfRowsInSection == 0) {
        message = @"No Comments yet...";
    }
    
    return message;
}
- (IBAction)addMyScheduleBtn:(id)sender {
    
    UIAlertController * alert=[UIAlertController
                               
                               alertControllerWithTitle:@"ALERT" message:@"Do You Want To Add Record?"preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes, please"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    
                                    [self addSession];
                                    NSLog(@"you pressed Yes, please button");
                                    //[self.navigationController popViewControllerAnimated:YES];
                                    [_addMyScheduleBtn setImage:[UIImage imageNamed:@"added-other.png"] forState:UIControlStateNormal];
                                   
                                }];
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"No, thanks"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               {
                                   NSLog(@"you pressed No, thanks button");
                                   
                               }];
    
    [alert addAction:yesButton];
    [alert addAction:noButton];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}
- (IBAction)addMyScheduleLargeBtn:(id)sender {
    
    NSString *emailid=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
    if (emailid==NULL) {
        UIAlertController * alert=[UIAlertController
                                   
                                   alertControllerWithTitle:@"Alert!" message:@"Please login to add in my Schedule"preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"OK"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action)
                                    {
                                        NSLog(@"you pressed ok, please button");
                                        
                                    }];
        
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    else {
    
    UIAlertController * alert=[UIAlertController
                               
                               alertControllerWithTitle:@"ALERT" message:@"Do You Want To Add Record?"preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes, please"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                   
                                    [self addSession];
                                    NSLog(@"you pressed Yes, please button");
                                    //[self.navigationController popViewControllerAnimated:YES];
                                     //[_addMyScheduleBtn setImage:[UIImage imageNamed:@"added-other.png"] forState:UIControlStateNormal];
                                    
                                }];
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"No, thanks"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               {
                                   NSLog(@"you pressed No, thanks button");
                                 
                               }];
    
    [alert addAction:yesButton];
    [alert addAction:noButton];
    
    [self presentViewController:alert animated:YES completion:nil];
    }
}
-(void)addSession
{
    NSString *savedValue=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
    
    NSString *savedsessionid=[[NSUserDefaults standardUserDefaults]stringForKey:@"sessionid"];
    
    NSString *myst=[NSString stringWithFormat:@"emailid=%@&session_id=%@",savedValue,savedsessionid];
    
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    
    NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:add_to_keynote_schedule]];
    
   // NSURL * url = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/add_to_keynote_schedule.php"];
    
    NSMutableURLRequest *urlrequest=[NSMutableURLRequest requestWithURL:url];
    [urlrequest setHTTPMethod:@"POST"];
    [urlrequest setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
    NSError *error=nil;
    if(error)
    {
        NSLog(@"%@",error.description);
    }
    
    NSURLSessionDataTask *task=[session dataTaskWithRequest:urlrequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                {
                                    if (error)
                                    {
                                        NSLog(@"%@",error.description);
                                    }
                                    NSString *text=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                    NSLog(@"data=%@",text);
                                    NSError *error1=nil;
                                    NSDictionary *responsedict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error1];
                                    if(error1)
                                    {
                                        NSLog(@"error 1 is %@",error1.description);
                                    }
                                    self.success=[responsedict objectForKey:@"success"];
                                    self.message=[responsedict objectForKey:@"message"];
                                    
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        
                                        if([self.success isEqualToString:@"1"])
                                        {
                                            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Success" message:self.message preferredStyle:UIAlertControllerStyleAlert];
                                            
                                            UIAlertAction* ok = [UIAlertAction
                                                                 actionWithTitle:@"OK"
                                                                 style:UIAlertActionStyleDefault
                                                                 handler:^(UIAlertAction * action)
                                                                 {
                                                                     NSLog(@"Show blue clicked tick.......");
                                                                     [_addMyScheduleBtn setImage:[UIImage imageNamed:@"added-other.png"] forState:UIControlStateNormal];
                                                                     [_addMyScheduleBtn setUserInteractionEnabled:NO];
                                                [_addMyScheduleLargeBtn setUserInteractionEnabled:NO];
                                                                     
                                                 self.addSchLbl.text = @"Added to My Schedule";
                                                                     [alertView dismissViewControllerAnimated:YES completion:nil];
                                                                     
                                                                 }];
                                            
                                            
                                            [alertView addAction:ok];
                                            
                                            [self presentViewController:alertView animated:YES completion:nil];
                                            
                                        }
                                        else
                                        {
                                            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Oops!" message:self.message preferredStyle:UIAlertControllerStyleAlert];
                                            
                                            UIAlertAction* ok = [UIAlertAction
                                                                 actionWithTitle:@"OK"
                                                                 style:UIAlertActionStyleDefault
                                                                 handler:^(UIAlertAction * action)
                                                                 {
                                                                     //[_addMyScheduleBtn setImage:[UIImage imageNamed:@"added-other.png"] forState:UIControlStateNormal];
                                                                     
                                                  _addSchLbl.text=@"Added to My Schedule";
                                                                     [alertView dismissViewControllerAnimated:YES completion:nil];
                                                                     
                                                                 }];
                                            
                                            
                                            [alertView addAction:ok];
                                            
                                            [self presentViewController:alertView animated:YES completion:nil];
                                            
                                        }
                                    });
                                    
                                    
                                    NSLog(@"json = %@",responsedict);
                                    
                                    
                                }];
    [task resume];
}

- (IBAction)likeBtnClicked:(id)sender {
    NSString *emailid=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
    if (emailid==NULL) {
        UIAlertController * alert=[UIAlertController
                                   
                                   alertControllerWithTitle:@"Alert!" message:@"Please login to like keynote"preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"OK"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action)
                                    {
                                        NSLog(@"you pressed ok, please button");
                                        
                                    }];
        
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    else {
    [self likeSession];
    }
    //  [_likeBtnClicked setImage:[UIImage imageNamed:@"liked.png"] forState:UIControlStateNormal];
}

-(void)likeSession
{
    NSString *savedValue=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
    
    NSString *savedsessionid=[[NSUserDefaults standardUserDefaults]stringForKey:@"sessionid"];
    
    NSString *myst=[NSString stringWithFormat:@"emailid=%@&session_id=%@",savedValue,savedsessionid];
    
    
    NSLog(@"my string=%@",myst);
    
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    
    NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:add_keynote_likes]];
    
    //NSURL * url = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/add_keynote_likes.php"];
    
 
    NSMutableURLRequest *urlrequest=[NSMutableURLRequest requestWithURL:url];
    [urlrequest setHTTPMethod:@"POST"];
    [urlrequest setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
    NSError *error=nil;
    if(error)
    {
        NSLog(@"%@",error.description);
    }
    
    
    
    NSURLSessionDataTask *task=[session dataTaskWithRequest:urlrequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                {
                                    if (error)
                                    {
                                        NSLog(@"%@",error.description);
                                    }
                                    NSString *text=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                    NSLog(@"data=%@",text);
                                    
                                    NSError *error1=nil;
                                    NSDictionary *responsedict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error1];
                                    if(error1)
                                    {
                                        NSLog(@"error 1 is %@",error1.description);
                                    }
                                    
                                    self.success=[responsedict objectForKey:@"success"];

                                    
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        
                                        if([self.success isEqualToString:@"1"])
                                        {
                                            [self getLikes];
                                            NSLog(@"Liked click.......");
                                            // [_likeBtnClicked setImage:[UIImage imageNamed:@"liked.png"] forState:UIControlStateNormal];
                                            [_likeBtnClicked setUserInteractionEnabled:NO];
                                            
                                        }
                                        else
                                        {
                                            NSLog(@"Failure.......");
                                        }
                                    });
                                    
                                    NSLog(@"json = %@",responsedict);
                                    
                                    
                                }];
    [task resume];
    
}

-(void)getLikes{
    
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSString *savedsessionid=[[NSUserDefaults standardUserDefaults]stringForKey:@"sessionid"];
    
    NSString *myst2=[NSString stringWithFormat:@"session_id=%@",savedsessionid];
    
    NSLog(@"Session ID.....:%@",myst2);
    
    NSURL * url2 = [NSURL URLWithString:[mainUrl stringByAppendingString:get_keynote_likes]];
    
    //NSURL * url2 = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/get_keynote_likes.php"];
   
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url2];
    
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[myst2 dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(error == nil)
        {
            NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
            _count_lbl.text=text;
            NSLog(@"count.......*****%@",text);
        }
    }];
    
    [dataTask resume];
    
    
}

-(void)getCommentCount{
    
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSString *savedsessionid=[[NSUserDefaults standardUserDefaults]stringForKey:@"sessionid"];
    
    NSString *myst2=[NSString stringWithFormat:@"session_id=%@",savedsessionid];
    
    NSLog(@"Session ID.....:%@",myst2);
    
    NSURL * url2 = [NSURL URLWithString:[mainUrl stringByAppendingString:get_keynote_comment_count]];
    
    //NSURL * url2 = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/get_keynote_comment_count.php"];

    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url2];
    
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[myst2 dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(error == nil)
        {
            NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
            
            _count_comment.text=text;
            NSLog(@"comment count==%@",_count_comment.text);
        }
    }];
    
    [dataTask resume];
    
    
}

-(void)keynoteparsing2{
    
    NSString *savedvalue2=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
    NSString *savedsessionid=[[NSUserDefaults standardUserDefaults]stringForKey:@"sessionid"];
    
    NSString *myst=[NSString stringWithFormat:@"emailid=%@&session_id=%@",savedvalue2,savedsessionid];
    NSLog(@"Keynote session_id.......%@",myst);
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:keynote_info]];
    
    // NSURL * url = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/keynote_info.php"];//local
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSURLSessionDataTask *task=[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                {
                                    
                                    if(data==nil)
                                    {
                                        NSLog(@"Data is nil");
                                    }
                                    else
                                    {
                                        
                                        NSDictionary *outerdic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                        
                                        
                                        NSArray *keyarr=[outerdic objectForKey:@"keynotes"];
                                        NSLog(@"keynoteee%@",outerdic);
                                        
                                        for(NSDictionary *temp in keyarr)
                                        {
                                            NSString *str1=[temp objectForKey:@"session_id"];
                                            NSString *str2=[temp objectForKey:@"added"];
                                            
                                            NSLog(@"added value key===%@",str2);
                                            if ([str2 isEqualToString:@"false"]) {
                                                NSLog(@"Tempdata is .....");
                                                [_addMyScheduleBtn setImage:[UIImage imageNamed:@"add-other.png"] forState:UIControlStateNormal];
                                                [_addMyScheduleBtn setUserInteractionEnabled:YES];
                                            }
                                            else{
                                                NSLog(@"Show blue tick.......");
                                                [_addMyScheduleBtn setImage:[UIImage imageNamed:@"added-other.png"] forState:UIControlStateNormal];
                                                [_addMyScheduleBtn setUserInteractionEnabled:NO];
                                                //[_addMyScheduleLargeBtn setUserInteractionEnabled:NO];
                                                
                                            }
                                            
                                            
                                            if([str1 isEqualToString:_tempsessionid])
                                            {
                                                _keynamestr=str1;
                                                _addedstr=str2;
                                                
                                                
                                                
                                                [_indicator stopAnimating];
                                                
                                                
                                            }
                                        }
                                        
                                    }
                                    
                                }];
    [task resume];
    
    
}
- (void)showAnimate
{
    self.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.view.alpha = 0;
    [UIView animateWithDuration:.25 animations:^{
        self.view.alpha = 1;
        self.view.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)removeAnimate
{
    _popUpView.hidden=YES;
}
- (IBAction)closePopup:(id)sender {
    [self removeAnimate];
}

- (void)showInView:(UIView *)aView animated:(BOOL)animated
{
    [aView addSubview:self.view];
    if (animated) {
        [self showAnimate];
    }
}
- (IBAction)commentBtnClicked:(id)sender {
    
    _popUpView.hidden=NO;
    self.tableView.allowsSelectionDuringEditing =NO;
    self.tableView.allowsSelection = NO;
    
    
}
@end
