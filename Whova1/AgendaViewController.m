
#import "AgendaViewController.h"
#import "InvitedInfoViewController.h"
#import "TechTalkNewViewController.h"
#import "SessTalkViewController.h"
#import "Reachability.h"
#import "WomenViewController.h"
#import "Constant.h"
#define SYSTEM_VERSION_GREATERTHAN_OR_EQUALTO(v) ([[[UIDevice currentDevice]systemVersion] compare:v options:NSNumericSearch]!=NSOrderedAscending)
@interface AgendaViewController ()

@end

@implementation AgendaViewController


-(void)getAgendaWSCall
{
    _tickArr=[[NSMutableArray alloc]init];
    [self.tableView setSeparatorColor:[UIColor clearColor]];
    [_segView setUserInteractionEnabled:NO];
    
    self.all_authors=[[NSMutableArray alloc]init];
    self.all_sessions=[[NSMutableArray alloc]init];
    self.all_papers=[[NSMutableArray alloc]init];
    
    self.user_sessions=[[NSMutableArray alloc]init];
    _prog_id_arr=[[NSMutableArray alloc]init];
    _session_id_arr=[[NSMutableArray alloc]init];
    [_indicator startAnimating];
    
    NSString *savedvalue2=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
    NSString *myst2=[NSString stringWithFormat:@"emailid=%@",savedvalue2];
    
    
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    
    NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:agenda_first8]];
    
   // NSURL * url = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/agenda_first6.php"];
    
    
    //NSURL *url=[NSURL URLWithString:@"http://siddhantedu.com/iOSAPI/agenda_first3.php"];//server
    
    NSMutableURLRequest *urlrequest=[NSMutableURLRequest requestWithURL:url];
    [urlrequest setHTTPMethod:@"POST"];
 
    [urlrequest setHTTPBody:[myst2 dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask *tassk=[session dataTaskWithRequest:urlrequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSString *text=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"data=%@",text);
        
        NSError *error1=nil;
        NSDictionary *responsedict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error1];
        if(error1)
        {
            NSLog(@"error 1 is %@",error1.description);
        }
        NSLog(@"json = %@",responsedict);
        
        NSArray *agenda=[responsedict objectForKey:@"full_agenda"];
        for(NSDictionary *dict in agenda)
        {
            Session_itherm *sess=[[Session_itherm alloc]init];
            sess.date=dict[@"date"];
            sess.day=dict[@"day"];
            sess.end_time=dict[@"end_time"];
            sess.room_name=dict[@"room_name"];
            sess.session_id=dict[@"session_id"];
            sess.session_name=dict[@"session_name"];
            sess.start_time=dict[@"start_time"];
            sess.program_type_id=dict[@"program_type_id"];
            sess.category=dict[@"category"];
            sess.time_falg=dict[@"time_flag"];
            sess.line_flag=dict[@"line_flag"];
            sess.line_lbl=dict[@"line_lbl"];
            sess.line_down=dict[@"line_down"];
            sess.paper_details_cnt=dict[@"paper_details_cnt"];
            sess.user_paper_cnt=dict[@"user_paper_cnt"];
            

            [self.all_sessions addObject:sess];
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            for(Session_itherm *sess in self.all_sessions)
            {
              
                NSLog(@"day is %@",sess.day);
                
            }
            
            NSPredicate *predicate1=[NSPredicate predicateWithFormat:@"day matches 'Tuesday'"];
            self.session = [self.all_sessions filteredArrayUsingPredicate:predicate1];
           
            [self.tableView reloadData];
            [self segvaluechanged:_segView];
            
            
        });
    }];
    
    [tassk resume];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
 
    self.navigationItem.backBarButtonItem.title=@"Back";
    
    UIBarButtonItem *newBackButton =
    [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                     style:UIBarButtonItemStylePlain
                                    target:nil
                                    action:nil];
    [[self navigationItem] setBackBarButtonItem:newBackButton];
   
    
}

