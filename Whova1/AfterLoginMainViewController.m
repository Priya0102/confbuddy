//
//  AfterLoginMainViewController.m
//  ITherm
//
//  Created by Anveshak on 3/1/18.
//  Copyright © 2018 Anveshak . All rights reserved.
//

#import "AfterLoginMainViewController.h"
#import "AfterLogin.h"  
#import "AfterLoginTableViewCell.h"
#import "Constant.h"
#import "UpcomingSession.h"
#import "UpcomingSessionTableViewCell.h"
#import "NotificationsViewController.h"
#import "UserNotiViewController.h"
#import "CourseViewController.h"
#import "Session_itherm.h"
#import "SessTalkViewController.h"
#import "InvitedInfoViewController.h"
#import "WomenViewController.h"
#import "BreakViewController.h"
#import "KeyViewController.h"
#import "PosterViewController.h"
#import "SessionViewController.h"
#import "TechTalkNewViewController.h"

@interface AfterLoginMainViewController ()

@end

@implementation AfterLoginMainViewController
    
- (void)viewDidLoad {
    [super viewDidLoad];
      
    [_tableview2 setShowsHorizontalScrollIndicator:NO];
    [_tableview2 setShowsVerticalScrollIndicator:NO];
    
    _tableview1.delegate=self;
    _tableview1.dataSource=self;
    _tableview1.scrollEnabled=NO;
    
    _tableview2.delegate=self;
    _tableview2.dataSource=self;
    
    _latestNotification=[[NSMutableArray alloc]init];
    _upcomingSessions=[[NSMutableArray alloc]init];
    
    self.view1.layer.masksToBounds=YES;
    self.view1.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.view1.layer.cornerRadius=8;
    self.view1.layer.borderWidth=0.2;
    // self.imgView2.layer.shadowColor=[UIColor redColor].CGColor;

    
    
    self.btnTotalSession.layer.masksToBounds=YES;
    self.btnTotalSession.layer.cornerRadius=8;
    self.btnTotalSession.layer.borderColor=([UIColor colorWithRed:(84.0/225.0) green:(211.0/225.0) blue:(199.0/255.0)alpha:1.0].CGColor);
    self.btnTotalSession.layer.borderWidth=1.0;
  
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    
    gradient.frame = _btnTotalSession.bounds;
    gradient.colors = @[(id)[UIColor colorWithRed:(208/225.0) green:(234/225.0) blue:(229/255.0)alpha:1].CGColor, (id)[UIColor colorWithRed:(131/225.0) green:(234/225.0) blue:(229/255.0)alpha:1].CGColor];
    
    [_btnTotalSession.layer insertSublayer:gradient atIndex:0];
    
    
    self.keynoteBtn.layer.masksToBounds=YES;
    self.keynoteBtn.layer.cornerRadius=8;
    self.keynoteBtn.layer.borderColor=([UIColor colorWithRed:(88.0/225.0) green:(211.0/225.0) blue:(244.0/255.0)alpha:1.0].CGColor);
     self.keynoteBtn.layer.borderWidth=1.0;
    
    CAGradientLayer *gradient1 = [CAGradientLayer layer];
    
    gradient1.frame = _keynoteBtn.bounds;
    gradient1.colors = @[(id)[UIColor colorWithRed:(178/225.0) green:(239/225.0) blue:(239/255.0)alpha:1].CGColor, (id)[UIColor colorWithRed:(138/225.0) green:(239/225.0) blue:(239/255.0)alpha:1].CGColor];
    
    [_keynoteBtn.layer insertSublayer:gradient1 atIndex:0];
    
    
    
    self.myScheduleBtn.layer.masksToBounds=YES;
    self.myScheduleBtn.layer.cornerRadius=8;
    self.myScheduleBtn.layer.borderColor=([UIColor colorWithRed:(247.0/225.0) green:(215.0/225.0) blue:(79.0/255.0)alpha:1.0].CGColor);
    self.myScheduleBtn.layer.borderWidth=1.0;
    
    CAGradientLayer *gradient2 = [CAGradientLayer layer];
    
    gradient2.frame = _myScheduleBtn.bounds;
    gradient2.colors = @[(id)[UIColor colorWithRed:(242/225.0) green:(226/225.0) blue:(174/255.0)alpha:1].CGColor, (id)[UIColor colorWithRed:(242/225.0) green:(209/225.0) blue:(116/255.0)alpha:1].CGColor];
    
    [_myScheduleBtn.layer insertSublayer:gradient2 atIndex:0];
    
    self.navigationItem.hidesBackButton = NO;
    [self setupScrollView2:self.scroll2];
    
    
    UIPageControl *pgCtr2=[[UIPageControl alloc]init];//WithFrame:CGRectMake(0, 264, 480,50)];
    [pgCtr2 setTag:5];
    pgCtr2.numberOfPages=11;
    pgCtr2.autoresizingMask=UIViewAutoresizingNone;
    [self.contentview2 addSubview:pgCtr2];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"HelveticaLTStd-Roman" size:10.0f], NSFontAttributeName,[UIColor whiteColor], NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"HelveticaLTStd-Roman" size:10.0f], NSFontAttributeName,[UIColor whiteColor], NSForegroundColorAttributeName,nil] forState:UIControlStateHighlighted];
    
    
    
    _upcomingDateArray=[[NSMutableArray alloc]init];
    _upcomingTimeArray=[[NSMutableArray alloc]init];
    _upcomingSessionArr=[[NSMutableArray alloc]init];
    _upcomingLocationArr=[[NSMutableArray alloc]init];
    _upcomingSessDetailArr=[[NSMutableArray alloc]init];
   
    [self upcomingSessionParsing];
    [self getTodaySessionCount];
    [self getSessionAttendedCount];
    [self getSheduledItemCount];
    
    
    UIBarButtonItem *Savebtn=[[UIBarButtonItem alloc]initWithImage:
                              [[UIImage imageNamed:@"bell_ipad.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                             style:UIBarButtonItemStylePlain target:self action:@selector(extracted)];
    self.navigationItem.rightBarButtonItem=Savebtn;
    
    [self loginStatus];
    

}
- (void)extracted {
    bool isSendToSecondView = false;
    
    if (isSendToSecondView) {
        NotificationsViewController *admin = [self.storyboard instantiateViewControllerWithIdentifier:@"adminController"];
        
        [self.navigationController pushViewController:admin animated:YES];
    }
    else {
        UserNotiViewController *user = [self.storyboard instantiateViewControllerWithIdentifier:@"userController"];
        
        [self.navigationController pushViewController:user animated:YES];
    }
}

//-(void)SaveButtonClicked
//{
//    if([self.role_id isEqualToString:@"13"]){
//        NSLog(@"admin tab clicked==");
//        UIViewController *admin=[self.storyboard instantiateViewControllerWithIdentifier:@"adminController"];
//        
//        [self presentViewController:admin animated:YES completion:nil];
//        
//
//        NSLog(@"naviiii=%@",self.navigationController);
//    }
//    else
//    {
//       NSLog(@"user tab clicked==");
//        
//        UIViewController *user=[self.storyboard instantiateViewControllerWithIdentifier:@"userController"];
//        
//        [self presentViewController:user animated:YES completion:nil];
//    }
//
//}
-(void)loginStatus{
    
    NSString *savedValue = [[NSUserDefaults standardUserDefaults] stringForKey:@"email"];
    
    
    NSString *myst=[NSString stringWithFormat:@"user=%@",savedValue];
    
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    

    NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:two_2]];
    
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if(error == nil)
        {
            NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
            NSLog(@"data=%@",text);
            self.role_id=text;
            NSLog(@"role id=%@",self.role_id);
        }
        NSError *er=nil;
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&er];
        if(er)
        {
            
        }
        self.role_id=[responseDict objectForKey:@"status"];
         NSLog(@"***role id=%@",self.role_id);
        
    }];
    
    
    [dataTask resume];

}
-(void)viewWillAppear:(BOOL)animated
{
    [self dataFetchingLatest];
    
    [_tableview1 reloadData];
    
}

