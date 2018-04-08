//
//  MainViewController.m
//  ITherm
//
//  Created by Anveshak on 2/27/18.
//  Copyright © 2018 Anveshak . All rights reserved.
//

#import "MainViewController.h"
#import "Constant.h"
#import "UpcomingSession.h"
#import "UpcomingSessionTableViewCell.h"
#import "CourseViewController.h"
#import "SessionViewController.h"
#import "SessTalkViewController.h"
#import "InvitedInfoViewController.h"
#import "BreakViewController.h"
#import "KeyViewController.h"
#import "PosterViewController.h"
#import "TechTalkNewViewController.h"
#import "WomenViewController.h"
@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     _que=[[NSOperationQueue alloc]init];
  
    
    [self getKeynoteCount];
    [self getTotalSessionCount];
    
    self.view1.layer.masksToBounds=YES;
    self.view1.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.view1.layer.cornerRadius=5;
    self.view1.layer.borderWidth=0.2;
   
    self.view2.layer.masksToBounds=YES;
    self.view2.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.view2.layer.cornerRadius=5;
    self.view2.layer.borderWidth=0.2;
    
    self.view3.layer.masksToBounds=YES;
    self.view3.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.view3.layer.cornerRadius=5;
    self.view3.layer.borderWidth=0.2;
    
    self.profilePic.layer.masksToBounds=YES;
    self.profilePic.layer.borderColor=_profilePic.layer.borderColor=([UIColor colorWithRed:(211.0/225.0) green:(211.0/225.0) blue:(211.0/255.0)alpha:1.0].CGColor);
    
    self.profilePic.layer.borderWidth=1.1;
    self.profilePic.layer.cornerRadius = self.profilePic.frame.size.width / 2;
    self.profilePic.clipsToBounds = YES;
    
    
    self.signInBtn.layer.masksToBounds=YES;
    self.signInBtn.layer.cornerRadius=5;

    self.registerBtn.layer.masksToBounds=YES;
    self.registerBtn.layer.cornerRadius=5;
    
    self.viewSessionBtn.layer.masksToBounds=YES;
    self.viewSessionBtn.layer.cornerRadius=5;

    self.addSchBtn.layer.masksToBounds=YES;
    self.addSchBtn.layer.cornerRadius=5;
    
    
    self.btnTotalSession.layer.masksToBounds=YES;
    self.btnTotalSession.layer.cornerRadius=5;
    self.btnTotalSession.layer.borderColor=([UIColor colorWithRed:(84.0/225.0) green:(211.0/225.0) blue:(199.0/255.0)alpha:1.0].CGColor);
    self.btnTotalSession.layer.borderWidth=1.0;
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    
    gradient.frame = _btnTotalSession.bounds;
    gradient.colors = @[(id)[UIColor colorWithRed:(208.0/225.0) green:(234.0/225.0) blue:(229.0/255.0)alpha:1.0].CGColor, (id)[UIColor colorWithRed:(131.0/225.0) green:(234.0/225.0) blue:(229.0/255.0)alpha:1.0].CGColor];
    
    [_btnTotalSession.layer insertSublayer:gradient atIndex:0];
    
    
    self.keynoteBtn.layer.masksToBounds=YES;
    self.keynoteBtn.layer.cornerRadius=8;
    self.keynoteBtn.layer.borderColor=([UIColor colorWithRed:(88.0/225.0) green:(211.0/225.0) blue:(244.0/255.0)alpha:1.0].CGColor);
     self.keynoteBtn.layer.borderWidth=1.0;
    
    CAGradientLayer *gradient1 = [CAGradientLayer layer];
    
    gradient1.frame = _keynoteBtn.bounds;
    gradient1.colors = @[(id)[UIColor colorWithRed:(178.0/225.0) green:(239.0/225.0) blue:(239/255.0)alpha:1].CGColor, (id)[UIColor colorWithRed:(138/225.0) green:(239/225.0) blue:(239/255.0)alpha:1].CGColor];
    
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
    
