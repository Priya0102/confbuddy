//
//  ScheduleViewController.m
//  ITherm
//
//  Created by Anveshak on 1/30/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import "ScheduleViewController.h"
#import "PaperTableViewCell.h"
#import "Session_itherm.h"
#import "Paper_itherm.h"
#import "PanelSchViewController.h"
#import "DetaiScheduleViewController.h"
#import "ScheduleTableViewCell.h"
#import "SessTalkViewController.h"
#import "TechTalkNewViewController.h"
#import "PosterViewController.h"
#import "BreakViewController.h"
#import "KeyScheduleViewController.h"
#import "InvitedInfoViewController.h"
#import "CourseViewController.h"
#import "WomenSchViewController.h"
#import "CourseSchViewController.h"
#import "InvitedSheduleViewController.h"
#import "TalkSheduleViewController.h"
#import "Constant.h"
#define SYSTEM_VERSION_GREATERTHAN_OR_EQUALTO(v) ([[[UIDevice currentDevice]systemVersion] compare:v options:NSNumericSearch]!=NSOrderedAscending)
@interface ScheduleViewController ()

@end

@implementation ScheduleViewController

 -(void)viewDidLoad{
 [super viewDidLoad];
 
 [self.tableView setSeparatorColor:[UIColor clearColor]];
     self.segView.tintColor = [UIColor colorWithRed:20.0/255.0 green:102.0/255.0 blue:152.0/255.0 alpha:1.0];
     
     [self.segView setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
     
     
     self.line1.hidden=YES;
     self.line2.hidden=YES;
     self.line3.hidden=YES;
     self.line4.hidden=YES;
 
 self.date.text=@"29 May 2018";
 self.all_sessions=[[NSMutableArray alloc]init];
 
 self.user_papers=[[NSMutableArray alloc]init];
 
 _tableView.delegate=self;
 _tableView.dataSource=self;
 
 [_segView setUserInteractionEnabled:NO];
 
 
 
 }
 
 -(void)viewWillAppear:(BOOL)animated
 {
 [super viewWillAppear:YES];
NSString *emailid=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
     if (emailid==NULL) {
         UIAlertController * alert=[UIAlertController
                                    
                                    alertControllerWithTitle:@"Alert!" message:@"Please login to view my Schedule"preferredStyle:UIAlertControllerStyleAlert];
         
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

 [self sessionParsing];
         
     }
 //[self.tableView reloadData];
 
 //[self segvaluechanged:_segView];
 //[_all_sessions removeAllObjects];
 //[_user_papers removeAllObjects];
 
 // [self paperParsing];
 
 
 }
 
 
 #pragma mark - Table view data source
 
 - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
      return 1;
 }
 
 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
      return self.session.count;
 }
 
 
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
 ScheduleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
 
 
 Session_itherm *sess=self.session[indexPath.row];
 cell.sessionName.text=sess.session_name;
 cell.locationName.text=sess.room_name;
 cell.startTime.text=sess.start_time;
 cell.endTime.text=sess.end_time;
 cell.category.text=sess.category;
 cell.sessidLbl.text=sess.session_id;
 
 cell.delBtn.tag=indexPath.row;
 
 NSLog(@"My Schedule Session name%@",cell.sessionName.text);
 
     if([cell.category.text isEqualToString:@"Keynote"])
     {
         cell.category.backgroundColor=[UIColor colorWithRed:255.0/255.0 green:237.0/255.0 blue:202.0/255.0 alpha:1.0];
         cell.category.layer.borderColor=(__bridge CGColorRef _Nullable)([UIColor colorWithRed:(247.0/225.0) green:(209.0/225.0) blue:(148.0/255.0)alpha:1.0]);
     }
     else if([cell.category.text isEqualToString:@"Techtalk"])
     {
         cell.category.backgroundColor=[UIColor colorWithRed:205.0/255.0 green:241.0/255.0 blue:249.0/255.0 alpha:1.0];
         
         cell.category.layer.borderColor=(__bridge CGColorRef _Nullable)([UIColor colorWithRed:(130.0/225.0) green:(217.0/225.0) blue:(224.0/255.0)alpha:1.0]);
     }
     else if([cell.category.text isEqualToString:@"Panel"])
     {
         cell.category.backgroundColor=[UIColor colorWithRed:255.0/255.0 green:227.0/255.0 blue:227.0/255.0 alpha:1.0];
         cell.category.layer.borderColor=(__bridge CGColorRef _Nullable)([UIColor colorWithRed:(252.0/225.0) green:(197.0/225.0) blue:(197.0/255.0)alpha:1.0]);
     }
     
     else if([cell.category.text isEqualToString:@"Course"])
     {
         cell.category.backgroundColor=[UIColor colorWithRed:225.0/255.0 green:255.0/255.0 blue:231.0/255.0 alpha:1.0];
         
         cell.category.layer.borderColor=(__bridge CGColorRef _Nullable)([UIColor colorWithRed:166.0/255.0 green:224.0/255.0 blue:176.0/255.0 alpha:1.0]);
         
     }
     else if([cell.category.text isEqualToString:@"Invited"])
     {
         cell.category.backgroundColor=[UIColor colorWithRed:223.0/255.0 green:230.0/255.0 blue:247.0/255.0 alpha:1.0];
         cell.category.layer.borderColor=(__bridge CGColorRef _Nullable)([UIColor colorWithRed:163.0/255.0 green:188.0/255.0 blue:239.0/255.0 alpha:1.0]);
     }
     else if([cell.category.text isEqualToString:@"Women"])
     {
         cell.category.backgroundColor=[UIColor colorWithRed:255.0/255.0 green:230.0/255.0 blue:247.0/255.0 alpha:1.0];
         cell.category.layer.borderColor=(__bridge CGColorRef _Nullable)([UIColor colorWithRed:(249.0/225.0) green:(183.0/225.0) blue:(230.0/255.0) alpha:1.0]);
         
     }
     else if([cell.category.text isEqualToString:@"Poster"])
     {
         cell.category.backgroundColor=[UIColor colorWithRed:255.0/255.0 green:254.0/255.0 blue:222.0/255.0 alpha:1.0];
         cell.category.layer.borderColor=(__bridge CGColorRef _Nullable)([UIColor colorWithRed:(229.0/225.0) green:(223.0/225.0) blue:(140.0/255.0) alpha:1.0]);
     }
     else if([cell.category.text isEqualToString:@"Break"])
     {
         cell.category.backgroundColor=[UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1.0];
         cell.category.layer.borderColor=(__bridge CGColorRef _Nullable)([UIColor colorWithRed:(204.0/225.0) green:(204.0/225.0) blue:(204.0/255.0) alpha:1.0]);
     }
     else
     {
         cell.category.backgroundColor=[UIColor colorWithRed:243.0/255.0 green:224.0/255.0 blue:252.0/255.0 alpha:1.0];
         cell.category.layer.borderColor=(__bridge CGColorRef _Nullable)([UIColor colorWithRed:220.0/255.0 green:184.0/255.0 blue:244.0/255.0 alpha:1.0]);
         
     }
     