-(void)dataFetchingLatest
{
    [_latestNotification removeAllObjects];
    
    NSString *savedvalue=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
    
    NSString *myst=[NSString stringWithFormat:@"emailid=%@",savedvalue];//2
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:user_notification_get3]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    
    [urlRequest setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
    NSError *error=nil;
    if (error) {
        NSLog(@"%@",error.description);
    }
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(error == nil)
        {
            
            NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
            NSLog(@"data=%@",text);
            NSError *er=nil;
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&er];
            
            NSLog(@"....%@",responseDict);
            if(er)
            {
            }
            NSArray *mynotification=[responseDict objectForKey:@"all_notifications"];
            
            NSLog(@"Notification count %lu",(unsigned long)mynotification.count);
            
            if(mynotification.count==0)
            {
                CGRect labelFrame = CGRectMake(55,160,320,130);
                
                UILabel *myLabel = [[UILabel alloc] initWithFrame:labelFrame];
                
                myLabel.backgroundColor = [UIColor clearColor];
                myLabel.textColor = [UIColor lightGrayColor];
                myLabel.font = [UIFont fontWithName:@"Verdana" size:15.0];
                //myLabel.textAlignment=NSTextAlignmentCenter;
                myLabel.numberOfLines = 2;
                myLabel.text = @"Currently no new Notifications.";
                
                myLabel.shadowColor = [UIColor darkGrayColor];
                myLabel.shadowOffset = CGSizeMake(1.0,1.0);
                
                [self.view addSubview:myLabel];
//                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:nil message:@"No New Notifications" preferredStyle:UIAlertControllerStyleAlert];
//                
//                UIAlertAction* ok = [UIAlertAction
//                                     actionWithTitle:@"OK"
//                                     style:UIAlertActionStyleDefault
//                                     handler:^(UIAlertAction * action)
//                                     {
//                                         [alertView dismissViewControllerAnimated:YES completion:nil];
//                                         
//                                     }];
//                
//                [alertView addAction:ok];
//                [self presentViewController:alertView animated:YES completion:nil];
            }
            else{
                
                for(NSDictionary * dict in mynotification)
                {
                    AfterLogin *obj=[[AfterLogin alloc]init];
                    obj.notification_name=dict[@"name"];
                    obj.date=dict[@"date"];
                    obj.notify_time=dict[@"time"];
                    NSLog(@"aaaaaaa%@",obj.notify_time);
                    obj.notify_description=dict[@"description"];
                    obj.read=dict[@"read"];
                    obj.notification_id=dict[@"notification_id"];
                    
                    [self.latestNotification addObject:obj];
                    //[indicator stopAnimating];
                }
                [self.tableview1 reloadData];
            }
            [self.tableview1 reloadData];
        }
        
        
        
    }];
    
    [dataTask resume];
    
    
    
}

