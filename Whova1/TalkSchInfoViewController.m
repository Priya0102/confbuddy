//
//  TalkSchInfoViewController.m
//  ITherm
//
//  Created by Anveshak on 12/19/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import "TalkSchInfoViewController.h"
#import "TalkSchCom.h"
#import "TalkSchComTableViewCell.h"
#import "AbsViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Constant.h"
@interface TalkSchInfoViewController ()

@end

@implementation TalkSchInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_indicator startAnimating];
    _que=[[NSOperationQueue alloc]init];
    
    self.image.layer.cornerRadius = self.image.frame.size.width / 2;
    self.image.clipsToBounds = YES;
    self.image.layer.borderWidth=1.1;
    
    [self getLikes];
    [self getComments];
    [self getCommentCount];
    
    _tableview.delegate=self;
    _tableview.dataSource=self;
    
    _imgarr=[[NSMutableArray alloc]init];
    _commentarr=[[NSMutableArray alloc]init];
    _usernamearr=[[NSMutableArray alloc]init];
    _datearr=[[NSMutableArray alloc]init];
    
    _comments.delegate =self;
    
    _keynotecommentarr=[[NSMutableArray alloc]init];
    
    self.talk_id.text=self.talkidstr;
    self.location.text=self.locationstr;
    self.starttime.text=self.starttimestr;
    self.endtime.text=self.endtimestr;
    self.sessionName.text=self.sess_namestr;
    self.talk.text=self.tempTalkName;
    self.speakeruniversity.text=_tempSpeakeruni;
    self.speakerName.text=_tempSpeakerName;
    self.abstract.text=_abstractstr;
    self.session_id.text=_tempsessionid;
    
    NSLog(@"sess id talk in sch==%@",_tempsessionid);
    
    [[NSUserDefaults standardUserDefaults]setValue:self.talkidstr forKey:@"talk_id"];
    NSLog(@"talk_id in sch= %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"talk_id"]);
    
    
    if([_abstractstr isEqual:[NSNull null]])
    {
        _abstract.text=@"--";
    }
    else
    {
        _abstract.text=_abstractstr;
    }
    
    
    _comments.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    _comments.layer.borderWidth=1.0;
    
    self.postBtn.layer.masksToBounds=YES;
    self.postBtn.layer.borderColor=[UIColor colorWithRed:20.0/255.0 green:72.0/255.0 blue:114.0/255.0 alpha:1.0].CGColor;
    self.postBtn.layer.borderWidth=1.1;
    self.postBtn.layer.cornerRadius=5;
    
    _popUpView.hidden=YES;
    self.popUpView.layer.cornerRadius = 5;
    self.popUpView.layer.shadowOpacity = 0.8;
    self.popUpView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    
    [self.tableview setSeparatorColor:[UIColor clearColor]];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self keynoteparsing];

    int i=[_indxpath intValue];
    NSString *tempimgstr=[_kimgarray objectAtIndex:i];
    
    [_image sd_setImageWithURL:[NSURL URLWithString:tempimgstr]
              placeholderImage:[UIImage imageNamed:@"default.png"]];
    
    [_indicator stopAnimating];
    
    [self.tableview reloadData];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"showTalkdescAbs"])
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
    
    TalkSchComTableViewCell *cell = [self.tableview dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    TalkSchCom *ktemp=[_keynotecommentarr objectAtIndex:indexPath.row];
    
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
    //
    
    NSLog(@"talk commentss ==== %@",cell.comments);
    NSLog(@"talk comment date ==== %@",cell.date1);
    [_indicator stopAnimating];
    return cell;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return  YES;
}

