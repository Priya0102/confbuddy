//
//  SessTalkViewController.m
//  ITherm
//
//  Created by Anveshak on 5/19/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import "SessTalkViewController.h"
#import "TalkInfoViewController.h"
#import "TalkTableViewCell.h"
#import "Reachability.h"
#import "Session_itherm.h"
#import "Talk_itherm.h"
#import "Constant.h"

#define SYSTEM_VERSION_GREATERTHAN_OR_EQUALTO(v) ([[[UIDevice currentDevice]systemVersion] compare:v options:NSNumericSearch]!=NSOrderedAscending)
@interface SessTalkViewController ()

@end

@implementation SessTalkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_indicator startAnimating];
    _tickarray=[[NSMutableArray alloc]init];
    self.talk_id=[[NSMutableArray alloc]init];
    
    self.chairimage.layer.cornerRadius = self.chairimage.frame.size.width / 2;
    self.chairimage.clipsToBounds = YES;

    _tableView.delegate=self;
    _tableView.dataSource=self;
    
    self.user_papers=[[NSMutableArray alloc]init];
    self.talkArray=[[NSMutableArray alloc]init];
    
    _sessionName.text=_sessNamestr;
    _endTime.text=_etime;
    _startTime.text=_stime;
    _location.text=_locationstr;
    _date.text=_datestr;
    
    _que=[[NSOperationQueue alloc]init];
    
    NSLog(@"SESSION ID IN TECH TALK....%@ %@",_session_idstr,_locationstr);

    
    [self userpaperget];
    
//    self.setButton.layer.masksToBounds=YES;
//    self.setButton.layer.borderColor=[UIColor blueColor].CGColor;
//    self.setButton.layer.borderWidth=1.1;
//    self.setButton.layer.cornerRadius=10;
    
    [self.tableView setSeparatorColor:[UIColor clearColor]];
    
    self.viewMapBtn.layer.masksToBounds=YES;
    self.viewMapBtn.layer.borderColor=[UIColor colorWithRed:20.0/255.0 green:72.0/255.0 blue:114.0/255.0 alpha:1.0].CGColor;
    self.viewMapBtn.layer.borderWidth=1.1;
    self.viewMapBtn.layer.cornerRadius=10;
}

- (void)viewWillAppear:(BOOL)animated
{
    //[self.tableView reloadData];
    [self dataParsing];
    
    NSLog(@"TICK ARRAY COUNT IN Will Appear....%lu",(unsigned long)_tickarray.count);
    NSLog(@"hi");
    
    [super viewWillAppear:YES];
    
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    NetworkStatus netStatus = [reach currentReachabilityStatus];
    if (netStatus == NotReachable)
    {
        //            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"No Internet Connection" message:@"Explain the situation to the user" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        //            [alert show];
        //            //   [alert release];
        UIAlertController * alert=[UIAlertController
                                   
                                   alertControllerWithTitle:@"Alert!" message:@"No Internet Connection"preferredStyle:UIAlertControllerStyleAlert];
        
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
        //other actions.
    }
    

}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
    {
        return 1;
    }
    
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
    {
        return _talkArray.count;
    }
    
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        TalkTableViewCell *cell=[_tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        Talk_itherm *t=[_talkArray objectAtIndex:indexPath.row];
        cell.talkName.text=t.talkName;
        cell.tickButton.tag=indexPath.row;
        cell.talkid.text=t.talkid;
        cell.starttime.text=t.start_time;
        
        [_indicator stopAnimating];
        
        NSString *tempadd=t.added;
        NSString *pprid=t.talkid;
        NSLog(@"paper id==%@",pprid);
        NSLog(@"Added===%@",t.added);
        
        if ([tempadd isEqual:[NSNull null]]) {
            NSLog(@"Tempdata is null.....");
            [cell.tickButton setImage:[UIImage imageNamed:@"addNew.png"] forState:UIControlStateNormal];
            [cell.tickButton setUserInteractionEnabled:YES];
        }
        else{
            NSLog(@"Show blue.......");
            // [_tickarray addObject:tempadd];
            [cell.tickButton setImage:[UIImage imageNamed:@"addedNew.png"] forState:UIControlStateNormal];
            [cell.tickButton setUserInteractionEnabled:NO];
            //         NSLog(@"tick array value********%@",_tickarray[indexPath.row]);
        }
        
        NSLog(@"Array Length : %lu",(unsigned long)_tickarray.count);
        for(int i=0;i<_tickarray.count;i++)
        {
            NSString *str;
            str=[NSString stringWithFormat:@"%@",_tickarray[i]];
            
            NSLog(@"talk id in scroll...in tick array  %@..%@..at location %d",pprid,str,i);
            if([str isEqualToString:pprid])
            {
                NSLog(@"print tick..%@..%@",pprid,str);
                [cell.tickButton setImage:[UIImage imageNamed:@"addedNew.png"] forState:UIControlStateNormal];
                
            }
            
            UIImageView *alarm_done=[[UIImageView alloc]init];
            alarm_done.image=[UIImage imageNamed:@"added-other.png"];
            
//            if (![self itemHasReminder:t.talkid]) {
//                // NSLog(@"in if loop");
//                cell.accessoryView=_setButton;
//                self.setButton.tag=indexPath.row;
//            }
//            else
//            {
//                cell.accessoryView =alarm_done;
//            }

        }
        
        return cell;
    }
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
    {
        Talk_itherm *i=[_talkArray objectAtIndex:indexPath.row];
        _temptalkname=i.talkName;
        _tempabs=i.abstract;
        _tempspeakerName=i.speakerName;
        _tempspuni=i.speakerUni;
        _location.text=i.location;
        _temptalkid=i.talkid;
        //_session_idstr=i.sessionidstr;
        
        NSLog(@"IN DidSelect..talkname==%@,location=%@ talkid==%@ sess id=%@",_temptalkname,_locationstr,_temptalkid,_session_idstr);
        
        
        [self performSegueWithIdentifier:@"showTalkInfo" sender:nil];
        
    }