//     
// if([cell.category.text isEqualToString:@"Keynote"])
// {
// cell.category.backgroundColor=[UIColor greenColor];
// }
// else if([cell.category.text isEqualToString:@"Techtalk"])
// {
// cell.category.backgroundColor=[UIColor orangeColor];
// }
// else if([cell.category.text isEqualToString:@"Panel"])
// {
// cell.category.backgroundColor=[UIColor blueColor];
// }
// 
// else if([cell.category.text isEqualToString:@"Course"])
// {
// cell.category.backgroundColor=[UIColor purpleColor];
// 
// }
// else if([cell.category.text isEqualToString:@"Invited"])
// {
// cell.category.backgroundColor=[UIColor cyanColor];
// }
// else if([cell.category.text isEqualToString:@"Women"])
// {
// cell.category.backgroundColor=[UIColor colorWithRed:8.0/255.0 green:42.0/255.0 blue:127.0/255.0 alpha:1.0];
// 
// }
// else if([cell.category.text isEqualToString:@"Poster"])
// {
// cell.category.backgroundColor=[UIColor magentaColor];
// }
// 
// else
// {
// cell.category.backgroundColor=[UIColor lightGrayColor];
// }
 
 return cell;
 }
 
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 
 return YES;
 }
 
 
 -(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 {
 ScheduleTableViewCell *cell=[_tableView cellForRowAtIndexPath:indexPath];
 _tempcatog=cell.category.text;
 _tempsessionName=cell.sessionName.text;
 _tempsessid=cell.sessidLbl.text;
 _tempstart=cell.startTime.text;
 _tempend=cell.endTime.text;
 _temploc=cell.locationName.text;
 _category_str=cell.category.text;
 
 
 if([_tempcatog isEqualToString:@"Session"])
 {
 [self performSegueWithIdentifier:@"showDetailSchedule" sender:self];
 }
 else if([_tempcatog isEqualToString:@"Women"])
 {
 [self performSegueWithIdentifier:@"showDetailSchWomen" sender:self];
 }
 else if([_tempcatog isEqualToString:@"Keynote"])
 {
 [self performSegueWithIdentifier:@"showSchKey" sender:self];
 }
 else if([_tempcatog isEqualToString:@"Panel"])
 {
 [self performSegueWithIdentifier:@"showDetailSchPanel" sender:self];
 }
 else if([_tempcatog isEqualToString:@"Invited"])
 {
 [self performSegueWithIdentifier:@"showShechduleInvited" sender:self];
 }
 else if([_tempcatog isEqualToString:@"Techtalk"])
 {
 [self performSegueWithIdentifier:@"showTalkSchedule" sender:self];
 }
 else if([_tempcatog isEqualToString:@"Poster"])
 {
 [self performSegueWithIdentifier:@"showDetailSchPoster" sender:self];
 }
 else if([_tempcatog isEqualToString:@"Course"])
 {
 [self performSegueWithIdentifier:@"showDetailSchCourse" sender:self];
 }
 
 }
 
 
 - (IBAction)segvaluechanged:(id)sender {
 
 if(_segView.selectedSegmentIndex==0)
 {
 NSString *title=@"Tuesday";
 NSPredicate *predicate1=[NSPredicate predicateWithFormat:@"day matches %@",title];
 self.papers =(NSMutableArray *)[self.user_papers filteredArrayUsingPredicate:predicate1];
 [self.tableView reloadData];
 NSPredicate *predicate2=[NSPredicate predicateWithFormat:@"day matches %@",title];
 self.session = (NSMutableArray *)[self.all_sessions filteredArrayUsingPredicate:predicate2];
     self.line1.hidden=false;
     self.line2.hidden=true;
     self.line3.hidden=true;
     self.line4.hidden=true;
 [self.tableView reloadData];
 //self.date.text=@"30 May 2017";
 }
 else if(_segView.selectedSegmentIndex==1)
 {
 NSString *title=@"Wednesday";
 NSPredicate *predicate1=[NSPredicate predicateWithFormat:@"day matches %@",title];
 self.papers =(NSMutableArray *)[self.user_papers filteredArrayUsingPredicate:predicate1];
 [self.tableView reloadData];
 NSPredicate *predicate2=[NSPredicate predicateWithFormat:@"day matches %@",title];
 self.session = (NSMutableArray *)[self.all_sessions filteredArrayUsingPredicate:predicate2];
     self.line1.hidden=YES;
     self.line2.hidden=NO;
     self.line3.hidden=YES;
     self.line4.hidden=YES;
 [self.tableView reloadData];
 // self.date.text=@"31 May 2017";
 }
 else if(_segView.selectedSegmentIndex==2)
 {
 NSString *title=@"Thursday";
 NSPredicate *predicate1=[NSPredicate predicateWithFormat:@"day matches %@",title];
 self.papers =(NSMutableArray *)[self.user_papers filteredArrayUsingPredicate:predicate1];
 [self.tableView reloadData];
 NSPredicate *predicate2=[NSPredicate predicateWithFormat:@"day matches %@",title];
 self.session =(NSMutableArray *) [self.all_sessions filteredArrayUsingPredicate:predicate2];
     self.line1.hidden=YES;
     self.line2.hidden=YES;
     self.line3.hidden=NO;
     self.line4.hidden=YES;
     
 [self.tableView reloadData];
 //  self.date.text=@"01 June 2017";
 }
 else if(_segView.selectedSegmentIndex==3)
 {
 NSString *title=@"Friday";
 NSPredicate *predicate1=[NSPredicate predicateWithFormat:@"day matches %@",title];
 self.papers =(NSMutableArray *)[self.user_papers filteredArrayUsingPredicate:predicate1];
 [self.tableView reloadData];
 NSPredicate *predicate2=[NSPredicate predicateWithFormat:@"day matches %@",title];
 self.session = (NSMutableArray *)[self.all_sessions filteredArrayUsingPredicate:predicate2];
     self.line1.hidden=YES;
     self.line2.hidden=YES;
     self.line3.hidden=YES;
     self.line4.hidden=NO;
 [self.tableView reloadData];
 
 }
 
 

}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if([[segue identifier]isEqualToString:@"showDetailSchedule"])
    {
        DetaiScheduleViewController *d=[segue destinationViewController];
        d.tempsessionName=_tempsessionName;
        d.tempsessionid=_tempsessid;
        d.startstr=_tempstart;
        d.endstr=_tempend;
        d.locstr=_temploc;
        
    }
    if([[segue identifier]isEqualToString:@"showTalkSchedule"])
    {
        TalkSheduleViewController  *stlk=[segue destinationViewController];
        stlk.session_idstr=_tempsessid;
        stlk.stime=_tempstart;
        stlk.locationstr=_temploc;
        stlk.etime=_tempend;
        stlk.sessNamestr=_tempsessionName;
        stlk.categorystr=_category_str;
        NSLog(@"SESSSION talk ID==%@",_tempsessid);
        
    }
    
    if([[segue identifier]isEqualToString:@"showDetailSchPanel"])
    {
        PanelSchViewController *t=[segue destinationViewController];
        t.tempsessionid=_tempsessid;
        t.stimeStr=_tempstart;
        t.etimeStr=_tempend;
        t.locStr=_temploc;
        t.sessionstr=_tempsessionName;
        
    }
    
    if([[segue identifier]isEqualToString:@"showDetailSchPoster"])
    {
        PosterViewController *ps=[segue destinationViewController];
        ps.temp_seesionid_str=_tempsessid;
        NSLog(@"SESSSION POSTER ID==%@",_tempsessid);
    }
    
    if([[segue identifier]isEqualToString:@"showSchKey"])
    {
        KeyScheduleViewController *k=[segue destinationViewController];
        k.tempsessionid=_tempsessid;
        k.starttimestr=_tempstart;
        k.endtimestr=_tempend;
        k.sess_namestr=_tempsessionName;
        k.locationstr=_temploc;
        
        NSLog(@"sesion_id==%@ location==%@ session===%@ starttime=%@ endtime=%@",_tempsessid,_temploc,_tempsessionName,_tempstart,_tempend);
    }
    
    if([[segue identifier]isEqualToString:@"showShechduleInvited"])
    {
        InvitedSheduleViewController *i=[segue destinationViewController];
        i.session_idstr=_tempsessid;
        i.etime=_tempend;
        i.stime=_tempstart;
        i.sessNamestr=_tempsessionName;
        i.locationstr=_temploc;
        i.categorystr=_category_str;
    }
    
    if([[segue identifier]isEqualToString:@"showDetailSchWomen"])
    {
        WomenSchViewController *w=[segue destinationViewController];
        w.sessionidStr=_tempsessid;
        w.stimeStr=_tempstart;
        w.etimeStr=_tempend;
        w.locStr=_temploc;
        w.session_namestr=_tempsessionName;
    }
    if([[segue identifier]isEqualToString:@"showDetailSchCourse"])
    {
        CourseSchViewController *d=[segue destinationViewController];
        d.sessionnamestr=_tempsessionName;
        d.temp_session_id=_tempsessid;
        d.stimestr=_tempstart;
        d.etimestr=_tempend;
        d.locationstr=_temploc;
    }
    
    
}