- (IBAction)addComments:(id)sender {
    
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
-(void)keynoteparsing
{
    
    NSString *savedvalue2=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
    
    NSString *savedtalkid=[[NSUserDefaults standardUserDefaults]stringForKey:@"talk_id"];
    
    NSString *myst=[NSString stringWithFormat:@"emailid=%@&talk_id=%@",savedvalue2,savedtalkid];
    NSLog(@"talk_id.......%@",myst);
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
  NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:talk_info]];
    
   // NSURL * url = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/talk_info.php"];//local
    
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
                                            NSString *str1=[temp objectForKey:@"talk_id"];
                                            NSString *str2=[temp objectForKey:@"added"];
                                            
                                            if([str1 isEqualToString:_talkidstr])
                                            {
                                                _talkidstr=str1;
                                                _addedStr=str2;
                                                
                                                
                                                if ([_addedStr isEqualToString:@"false"]) {
                                                    NSLog(@"Tempdata is .....");
                                                    [_addMyScheduleBtn setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
                                                    [_addMyScheduleBtn setUserInteractionEnabled:YES];
                                                }
                                                else{
                                                    NSLog(@"Show blue tick.......");
                                                    [_addMyScheduleBtn setImage:[UIImage imageNamed:@"added.png"] forState:UIControlStateNormal];
                                                    [_addMyScheduleBtn setUserInteractionEnabled:NO];
                                                }
                                                
                                            }
                                        }
                                        
                                    }
                                    
                                }];
    [task resume];
    
}

-(void)addComment{
    
    
    
    NSString *savedValue3=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
    NSString *savedtalkid=[[NSUserDefaults standardUserDefaults]stringForKey:@"talk_id"];
    
    // _tempcomment = _comments.text;
    
    NSString *myst3=[NSString stringWithFormat:@"emailid=%@&talk_id=%@&comment=%@",savedValue3,savedtalkid,_tempcomment];
    NSLog(@"my add comments string=%@",myst3);
    
    NSURLSessionConfiguration *config3=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session3=[NSURLSession sessionWithConfiguration:config3 delegate:self delegateQueue:nil];
    
    NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:add_talk_comment]];
    
   // NSURL *url=[NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/add_talk_comment.php"];
    
   
    
    NSMutableURLRequest *urlrequest=[NSMutableURLRequest requestWithURL:url];
    [urlrequest setHTTPMethod:@"POST"];
    [urlrequest setHTTPBody:[myst3 dataUsingEncoding:NSUTF8StringEncoding]];
    NSError *error=nil;
    if(error)
    {
        NSLog(@"%@",error.description);
    }
    
    NSURLSessionDataTask *task3=[session3 dataTaskWithRequest:urlrequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
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
                                             [self getCommentCount];
                                             [self getComments];
                                             
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
    [task3 resume];
}



-(void)getComments{
    
    [_keynotecommentarr removeAllObjects];
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSString *savedtalkid=[[NSUserDefaults standardUserDefaults]stringForKey:@"talk_id"];
    
    NSString *myst2=[NSString stringWithFormat:@"talk_id=%@",savedtalkid];
    
    NSLog(@"GET  talk_id ID.....:%@",myst2);
    
    NSURL * url2 = [NSURL URLWithString:[mainUrl stringByAppendingString:get_talk_comments]];
    
    //NSURL *url2=[NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/get_talk_comments.php"];

    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url2];
    
    
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[myst2 dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask *task4=[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                 {
                                     
                                     if(data==nil)
                                     {
                                         NSLog(@"Data is nil");
                                     }
                                     else
                                     {
                                         
                                         NSLog(@"response events==%@",response);
                                         
                                         NSDictionary *outerdic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                         NSArray *arr=[outerdic objectForKey:@"comments"];
                                         NSLog(@"events Array=%@",arr);
                                         
                                         for(NSDictionary *temp in arr){
                                             TalkSchCom *f=[[TalkSchCom alloc]init];
                                             f.name=temp[@"user"];
                                             // f.comments=temp[@"comment"];
                                             f.date1=temp[@"date"];
                                             NSString *str=@" \"";
                                             f.comments=[str stringByAppendingFormat:@"%@%@",temp[@"comment"],str];
                                             [_keynotecommentarr addObject:f];
                                             
                                             
                                         }
                                         
                                     }
                                     dispatch_async(dispatch_get_main_queue(), ^{
                                         [_tableview reloadData];
                                         [self scrollViewHeight];
                                     });
                                     
                                 }];
    
    [task4 resume];
    
}
-(void)scrollViewHeight{
    [self.tableview layoutIfNeeded];
    CGFloat tbleViewHeight = self.tableview.contentSize.height;
     [self.consContainerHeight setConstant:tbleViewHeight];
    NSLog(@"****scroll view height after adding cell in talk info tab: %@", self.consContainerHeight);
}
-(NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section   {
    
    NSString *message = @"";
    
    NSInteger numberOfRowsInSection = [self tableView:self.tableview numberOfRowsInSection:section ];
    
    if (numberOfRowsInSection == 0) {
        message = @"No Comments yet...";
    }
    
    return message;
}
- (IBAction)likeBtnClicked:(id)sender {
    [self likeSession];
    
    //  [_likeBtnClicked setImage:[UIImage imageNamed:@"liked.png"] forState:UIControlStateNormal];
}
-(void)likeSession
{
    NSString *savedValue=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
    
    NSString *savedtalkid=[[NSUserDefaults standardUserDefaults]stringForKey:@"talk_id"];
    
    NSString *myst=[NSString stringWithFormat:@"emailid=%@&talk_id=%@",savedValue,savedtalkid];
    
    NSLog(@"my string=%@",myst);
    
    
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    
    NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:add_talk_likes]];
    
    //NSURL *url=[NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/add_talk_likes.php"];
   
    
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
    
    NSString *savedtalkid=[[NSUserDefaults standardUserDefaults]stringForKey:@"talk_id"];
    
    NSString *myst2=[NSString stringWithFormat:@"talk_id=%@",savedtalkid];
    
    NSLog(@"talk_id ID.....:%@",myst2);
    
    NSURL * url2 = [NSURL URLWithString:[mainUrl stringByAppendingString:get_talk_likes]];
    