//- (BOOL)itemHasReminder:(NSString *)item {
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"talk_id matches %@", item];
//    NSLog(@"item is %@",item);
//    NSArray *filtered = [self.talkArray filteredArrayUsingPredicate:predicate];
//    NSLog(@"filtered count is %lu",(unsigned long)filtered.count);
//    return ([filtered count]);
//    
//}
//

-(void)alarmMethod
{
    NSLog(@"alaram Method....Button Clicked....");
}

- (IBAction)setButton:(id)sender {
    
    
    NSString *emailid=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
    if (emailid==NULL) {
        UIAlertController * alert=[UIAlertController
                                   
                                   alertControllerWithTitle:@"Alert!" message:@"Please login to add in my schedule"preferredStyle:UIAlertControllerStyleAlert];
        
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
    
    UIButton *btn =(UIButton *)sender;
    
    NSLog(@"Btn Click...........%ld",(long)btn.tag);
    //Talk *tlk=self.talkArray[btn.tag];
    NSLog(@"* set alarm btn click");
    
    if(_tickarray.count==0)
    {
        
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:nil message:@"Please Select Paper First" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 //                                                                   [sender setBackgroundImage:[UIImage imageNamed:@"set-128.png"] forState:UIControlStateNormal];
                                 //                                                                  // [alertView dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        [alertView addAction:ok];
        [self presentViewController:alertView animated:YES completion:nil];
        
    }
    else
    {
    
        
        UIAlertController * alert=[UIAlertController
                                   
                                   alertControllerWithTitle:@"ALERT" message:@"Do you want To Add in My Schedule?"preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"Yes, please"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action)
                                    {
                                        //What we write here????????**
                                        
                                        NSLog(@"you pressed Yes, please button");
                                        
                                        for(int i=0;i<_tickarray.count;i++)
                                        {
                                            NSLog(@"******talk count ticked****************************%@",_tickarray[i]);
                                            
                                            NSString *talkidstr=[NSString stringWithFormat:@"%@",_tickarray[i]];
                                            
                                            Talk_itherm *p2=self.talkArray[btn.tag];
                                            NSLog(@"******alarm btn click");
                                            NSLog(@"%@talk...............",p2);
                                            [self.user_papers addObject:p2];//sending object directly to array for getting user sessions as per user cliked
                                            
                                          
                                            if(SYSTEM_VERSION_GREATERTHAN_OR_EQUALTO(@"10.0"))
                                            {
                                                UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
                                                [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert)
                                                                      completionHandler:^(BOOL granted, NSError * _Nullable error) {
                                                                          if (!error) {
                                                                              NSLog(@"request authorization succeeded!");
                                                                              // [self showAlert];
                                                                              //[btn setBackgroundImage:[UIImage imageNamed:@"addedNew.png"] forState:UIControlStateNormal];
                                                                              [self.tableView reloadData];
                                                                              
                                                                          }
                                                                          else
                                                                          {
                                                                              NSLog(@"user notification failed");
                                                                          }
                                                                      }];
                                                
                                                
                                                
                                                UNMutableNotificationContent *objNotificationContent = [[UNMutableNotificationContent alloc] init];
                                                
                                                NSString *s=[NSString stringWithFormat:@"Start-time: %@",p2.start_time];
                                                NSLog(@"...%@",s);
                                                objNotificationContent.title = [NSString localizedUserNotificationStringForKey:p2.talkName arguments:nil];
                                                objNotificationContent.body = [NSString localizedUserNotificationStringForKey:s arguments:nil];
                                                objNotificationContent.sound = [UNNotificationSound defaultSound];
                                                
                                                /// 4. update application icon badge number
                                                //objNotificationContent.badge = @([[UIApplication sharedApplication] applicationIconBadgeNumber] + 1);
                                                objNotificationContent.badge=0;
                                                
                                                NSDateFormatter *dt=[[NSDateFormatter alloc]init];
                                                [dt setDateFormat:@"dd MMMM yyyy"];
                                                //NSDate *date=[dt dateFromString:@"22 May 2017"];// For current testing purpose use current date
                                    
                                                  NSDate *date=[dt dateFromString:p2.date];
                                                
                                                NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
                                                
                                                
                                                NSDateComponents *weekdayComponents =[gregorianCalendar components:(NSCalendarUnitDay | NSCalendarUnitMonth |NSCalendarUnitYear) fromDate:date];
                                                
                                                NSLog(@"date com= %@",weekdayComponents);
                                                
                                                if ([p2.start_time isEqual:@"08:00 am"]) {
                                                    weekdayComponents.hour=07;
                                                    weekdayComponents.minute=55;
                                                }
                                                if ([p2.start_time isEqual:@"08:30 am"]) {
                                                    weekdayComponents.hour=8;
                                                    weekdayComponents.minute=25;
                                                }
                                                if ([p2.start_time isEqual:@"09:00 am"]) {
                                                    weekdayComponents.hour=8;
                                                    weekdayComponents.minute=55;
                                                }
                                                if ([p2.start_time isEqual:@"01:50 pm"]) {
                                                    weekdayComponents.hour=13;
                                                    weekdayComponents.minute=45;
                                                }
                                                if ([p2.start_time isEqual:@"02:20 pm"]) {
                                                    weekdayComponents.hour=14;
                                                    weekdayComponents.minute=15;
                                                }
                                                if ([p2.start_time isEqual:@"02:35 pm"]) {
                                                    weekdayComponents.hour=14;
                                                    weekdayComponents.minute=30;
                                                }
                                                
                                                if ([p2.start_time isEqual:@"03:10 pm"]) {
                                                    weekdayComponents.hour=15;
                                                    weekdayComponents.minute=05;
                                                }
                                               

                                                UNTimeIntervalNotificationTrigger *trigger1 = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:50.f repeats:NO];
                                                
                                                 NSLog(@"trigerrr==%@",trigger1);
                                                
                                                UNCalendarNotificationTrigger *trigger=[UNCalendarNotificationTrigger triggerWithDateMatchingComponents:weekdayComponents repeats:NO];
                                                
                                                UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:p2.talkid
                                                                                                                      content:objNotificationContent trigger:trigger];
                                                /// 3. schedule localNotification
                                                UNUserNotificationCenter *center1 = [UNUserNotificationCenter currentNotificationCenter];
                                                [center1 addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
                                                    if (!error) {
                                                        NSLog(@"Local Notification succeeded");
                                                    }
                                                    else {
                                                        NSLog(@"Local Notification failed");
                                                    }
                                                }];
                                            }
                                            else
                                            {
                                                NSDateFormatter *dt=[[NSDateFormatter alloc]init];
                                                [dt setDateFormat:@"dd MMMM yyyy"];
                                                //NSDate *date=[dt dateFromString:@"24 November 2017"];//for testing todays date purpose
                                                NSDate *date=[dt dateFromString:p2.date];
                                                
                                                
                                                NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
                                                
                                                
                                                NSDateComponents *weekdayComponents =[gregorianCalendar components:(NSCalendarUnitDay | NSCalendarUnitMonth |NSCalendarUnitYear) fromDate:date];
                                                
                                                
                                                NSLog(@"date com %@",weekdayComponents);
                                                //weekdayComponents.hour=17;
                                                // weekdayComponents.minute=22;
                                                
                                                
                                                if ([p2.start_time isEqual:@"08:00 am"]) {
                                                    weekdayComponents.hour=7;
                                                    weekdayComponents.minute=55;
                                                }
                                                if ([p2.start_time isEqual:@"08:30 am"]) {
                                                    weekdayComponents.hour=8;
                                                    weekdayComponents.minute=25;
                                                }
                                                if ([p2.start_time isEqual:@"09:00 am"]) {
                                                    weekdayComponents.hour=8;
                                                    weekdayComponents.minute=55;
                                                }
                                                if ([p2.start_time isEqual:@"01:50 pm"]) {
                                                    weekdayComponents.hour=13;
                                                    weekdayComponents.minute=45;
                                                }
                                                if ([p2.start_time isEqual:@"02:20 pm"]) {
                                                    weekdayComponents.hour=14;
                                                    weekdayComponents.minute=15;
                                                }
                                                if ([p2.start_time isEqual:@"02:35 pm"]) {
                                                    weekdayComponents.hour=14;
                                                    weekdayComponents.minute=30;
                                                }
                                                
                                                if ([p2.start_time isEqual:@"03:10 pm"]) {
                                                    weekdayComponents.hour=15;
                                                    weekdayComponents.minute=05;
                                                }
                                                

                                                NSDate *date1=[gregorianCalendar dateFromComponents:weekdayComponents];//this is used to convert nsdatecomponents to nsdate and stored in date1 variable
                                                
                                                UILocalNotification *notification=[[UILocalNotification alloc]init];
                                                
                                                NSString *s=[NSString stringWithFormat:@"Start-time: %@",p2.start_time];
                                                
                                                notification.alertTitle=p2.talkName;
                                                
                                                notification.alertBody=s;
                                                
                                                notification.soundName=UILocalNotificationDefaultSoundName;
                                                notification.applicationIconBadgeNumber=0;
                                                
                                                [[UIApplication sharedApplication]scheduleLocalNotification:notification];
                                                
                                                notification.fireDate=date1;
                                                
                                                NSLog(@"%ld",(long)weekdayComponents.hour);
                                                weekdayComponents.timeZone=[NSTimeZone timeZoneWithName:@"Asia/Kolkata"];
                                                
                                                NSDate *da=[gregorianCalendar dateFromComponents:weekdayComponents];
                                                NSLog(@"%@",da);
                                                
                                                NSDate *da1=[[NSCalendar currentCalendar]dateFromComponents:weekdayComponents];
                                                NSLog(@"%@",da1);
                                                
                                                
                                                
                                                notification.fireDate=[gregorianCalendar dateFromComponents:weekdayComponents];
                                                notification.fireDate=[[NSCalendar currentCalendar]dateFromComponents:weekdayComponents];
                                                
                                                
                                                NSDateFormatter *dt1=[[NSDateFormatter alloc]init];
                                                [dt1 setDateFormat:@"dd MMMM yyyy hh:mm:ss a"];
                                                
                                                NSLog(@"CODE FOR OLD VERSIONS");//code for old versions
                                            
                                            }
                                            //    [sender setUserInteractionEnabled:NO];
                                            //    [sender setEnabled:NO];
                                            
                                            NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
                                            NSURLSession *session=[NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
                                            
                                            
                                            
                                            NSString *savedValue=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];//used to retrieve user's emailid which we have stored in nsuserdefaults for key email(those user login dat person mail id will get using userdefaults)
                                            
                                            NSString *myst=[NSString stringWithFormat:@"emailid=%@&talk_id=%@&session_id=%@",savedValue,talkidstr,_session_idstr];
                                            
                                            NSLog(@".. My SAtatement...***%@",myst);
                                            
                                         
                                            NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:schedule_talk]];
                                            
                                          //  NSURL * url = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/schedule_talk.php"];//local
                                            
                                            //                                       NSURL *url=[NSURL URLWithString:@"http://siddhantedu.com/iOSAPI/user_paper6.php"];//server
                                            
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
                                                                            if (error) {
                                                                                NSLog(@"%@",error.description);
                                                                            }
                                                                            NSString *text=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                                                            NSLog(@"**data techtalk**=%@",text);
                                                                            NSError *error1=nil;
                                                                            NSDictionary *responsedict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error1];
                                                                            if(error1)
                                                                            {
                                                                                NSLog(@"error 1 is %@",error1.description);
                                                                            }
                                                                            NSLog(@"json = %@",responsedict);
                                                                            
                                                                        }];
                                            [task resume];
                                        }
                                        
                                        // call method whatever u need
                                    }];
                                    
        UIAlertAction* noButton = [UIAlertAction
                                   actionWithTitle:@"No,thanks"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action)
                                   {
                                       //What we write here????????**
                                       NSLog(@"you pressed No, thanks button");
                                       // call method whatever u need
                                   }];
        
        [alert addAction:yesButton];
        [alert addAction:noButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    
    }
    
  }
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
    {
        
        if([[segue identifier] isEqualToString:@"showTalkInfo"]){
        TalkInfoViewController *tlk=[segue destinationViewController];
        
        tlk.tempTalkName=_temptalkname;
        tlk.abstractstr=_tempabs;
        tlk.tempSpeakerName=_tempspeakerName;
        tlk.tempSpeakeruni=_tempspuni;
        tlk.sess_namestr=_sessNamestr;
        tlk.locationstr=_locationstr;
        tlk.talkidstr=_temptalkid;
        tlk.starttimestr=_stime;
        tlk.endtimestr=_etime;
        tlk.tempsessionid=_session_idstr;
            
            NSLog(@"***segue session id talk***%@",_session_idstr);
            
    }
    }