-(void)sessionParsing
{
    [_all_sessions removeAllObjects];
    
    
    
    NSString *savedvalue=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
    NSString *myst=[NSString stringWithFormat:@"emailid=%@",savedvalue];//2
    
    NSURLSessionConfiguration *defaultConfigObject=[NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *defaultSession=[NSURLSession sessionWithConfiguration:defaultConfigObject delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:user_session_get]];
    
    //NSURL * url = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/user_session_get.php"];
    
    
    NSMutableURLRequest *urlRequest=[NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest  setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLSessionDataTask *dataTask=[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)                                    {
        if (error) {
            
            NSLog(@"error=%@",error.description);
        }
        
        NSString *text=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"data is= %@",text);
        NSError *error1=nil;
        NSDictionary *responsedict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error1];
        if (error1) {
            NSLog(@"Error is %@",error1.description);
        }
        NSLog(@"json=%@",responsedict);
        
        NSArray *agenda=[responsedict objectForKey:@"agendamaster"];
        NSLog(@"Notification count %lu",(unsigned long)agenda.count);
        
        if(agenda.count==0)
        {
            _noSchedule = [[UITextView alloc]initWithFrame:
                           CGRectMake(80, 200, 400, 300)];
            [_noSchedule setText:@"Nothing is Scheduled..."];
            [_noSchedule setTextColor:[UIColor grayColor]];
            [_noSchedule setFont:[UIFont fontWithName:@"ArialMT" size:16]];
            _noSchedule.delegate =self;
            [self.view addSubview:_noSchedule];
            
        }
        else {
            
            for(NSDictionary *dict in agenda){
                Session_itherm *sess=[[Session_itherm alloc]init];
                sess.session_name=dict[@"session_name"];
                sess.room_name=dict[@"room_name"];
                sess.date=dict[@"date"];
                sess.day=dict[@"day"];
                sess.start_time=dict[@"start_time"];
                sess.end_time=dict[@"end_time"];
                sess.program_type_id=dict[@"program_type_id"];
                sess.session_id=dict[@"session_id"];//for passing session_id
                sess.category=dict[@"category"];
                NSLog(@"session name is %@",sess.session_name);
                [self.all_sessions addObject:sess];
                
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSLog(@"COUNT=%lu",(unsigned long)self.all_sessions.count);
            for(Session_itherm *sess in self.all_sessions) {
                NSLog(@"session name is %@",sess.day);
            }
            //Session_itherm *sess=self.all_sessions[0];//going in exception so commented here at 30 Jan 2018
            // NSLog(@"room name is %@",sess.room_name);
            NSPredicate *predicate=[NSPredicate predicateWithFormat:@"day matches 'Tuesday'"];//for selecting first seg data or loading first seg selected data
            self.session = (NSMutableArray *)[self.all_sessions filteredArrayUsingPredicate:predicate];
            [self.tableView reloadData];
           // [_indicator stopAnimating];
            [self segvaluechanged:_segView];
            [_segView setUserInteractionEnabled:YES];
        });
    }];
    
    [dataTask resume];
}