//    [_viewSessionBtn addTarget:self action:@selector(buttonPressed:)
//     forControlEvents:UIControlEventTouchUpInside];
    
    _tableview2.delegate=self;
    _tableview2.dataSource=self;
    
    _upcomingSessions=[[NSMutableArray alloc]init];
    _upcomingDateArray=[[NSMutableArray alloc]init];
    _upcomingTimeArray=[[NSMutableArray alloc]init];
    _upcomingSessionArr=[[NSMutableArray alloc]init];
    _upcomingLocationArr=[[NSMutableArray alloc]init];
    _upcomingSessDetailArr=[[NSMutableArray alloc]init];
    
    [self upcomingSessionParsing];
    
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
        return self.upcomingSessions.count;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   
        UpcomingSessionTableViewCell *cell = [self.tableview2 dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
        UpcomingSession *ktemp=[_upcomingSessions objectAtIndex:indexPath.row];
        cell.startTime.text=ktemp.startTimeStr;
        cell.upcomingDate.text=ktemp.dateStr;
        cell.upcomingLocation.text=ktemp.roomnameStr;
        cell.upcomingSessionName.text=ktemp.sessionNameStr;
        cell.upcomingSessionDetails.text=ktemp.sessionDetailsStr;
        cell.sessionid.text=ktemp.sessionidStr;
        cell.endtime.text=ktemp.endtimeStr;
        
    
    return cell;
}

//- (void)buttonPressed:(UIButton *)button {
//    NSLog(@"Button Pressed");
//    
//    if ([self.programidStr isEqualToString:@"1"]) {
//        UIViewController *admin=[self.storyboard instantiateViewControllerWithIdentifier:@"showSession"];
//        
//        [self presentViewController:admin animated:YES completion:nil];
//    }
//    else if ([self.programidStr isEqualToString:@"2"]){
//        UIViewController *admin=[self.storyboard instantiateViewControllerWithIdentifier:@"showKey"];
//        
//        [self presentViewController:admin animated:YES completion:nil];
//    }
//    else if ([self.programidStr isEqualToString:@"3"]){
//        UIViewController *admin=[self.storyboard instantiateViewControllerWithIdentifier:@"showTalk"];
//        
//        [self presentViewController:admin animated:YES completion:nil];
//    }
//    else if ([self.programidStr isEqualToString:@"4"]){
//        UIViewController *admin=[self.storyboard instantiateViewControllerWithIdentifier:@"showCourse"];
//         NSLog(@"Course Button Pressed");
//        
//        [self presentViewController:admin animated:YES completion:nil];
//    }
//    
//}
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getKeynoteCount{
 
    
    NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:get_keynote_count]];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    
    NSURLSessionConfiguration *configuration=[NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session=[NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                {
                                    
                                    if(error == nil)
                                    {
                                        NSDictionary *outerdic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                
                                        
                                        NSString *text=[outerdic objectForKey:@"total_keynotes"];
                                        _keynoteCount.text=text;
                                        NSLog(@"keynoteCount count==%@",_keynoteCount.text);
                                        
                                    }
                                }];
    
    [task resume];
}
-(void)getTotalSessionCount{
    
        
    NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:get_total_session_count]];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    
    NSURLSessionConfiguration *configuration=[NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session=[NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                {
                                    
            if(error == nil)
            {
                NSDictionary *outerdic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                
                NSString *text=[outerdic objectForKey:@"total_sessions"];
                _totalSessionCount.text=text;
                NSLog(@"totalSessionCount count==%@",_totalSessionCount.text);
                
            }
        }];
        
        [task resume];
        
}


    
/*-(void)upcomingSessionparsing
    {

        NSBlockOperation *op1=[NSBlockOperation blockOperationWithBlock:^{
            
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
                                                
                                                
                                                NSLog(@"upcoming sessionn===%@",response);
                                                
                                                
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
    
                                                        _sessionidStr=str1;
                                                        _sessionNameStr=str2;
                                                        _startTimeStr=str3;
                                                        _dateStr=str4;
                                                        _roomnameStr=str5;
                                                        _programidStr=str6;
                                                        _categoryStr=str7;
                                                        _sessionDetailsStr=str8;
                                                    
                                                        _sessionName.text=_sessionNameStr;
                                                        _startTime.text=_startTimeStr;
                                                        _CurrentDate.text=_dateStr;
                                                        _location.text=_roomnameStr;
                                                       _sessionDetails.text=_sessionDetailsStr;
                                              
                                                }
                                                
                                            }
                                            
                                        }];
            [task resume];
            
        }];
        
        [_que addOperation:op1];
        
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