-(void)getAgendaMasterWSCall
{
    self.myrem=[[NSMutableArray alloc]init];
    self.rem=[[NSMutableArray alloc]init];
    
    [self.segView addTarget:self action:@selector(segvaluechanged:) forControlEvents:UIControlEventValueChanged];
    NSString *savedvalue=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
    
    NSString *myst=[NSString stringWithFormat:@"emailid=%@",savedvalue];//2
    
    NSURLSessionConfiguration *defaultConfigObject=[NSURLSessionConfiguration defaultSessionConfiguration];
    
    
    NSURLSession *defaultSession=[NSURLSession sessionWithConfiguration:defaultConfigObject delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURL * url1 = [NSURL URLWithString:[mainUrl stringByAppendingString:user_session_get5]];
    
    //NSURL * url1 = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/user_session_get5.php"];
 
    //NSURL *url1=[NSURL URLWithString:@"http://siddhantedu.com/iOSAPI/user_session_get2.php"];//server
    
    
    
    NSMutableURLRequest *urlRequest1=[NSMutableURLRequest requestWithURL:url1];
    [urlRequest1 setHTTPMethod:@"POST"];
    [urlRequest1 setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSURLSessionDataTask *dataTask=[defaultSession dataTaskWithRequest:urlRequest1 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                     {
                                        if (error) {
                                            
                                            NSLog(@"error=%@",error.description);
                                        }
                                        
                                        NSString *text=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                        NSLog(@"data is= %@",text);
                                        NSError *error1=nil;
                                        
                                        
                                        if(data!=nil)
                                        {
                                        
                                        NSDictionary *responsedict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error1];
                                        if (error1) {
                                            NSLog(@"Error is %@",error1.description);
                                        }
                                        NSLog(@"json=%@",responsedict);
                                        
                                        NSArray *agenda=[responsedict objectForKey:@"agendamaster"];
                                        for(NSDictionary *dict in agenda){
                                            Session_itherm *sess=[[Session_itherm alloc]init];
                                            sess.session_name=dict[@"session_name"];
                                            sess.room_name=dict[@"room_name"];
                                            sess.date=dict[@"date"];
                                            sess.day=dict[@"day"];
                                            sess.start_time=dict[@"start_time"];
                                            sess.end_time=dict[@"end_time"];
                                            // sess.track_name=dict[@"track_name"];
                                            sess.session_id=dict[@"session_id"];
                                            sess.program_type_id=dict[@"program_type_id"];
                                            sess.category=dict[@"category"];
                                            sess.time_falg=dict[@"time_flag"];
                                            sess.line_flag=dict[@"line_flag"];
                                            sess.line_lbl=dict[@"line_lbl"];
                                            sess.line_down=dict[@"line_down"];
                                            
                                            
                                            [self.user_sessions addObject:sess];
                                        }
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                            
                                            NSLog(@"COUNT=%lu",(unsigned long)self.user_sessions.count);
                                            for(Session_itherm *sess in self.user_sessions) {
                                                NSLog(@"session name is %@",sess.day);
                                            }
                                            [self.tableView reloadData];
                                           
                                        });
                                    }
                                        else
                                        {
                                            NSLog(@"Data  is nil");
                                        }
                                    }
                                    
                                    ];
    
    [dataTask resume];
}
- (BOOL)itemHasReminder:(NSString *)item {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"session_id matches %@", item];
    NSLog(@"item is %@",item);
    NSArray *filtered = [self.user_sessions filteredArrayUsingPredicate:predicate];
    NSLog(@"filtered count is %lu",(unsigned long)filtered.count);
    return ([filtered count]);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self getAgendaWSCall];
    [self getAgendaMasterWSCall];
    
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


