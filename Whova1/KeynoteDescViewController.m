//
//  KeynoteDescViewController.m
//  ITherm
//
//  Created by Anveshak on 11/17/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import "KeynoteDescViewController.h"
#import "AbsViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "KeyDescCommentTableViewCell.h"
#import "KeyDesc.h"
#import "Constant.h"
@interface KeynoteDescViewController ()

@end

@implementation KeynoteDescViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [_indicator startAnimating];
    
     self.sessionid.text=self.tempsessionid;
    NSLog(@"temp sessin id==%@",_tempsessionid);
    self.kimgview.layer.cornerRadius = self.kimgview.frame.size.width / 2;
    self.kimgview.clipsToBounds = YES;
    
    
    self.kimgview.layer.borderColor=[UIColor blackColor].CGColor;
    
     NSString *starttime=[[NSUserDefaults standardUserDefaults]stringForKey:@"keystarttime"];
    
    
    NSLog(@"Start time::::%@",starttime);
    _starttime.text=starttime;
    
     NSString *endtime=[[NSUserDefaults standardUserDefaults]stringForKey:@"keyendtime"];
    
    _endtime.text=endtime;
    
     NSString *location=[[NSUserDefaults standardUserDefaults]stringForKey:@"keylocation"];
    
    _location.text=location;
    
    [_indicator startAnimating];
    NSLog(@"%@   %@",_namestr,_kimg);
    
    int i=[_indxpath intValue];
    NSLog(@"%@",[_abstrarray objectAtIndex:i]);
    
    if([[_abstrarray objectAtIndex:i]isEqual:[NSNull null]])
    {
        _abstractlabel.text=@"--";
    }
    else
    {
        _abstractlabel.text=[_abstrarray objectAtIndex:i];
    }
    
    NSLog(@" kimgarray  %@",[_kimgarray objectAtIndex:i]);
    NSLog(@"image  %@",_kimg);
    _namelabel.text=_namestr;
    _universitylabel.text=_unistr;
    _keynotelabel.text=_keystr;
    
    NSLog(@"%@",_newurlstr);
    [self getLikes];
    [self getCommentCount];
    [self getComments];
    [self keynoteparsing];
    
    self.allnotifications=[[NSMutableArray alloc]init];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    
    
    _imgarr=[[NSMutableArray alloc]init];
    _commentarr=[[NSMutableArray alloc]init];
    _usernamearr=[[NSMutableArray alloc]init];
    _datearr=[[NSMutableArray alloc]init];
    
    _comments.delegate =self;
    
    _popUpView.hidden=YES;
    self.popUpView.layer.cornerRadius = 5;
    self.popUpView.layer.shadowOpacity = 0.8;
    self.popUpView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    
    //[self.tableView setSeparatorColor:[UIColor clearColor]];
    
    _comments.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    _comments.layer.borderWidth=1.0;
    
    self.postBtn.layer.masksToBounds=YES;
    self.postBtn.layer.borderColor=[UIColor colorWithRed:20.0/255.0 green:72.0/255.0 blue:114.0/255.0 alpha:1.0].CGColor;
    self.postBtn.layer.borderWidth=1.1;
    self.postBtn.layer.cornerRadius=5;

}

-(void)viewWillAppear:(BOOL)animated
{
    int i=[_indxpath intValue];
    NSString *tempimgstr=[_kimgarray objectAtIndex:i];
    
    [_kimgview sd_setImageWithURL:[NSURL URLWithString:tempimgstr]
                 placeholderImage:[UIImage imageNamed:@"default.png"]];
    
    [_indicator stopAnimating];
    
    [self.tableView reloadData];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"showKeydescAbs"])
    {
        AbsViewController *ab=[segue destinationViewController];
        ab.absStr=_abstractlabel.text;
    }
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _allnotifications.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    KeyDescCommentTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    KeyDesc *ktemp=[_allnotifications objectAtIndex:indexPath.row];
    
    cell.name.text=ktemp.name;
    cell.comments.text=ktemp.comments;
    cell.date1.text=ktemp.date1;
   // NSString *kImgLink=[_imgarr objectAtIndex:indexPath.row];
    
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
//    
    
    NSLog(@"commentss ==== %@",cell.comments);
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
    NSString *myst=[NSString stringWithFormat:@"emailid=%@&session_id=%@",savedvalue2,_tempsessionid];
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

-(void)addComment{
    
    
    
    NSString *savedValue=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
   // _tempcomment = _comments.text;
    
    NSString *myst=[NSString stringWithFormat:@"emailid=%@&session_id=%@&comment=%@",savedValue,_tempsessionid,_tempcomment];
    NSLog(@"my string commentsss=%@",myst);
  
    
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
    
    [_allnotifications removeAllObjects];
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSString *myst2=[NSString stringWithFormat:@"session_id=%@",_tempsessionid];
    
    NSLog(@"GET  Session ID.....:%@",myst2);
    
    NSURL * url2 = [NSURL URLWithString:[mainUrl stringByAppendingString:get_keynote_comments]];
    
    //NSURL * url2 = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/get_keynote_comments.php"];

    
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
                                            NSString *str1=[temp objectForKey:@"user"];
                                            NSString *str2=[temp objectForKey:@"comment"];
                                            NSString *str3=[temp objectForKey:@"date"];
                                            NSString *str4=[temp objectForKey:@"images"];
                                            
                                            NSLog(@"user==%@ comment==%@ Date==%@  images==%@",str1,str2,str3,str4);
                                            
                                            //[_usernamearr addObject:str1];
                                            [_commentarr addObject:str2];
                                            [_datearr addObject:str3];
                                            [_imgarr addObject:str4];
                                            
                                            
                                            
                                            KeyDesc *c1=[[KeyDesc alloc]init];
                                            
                                            c1.name=str1;
                                            //c1.comments=str2;
                                            c1.date1=str3;
                                            c1.img=str4;
                                            
                                            NSString *str= @" \"";
                                            
                                            c1.comments=[str stringByAppendingFormat:@"%@ %@",str2,str];
                                            
                                            [_allnotifications addObject:c1];
                                            
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
    [self.consContainerHeight setConstant: tbleViewHeight];

    //NSLog(@"****scroll view height after adding cell in talk info tab: %@", self.consContainerHeight);
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
                                    // [_addMyScheduleBtn setImage:[UIImage imageNamed:@"added-other.png"] forState:UIControlStateNormal];
                                   
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
    
    NSString *myst=[NSString stringWithFormat:@"emailid=%@&session_id=%@",savedValue,_tempsessionid];
  
    
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    
    NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:add_to_keynote_schedule]];
    
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
                                                                     _addKeyLbl.text=@"Added to My Schedule";
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

                                                 _addKeyLbl.text=@"Added to My Schedule";                    
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
    
    NSString *myst=[NSString stringWithFormat:@"emailid=%@&session_id=%@",savedValue,_tempsessionid];
    NSLog(@"my string=%@",myst);

    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    
    NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:add_keynote_likes]];
    
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
                                    // self.message=[responsedict objectForKey:@"message"];
                                    
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
    
    NSString *myst2=[NSString stringWithFormat:@"session_id=%@",_tempsessionid];
    
    NSLog(@"Session ID.....:%@",myst2);
    
    NSURL * url2 = [NSURL URLWithString:[mainUrl stringByAppendingString:get_keynote_likes]];
    
  //  NSURL * url2 = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/get_keynote_likes.php"];
  
    
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
    
    NSString *myst2=[NSString stringWithFormat:@"session_id=%@",_tempsessionid];
    
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