-(void)dataParsing
    {
        [_talkArray removeAllObjects];
        
        NSBlockOperation *op1=[NSBlockOperation blockOperationWithBlock:^{
            NSString *savedvalue2=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
        
        NSString *myst=[NSString stringWithFormat:@"session_id=%@&email=%@",_session_idstr,savedvalue2];
        
      NSURL * urlstr = [NSURL URLWithString:[mainUrl stringByAppendingString:techtalk_info]];
            
        //NSString *urlstr=@"http://192.168.1.100/phpmyadmin/itherm/techtalk_info.php";

        NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:urlstr];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
        NSError *error=nil;
        NSLog(@"POST CONTAINT....%@",myst);
        if(error)
        {
            NSLog(@"%@",error.description);
        }
        
        NSURLSessionConfiguration *configuration=[NSURLSessionConfiguration defaultSessionConfiguration];
        
        NSURLSession *session=[NSURLSession sessionWithConfiguration:configuration];
        
        
        NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                    {
                                        
                                        NSString *text=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                        NSLog(@"data.....******=%@",text);
                                        NSLog(@"!!!!!!!!!!!!!!!!!!!!!!!%@",response);
                                        if(data==nil)
                                        {
                                            NSLog(@"Data is nil");
                                            
                                        }
                                        
                                        else
                                        {
                                            
                                            
                                            NSLog(@"*************************%@",response);
                                            
                                            
                                            NSDictionary *outerdic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                        
                                            NSArray *keyarr=[outerdic objectForKey:@"tech_talk"];
                                            
                                            for(NSDictionary *temp in keyarr)
                                            {
                                                //NSString *str1=[[temp objectForKey:@"name"]description];
                                               
                                                NSString *str4=[temp objectForKey:@"session_id"];
                                                NSString *str5=[temp objectForKey:@"session_name"];
                                                NSString *str6=[temp objectForKey:@"university"];
                                                NSString *str8=[temp objectForKey:@"chair"];
                                               
                                                
                                                NSLog(@"str4=%@ str5=%@",str4,str5);
                                                [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                                                   // _sessionName.text=str5;
                                                    _chairname.text=str8;
                                                    _chairuniversity.text=str6;
                                                    
                                                }];
                                                NSArray *personarr=[temp objectForKey:@"talk_person"];
                                                for(NSDictionary *persondic in personarr)
                                                {
                                                    
                                                    NSString *str2=[[persondic objectForKey:@"talk_id"]description];
                                                    NSString *str3=[persondic objectForKey:@"talk"];
                                                    NSString *str9=[persondic objectForKey:@"speaker_name"];
                                                    NSString *str10=[persondic objectForKey:@"speaker_university"];
                                                    NSString *str7=[persondic objectForKey:@"abstract"];
                                                    NSString *str8=[persondic objectForKey:@"added"];
                                                     NSString *str11=[persondic objectForKey:@"start_time"];
                                                    
                                                    Talk_itherm *i1=[[Talk_itherm alloc]init];
                                                    
                                                    i1.talkid=str2;
                                                    i1.talkName=str3;
                                                    i1.abstract=str7;
                                                    i1.speakerName=str9;
                                                    i1.speakerUni=str10;
                                                    i1.added=str8;
                                                    i1.start_time=str11;
                                                    [_talkArray addObject:i1];

                                                    [_tableView reloadData];
                                                }
                                               
                                            }
                                            [_tableView reloadData];
                                        }
                                        [_tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
                                    }];
        [task resume];
             }];
        
           [_que addOperation:op1];
    }

  