- (IBAction)deleteButtonClick:(id)sender {
    UIButton *btn =(UIButton *)sender;
    NSLog(@"%ld",(long)btn.tag);
    
    
    
    UIAlertController * alert=[UIAlertController
                               
                               alertControllerWithTitle:@"ALERT" message:@"Do You Want To Delete Record?"preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes, please"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    
                                    Session_itherm *s2=self.session[btn.tag];
                                    NSLog(@"session id is=%@",s2.session_id);
                                    
                                    [self.all_sessions removeObjectAtIndex:btn.tag];
                                    //[_tableView reloadData];
                                    
                                    
                                    NSString *savedValue=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
                                    NSString *myst=[NSString stringWithFormat:@"emailid=%@&session_id=%@&category=%@",savedValue,s2.session_id,s2.category];
                                    NSLog(@"my string in schedule tab=%@",myst);
                                    
                                    
                                    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
                                    NSURLSession *session=[NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
                                    
                                    NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:sessiondelnew]];
                                    
                                    //NSURL * url = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/sessiondelnew.php"];
                                    
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
                                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                                        
                                                                        NSLog(@"COUNT=%lu",(unsigned long)self.all_sessions.count);
                                                                        for(Session_itherm *sess in self.all_sessions) {
                                                                            NSLog(@"session name is %@",sess.day);
                                                                        }
                                                                        //Session_itherm *sess=self.all_sessions[0];
                                                                        //NSLog(@"room name is %@",sess.room_name);
                                                                        int i=0;
                                                                        for (Session_itherm *sessionId in self.all_sessions) {
                                                                            if ([sessionId.session_id isEqualToString:s2.session_id]) {
                                                                                break;
                                                                            }
                                                                            i++;
                                                                        }
                                                                        
                                                                        [self.all_sessions removeObjectAtIndex:i];
                                                                       // [self.session removeObjectAtIndex:btn.tag];
                                                                        
                                                                        
                                                                        [self.tableView reloadData];
                                                                        
                                                                        
                                                                    });
                                                                    
                                                                    
                                                                }];
                                    
                                    [task resume];
                                    
                                    [self viewWillAppear:YES];
                                    [self.tableView reloadData];
                                    
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
    //[self.tableView reloadData];
    [self presentViewController:alert animated:YES completion:nil];
    
    
    // NSLog(@"%@",[_all_sessions objectAtIndex:indexPath.row]);
    // NSString *delstr=[NSString stringWithFormat:@"%@",[_all_sessions objectAtIndex:indexPath.row]];
}