//    NSURL *url2=[NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/get_talk_likes.php"];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url2];
    
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[myst2 dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(error == nil)
        {
            NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
            _count_like.text=text;
            NSLog(@"count.......*****%@",text);
        }
    }];
    
    [dataTask resume];
    
    
}
-(void)getCommentCount{
    
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSString *savedtalkid=[[NSUserDefaults standardUserDefaults]stringForKey:@"talk_id"];
    
    NSString *myst2=[NSString stringWithFormat:@"talk_id=%@",savedtalkid];
    
    NSLog(@"talk_id ID Comment count.....:%@",myst2);
    
     NSURL * url2 = [NSURL URLWithString:[mainUrl stringByAppendingString:get_talk_comment_count]];
    
    //NSURL *url2=[NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/get_talk_comment_count.php"];
  
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url2];
    
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[myst2 dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(error == nil)
        {
            NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
            
            _count_comment.text=text;
            NSLog(@"comment panelist count==%@",_count_comment.text);
        }
    }];
    
    [dataTask resume];
    
    
}
- (IBAction)deleteBtn:(id)sender {
    
    UIAlertController * alert=[UIAlertController
                               
                               alertControllerWithTitle:@"ALERT" message:@"Do You Want To Delete Record?"preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes, please"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    [self deleteSession];
                                    NSLog(@"you pressed Yes, please button");
                                   [self.navigationController popViewControllerAnimated:YES];
                                   
                                }];
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"No,thanks"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               {
            
                                   NSLog(@"you pressed No, thanks button");
                                  
                               }];
    
    [alert addAction:yesButton];
    [alert addAction:noButton];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}
-(void)deleteSession
{
    NSString *savedValue=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
     NSString *savedtalkid=[[NSUserDefaults standardUserDefaults]stringForKey:@"talk_id"];
    
    NSString *myst=[NSString stringWithFormat:@"emailid=%@&talk_id=%@&session_id=%@",savedValue,savedtalkid,_tempsessionid];
    NSLog(@"my string after delete=%@",myst);
   
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    
     NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:techtalk_delete]];
    
   // NSURL * url = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/techtalk_delete.php"];

    
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
                                    NSLog(@"json = %@",responsedict);
                                    
//                                    dispatch_async(dispatch_get_main_queue(), ^{
//                                    
//                                    });
                                    // [_tableView1 reloadData];
                                    
                                }];
    // [_tableVIew reloadData];
    
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
    self.tableview.allowsSelectionDuringEditing =NO;
    self.tableview.allowsSelection = NO;
    
    
}



@end