- (IBAction)tickButtonClick:(id)sender {
    

    UIButton *btn =(UIButton *)sender;
    Talk_itherm *tlk=self.talkArray[btn.tag];
    if([[btn imageForState:UIControlStateNormal]isEqual:[UIImage imageNamed:@"addNew.png"]])
    {
        [btn setImage:[UIImage imageNamed:@"addedNew.png"] forState:UIControlStateNormal];
        NSLog(@"gray tick clicked...");
        NSLog(@"talk ID:-...%@",tlk.talkid);
        NSString *str=[NSString stringWithFormat:@"%@",tlk.talkid];
        [_tickarray addObject:str];
        
        NSLog(@"after adding count is %lu",(unsigned long)_tickarray.count);
        
    }
    
    else
    {
        [btn setImage:[UIImage imageNamed:@"addNew.png"] forState:UIControlStateNormal];
        
        NSLog(@"blue tick clicked...");
        NSString *str=[NSString stringWithFormat:@"%@",tlk.talkid];
        if([_tickarray isEqual:[NSNull null]])
        {
            NSLog(@"Array is EMPTY");
        }
        else
        {
            [_tickarray removeObject:str];
            
            NSLog(@"after removing count is%lu",(unsigned long)_tickarray.count);
            
        }
    }
    
    
    
    NSLog(@"Btn Click...........%ld",(long)btn.tag);
    
}
-(void)userpaperget {
    
    NSString *savedvalue=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];//1 email-id is used to save in user defaults,this can be done to store value once and can be used anywhere where we required
    NSString *myst2=[NSString stringWithFormat:@"emailid=%@",savedvalue];//2
    
    NSURLSessionConfiguration *defaultConfigObject2=[NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *defaultSession2=[NSURLSession sessionWithConfiguration:defaultConfigObject2 delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURL * url1 = [NSURL URLWithString:[mainUrl stringByAppendingString:user_talk_get6]];
    
   // NSURL * url1 = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/user_talk_get6.php"];
   
    NSMutableURLRequest *urlRequest1=[NSMutableURLRequest requestWithURL:url1];
    [urlRequest1 setHTTPMethod:@"POST"];//we get to knw dat we r sending post mtd to above url
    [urlRequest1 setHTTPBody:[myst2 dataUsingEncoding:NSUTF8StringEncoding]]; //3 this is used to encode data
    
    
    NSURLSessionDataTask *dataTask2=[defaultSession2 dataTaskWithRequest:urlRequest1 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)//wen we create datatask it resume first and den dat url(task/api) is go through completion handler block...
                                     {
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
                                         
                                         NSArray *agenda=[responsedict objectForKey:@"paperdetails"];
                                         for(NSDictionary *dict in agenda){
                                             Talk_itherm *pi=[[Talk_itherm alloc]init];
                                             pi.talkName=dict[@"talk"];
                                             pi.start_time=dict[@"start_time"];
                                             pi.speakerName=dict[@"speaker_name"];
                                             pi.speakerUni=dict[@"speaker_university"];
                                             pi.talkid=dict[@"talk_id"];
                                             pi.sessionidstr=dict[@"session_id"];
                                             pi.date=dict[@"date"];
                                             pi.day=dict[@"day"];
                                             
                                             
                                             [self.user_papers addObject:pi];
                                         }
                                         dispatch_async(dispatch_get_main_queue(), ^{
                                             
                                             NSLog(@"COUNT=%lu",(unsigned long)self.user_papers.count);
                                             for(Session_itherm *sess in self.user_papers) {
                                             }
                                             [self.tableView reloadData];
                                         });
                                     }];
    
    [dataTask2 resume];
 
}

@end