-(void)upcomingSessionParsing{
    
    [_upcomingDateArray removeAllObjects];
    [_upcomingTimeArray removeAllObjects];
    [_upcomingSessionArr removeAllObjects];
    [_upcomingLocationArr removeAllObjects];
    [_upcomingSessDetailArr removeAllObjects];
    
   
    [_upcomingSessions removeAllObjects];
    
    NSURL * urlstr = [NSURL URLWithString:[mainUrl stringByAppendingString:get_upcoming_session]];
   
    
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
                                        
                                        
                                        NSLog(@"upcoming sessionn=**%@",response);
                                        
                                        
                                        NSDictionary *outerdic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                        
                                        NSArray *keyarr=[outerdic objectForKey:@"upcoming_sessions"];
                                        
                                        for(NSDictionary *temp in keyarr)
                                        {
                                            NSString *str1=[temp objectForKey:@"session_id"];
                                            NSString *str2=[temp objectForKey:@"session_name"];
                                            NSString *str3=[temp objectForKey:@"start_time"];
                                            NSString *str4=[temp objectForKey:@"date"];
                                            NSString *str5=[temp objectForKey:@"room_name"];
                                            NSString *str6=[temp objectForKey:@"program_type_id"];
                                            NSString *str7=[temp objectForKey:@"category"];
                                            NSString *str8=[temp objectForKey:@"session_details"];
                                            NSString *str9=[temp objectForKey:@"end_time"];
                                            
                                        
                                            NSLog(@"str4  %@",str3);
                                            UpcomingSession *k1=[[UpcomingSession alloc]init];
                                            k1.sessionidStr=str1;
                                            k1.sessionNameStr=str2;
                                            k1.startTimeStr=str3;
                                            k1.dateStr=str4;
                                            k1.roomnameStr=str5;
                                            k1.programidStr=str6;
                                            k1.categoryStr=str7;
                                            k1.sessionDetailsStr=str8;
                                            k1.endtimeStr=str9;
                                            
                                            [[NSUserDefaults standardUserDefaults]setValue:str1 forKey:@"sesionid"];
                                            NSLog(@"***sesion ID = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"sesionid"]);
                                            
                                            [_upcomingSessions addObject:k1];
                                            
                                            [_tableview2 reloadData];
                                        }
                                        [_tableview2 reloadData];
                                    }
                                    [_tableview2 performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
                                }];
    [task resume];
    
    [_tableview2 reloadData];
    


}
-(void)setupScrollView2:(UIScrollView *)scrMain{
    for (int i=1; i<=11; i++) {
        UIImage *image=[UIImage imageNamed:[NSString stringWithFormat:@"therminic.png"]];
        UIImage *image2=[UIImage imageNamed:[NSString stringWithFormat:@"eptc.png"]];
        UIImage *image3=[UIImage imageNamed:[NSString stringWithFormat:@"uci.png"]];
        UIImage *image4=[UIImage imageNamed:[NSString stringWithFormat:@"future.png"]];
        UIImage *image5=[UIImage imageNamed:[NSString stringWithFormat:@"polyonics.png"]];
        UIImage *image6=[UIImage imageNamed:[NSString stringWithFormat:@"jc.png"]];
        UIImage *image7=[UIImage imageNamed:[NSString stringWithFormat:@"wspc.png"]];
        UIImage *image8=[UIImage imageNamed:[NSString stringWithFormat:@"ieee.png"]];
        UIImage *image9=[UIImage imageNamed:[NSString stringWithFormat:@"huawei.png"]];
        UIImage *image10=[UIImage imageNamed:[NSString stringWithFormat:@"s3ip.png"]];
        UIImage *image11=[UIImage imageNamed:[NSString stringWithFormat:@"intel.png"]];
        // UIImage *image12=[UIImage imageNamed:[NSString stringWithFormat:@"h14.jpg"]];
        
        [_imgView2 setImage:image];
        _imgView2.animationImages=@[image,image2,image3,image4,image5,image6,image7,image8,image9,image10,image11];
        _imgView2.animationDuration=25.0;
        _imgView2.tag=i+1;
        
        [_imgView2 startAnimating];
    }
    
    
    [NSTimer scheduledTimerWithTimeInterval:8 target:self selector:@selector(scrollingTimer2) userInfo:nil repeats:YES];
}
-(void)scrollingTimer2{
    UIScrollView *scrMain=(UIScrollView *)[self.view viewWithTag:1];
    UIPageControl *pgCtr2=(UIPageControl*)[self.view viewWithTag:24];
    CGFloat contentOffset=self.scroll2.contentOffset.x;
    
    
    int nextPage=(int)(contentOffset/self.scroll2.frame.size.width)+1;
    
    if (nextPage!=12){
        [self.scroll2 scrollRectToVisible:CGRectMake(nextPage*self.scroll2.frame.size.width,0,self.scroll2.frame.size.width,self.scroll2.frame.size.height)animated:YES];
        pgCtr2.currentPage=nextPage;
    }else{
        [self.scroll2 scrollRectToVisible:CGRectMake(0,0,self.scroll2.frame.size.width,self.scroll2.frame.size.height)animated:YES];
        
        pgCtr2.currentPage=0;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView==self.tableview2) {
        return 1;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView==self.tableview2) {
        return self.upcomingSessions.count;
    }
    return _latestNotification.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (tableView==self.tableview2) {
        
        UpcomingSessionTableViewCell *cell = [self.tableview2 dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
        UpcomingSession *ktemp=[_upcomingSessions objectAtIndex:indexPath.row];
        cell.startTime.text=ktemp.startTimeStr;
        cell.upcomingDate.text=ktemp.dateStr;
        cell.upcomingLocation.text=ktemp.roomnameStr;
        cell.upcomingSessionName.text=ktemp.sessionNameStr;
        cell.upcomingSessionDetails.text=ktemp.sessionDetailsStr;
        cell.sessionid.text=ktemp.sessionidStr;
        cell.endtime.text=ktemp.endtimeStr;
        
        //cell.viewSession.tag = indexPath.row;
        
//        [cell.viewSessionBtn addTarget:self action:@selector(yourButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
      
    }
    else if(tableView==self.tableview1){
        
        AfterLoginTableViewCell *cell=[self.tableview1 dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
        AfterLogin *obj=self.latestNotification[indexPath.row];
        cell.notification.text=obj.notification_name;
        cell.desc.text=obj.notify_description;
        cell.date.text=obj.date;
    }
    return cell;
}
//-(void)yourButtonClicked:(UIButton*)sender
//{
//    if (sender.tag == 0)
//    {
//        // Your code here
//    }
//}
-(void)getTodaySessionCount{
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSString *savedValue = [[NSUserDefaults standardUserDefaults] stringForKey:@"email"];
    
    NSString *myst=[NSString stringWithFormat:@"emailid=%@",savedValue];
    
    
    NSLog(@"get data email ID.....:%@",myst);
    
    NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:get_today_session_count]];
    
    //NSURL * url2 = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/get_keynote_comment_count.php"];
    
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(error == nil)
        {
            
            NSString *text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
        
            _todaySessionCount.text=text;
            NSLog(@"total session count==%@",_todaySessionCount.text);
            
        }
    }];
    
    [dataTask resume];

}
-(void)getSessionAttendedCount{
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSString *savedValue = [[NSUserDefaults standardUserDefaults] stringForKey:@"email"];
    
    NSString *myst=[NSString stringWithFormat:@"emailid=%@",savedValue];
    
    
    NSLog(@"get data email ID.....:%@",myst);
    
    NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:get_session_attended_count]];
    
    //NSURL * url2 = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/get_keynote_comment_count.php"];
    
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(error == nil)
        {
            
            NSString *text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
            
            _sessionAttendedCount.text=text;
            NSLog(@"session attended count==%@",_sessionAttendedCount.text);
            
        }
    }];
    
    [dataTask resume];
    
}
-(void)getSheduledItemCount{
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSString *savedValue = [[NSUserDefaults standardUserDefaults] stringForKey:@"email"];
    
    NSString *myst=[NSString stringWithFormat:@"emailid=%@",savedValue];
    
    
    NSLog(@"get data email ID.....:%@",myst);
    
    NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:get_scheduled_item_count]];
    
    //NSURL * url2 = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/get_keynote_comment_count.php"];
    
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(error == nil)
        {
            
            NSString *text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
            
            _scheduledItemsCount.text=text;
            NSLog(@"scheduled item count==%@",_scheduledItemsCount.text);
            
        }
    }];
    
    [dataTask resume];
    
}

