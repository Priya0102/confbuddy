
#import "SessionViewController.h"
#import "Session_itherm.h"
#import "Reachability.h"
#import "Constant.h"
#define SYSTEM_VERSION_GREATERTHAN_OR_EQUALTO(v) ([[[UIDevice currentDevice]systemVersion] compare:v options:NSNumericSearch]!=NSOrderedAscending)
@interface SessionViewController ()

@end

@implementation SessionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_indicator startAnimating];
    _tickarray=[[NSMutableArray alloc]init];
    
    _que=[[NSOperationQueue alloc]init];
    self.setButton.layer.masksToBounds=YES;
    self.setButton.layer.borderColor=[UIColor colorWithRed:20.0/255.0 green:72.0/255.0 blue:114.0/255.0 alpha:1.0].CGColor;
    self.setButton.layer.borderWidth=1.1;
    
    self.viewMapBtn.layer.masksToBounds=YES;
    self.viewMapBtn.layer.borderColor=[UIColor colorWithRed:20.0/255.0 green:72.0/255.0 blue:114.0/255.0 alpha:1.0].CGColor;
    
    self.viewMapBtn.layer.borderWidth=1.1;
    self.viewMapBtn.layer.cornerRadius=10;
    
    _tableview.delegate=self;
    _tableview.dataSource=self;
    
    self.user_papers=[[NSMutableArray alloc]init];
    self.all_papers=[[NSMutableArray alloc]init];
    self.all_authors=[[NSMutableArray alloc]init];
    self.paperArr=[[NSMutableArray alloc]init];
    _endTimeLbl.text=_etimestr;
    _time.text=_stimestr;
    _loca.text=_locationstr;
    _date.text=_datestr;
    _session_name.text=_sessionstr;
    
    self.result=[[NSMutableArray alloc]init];
    
    [self userpaperget];
    
    
    [self.tableview setSeparatorColor:[UIColor clearColor]];
}

-(void)dataParsingNew
{
    [_all_papers removeAllObjects];
    NSBlockOperation *op1=[NSBlockOperation blockOperationWithBlock:^{
        NSString *savedvalue2=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
        
        
        NSString *myst=[NSString stringWithFormat:@"session_id=%@&emailid=%@",_temp_session_id,savedvalue2];
        NSLog(@"POST CONTAINT....%@",myst);
        
     NSURL * urlstr = [NSURL URLWithString:[mainUrl stringByAppendingString:paperdetails]];
        
   //NSString *urlstr=@"http://192.168.1.100/phpmyadmin/itherm/paperdetails.php";
        
          // NSString *urlstr=@"http://siddhantedu.com/iOSAPI/invited_new2.php";//server
        
        NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:urlstr];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
        NSError *error=nil;
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
                                        if(data==nil)
                                        {
                                            NSLog(@"Data is nil");
                                            
                                        }
                                        
                                        else
                                        {
                                            
                                            
                                            NSLog(@"%@",response);
                                            
                                            
                                            NSDictionary *outerdic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                            
                                            NSArray *keyarr=[outerdic objectForKey:@"inviteds"];
                                            
                                            for(NSDictionary *temp in keyarr)
                                            {
                                                NSString *str1=[[temp objectForKey:@"session_id"]description];
                                                NSString *str2=[[temp objectForKey:@"paper_name"]description];
                                                NSString *str3=[temp objectForKey:@"start_time"];
                                                NSString *str4=[temp objectForKey:@"added"];
                                                NSString *str5=[temp objectForKey:@"paper_id"];
                                                NSString *str6=[temp objectForKey:@"paper_abstract"];
                                                Paper_itherm *i1=[[Paper_itherm alloc]init];
                                                i1.session_id=str1;
                                                i1.paper_name=str2;
                                                i1.start_time=str3;
                                                i1.added=str4;
                                                i1.paper_id=str5;
                                                i1.paper_abstract=str6;
                                                
                                                [_all_papers addObject:i1];
                                                
                                                
                                            }
                                            
                                           // [_tableview reloadData];
                                        }
                                        
                                        [_tableview performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
                                    }];
        [task resume];
    }];
    
    [_que addOperation:op1];
}


-(void)userpaperget {
    
    NSString *savedvalue=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];//1 email-id is used to save in user defaults,this can be done to store value once and can be used anywhere where we required
    NSString *myst2=[NSString stringWithFormat:@"emailid=%@",savedvalue];//2
    
    NSURLSessionConfiguration *defaultConfigObject2=[NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *defaultSession2=[NSURLSession sessionWithConfiguration:defaultConfigObject2 delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    
    NSURL * url1 = [NSURL URLWithString:[mainUrl stringByAppendingString:user_paper_get6]];
    
   // NSURL * url1 = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/user_paper_get6.php"];//local

    
    //NSURL *url1=[NSURL URLWithString:@"http://siddhantedu.com/iOSAPI/user_paper_get6.php"];//server
    
    
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
                                             Paper_itherm *pi=[[Paper_itherm alloc]init];
                                             pi.paper_name=dict[@"paper_name"];
                                             pi.start_time=dict[@"start_time"];
                                             pi.end_time=dict[@"end_time"];
                                             pi.room_name=dict[@"room_name"];
                                             pi.paper_id=dict[@"paper_id"];
                                             pi.session_id=dict[@"session_id"];
                                             pi.date=dict[@"date"];
                                             pi.day=dict[@"day"];
                                             
                                             
                                             [self.user_papers addObject:pi];
                                         }
                                         dispatch_async(dispatch_get_main_queue(), ^{
                                             
                                             NSLog(@"COUNT=%lu",(unsigned long)self.user_papers.count);
                                             for(Session_itherm *sess in self.user_papers) {
                                                 NSLog(@"%@",sess);
                                             }
                                             [self.tableview reloadData];
                                         });
                                     }];
    
    [dataTask2 resume];
}

- (BOOL)itemHasReminder:(NSString *)item {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"paper_id matches %@", item];
    NSLog(@"item is %@",item);
    NSArray *filtered = [self.user_papers filteredArrayUsingPredicate:predicate];
    NSLog(@"filtered count is %lu",(unsigned long)filtered.count);
    return ([filtered count]);
}
- (void)viewWillAppear:(BOOL)animated
{
    //[super viewWillAppear:YES];
   // [self.tableview reloadData];
    

    [self dataParsingNew];
   
    NSLog(@"TICK ARRAY COUNT IN Will Appear....%lu",(unsigned long)_tickarray.count);
    NSLog(@"hi");
    
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    NetworkStatus netStatus = [reach currentReachabilityStatus];
    if (netStatus == NotReachable)
    {
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
    }
}