/*
 
 
 
 NSString *title=[self.segView titleForSegmentAtIndex:self.segView.selectedSegmentIndex];
 
 
 if([title isEqualToString:@"Wednesday"])
 {
 self.date.text=@"31 May 2017";
 }
 else if([title isEqualToString:@"Friday"])
 {
 self.date.text=@"02 June 2017";
 }
 else if([title isEqualToString:@"Thursday"])
 {
 self.date.text=@"01 June 2017";
 }
 else if([title isEqualToString:@"Tuesday"])
 {
 self.date.text=@"30 May 2017";
 }
 
 
 NSPredicate *predicate1=[NSPredicate predicateWithFormat:@"day matches %@",title];
 self.papers = [self.user_papers filteredArrayUsingPredicate:predicate1];
 NSLog(@"count is %lu",(unsigned long)self.papers.count);
 for(Paper_itherm *ppr in self.papers) {
 NSLog(@"paper name is %@",ppr.paper_name);
 }
 
 NSPredicate *predicate2=[NSPredicate predicateWithFormat:@"day matches %@",title];
 self.session = [self.all_sessions filteredArrayUsingPredicate:predicate2];
 NSLog(@"count is %lu",(unsigned long)self.session.count);
 for(Session_itherm *sess in self.session)
 {
 NSLog(@"session name is %@",sess.session_name);
 }
 
 [self.tableView reloadData];
 
 
 }
 
 
 -(void)sessionParsing
 {
 
 [_all_sessions removeAllObjects];
 
 NSString *savedvalue=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
 NSString *myst=[NSString stringWithFormat:@"emailid=%@",savedvalue];//2
 
 NSURLSessionConfiguration *defaultConfigObject=[NSURLSessionConfiguration defaultSessionConfiguration];
 
 NSURLSession *defaultSession=[NSURLSession sessionWithConfiguration:defaultConfigObject delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
 
 NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:user_session_get]];
 
 //NSURL * url = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/user_session_get.php"];
 
 
 NSMutableURLRequest *urlRequest=[NSMutableURLRequest requestWithURL:url];
 [urlRequest setHTTPMethod:@"POST"];
 [urlRequest  setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
 NSURLSessionDataTask *dataTask=[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)                                    {
 if (error) {
 
 NSLog(@"error=%@",error.description);
 }
 
 NSString *text=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
 NSLog(@"data is= %@",text);
 NSError *error1=nil;
 NSDictionary *responsedict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error1];
 if (error1) {
 NSLog(@"Error is %@",error1.description);
 }
 NSLog(@"json=%@",responsedict);
 
 NSArray *agenda=[responsedict objectForKey:@"agendamaster"];
 NSLog(@"Notification count %lu",(unsigned long)agenda.count);
 
 if(agenda.count==0)
 {
 _noSchedule = [[UITextView alloc]initWithFrame:
 CGRectMake(80, 200, 400, 300)];
 [_noSchedule setText:@"Nothing is Scheduled..."];
 [_noSchedule setTextColor:[UIColor grayColor]];
 [_noSchedule setFont:[UIFont fontWithName:@"ArialMT" size:16]];
 _noSchedule.delegate =self;
 [self.view addSubview:_noSchedule];
 
 
 }
 else {
 
 for(NSDictionary *dict in agenda){
 Session_itherm *sess=[[Session_itherm alloc]init];
 sess.session_name=dict[@"session_name"];
 sess.room_name=dict[@"room_name"];
 sess.date=dict[@"date"];
 sess.day=dict[@"day"];
 sess.start_time=dict[@"start_time"];
 sess.end_time=dict[@"end_time"];
 sess.program_type_id=dict[@"program_type_id"];
 sess.session_id=dict[@"session_id"];//for passing session_id
 sess.category=dict[@"category"];
 NSLog(@"session name is %@",sess.session_name);
 [self.all_sessions addObject:sess];
 
 }
 }
 dispatch_async(dispatch_get_main_queue(), ^{
 
 NSLog(@"COUNT=%lu",(unsigned long)self.all_sessions.count);
 for(Session_itherm *sess in self.all_sessions) {
 NSLog(@"session name is %@",sess.day);
 }
 //Session_itherm *sess=self.all_sessions[0];//going in exception so commented here at 30 Jan 2018
 // NSLog(@"room name is %@",sess.room_name);
 NSPredicate *predicate=[NSPredicate predicateWithFormat:@"day matches 'Tuesday'"];//for selecting first seg data or loading first seg selected data
 self.sessionarr = [self.all_sessions filteredArrayUsingPredicate:predicate];
 [self.tableView reloadData];
 [_indicator stopAnimating];
 [self segvaluechanged:_segView];
 [_segView setUserInteractionEnabled:YES];
 });
 }];
 
 [dataTask resume];
 }
 
 - (IBAction)deleteButtonClick:(id)sender {
 UIButton *btn =(UIButton *)sender;
 NSLog(@"btn tag===%ld",(long)btn.tag);
 
 Session_itherm *s2=self.sessionarr[btn.tag];
 NSLog(@"session id is=%@",s2.session_id);
 
 UIAlertController * alert=[UIAlertController
 
 alertControllerWithTitle:@"ALERT" message:@"Do You Want To Delete Record?"preferredStyle:UIAlertControllerStyleAlert];
 
 UIAlertAction* yesButton = [UIAlertAction
 actionWithTitle:@"Yes, please"
 style:UIAlertActionStyleDefault
 handler:^(UIAlertAction * action)
 {
 
 Session_itherm *s2=self.sessionarr[btn.tag];
 NSLog(@"session id is=%@",s2.session_id);
 
 [_all_sessions removeObjectAtIndex:btn.tag];
 
 //self.sessionarr = [_all_sessions copy];
 
 NSString *savedValue=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
 NSString *myst=[NSString stringWithFormat:@"emailid=%@&session_id=%@&category=%@",savedValue,s2.session_id,s2.category];
 NSLog(@"my string in schedule tab=%@",myst);
 
 
 NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
 NSURLSession *session=[NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
 
 NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:sessiondelnew]];
 
 //NSURL * url = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/sessiondelnew.php"];
 
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
 NSLog(@"json in schedule tab = %@",responsedict);
 dispatch_async(dispatch_get_main_queue(), ^{
 
 NSLog(@"COUNT=%lu",(unsigned long)self.all_sessions.count);
 for(Session_itherm *sess in self.all_sessions) {
 NSLog(@"session name is %@",sess.day);
 
 }
 // [_tableView reloadData];
 
 });
 
 }];
 //  [_tableView reloadData];
 
 [task resume];
 
 [self viewWillAppear:YES];
 [self.tableView reloadData];
 
 
 
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
 
 */





@end