- (IBAction)segvaluechanged:(id)sender
{
   // NSString *title=[self.segView titleForSegmentAtIndex:self.segView.selectedSegmentIndex];
 //   NSLog(@"title   *************%@",title);
    
    if(_segView.selectedSegmentIndex==0)
    {
        NSString *title=@"Tuesday";
        NSPredicate *predicate1=[NSPredicate predicateWithFormat:@"day matches %@",title];
       // NSLog(@"predicate......................%@",predicate1);
        self.session = [self.all_sessions filteredArrayUsingPredicate:predicate1];
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
        self.session = [self.all_sessions filteredArrayUsingPredicate:predicate1];
        self.line1.hidden=YES;
        self.line2.hidden=NO;
        self.line3.hidden=YES;
        self.line4.hidden=YES;

        [self.tableView reloadData];
       
    }
    else if(_segView.selectedSegmentIndex==2)
    {
        NSString *title=@"Thursday";
        NSPredicate *predicate1=[NSPredicate predicateWithFormat:@"day matches %@",title];
        self.session = [self.all_sessions filteredArrayUsingPredicate:predicate1];
        self.line1.hidden=YES;
        self.line2.hidden=YES;
        self.line3.hidden=NO;
        self.line4.hidden=YES;

        [self.tableView reloadData];
      
    }
    else if(_segView.selectedSegmentIndex==3)
    {
        NSString *title=@"Friday";
        NSPredicate *predicate1=[NSPredicate predicateWithFormat:@"day matches %@",title];
        self.session = [self.all_sessions filteredArrayUsingPredicate:predicate1];
        self.line1.hidden=YES;
        self.line2.hidden=YES;
        self.line3.hidden=YES;
        self.line4.hidden=NO;
        [self.tableView reloadData];
       
    }

    

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.session.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AgendaViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    Session_itherm *sess=self.session[indexPath.row];
    cell.sessionName.text=sess.session_name;
    cell.startTime.text=sess.start_time;
    cell.endTime.text=sess.end_time;
    cell.locationName.text=sess.room_name;
    cell.date.text=sess.date;
    cell.category.text=sess.category;
    [_indicator stopAnimating];
    [_segView setUserInteractionEnabled:YES];
    NSString *tempflag=sess.time_falg;
    
    if([tempflag isEqualToString:@"0"])
    {
        cell.sessionName.text=sess.session_name;
        cell.startTime.text=sess.start_time;
        cell.endTime.text=sess.end_time;
        cell.locationName.text=sess.room_name;
        cell.date.text=sess.date;
        cell.category.text=sess.category;
        [cell.startTime setHidden:YES];
        [cell.endTime setHidden:YES];
        [cell.tolabel setHidden:YES];
    }
    else
    {
        cell.sessionName.text=sess.session_name;
        cell.startTime.text=sess.start_time;
        cell.endTime.text=sess.end_time;
        cell.locationName.text=sess.room_name;
        cell.date.text=sess.date;
        cell.category.text=sess.category;
        [cell.startTime setHidden:NO];
        [cell.endTime setHidden:NO];
        [cell.tolabel setHidden:NO];
    }
    
    NSString *templinef=sess.line_flag;
    if([templinef isEqualToString:@"0"])
    {
        [cell.lineLabel setHidden:YES];
    }
    else
    {
        [cell.lineLabel setHidden:NO];
    }
    
    NSString *line=sess.line_lbl;
    if([line isEqualToString:@"0"])
    {
        [cell.line_lbl setHidden:YES];
    }
    else
    {
        [cell.line_lbl setHidden:NO];
    }
    
    NSString *temp2=sess.line_down;
    if([temp2 isEqualToString:@"0"])
    {
        [cell.line_down setHidden:YES];
    }
    else
    {
        [cell.line_down setHidden:NO];
    }
    
    

    
    if([cell.category.text isEqualToString:@"Keynote"])
    {
        cell.category.backgroundColor=[UIColor greenColor];
    }
    else if([cell.category.text isEqualToString:@"Techtalk"])
    {
        cell.category.backgroundColor=[UIColor orangeColor];
    }
    else if([cell.category.text isEqualToString:@"Panel"])
    {
        cell.category.backgroundColor=[UIColor blueColor];
    }
    
    else if([cell.category.text isEqualToString:@"Course"])
    {
        cell.category.backgroundColor=[UIColor purpleColor];

    }
    else if([cell.category.text isEqualToString:@"Invited"])
    {
        cell.category.backgroundColor=[UIColor cyanColor];
    }
    else if([cell.category.text isEqualToString:@"Women"])
    {
        cell.category.backgroundColor=[UIColor colorWithRed:8.0/255.0 green:42.0/255.0 blue:127.0/255.0 alpha:1.0];
        
    }
    else if([cell.category.text isEqualToString:@"Poster"])
    {
        cell.category.backgroundColor=[UIColor magentaColor];
    }

    else
    {
        cell.category.backgroundColor=[UIColor lightGrayColor];
    }
   
    UIButton *_button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
   // [_button setFrame:CGRectMake(600.0f,-40.0f,50.0f,50.0f)]; // SET the values for your wishes right side
    
    [_button setFrame:CGRectMake(-5.0f, -5.0f, 50.0f, 50.0f)];
    [_button setCenter:CGPointMake(128.f, 128.f)]; // SET
    [_button setClipsToBounds:false];
    
    [_button setBackgroundImage:[UIImage imageNamed:@"addNew.png"] forState:UIControlStateNormal];
    //[_button setTitle:@"  Add alarm" forState:UIControlStateNormal];
   // [_button.titleLabel setFont:[UIFont systemFontOfSize:8.0f]];
   // [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //[_button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
   // [_button setTitleEdgeInsets:UIEdgeInsetsMake(10.0f,-5.0f,-50.0f,0.0f)];
    [_button addTarget:self action:@selector(buttonclicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *alarm_done=[[UIImageView alloc]initWithFrame:CGRectMake(17.0f,26.0f,36.0f,36.0f)];
  // UIImageView *alarm_done=[[UIImageView alloc]initWithFrame:CGRectMake(400.0f,-80.0f,50.0f,50.0f)];//right side image
    alarm_done.image=[UIImage imageNamed:@"addedNew.png"];

   if([cell.category.text isEqualToString:@"Break"])
    {
        NSLog(@"****BREAK......");
        cell.accessoryType=UITableViewCellAccessoryDetailDisclosureButton;
        
        [_button setHidden:NO];
        [_button setBackgroundImage:[UIImage imageNamed:@"right.png"] forState:UIControlStateNormal];
        [_button setEnabled:NO];
        cell.category.backgroundColor=[UIColor redColor];
        cell.accessoryType=UITableViewCellAccessoryDetailDisclosureButton;
    
    }
    
    
if([sess.category isEqualToString:@"Session"])
{

    if([sess.paper_details_cnt isEqualToString:sess.user_paper_cnt])
    {
        NSLog(@"Paper details count=%@",sess.paper_details_cnt);
        NSLog(@"User Paper count=%@",sess.user_paper_cnt);
        cell.accessoryView=alarm_done;
        NSLog(@"ALARM DONE CLICKED-%@",cell.accessoryView);
    }
    else
    {
        cell.accessoryView=_button;
       _button.tag=indexPath.row;
        
        NSLog(@"ALARM NOT DONE CLICKED-%@",cell.accessoryView);
    }
    
}
 if([sess.category isEqualToString:@"Course"])
    {
        
        if([sess.paper_details_cnt isEqualToString:sess.user_paper_cnt])
        {
            cell.accessoryView=alarm_done;
            
        }
        else
        {
            cell.accessoryView=_button;
            _button.tag=indexPath.row;
        }
        
    }
    
 if([sess.category isEqualToString:@"Techtalk"])
    {
        
        if([sess.paper_details_cnt isEqualToString:sess.user_paper_cnt])
        {
            cell.accessoryView=alarm_done;
            
        }
        else
        {
            cell.accessoryView=_button;
            _button.tag=indexPath.row;
        }
        
    }
    
    
 if([sess.category isEqualToString:@"Invited"])
    {
        
        if([sess.paper_details_cnt isEqualToString:sess.user_paper_cnt])
        {
            cell.accessoryView=alarm_done;
            
        }
        else
        {
            cell.accessoryView=_button;
            _button.tag=indexPath.row;
        }
        
    }
    if([sess.category isEqualToString:@"Keynote"])
    {
        
        if([sess.paper_details_cnt isEqualToString:sess.user_paper_cnt])
        {
            cell.accessoryView=alarm_done;
            
        }
        else
        {
            cell.accessoryView=_button;
            _button.tag=indexPath.row;
        }
        
    }
    if([sess.category isEqualToString:@"Women"])
    {
        
        if([sess.paper_details_cnt isEqualToString:sess.user_paper_cnt])
        {
            cell.accessoryView=alarm_done;
            
        }
        else
        {
            cell.accessoryView=_button;
            _button.tag=indexPath.row;
        }
        
    }
    if([sess.category isEqualToString:@"Panel"])
    {
        
        if([sess.paper_details_cnt isEqualToString:sess.user_paper_cnt])
        {
            cell.accessoryView=alarm_done;
            
        }
        else
        {
            cell.accessoryView=_button;
            _button.tag=indexPath.row;
        }
        
    }

   else
    {
   
//    if (![self itemHasReminder:sess.session_id]) {  //uncomment dis for getting remainder alert on top of device
//       // NSLog(@"in if loop");
//        cell.accessoryView=_button;
//        _button.tag=indexPath.row;
//    }
//    else
//    {
//       cell.accessoryView =alarm_done;
//    }
        
      // cell.accessoryView=_button;// current time testing purpose
    }
    
    
    NSString *sessid=sess.session_id;
    
    
    NSLog(@"Array Length : %lu",(unsigned long)_tickArr.count);
    for(int i=0;i<_tickArr.count;i++)
    {
        NSString *str;
        str=[NSString stringWithFormat:@"%@",_tickArr[i]];
        
        //NSLog(@". Paper id in scroll....paper id in tick array  %@..%@..at location %d",sessid,str,i);
        if([str isEqualToString:sessid])
        {
            NSLog(@"******print tick..%@..%@",sessid,str);
            cell.accessoryView=alarm_done;
            
    
            //[cell.accessoryView setImage:[UIImage imageNamed:@"tick-blue.png"] forState:UIControlStateNormal];
            
            
        }
    
//        else{
//             NSLog(@"***Show gray........");
//        }
//        
    }

    
    
    
    //cell.accessoryView=_button; //if we uncoment dis we will get our reminder button and action  (for testing purpose)
    
    
    return cell;
}


-(void)buttonclicked:(id)sender
{
    
    
    UIAlertController * alert=[UIAlertController
                               
                               alertControllerWithTitle:@"ALERT" message:@"Do you want to add in my schedule?"preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes,please"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
    
    UIButton *button = sender;
    Session_itherm *s2=self.session[button.tag];
    [button setBackgroundImage:[UIImage imageNamed:@"addedNew.png"] forState:UIControlStateNormal];
    [self.user_sessions addObject:s2];//sending object directly to array for getting user sessions as per user cliked
        NSString *str=[NSString stringWithFormat:@"%@",s2.session_id];
        [_tickArr addObject:str];
                                    
                                    
    //NSLog(@"%@",s2.start_time);
if(SYSTEM_VERSION_GREATERTHAN_OR_EQUALTO(@"10.0"))
{
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert)
                          completionHandler:^(BOOL granted, NSError * _Nullable error) {
                              if (!error) {
                                  NSLog(@"request authorization succeeded!");
                                  [button setBackgroundImage:[UIImage imageNamed:@"addedNew.png"] forState:UIControlStateNormal];
                                  
    
                              }
                              else
                              {
                                  NSLog(@"user notification failed");
                              }
                          }];
    
    

    UNMutableNotificationContent *objNotificationContent = [[UNMutableNotificationContent alloc] init];
    
    NSString *s=[NSString stringWithFormat:@"Start-time: %@,Room: %@",s2.start_time,s2.room_name];
    objNotificationContent.title = [NSString localizedUserNotificationStringForKey:s2.session_name arguments:nil];
    objNotificationContent.body = [NSString localizedUserNotificationStringForKey:s arguments:nil];
    objNotificationContent.sound = [UNNotificationSound defaultSound];
    
    /// 4. update application icon badge number
    //objNotificationContent.badge = @([[UIApplication sharedApplication] applicationIconBadgeNumber] + 1);
    objNotificationContent.badge=0;
/*
    NSDateFormatter *dt=[[NSDateFormatter alloc]init];
    [dt setDateFormat:@"dd MMMM yyyy"];
   // NSDate *date=[dt dateFromString:@"06 February 2017"];// For current testing purpose use current date
    NSDate *date=[dt dateFromString:s2.date]; //for setting notification use the date of the session selected
    
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    
    NSDateComponents *weekdayComponents =[gregorianCalendar components:(NSCalendarUnitDay | NSCalendarUnitMonth |NSCalendarUnitYear) fromDate:date];
    
    NSLog(@"date com %@",weekdayComponents);
 *///old data uncomment thisss
 //--------------------------------------------------------------------------------------------------------------------
    
    NSDateFormatter *dt=[[NSDateFormatter alloc]init];
    [dt setDateFormat:@"dd MMMM yyyy"];
     //NSDate *date=[dt dateFromString:@"24 November 2017"];/* For current testing purpose use current date*/
    NSDate *date=[dt dateFromString:s2.date];/* for setting notification use the date of the session selected*/
                                              
                                              
                                              NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
                                              
                                              
                                              NSDateComponents *weekdayComponents =[gregorianCalendar components:(NSCalendarUnitDay | NSCalendarUnitMonth |NSCalendarUnitYear) fromDate:date];
                                              
                                              NSLog(@"date com %@",weekdayComponents);
    
    //weekdayComponents.hour=17;
   // weekdayComponents.minute=22;

   /* if ([s2.start_time isEqual:@"08:00 am"]) {
        weekdayComponents.hour=07;
        weekdayComponents.minute=55;//This is used for ringing purpose whatever we set time
        //(This is used to send notification at time we set in weekendcomponents.hour)
    }
    if ([s2.start_time isEqual:@"09:35 am"]) {
        weekdayComponents.hour=9;
        weekdayComponents.minute=30;
    }
    if ([s2.start_time isEqual:@"10:40 am"]) {
        weekdayComponents.hour=10;
        weekdayComponents.minute=35;
    }
    if ([s2.start_time isEqual:@"11:00 am"]) {
        weekdayComponents.hour=10;
        weekdayComponents.minute=55;
    }
    if ([s2.start_time isEqual:@"12:40 pm"]) {
        weekdayComponents.hour=12;
        weekdayComponents.minute=35;
        
    }
    if ([s2.start_time isEqual:@"03:50 pm"]) {
        weekdayComponents.hour=15;
        weekdayComponents.minute=45;
    }
    if ([s2.start_time isEqual:@"05:25 pm"]) {
        weekdayComponents.hour=17;
        weekdayComponents.minute=20;
        
    }
    
   */
    
    // Deliver the notification in five seconds.
    
    UNTimeIntervalNotificationTrigger *trigger1 = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:50.f repeats:NO];
    
    NSLog(@"%@",trigger1);
    UNCalendarNotificationTrigger *trigger=[UNCalendarNotificationTrigger triggerWithDateMatchingComponents:weekdayComponents repeats:NO];
    
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:s2.session_id
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
  NSDate *date=[dt dateFromString:s2.date];// this is used to convert nsstring to nsdate and stored in date variable
    
    
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];

     
   NSDateComponents *weekdayComponents =[gregorianCalendar components:(NSCalendarUnitDay | NSCalendarUnitMonth |NSCalendarUnitYear) fromDate:date];
    
    
    NSLog(@"date com %@",weekdayComponents);
    //weekdayComponents.hour=17;
    // weekdayComponents.minute=22;
 
   /* if ([s2.start_time isEqual:@"08:00 am"]) {
        weekdayComponents.hour=07;
        weekdayComponents.minute=55;//This is used for ringing purpose whatever we set time
        //(Thiw is used to send notification at time we set in weekendcomponents.hour)
    }
    if ([s2.start_time isEqual:@"09:35 am"]) {
        weekdayComponents.hour=9;
        weekdayComponents.minute=30;
    }
    if ([s2.start_time isEqual:@"10:40 am"]) {
        weekdayComponents.hour=10;
        weekdayComponents.minute=35;
    }
    if ([s2.start_time isEqual:@"11:00 am"]) {
        weekdayComponents.hour=10;
        weekdayComponents.minute=55;
    }
    if ([s2.start_time isEqual:@"12:40 pm"]) {
        weekdayComponents.hour=12;
        weekdayComponents.minute=35;
        
    }
    if ([s2.start_time isEqual:@"03:50 pm"]) {
        weekdayComponents.hour=15;
        weekdayComponents.minute=45;
    }
    if ([s2.start_time isEqual:@"05:25 pm"]) {
        weekdayComponents.hour=17;
        weekdayComponents.minute=20;
    }
  */
    
    NSDate *date1=[gregorianCalendar dateFromComponents:weekdayComponents];//this is used to convert nsdatecomponents to nsdate and stored in date1 variable

    UILocalNotification *notification=[[UILocalNotification alloc]init];
    
    NSString *s=[NSString stringWithFormat:@"Start-time: %@,Room: %@",s2.start_time,s2.room_name];

    notification.alertTitle=s2.session_name;

    notification.alertBody=s;
    
    notification.soundName=UILocalNotificationDefaultSoundName;
    notification.applicationIconBadgeNumber=0;
    
    [[UIApplication sharedApplication]scheduleLocalNotification:notification];

    notification.fireDate=date1;


   // NSDateComponents *weekdayComponents=[[NSDateComponents alloc]init];
   // NSDate *date=[dt dateFromString:s2.date];
  /*weekdayComponents.hour=12;
    weekdayComponents.minute=40;
    weekdayComponents.day=24;
    weekdayComponents.month=11;
    weekdayComponents.year=2017;
    NSLog(@"%ld",(long)weekdayComponents.hour);
    weekdayComponents.timeZone=[NSTimeZone timeZoneWithName:@"Asia/Kolkata"];
    
    NSDate *da=[gregorianCalendar dateFromComponents:weekdayComponents];
    NSLog(@"%@",da);
    
    NSDate *da1=[[NSCalendar currentCalendar]dateFromComponents:weekdayComponents];
        NSLog(@"%@",da);
    
    
    
    notification.fireDate=[gregorianCalendar dateFromComponents:weekdayComponents];
    notification.fireDate=[[NSCalendar currentCalendar]dateFromComponents:weekdayComponents];
    
    
    NSDateFormatter *dt1=[[NSDateFormatter alloc]init];
    [dt1 setDateFormat:@"dd MMMM yyyy hh:mm:ss a"];
    NSDate *da2=[dt1 dateFromString:@"24 November 2017 12:40:00 pm"];
    //NSDate *da1=[dt dateFromString:s2.date];
    NSLog(@"da is %@",da1);
 
*/
    //testing on current date purpose uncoment dis if user wants to test current date nd time and insert current data
    
    NSLog(@"CODE FOR OLD VERSIONS");
}
    
        NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session=[NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
        NSString *savedValue=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
        
        NSString *myst=[NSString stringWithFormat:@"emailid=%@&session_id=%@",savedValue,s2.session_id];
                                    
                      
                                    
       NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:agenda_reminder_btn]];
                                    
  //NSURL * url = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/agenda_reminder_btn.php"];

    
  //NSURL *url=[NSURL URLWithString:@"http://siddhantedu.com/iOSAPI/user.php"];//server

        
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
                                        NSLog(@"data.....******=%@",text);
                                        NSError *error1=nil;
                                        NSDictionary *responsedict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error1];
                                        if(error1)
                                        {
                                            NSLog(@"error 1 is %@",error1.description);
                                        }
                                        NSLog(@"json = %@",responsedict);
                                        
                                    }];
        [task resume];
    
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
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([[segue identifier]isEqualToString:@"showTalk"])
    {
        SessTalkViewController *stlk=[segue destinationViewController];
        stlk.session_idstr=_tempstr2;
        stlk.stime=_startb_str;
        stlk.locationstr=_locationb_str;
        stlk.etime=_endb_str;
        stlk.sessNamestr=_session_str;
        NSLog(@"IN DID SELECT Agendaaa...%@.....%@",_locationb_str,_session_str);
    
    }
    
    if([[segue identifier]isEqualToString:@"showSession"])
    {
        SessionViewController *s=[segue destinationViewController];
        s.temp_session_id=_tempstr2;
        s.stimestr=_startb_str;
        s.locationstr=_locationb_str;
        s.datestr=_date_str;
        s.sessionstr=_session_str;
        s.etimestr=_endb_str;
    }
    if([[segue identifier]isEqualToString:@"showCourse"])
    {
        CourseViewController *s=[segue destinationViewController];
        s.temp_session_id=_tempstr2;
        s.stimestr=_startb_str;
        s.locationstr=_locationb_str;
        s.datestr=_date_str;
        s.sessionnamestr=_session_str;
        s.etimestr=_endb_str;
    }
    if([[segue identifier]isEqualToString:@"showWomen"])
    {
        WomenViewController *s=[segue destinationViewController];
        s.sessionidStr=_tempstr2;
        s.stimeStr=_startb_str;
        s.locStr=_locationb_str;
        s.etimeStr=_endb_str;
    }
    if([[segue identifier]isEqualToString:@"showPanel"])
    {
        TechTalkNewViewController *t=[segue destinationViewController];
        t.tempsessionid=_tempstr2;
        t.stimeStr=_startb_str;
        t.locStr=_locationb_str;
        t.etimeStr=_endb_str;
      
    }
    
    if([[segue identifier]isEqualToString:@"showPoster"])
    {
        PosterViewController *ps=[segue destinationViewController];
        ps.temp_seesionid_str=_tempstr2;
    }

    if([[segue identifier]isEqualToString:@"showBreak"])
    {
        BreakViewController *b=[segue destinationViewController];
        b.startstr=_startb_str;
        b.endstr=_endb_str;
        b.locationstr=_locationb_str;
    
    }
    
    if([[segue identifier]isEqualToString:@"showKey"])
    {
        KeyViewController *k=[segue destinationViewController];
        k.sessionidstr=_tempstr2;
        k.starttimestr=_startb_str;
        k.locationstr=_locationb_str;
        k.keynotetiltestr=_session_str;
        k.endtimestr=_endb_str;
        
    }
    
    if([[segue identifier]isEqualToString:@"showInvited"])
    {
        InvitedInfoViewController *i=[segue destinationViewController];
        i.session_idstr=_tempstr2;
        i.etime=_endb_str;
        i.stime=_startb_str;
        i.sessNamestr=_session_str;
        i.locationstr=_locationb_str;
    
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
     AgendaViewCell *cell=[_tableView cellForRowAtIndexPath:indexPath];
    _startb_str=cell.startTime.text;
    _endb_str=cell.endTime.text;
    _locationb_str=cell.locationName.text;
    _date_str=cell.date.text;
    _session_str=cell.sessionName.text;
    
    NSLog(@" start time  %@    lbl  %@",_startb_str,cell.startTime.text);
    
    Session_itherm *sess=[_session objectAtIndex:indexPath.row];
    NSString *tempstr=sess.program_type_id;
    _tempstr2=sess.session_id;
    
    NSLog(@"%@",tempstr);

    if([tempstr isEqualToString:@"1"])
    {
    [self performSegueWithIdentifier:@"showSession" sender:self];
    }
    else if([tempstr isEqualToString:@"2"])
    {
        [self performSegueWithIdentifier:@"showKey" sender:nil];
    }
    else if([tempstr isEqualToString:@"3"])
    {
        [self performSegueWithIdentifier:@"showTalk" sender:nil];
    }
    else if([tempstr isEqualToString:@"4"])
    {
        [self performSegueWithIdentifier:@"showCourse" sender:nil];
    }
    
    else if([tempstr isEqualToString:@"5"])
    {
        [self performSegueWithIdentifier:@"showWomen" sender:self];
    }
    else if([tempstr isEqualToString:@"6"])
    {
        [self performSegueWithIdentifier:@"showPoster" sender:nil];
    }
    
    else if([tempstr isEqualToString:@"7"])
    {
        [self performSegueWithIdentifier:@"showBreak" sender:nil];
    }
    else if([tempstr isEqualToString:@"8"])
    {
        [self performSegueWithIdentifier:@"showInvited" sender:nil];
    }
    else if([tempstr isEqualToString:@"9"])
    {
        [self performSegueWithIdentifier:@"showPanel" sender:nil];
    }
    

}

@end