- (NSInteger)numberOfSectionsIntableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.all_papers.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PaperTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    Paper_itherm *paper=[self.all_papers objectAtIndex: indexPath.row];
    cell.papername.text=paper.paper_name;
    // cell.paper_abstract.text=paper.paper_abstract;
    cell.start_time.text=paper.start_time;
    cell.reminderButton.tag=indexPath.row;
    
    [_indicator stopAnimating];
    
    
    NSString *tempadd=paper.added;
    NSString *pprid=paper.paper_id;
    
    
    if ([tempadd isEqual:[NSNull null]]) {
        NSLog(@"Tempdata is null.....");
        [cell.reminderButton setImage:[UIImage imageNamed:@"addNew.png"] forState:UIControlStateNormal];
        [cell.reminderButton setUserInteractionEnabled:YES];
    }
    else{
        NSLog(@"Show blue.......");
       
        [cell.reminderButton setImage:[UIImage imageNamed:@"addedNew.png"] forState:UIControlStateNormal];
        [cell.reminderButton setUserInteractionEnabled:NO];
    }
    
    NSLog(@"Array Length : %lu",(unsigned long)_tickarray.count);
    for(int i=0;i<_tickarray.count;i++)
    {
        NSString *str;
        str=[NSString stringWithFormat:@"%@",_tickarray[i]];
        
        NSLog(@". Paper id in scroll....paper id in tick array  %@..%@..at location %d",pprid,str,i);
        if([str isEqualToString:pprid])
        {
            NSLog(@". print tick..%@..%@",pprid,str);
            [cell.reminderButton setImage:[UIImage imageNamed:@"addedNew.png"] forState:UIControlStateNormal];
            
            
        }
        
       /* UIImageView *alarm_done=[[UIImageView alloc]init];
        alarm_done.image=[UIImage imageNamed:@"added.png"];
        
        if (![self itemHasReminder:paper.paper_id]) {
            // NSLog(@"in if loop");
            cell.accessoryView=_setButton;
            self.setButton.tag=indexPath.row;
        }
        else
        {
            cell.accessoryView =alarm_done;
        }
        */
        //cell.accessoryView=_setButton;// current time testing purpose
    }
    
    
    
    
    
    
    // }
    
    //  else
    // {
    //        for(int i=0;i<_tickarray.count;i++)
    //        {
    //            NSString *str1=[NSString stringWithFormat:@"%@",_tickarray[i]];
    //
    //
    //            if (![tempadd isEqual:[NSNull null]] || [pprid isEqualToString:str1]) {
    //                NSLog(@"Tempdata is null.....");
    //                [cell.reminderButton setImage:[UIImage imageNamed:@"addNew.png"] forState:UIControlStateNormal];
    //            }
    //
    //            else
    //            {
    //
    //                NSLog(@"Show blue.......");
    //                [cell.reminderButton setImage:[UIImage imageNamed:@"addedNew.png"] forState:UIControlStateNormal];
    //
    //            }
    //
    //        }
    
    
    //}
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    NSIndexPath *path=[[self tableview] indexPathForSelectedRow];
    Paper_itherm *paper=self.all_papers[path.row];
    NSLog(@"SELECTED paper_id is=%@",paper.paper_id);
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"paper_id matches %@",paper.paper_id];
    // used to select authors with particular paper id we have selected
    NSArray *filtered = [self.all_authors filteredArrayUsingPredicate:predicate];
    
    
    
    AuthorDetailViewController *avc=[segue destinationViewController];
    //avc.a1=[self.result objectAtIndex:path.row];
    avc.authors=filtered;
    avc.paper=paper.paper_name;
    avc.tempSessionName=_session_name.text;
    avc.abstractstr=_tempabst;
    avc.paperidstr=paper.paper_id;
    avc.locationstr=_loca.text;
    avc.starttimestr=_time.text;
    avc.endtimestr=_endTimeLbl.text;
    avc.sessionidStr=_temp_session_id;
    NSLog(@"PAPER ID==%@ & Sess session id==%@",avc.paperidstr,_temp_session_id);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //[self prepareForSegue:@"showAuthor" sender:nil];
    
    Paper_itherm *p1=[_all_papers objectAtIndex:indexPath.row];
    _tempabst=p1.paper_abstract;
    NSLog(@".......*********%@",_tempabst);
    
    
    [self performSegueWithIdentifier:@"showAuthor" sender:nil];
    
    
    
}