/*-(void)getSessionCount{
 
         AfterLogin *a1=[[AfterLogin alloc]init];
        NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
        NSString *savedValue = [[NSUserDefaults standardUserDefaults] stringForKey:@"email"];
    
    
        NSString *myst=[NSString stringWithFormat:@"emailid=%@",savedValue];
   
        
        NSLog(@"get data email ID.....:%@",myst);
        
        NSURL * url2 = [NSURL URLWithString:[mainUrl stringByAppendingString:get_data_for_today]];
        
        //NSURL * url2 = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/get_keynote_comment_count.php"];
        
        
        NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url2];
        
        [urlRequest setHTTPMethod:@"POST"];
        [urlRequest setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
        
        NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if(error == nil)
            {
                NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                NSLog(@"data=%@",text);
                NSError *er=nil;
                
                NSDictionary *outerdic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&er];
        
                for(NSDictionary *temp in outerdic)
                {
                    a1.totalSession=temp[@"sessions_today"];
                    
                }
            
                 dispatch_async(dispatch_get_main_queue(), ^{
                     
                     if(a1.totalSession==(NSString *) [NSNull null])
                     {
                         a1.totalSession=@"---";
                     }
                    _todaySessionCount.text=a1.totalSession;
                     
                     
                     
                     NSLog(@"today session count==%@ & sessionAttendend=%@ & scheduledIthemsCount-%@",_todaySessionCount.text,_sessionAttendedCount.text,_scheduledItemsCount.text);
                  });
        }

//                NSString *text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
//
//
//                _todaySessionCount.text=text;
//                _sessionAttendedCount.text=text;
//                _scheduledItemsCount.text=text;
                

         }];
          
        [dataTask resume];
        
        

}
*/
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UpcomingSessionTableViewCell *cell = [self.tableview2 cellForRowAtIndexPath:indexPath];

    cell.startTime.text=_startstr;
    cell.upcomingDate.text=_datestr;
    cell.upcomingLocation.text=_locationstr;
    cell.upcomingSessionName.text=_sessionnamestr;
    cell.upcomingSessionDetails.text=_sessiondetailsstr;
    cell.sessionid.text=_tempSessid;
    cell.endtime.text=_endstr;
    
    UpcomingSession *u=self.upcomingSessions[indexPath.row];
    NSString *tempstr=u.sessionidStr;
    NSString *tempstr2=u.programidStr;
    _tempSessid=u.sessionidStr;
    _startstr=u.startTimeStr;
    _sessionnamestr=u.sessionNameStr;
    _sessiondetailsstr=u.sessionDetailsStr;
    _locationstr=u.roomnameStr;
    _endstr=u.endtimeStr;
    NSLog(@"***temp str==%@ & temp str2==%@",tempstr,tempstr2);
     if([tempstr2 isEqualToString:@"4"])
    {
        [self performSegueWithIdentifier:@"showCourse" sender:nil];
    }
    if([tempstr2 isEqualToString:@"1"])
    {
        [self performSegueWithIdentifier:@"showSession" sender:self];
    }
    else if([tempstr2 isEqualToString:@"2"])
    {
        [self performSegueWithIdentifier:@"showKey" sender:nil];
    }
    else if([tempstr2 isEqualToString:@"3"])
    {
        [self performSegueWithIdentifier:@"showTalk" sender:nil];
    }
    else if([tempstr2 isEqualToString:@"5"])
    {
        [self performSegueWithIdentifier:@"showWomen" sender:self];
    }
    else if([tempstr2 isEqualToString:@"6"])
    {
        [self performSegueWithIdentifier:@"showPoster" sender:nil];
    }
    
    else if([tempstr2 isEqualToString:@"7"])
    {
        [self performSegueWithIdentifier:@"showBreakfast" sender:nil];
    }
    else if([tempstr2 isEqualToString:@"8"])
    {
        [self performSegueWithIdentifier:@"showInvited" sender:nil];
    }
    else if([tempstr2 isEqualToString:@"9"])
    {
        [self performSegueWithIdentifier:@"showPanel" sender:nil];
    }
    
    

    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([[segue identifier]isEqualToString:@"showCourse"])
    {
        CourseViewController *s=[segue destinationViewController];
        s.temp_session_id=_tempSessid;
        s.stimestr=_startstr;
        s.locationstr=_locationstr;
        s.datestr=_datestr;
        s.sessionnamestr=_sessionnamestr;
        s.etimestr=_endstr;
    }
    if([[segue identifier]isEqualToString:@"showTalk"])
    {
        SessTalkViewController *stlk=[segue destinationViewController];
        stlk.session_idstr=_tempSessid;
        stlk.stime=_startstr;
        stlk.locationstr=_locationstr;
        stlk.etime=_endstr;
        stlk.sessNamestr=_sessionnamestr;
        NSLog(@"IN DID SELECT after login...%@.....%@",_locationstr,_sessionnamestr);
        
    }
    
    if([[segue identifier]isEqualToString:@"showSession"])
    {
        SessionViewController *s=[segue destinationViewController];
        s.temp_session_id=_tempSessid;
        s.stimestr=_startstr;
        s.locationstr=_locationstr;
        s.datestr=_datestr;
        s.sessionstr=_sessionnamestr;
        s.etimestr=_endstr;
    }
    if([[segue identifier]isEqualToString:@"showWomen"])
    {
        WomenViewController *s=[segue destinationViewController];
        s.sessionidStr=_tempSessid;
        s.stimeStr=_startstr;
        s.locStr=_locationstr;
        s.etimeStr=_endstr;
    }
    if([[segue identifier]isEqualToString:@"showPanel"])
    {
        TechTalkNewViewController *t=[segue destinationViewController];
        t.tempsessionid=_tempSessid;
        t.stimeStr=_startstr;
        t.locStr=_locationstr;
        t.etimeStr=_endstr;
        
    }
    
    if([[segue identifier]isEqualToString:@"showPoster"])
    {
        PosterViewController *ps=[segue destinationViewController];
        ps.temp_seesionid_str=_tempSessid;
    }
    
    if([[segue identifier]isEqualToString:@"showBreakfast"])
    {
        BreakViewController *b=[segue destinationViewController];
        b.startstr=_startstr;
        b.endstr=_endstr;
        b.locationstr=_locationstr;
        
    }
    
    if([[segue identifier]isEqualToString:@"showKey"])
    {
        KeyViewController *k=[segue destinationViewController];
        k.sessionidstr=_tempSessid;
        k.starttimestr=_startstr;
        k.locationstr=_locationstr;
        k.keynotetiltestr=_sessionnamestr;
        k.endtimestr=_endstr;
        
    }
    
    if([[segue identifier]isEqualToString:@"showInvited"])
    {
        InvitedInfoViewController *i=[segue destinationViewController];
        i.session_idstr=_tempSessid;
        i.etime=_endstr;
        i.stime=_startstr;
        i.sessNamestr=_sessionnamestr;
        i.locationstr=_locationstr;
        
    }

    
}
 

@end