- (IBAction)alramButtonClick:(id)sender {
    
    
    UIButton *btn =(UIButton *)sender;
    Paper_itherm *paper=self.all_papers[btn.tag];
    //[btn setUserInteractionEnabled:YES];
    if([[btn imageForState:UIControlStateNormal]isEqual:[UIImage imageNamed:@"addNew.png"]])
    {
        [btn setImage:[UIImage imageNamed:@"addedNew.png"] forState:UIControlStateNormal];
        NSLog(@"gray tick clicked...");
        NSLog(@"PAPER ID:-...%@",paper.paper_id);
        NSString *str=[NSString stringWithFormat:@"%@",paper.paper_id];
        [_tickarray addObject:str];
        
        NSLog(@"after adding count is %lu",(unsigned long)_tickarray.count);
    }
    
    else
    {
        //[btn setUserInteractionEnabled:NO];
        [btn setImage:[UIImage imageNamed:@"addNew.png"] forState:UIControlStateNormal];
        
        NSLog(@"blue tick clicked...");
        NSString *str=[NSString stringWithFormat:@"%@",paper.paper_id];
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



-(void)alarmMethod
{
    
    
    NSLog(@"alram Method....Button Clicked....");
}


- (IBAction)setButton:(id)sender {
    
    NSString *emailid=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
    if (emailid==NULL) {
        UIAlertController * alert=[UIAlertController
                                   
                                   alertControllerWithTitle:@"Alert!" message:@"Please login to add in My Schedule"preferredStyle:UIAlertControllerStyleAlert];
        
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
    
    //Paper_itherm *p2=self.all_papers[btn.tag];
    
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
                                   
                                   alertControllerWithTitle:@"ALERT" message:@"Do you want to add in my schedule?"preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"Yes, please"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action)
                                    {// 1
                                        
                                        NSLog(@"you pressed Yes, please button");
                                        
                                        for(int i=0;i<_tickarray.count;i++)
                                        {// 2
                                            NSLog(@"*****%@",_tickarray[i]);
                                            
                                            NSString *paperid=[NSString stringWithFormat:@"%@",_tickarray[i]];
                                            
                                            Paper_itherm *p2=self.all_papers[btn.tag];
                                            NSLog(@"******alarm btn click");
                                            NSLog(@"%@paper...............",p2);
                                            [self.user_papers addObject:p2];//sending object directly to array for getting user sessions as per user cliked
                                            
                                            NSLog(@"#####papers start time===%@",p2.start_time);
                                            if(SYSTEM_VERSION_GREATERTHAN_OR_EQUALTO(@"10.0"))
                                            { //3
                                                UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
                                                [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert)
                                                                      completionHandler:^(BOOL granted, NSError * _Nullable error) {
                                                                          if (!error) {
                                                                              NSLog(@"request authorization succeeded!");
                                                                              // [self showAlert];
                                                                              
                                                                              UIAlertController *alertView = [UIAlertController alertControllerWithTitle:nil message:@"Selected paper is added in My Schedule" preferredStyle:UIAlertControllerStyleAlert];
                                                                              
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

                                                                              
                                                                              
                                                // [btn setBackgroundImage:[UIImage imageNamed:@"addedNew.png"] forState:UIControlStateNormal];
                                                                              [self.tableview reloadData];
                                                                              
                                                                          }
                                                                          else
                                                                          {
                                                                              NSLog(@"user notification failed");
                                                                          }
                                                                      }];
                                                
                                                
                                                
                                                UNMutableNotificationContent *objNotificationContent = [[UNMutableNotificationContent alloc] init];
                                                
                                                NSString *s=[NSString stringWithFormat:@"Start-time: %@",p2.start_time];
                                                NSLog(@"...%@",s);
                                                objNotificationContent.title = [NSString localizedUserNotificationStringForKey:p2.paper_name arguments:nil];
                                                objNotificationContent.body = [NSString localizedUserNotificationStringForKey:s arguments:nil];
                                                objNotificationContent.sound = [UNNotificationSound defaultSound];
                                                
                                                /// 4. update application icon badge number
                                                //objNotificationContent.badge = @([[UIApplication sharedApplication] applicationIconBadgeNumber] + 1);
                                                objNotificationContent.badge=0;
                                                
                                                NSDateFormatter *dt=[[NSDateFormatter alloc]init];
                                                [dt setDateFormat:@"dd MMMM yyyy"];
                                                // NSDate *date=[dt dateFromString:@"24 November 2017"];// For current testing purpose use current date
                                                NSDate *date=[dt dateFromString:p2.date];// for setting notification use the date of the session selected
                                                
                                                
                                                NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
                                                
                                                
                                                NSDateComponents *weekdayComponents =[gregorianCalendar components:(NSCalendarUnitDay | NSCalendarUnitMonth |NSCalendarUnitYear) fromDate:date];
                                                
                                                NSLog(@"date com %@",weekdayComponents);
                                                //weekdayComponents.hour=17;
                                                // weekdayComponents.minute=22;
                                                
                                                if ([p2.start_time isEqual:@"08:00 am"]) {
                                                    weekdayComponents.hour=07;
                                                    weekdayComponents.minute=55;//This is used for ringing purpose whatever we set time
                                                    //(This is used to send notification at time we set in weekendcomponents.hour)
                                                }
                                                if ([p2.start_time isEqual:@"08:15 am"]) {
                                                    weekdayComponents.hour=8;
                                                    weekdayComponents.minute=10;
                                                }
                                                if ([p2.start_time isEqual:@"08:18 am"]) {
                                                    weekdayComponents.hour=8;
                                                    weekdayComponents.minute=13;
                                                }
                                                if ([p2.start_time isEqual:@"08:22 am"]) {
                                                    weekdayComponents.hour=8;
                                                    weekdayComponents.minute=17;
                                                }
                                                if ([p2.start_time isEqual:@"08:30 am"]) {
                                                    weekdayComponents.hour=8;
                                                    weekdayComponents.minute=25;
                                                }
                                                if ([p2.start_time isEqual:@"08:36 am"]) {
                                                    weekdayComponents.hour=8;
                                                    weekdayComponents.minute=31;
                                                }
                                                if ([p2.start_time isEqual:@"08:44 am"]) {
                                                    weekdayComponents.hour=8;
                                                    weekdayComponents.minute=39;
                                                }
                                                if ([p2.start_time isEqual:@"08:45 am"]) {
                                                    weekdayComponents.hour=8;
                                                    weekdayComponents.minute=40;
                                                }
                                                if ([p2.start_time isEqual:@"08:54 am"]) {
                                                    weekdayComponents.hour=8;
                                                    weekdayComponents.minute=49;
                                                }
                                                if ([p2.start_time isEqual:@"09:00 am"]) {
                                                    weekdayComponents.hour=8;
                                                    weekdayComponents.minute=55;
                                                }
                                                if ([p2.start_time isEqual:@"09:05 am"]) {
                                                    weekdayComponents.hour=9;
                                                    weekdayComponents.minute=00;
                                                }
                                                if ([p2.start_time isEqual:@"09:12 am"]) {
                                                    weekdayComponents.hour=9;
                                                    weekdayComponents.minute=07;
                                                }
                                                if ([p2.start_time isEqual:@"09:15 am"]) {
                                                    weekdayComponents.hour=9;
                                                    weekdayComponents.minute=10;
                                                }
                                                if ([p2.start_time isEqual:@"11:00 am"]) {
                                                    weekdayComponents.hour=10;
                                                    weekdayComponents.minute=55;
                                                }
                                                if ([p2.start_time isEqual:@"11:15 am"]) {
                                                    weekdayComponents.hour=11;
                                                    weekdayComponents.minute=10;
                                                }
                                                if ([p2.start_time isEqual:@"11:18 am"]) {
                                                    weekdayComponents.hour=11;
                                                    weekdayComponents.minute=13;
                                                }
                                                if ([p2.start_time isEqual:@"11:22 am"]) {
                                                    weekdayComponents.hour=11;
                                                    weekdayComponents.minute=17;
                                                }
                                                if ([p2.start_time isEqual:@"11:30 am"]) {
                                                    weekdayComponents.hour=11;
                                                    weekdayComponents.minute=25;
                                                }
                                                if ([p2.start_time isEqual:@"11:36 am"]) {
                                                    weekdayComponents.hour=11;
                                                    weekdayComponents.minute=31;
                                                }
                                                if ([p2.start_time isEqual:@"11:45 am"]) {
                                                    weekdayComponents.hour=11;
                                                    weekdayComponents.minute=40;
                                                }
                                                if ([p2.start_time isEqual:@"11:46 am"]) {
                                                    weekdayComponents.hour=11;
                                                    weekdayComponents.minute=41;
                                                }
                                                if ([p2.start_time isEqual:@"11:54 am"]) {
                                                    weekdayComponents.hour=11;
                                                    weekdayComponents.minute=49;
                                                }
                                                if ([p2.start_time isEqual:@"12:00 pm"]) {
                                                    weekdayComponents.hour=11;
                                                    weekdayComponents.minute=55;
                                                }
                                                if ([p2.start_time isEqual:@"12:06 pm"]) {
                                                    weekdayComponents.hour=12;
                                                    weekdayComponents.minute=01;
                                                }
                                                if ([p2.start_time isEqual:@"12:12 pm"]) {
                                                    weekdayComponents.hour=12;
                                                    weekdayComponents.minute=07;
                                                }
                                                if ([p2.start_time isEqual:@"12:15 pm"]) {
                                                    weekdayComponents.hour=12;
                                                    weekdayComponents.minute=10;
                                                }
                                                if ([p2.start_time isEqual:@"01:50 pm"]) {
                                                    weekdayComponents.hour=13;
                                                    weekdayComponents.minute=45;
                                                }
                                                if ([p2.start_time isEqual:@"02:05 pm"]) {
                                                    weekdayComponents.hour=14;
                                                    weekdayComponents.minute=00;
                                                }
                                                if ([p2.start_time isEqual:@"02:08 pm"]) {
                                                    weekdayComponents.hour=14;
                                                    weekdayComponents.minute=03;
                                                }
                                                if ([p2.start_time isEqual:@"02:20 pm"]) {
                                                    weekdayComponents.hour=14;
                                                    weekdayComponents.minute=15;
                                                }
                                                if ([p2.start_time isEqual:@"02:26 pm"]) {
                                                    weekdayComponents.hour=14;
                                                    weekdayComponents.minute=21;
                                                }
                                                if ([p2.start_time isEqual:@"02:35 pm"]) {
                                                    weekdayComponents.hour=14;
                                                    weekdayComponents.minute=30;
                                                }
                                                if ([p2.start_time isEqual:@"02:44 pm"]) {
                                                    weekdayComponents.hour=14;
                                                    weekdayComponents.minute=39;
                                                }
                                                if ([p2.start_time isEqual:@"02:50 pm"]) {
                                                    weekdayComponents.hour=14;
                                                    weekdayComponents.minute=45;
                                                }
                                                if ([p2.start_time isEqual:@"03:02 pm"]) {
                                                    weekdayComponents.hour=14;
                                                    weekdayComponents.minute=57;
                                                }
                                                if ([p2.start_time isEqual:@"03:05 pm"]) {
                                                    weekdayComponents.hour=15;
                                                    weekdayComponents.minute=00;
                                                }
                                                if ([p2.start_time isEqual:@"03:50 pm"]) {
                                                    weekdayComponents.hour=15;
                                                    weekdayComponents.minute=45;
                                                }
                                                if ([p2.start_time isEqual:@"04:05 pm"]) {
                                                    weekdayComponents.hour=16;
                                                    weekdayComponents.minute=00;
                                                }
                                                if ([p2.start_time isEqual:@"04:08 pm"]) {
                                                    weekdayComponents.hour=16;
                                                    weekdayComponents.minute=03;
                                                }
                                                if ([p2.start_time isEqual:@"04:10 pm"]) {
                                                    weekdayComponents.hour=16;
                                                    weekdayComponents.minute=05;
                                                }
                                                if ([p2.start_time isEqual:@"04:20 pm"]) {
                                                    weekdayComponents.hour=16;
                                                    weekdayComponents.minute=15;
                                                }
                                                if ([p2.start_time isEqual:@"04:26 pm"]) {
                                                    weekdayComponents.hour=16;
                                                    weekdayComponents.minute=21;
                                                }
                                                if ([p2.start_time isEqual:@"04:30 pm"]) {
                                                    weekdayComponents.hour=16;
                                                    weekdayComponents.minute=25;
                                                }
                                                if ([p2.start_time isEqual:@"04:35 pm"]) {
                                                    weekdayComponents.hour=16;
                                                    weekdayComponents.minute=30;
                                                }
                                                if ([p2.start_time isEqual:@"04:44 pm"]) {
                                                    weekdayComponents.hour=16;
                                                    weekdayComponents.minute=39;
                                                }
                                                if ([p2.start_time isEqual:@"04:50 pm"]) {
                                                    weekdayComponents.hour=16;
                                                    weekdayComponents.minute=45;
                                                }
                                                if ([p2.start_time isEqual:@"05:02 pm"]) {
                                                    weekdayComponents.hour=16;
                                                    weekdayComponents.minute=57;
                                                }
                                                if ([p2.start_time isEqual:@"05:05 pm"]) {
                                                    weekdayComponents.hour=17;
                                                    weekdayComponents.minute=00;
                                                }
                                                
                                                // Deliver the notification in five seconds.
                                                
                                                UNTimeIntervalNotificationTrigger *trigger1 = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:50.f repeats:NO];
                                                
                                                UNCalendarNotificationTrigger *trigger=[UNCalendarNotificationTrigger triggerWithDateMatchingComponents:weekdayComponents repeats:NO];
                                                
                                                UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:p2.paper_id
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
                                                NSDate *date=[dt dateFromString:p2.date];// this is used to convert nsstring to nsdate and stored in date variable
                                                
                                                
                                                
                                                NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
                                                
                                                
                                                NSDateComponents *weekdayComponents =[gregorianCalendar components:(NSCalendarUnitDay | NSCalendarUnitMonth |NSCalendarUnitYear) fromDate:date];
                                                
                                                
                                                NSLog(@"date com %@",weekdayComponents);
                                                //weekdayComponents.hour=17;
                                                // weekdayComponents.minute=22;
                                                
                                                if ([p2.start_time isEqual:@"08:00 am"]) {
                                                    weekdayComponents.hour=07;
                                                    weekdayComponents.minute=55;//This is used for ringing purpose whatever we set time
                                                    //(Thiw is used to send notification at time we set in weekendcomponents.hour)
                                                }
                                                if ([p2.start_time isEqual:@"08:15 am"]) {
                                                    weekdayComponents.hour=8;
                                                    weekdayComponents.minute=10;
                                                }
                                                if ([p2.start_time isEqual:@"08:18 am"]) {
                                                    weekdayComponents.hour=8;
                                                    weekdayComponents.minute=13;
                                                }
                                                if ([p2.start_time isEqual:@"08:22 am"]) {
                                                    weekdayComponents.hour=8;
                                                    weekdayComponents.minute=17;
                                                }
                                                if ([p2.start_time isEqual:@"08:30 am"]) {
                                                    weekdayComponents.hour=8;
                                                    weekdayComponents.minute=25;
                                                }
                                                if ([p2.start_time isEqual:@"08:36 am"]) {
                                                    weekdayComponents.hour=8;
                                                    weekdayComponents.minute=31;
                                                }
                                                if ([p2.start_time isEqual:@"08:44 am"]) {
                                                    weekdayComponents.hour=8;
                                                    weekdayComponents.minute=39;
                                                }
                                                if ([p2.start_time isEqual:@"08:45 am"]) {
                                                    weekdayComponents.hour=8;
                                                    weekdayComponents.minute=40;
                                                }
                                                if ([p2.start_time isEqual:@"08:54 am"]) {
                                                    weekdayComponents.hour=8;
                                                    weekdayComponents.minute=49;
                                                }
                                                if ([p2.start_time isEqual:@"09:00 am"]) {
                                                    weekdayComponents.hour=8;
                                                    weekdayComponents.minute=55;
                                                }
                                                if ([p2.start_time isEqual:@"09:05 am"]) {
                                                    weekdayComponents.hour=9;
                                                    weekdayComponents.minute=00;
                                                }
                                                if ([p2.start_time isEqual:@"09:12 am"]) {
                                                    weekdayComponents.hour=9;
                                                    weekdayComponents.minute=07;
                                                }
                                                if ([p2.start_time isEqual:@"09:15 am"]) {
                                                    weekdayComponents.hour=9;
                                                    weekdayComponents.minute=10;
                                                }
                                                if ([p2.start_time isEqual:@"11:00 am"]) {
                                                    weekdayComponents.hour=10;
                                                    weekdayComponents.minute=55;
                                                }
                                                if ([p2.start_time isEqual:@"11:15 am"]) {
                                                    weekdayComponents.hour=11;
                                                    weekdayComponents.minute=10;
                                                }
                                                if ([p2.start_time isEqual:@"11:18 am"]) {
                                                    weekdayComponents.hour=11;
                                                    weekdayComponents.minute=13;
                                                }
                                                if ([p2.start_time isEqual:@"11:22 am"]) {
                                                    weekdayComponents.hour=11;
                                                    weekdayComponents.minute=17;
                                                }
                                                if ([p2.start_time isEqual:@"11:30 am"]) {
                                                    weekdayComponents.hour=11;
                                                    weekdayComponents.minute=25;
                                                }
                                                if ([p2.start_time isEqual:@"11:36 am"]) {
                                                    weekdayComponents.hour=11;
                                                    weekdayComponents.minute=31;
                                                }
                                                if ([p2.start_time isEqual:@"11:45 am"]) {
                                                    weekdayComponents.hour=11;
                                                    weekdayComponents.minute=40;
                                                }
                                                if ([p2.start_time isEqual:@"11:46 am"]) {
                                                    weekdayComponents.hour=11;
                                                    weekdayComponents.minute=41;
                                                }
                                                if ([p2.start_time isEqual:@"11:54 am"]) {
                                                    weekdayComponents.hour=11;
                                                    weekdayComponents.minute=49;
                                                }
                                                if ([p2.start_time isEqual:@"12:00 pm"]) {
                                                    weekdayComponents.hour=11;
                                                    weekdayComponents.minute=55;
                                                }
                                                if ([p2.start_time isEqual:@"12:06 pm"]) {
                                                    weekdayComponents.hour=12;
                                                    weekdayComponents.minute=01;
                                                }
                                                if ([p2.start_time isEqual:@"12:12 pm"]) {
                                                    weekdayComponents.hour=12;
                                                    weekdayComponents.minute=07;
                                                }
                                                if ([p2.start_time isEqual:@"12:15 pm"]) {
                                                    weekdayComponents.hour=12;
                                                    weekdayComponents.minute=10;
                                                }
                                                if ([p2.start_time isEqual:@"01:50 pm"]) {
                                                    weekdayComponents.hour=13;
                                                    weekdayComponents.minute=45;
                                                }
                                                if ([p2.start_time isEqual:@"02:05 pm"]) {
                                                    weekdayComponents.hour=14;
                                                    weekdayComponents.minute=00;
                                                }
                                                if ([p2.start_time isEqual:@"02:08 pm"]) {
                                                    weekdayComponents.hour=14;
                                                    weekdayComponents.minute=03;
                                                }
                                                if ([p2.start_time isEqual:@"02:20 pm"]) {
                                                    weekdayComponents.hour=14;
                                                    weekdayComponents.minute=15;
                                                }
                                                if ([p2.start_time isEqual:@"02:26 pm"]) {
                                                    weekdayComponents.hour=14;
                                                    weekdayComponents.minute=21;
                                                }
                                                if ([p2.start_time isEqual:@"02:35 pm"]) {
                                                    weekdayComponents.hour=14;
                                                    weekdayComponents.minute=30;
                                                }
                                                if ([p2.start_time isEqual:@"02:44 pm"]) {
                                                    weekdayComponents.hour=14;
                                                    weekdayComponents.minute=39;
                                                }
                                                if ([p2.start_time isEqual:@"02:50 pm"]) {
                                                    weekdayComponents.hour=14;
                                                    weekdayComponents.minute=45;
                                                }
                                                if ([p2.start_time isEqual:@"03:02 pm"]) {
                                                    weekdayComponents.hour=14;
                                                    weekdayComponents.minute=57;
                                                }
                                                if ([p2.start_time isEqual:@"03:05 pm"]) {
                                                    weekdayComponents.hour=15;
                                                    weekdayComponents.minute=00;
                                                }
                                                if ([p2.start_time isEqual:@"03:50 pm"]) {
                                                    weekdayComponents.hour=15;
                                                    weekdayComponents.minute=45;
                                                }
                                                if ([p2.start_time isEqual:@"04:05 pm"]) {
                                                    weekdayComponents.hour=16;
                                                    weekdayComponents.minute=00;
                                                }
                                                if ([p2.start_time isEqual:@"04:08 pm"]) {
                                                    weekdayComponents.hour=16;
                                                    weekdayComponents.minute=03;
                                                }
                                                if ([p2.start_time isEqual:@"04:10 pm"]) {
                                                    weekdayComponents.hour=16;
                                                    weekdayComponents.minute=05;
                                                }
                                                if ([p2.start_time isEqual:@"04:20 pm"]) {
                                                    weekdayComponents.hour=16;
                                                    weekdayComponents.minute=15;
                                                }
                                                if ([p2.start_time isEqual:@"04:26 pm"]) {
                                                    weekdayComponents.hour=16;
                                                    weekdayComponents.minute=21;
                                                }
                                                if ([p2.start_time isEqual:@"04:30 pm"]) {
                                                    weekdayComponents.hour=16;
                                                    weekdayComponents.minute=25;
                                                }
                                                if ([p2.start_time isEqual:@"04:35 pm"]) {
                                                    weekdayComponents.hour=16;
                                                    weekdayComponents.minute=30;
                                                }
                                                if ([p2.start_time isEqual:@"04:44 pm"]) {
                                                    weekdayComponents.hour=16;
                                                    weekdayComponents.minute=39;
                                                }
                                                if ([p2.start_time isEqual:@"04:50 pm"]) {
                                                    weekdayComponents.hour=16;
                                                    weekdayComponents.minute=45;
                                                }
                                                if ([p2.start_time isEqual:@"05:02 pm"]) {
                                                    weekdayComponents.hour=16;
                                                    weekdayComponents.minute=57;
                                                }
                                                if ([p2.start_time isEqual:@"05:05 pm"]) {
                                                    weekdayComponents.hour=17;
                                                    weekdayComponents.minute=00;
                                                }
                                                NSDate *date1=[gregorianCalendar dateFromComponents:weekdayComponents];//this is used to convert nsdatecomponents to nsdate and stored in date1 variable
                                                
                                                UILocalNotification *notification=[[UILocalNotification alloc]init];
                                                
                                                NSString *s=[NSString stringWithFormat:@"Start-time: %@",p2.start_time];
                                                
                                                notification.alertTitle=p2.paper_name;
                                                
                                                notification.alertBody=s;
                                                
                                                notification.soundName=UILocalNotificationDefaultSoundName;
                                                notification.applicationIconBadgeNumber=0;
                                                
                                                [[UIApplication sharedApplication]scheduleLocalNotification:notification];
                                                
                                                notification.fireDate=date1;
                                                
                                                //                                       weekdayComponents.hour=15;
                                                //                                             weekdayComponents.minute=14;
                                                //                                             weekdayComponents.day=24;
                                                //                                             weekdayComponents.month=11;
                                                //                                             weekdayComponents.year=2017;
                                                weekdayComponents.hour=NSCalendarUnitHour;//implemented but not sure it works
                                                weekdayComponents.minute=NSCalendarUnitMinute;
                                                weekdayComponents.day=NSCalendarUnitDay;
                                                weekdayComponents.month=NSCalendarUnitMonth;
                                                weekdayComponents.year=NSCalendarUnitYear;
                                                
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
                                                // NSDate *da2=[dt1 dateFromString:@"24 November 2017 03:14:00 pm"];//for current  date testing
                                                
                                                
                                                
                                                NSLog(@"CODE FOR OLD VERSIONS");//code for old versions
                                            }
                                            
                                            
                                            NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
                                            NSURLSession *session=[NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
                                            
                                            
                                            
                                            NSString *savedValue=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];//used to retrieve user's emailid which we have stored in nsuserdefaults for key email(those user login dat person mail id will get using userdefaults)
                                            
                                            NSString *myst=[NSString stringWithFormat:@"emailid=%@&paper_id=%@&session_id=%@",savedValue,paperid,p2.session_id];
                                            
                                            NSLog(@".. My SAtatement...***%@",myst);
                                            
                                          NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:paper_reminder_add]];
                                            
                                           // NSURL * url = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/paper_reminder_add.php"];//local
                                    
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
                                                                            NSLog(@"data=%@",text);
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
                                   actionWithTitle:@"No, thanks"
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
/*-(void)dataParsing
 {
 
 [_all_papers removeAllObjects];
 [_all_authors removeAllObjects];
 
 // NSBlockOperation *op1=[NSBlockOperation blockOperationWithBlock:^{
 NSString *savedvalue2=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
 
 NSString *myst=[NSString stringWithFormat:@"session_id=%@&email=%@",_temp_session_id,savedvalue2];
 
 
 NSString *urlstr=@"http://192.168.1.100/phpmyadmin/itherm/paper_name.php";
 //        NSString * urlstr =@"http://www.siddhantedu.com/iOSAPI/tech_talk3.php";//server
 NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstr]];
 [request setHTTPMethod:@"POST"];
 [request setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
 NSError *error=nil;
 NSLog(@"POST CONTAINT agenda....%@",myst);
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
 
 //                                                NSArray *keyarr=[outerdic objectForKey:@"paper_info"];
 NSArray *keyarr=outerdic[@"paper_info"];
 NSLog(@"SESSION AAAA=%@",keyarr);
 
 for(NSDictionary *temp in keyarr)
 {
 
 NSString *str1=[temp objectForKey:@"paper_id"];
 NSString *str2=[temp objectForKey:@"paper_name"];
 NSString *str3=[temp objectForKey:@"paper_abstract"];
 NSString *str4=[temp objectForKey:@"start_time"];
 NSString *str5=[temp objectForKey:@"session_id"];
 NSString *str6=[temp objectForKey:@"added"];
 
 Paper_itherm *pi=[[Paper_itherm alloc]init];
 pi.paper_id=str1;
 pi.paper_name=str2;
 pi.paper_abstract=str3;
 pi.start_time=str4;
 pi.session_id=str5;
 pi.added=str6;
 [_all_papers addObject:pi];
 NSLog(@"********start time:****%@ & *****paperabstract=%@ ",pi.start_time,pi.paper_abstract);
 
 NSString *str=[NSString stringWithFormat:@"%@",pi.added];
 
 NSLog(@".....String LEngth  %lu \t String : %@",(unsigned long)str.length,str);
 
 if([str isEqualToString:@"<null>"])
 {
 //                    NSLog(@" if([str isEqualToString:])");
 }
 else
 {
 [_tickarray addObject:str];
 }
 
 
 NSArray *authors=temp[@"author"];
 for (NSDictionary *dict in authors) {
 
 Paper_author *aut=[[Paper_author alloc]init];
 aut.paper_id=dict[@"paper_id"];
 aut.emailid=dict[@"emailid"];
 aut.first_name=dict[@"first_name"];
 aut.last_name=dict[@"last_name"];
 aut.country=dict[@"country"];
 aut.affiliation=dict[@"affiliation"];
 aut.salutation=dict[@"salutation"];
 aut.mobile_no=dict[@"mobile_no"];
 
 NSLog(@"********mobile NO:****%@ & *****firstname=%@ ",aut.mobile_no,aut.first_name);
 [self.all_authors
 addObject:aut];
 }
 }
 dispatch_async(dispatch_get_main_queue() , ^{
 
 [self.tableview reloadData];
 });
 }
 }];
 
 [task resume];
 //                                            [_tableview performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
 //                                        }];
 //            [task resume];
 //        }];
 //
 // [_que addOperation:op1];
 }
 */

/*-(void)dataParsing2
 {
 NSBlockOperation *op1=[NSBlockOperation blockOperationWithBlock:^{
 NSString *savedvalue2=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
 
 NSString *myst=[NSString stringWithFormat:@"session_id=%@&email=%@",_temp_session_id,savedvalue2];
 
 
 NSString *urlstr=@"http://192.168.1.100/phpmyadmin/itherm/paper_name.php";
 //        NSString * urlstr =@"http://www.siddhantedu.com/iOSAPI/tech_talk3.php";//server
 NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstr]];
 [request setHTTPMethod:@"POST"];
 [request setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
 NSError *error=nil;
 NSLog(@"POST CONTAINT agenda....%@",myst);
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
 
 NSArray *keyarr=[outerdic objectForKey:@"paper_info"];
 NSLog(@"SESSION AAAA=%@",keyarr);
 
 for(NSDictionary *dict1 in keyarr)
 {
 
 Paper_itherm *pi=[[Paper_itherm alloc]init];
 pi.paper_id=dict1[@"paper_id"];
 pi.paper_name=dict1[@"paper_name"];
 
 if([dict1[@"paper_abstract"]isEqual:[NSNull null]])
 {
 pi.paper_abstract=@"--";
 NSLog(@"Paper abstract===%@",pi.paper_abstract);
 }
 else
 {
 pi.paper_abstract=dict1[@"paper_abstract"];
 NSLog(@"Paper Name in loop....!%@",pi.paper_abstract);
 }
 pi.start_time=dict1[@"start_time"];
 pi.session_id=dict1[@"session_id"];
 pi.added=dict1[@"added"];
 //                                                pi.course_no=dict1[@"course_no"];
 //
 NSLog(@"********start time:****%@ & *****courseabstract=%@ ",pi.start_time,pi.paper_abstract);
 
 NSString *str=[NSString stringWithFormat:@"%@",pi.added];
 
 NSLog(@".....String LEngth  %lu \t String : %@",(unsigned long)str.length,str);
 
 if([str isEqualToString:@"<null>"])
 {
 //                    NSLog(@" if([str isEqualToString:])");
 }
 else{
 [_tickarray addObject:str];
 }
 
 [self.all_papers addObject:pi];
 
 
 
 
 NSArray *authors=dict1[@"author"];
 for (NSDictionary *dict in authors) {
 
 Paper_author *aut=[[Paper_author alloc]init];
 aut.paper_id=dict1[@"paper_id"];
 aut.emailid=dict[@"emailid"];
 aut.first_name=dict[@"first_name"];
 aut.last_name=dict[@"last_name"];
 aut.country=dict[@"country"];
 aut.affiliation=dict[@"affiliation"];
 aut.salutation=dict[@"salutation"];
 aut.mobile_no=dict[@"mobile_no"];
 
 [self.all_authors
 addObject:aut];
 }
 }
 [_tableview reloadData];
 }
 [_tableview performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
 }];
 [task resume];
 }];
 
 [_que addOperation:op1];
 }
 
 
 
 -(void)dataParsing1
 {
 NSBlockOperation *op1=[NSBlockOperation blockOperationWithBlock:^{
 NSString *savedvalue2=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
 
 NSString *myst=[NSString stringWithFormat:@"session_id=%@&email=%@",_temp_session_id,savedvalue2];
 
 
 NSString *urlstr=@"http://192.168.1.100/phpmyadmin/itherm/agenda_new.php";
 //        NSString * urlstr =@"http://www.siddhantedu.com/iOSAPI/tech_talk3.php";//server
 NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstr]];
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
 
 NSDictionary *outerdic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
 
 NSArray *paper=[outerdic objectForKey:@"full_papers"];
 NSLog(@"Full paper===%@",paper);
 for (NSDictionary *dict1 in paper)
 {
 Paper_itherm *pi=[[Paper_itherm alloc]init];
 pi.paper_id=dict1[@"paper_id"];
 pi.paper_name=dict1[@"paper_name"];
 if([dict1[@"paper_abstract"]isEqual:[NSNull null]])
 {
 pi.paper_abstract=@"--";
 }
 else
 {
 pi.paper_abstract=dict1[@"paper_abstract"];
 }
 pi.start_time=dict1[@"start_time"];
 pi.session_id=dict1[@"session_id"];
 pi.added=dict1[@"added"];
 
 NSString *str=[NSString stringWithFormat:@"%@",pi.added];
 
 
 if([str isEqualToString:@"<null>"])
 {
 //                    NSLog(@" if([str isEqualToString:])");
 }
 else{
 [_tickarray addObject:str];
 }
 
 [self.all_papers addObject:pi];
 
 NSArray *authors=dict1[@"author"];
 for (NSDictionary *dict in authors) {
 
 Paper_author *aut=[[Paper_author alloc]init];
 aut.paper_id=dict1[@"paper_id"];
 aut.emailid=dict[@"emailid"];
 aut.first_name=dict[@"first_name"];
 aut.last_name=dict[@"last_name"];
 aut.country=dict[@"country"];
 aut.affiliation=dict[@"affiliation"];
 aut.salutation=dict[@"salutation"];
 aut.mobile_no=dict[@"mobile_no"];
 [self.all_authors addObject:aut];
 }
 }
 
 
 [_tableview reloadData];
 }
 [_tableview performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
 }];
 [task resume];
 }];
 
 [_que addOperation:op1];
 }
 
 -(void)agendanewsession{
 
 
 NSString *savedvalue2=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
 NSString *myst=[NSString stringWithFormat:@"emailid=%@&session_id=%@",savedvalue2,_temp_session_id];
 NSLog(@"session_id.......%@",myst);
 
 NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
 NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
 
 
 // NSURL *url=[NSURL URLWithString:@"http://siddhantedu.com/iOSAPI/agenda_new.php"];//server
 //NSURL * url = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/iOSAPI/agenda_new.php"];//local
 NSURL * url = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/agenda_new.php"];
 
 NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
 [urlRequest setHTTPMethod:@"POST"];
 [urlRequest setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
 
 
 NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
 if(error == nil)
 {
 
 NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
 NSLog(@"data=%@",text);
 NSError *err=nil;
 NSDictionary *responsedict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
 if (err) {
 NSLog(@"error is %@ ",err.description);
 }
 NSLog(@"dictionary is %@ ",responsedict);
 
 NSArray *paper=responsedict[@"full_papers"];
 // NSLog(@"full papers=%@",paper);
 for (NSDictionary *dict1 in paper) {
 Paper_itherm *pi=[[Paper_itherm alloc]init];
 pi.paper_id=dict1[@"paper_id"];
 pi.paper_name=dict1[@"paper_name"];
 NSLog(@"paper_abstract Name....!%@",dict1[@"paper_abstract"]);
 if([dict1[@"paper_abstract"]isEqual:[NSNull null]])
 {
 pi.paper_abstract=@"--";
 }
 else
 {
 pi.paper_abstract=dict1[@"paper_abstract"];
 }
 pi.start_time=dict1[@"start_time"];
 pi.session_id=dict1[@"session_id"];
 pi.added=dict1[@"added"];
 NSLog(@"********start time:****%@",pi.start_time);
 
 NSString *str=[NSString stringWithFormat:@"%@",pi.added];
 
 NSLog(@".....String LEngth  %lu \t String : %@",(unsigned long)str.length,str);
 
 //                if ([str isEqual:nil]) {
 //                    NSLog(@"IN NULL...");
 //
 //
 //                    // [cell.reminderButton setImage:[UIImage imageNamed:@"addNew.png"] forState:UIControlStateNormal];
 //                }
 //                else{
 //                    NSLog(@"NOT NULL.......");
 //                    NSLog(@"%@ ADDED STRING",str);
 //                    // [_tickarray addObject:tempadd];
 //                    //   [cell.reminderButton setImage:[UIImage imageNamed:@"addedNew.png"] forState:UIControlStateNormal];
 //                    [_tickarray addObject:str];
 //
 // }
 
 if([str isEqualToString:@"<null>"])
 {
 //                    NSLog(@" if([str isEqualToString:])");
 }
 else{
 [_tickarray addObject:str];
 }
 
 [self.all_papers addObject:pi];
 
 
 
 
 NSArray *authors=dict1[@"author"];
 for (NSDictionary *dict in authors) {
 
 Paper_author *aut=[[Paper_author alloc]init];
 aut.paper_id=dict1[@"paper_id"];
 aut.emailid=dict[@"emailid"];
 aut.first_name=dict[@"first_name"];
 aut.last_name=dict[@"last_name"];
 aut.country=dict[@"country"];
 aut.affiliation=dict[@"affiliation"];
 aut.salutation=dict[@"salutation"];
 aut.mobile_no=dict[@"mobile_no"];
 [self.all_authors addObject:aut];
 }
 }
 dispatch_async(dispatch_get_main_queue() , ^{
 //                for (Paper_itherm *pi in self.all_papers) {
 //                    NSLog(@"paper-id is %@",pi.paper_id);
 //                    NSLog(@"paper name is %@",pi.paper_name);
 //
 //                }
 [self.tableview reloadData];
 });
 }
 }];
 
 [dataTask resume];
 }
 
 */
/*
 -(void)speakerlastdata{
 
 self.paper_id=[[NSMutableArray alloc]init];
 self.paper_name=[[NSMutableArray alloc]init];
 self.all_authors=[[NSMutableArray alloc]init];
 self.paper_abstract=[[NSMutableArray alloc]init];
 
 
 
 
 NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
 NSURLSession *defaultSession3 = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
 
 //NSURL * url2 = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/iOSAPI/speakers_last_3.php"];//local
 // NSURL *url2=[NSURL URLWithString:@"http://siddhantedu.com/iOSAPI/speakers_last_3.php"];//server
 // //NSURL * url2 = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/iOSAPI/changedapis/speakers_last2.php"];
 NSURL * url2 = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/speakers_last_3.php"];
 
 NSMutableURLRequest * urlRequest2 = [NSMutableURLRequest requestWithURL:url2];
 [urlRequest2 setHTTPMethod:@"GET"];
 
 NSURLSessionDataTask * dataTask3 =[defaultSession3 dataTaskWithRequest:urlRequest2 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
 if(error == nil)
 {
 
 NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
 NSLog(@"data=%@",text);
 NSError *er=nil;
 NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&er];
 if(er)
 {
 NSLog(@"error is %@",er.description);
 }
 NSLog(@"data=%@",responseDict);
 NSArray *arr=[responseDict objectForKey:@"all_papers"];
 
 NSString *pid=0;
 for(NSDictionary *dict in arr)
 {
 pid=dict[@"paper_id"];
 NSString *pname=dict[@"paper_name"];
 NSString *abstract=dict[@"paper_abstract"];
 NSString *starttime=dict[@"start_time"];
 NSLog(@"************ABSTRACT%@",abstract);
 [self.paper_id addObject:pid];
 NSLog(@"pid is %@",pid);
 // [self.paper_name addObject:_paper_name];
 
 NSArray *authors=dict[@"author"];
 //NSLog(@"array is %@",authors);
 for(NSDictionary *dictionary in authors)
 {
 Paper_author *aut=[[Paper_author alloc]init];
 aut.paper_id=pid;
 aut.emailid=dictionary[@"emailid"];
 aut.first_name=dictionary[@"first_name"];
 aut.last_name=dictionary[@"last_name"];
 aut.country=dictionary[@"country"];
 aut.affiliation=dictionary[@"affiliation"];
 aut.salutation=dictionary[@"salutation"];
 aut.mobile_no=dictionary[@"mobile_no"];
 [self.all_authors addObject:aut];
 //NSLog(@"name is %@",dictionary[@"first_name"]);
 }
 }
 
 
 }
 dispatch_async(dispatch_get_main_queue(), ^{
 [self.tableview reloadData];
 
 });
 }];
 
 [dataTask3 resume];
 
 
 
 }
 */

- (IBAction)viewMapBtn:(id)sender {
}
@end
