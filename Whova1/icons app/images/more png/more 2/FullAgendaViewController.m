//  FullAgendaViewController.m
//  ITherm
//
//  Created by Anveshak on 2/20/18.
//  Copyright © 2018 Anveshak . All rights reserved.
//
#import "SessionModel.h"
#import "FullAgendaViewController.h"
#import "AgendaViewController.h"
#import "InvitedInfoViewController.h"
#import "TechTalkNewViewController.h"
#import "SessTalkViewController.h"
#import "Reachability.h"
#import "WomenViewController.h"
#import "Constant.h"
#import "FullAgendaTableViewCell.h"
#import "CustomHeaderCell.h"
#import "FullAgendaHeaderView.h"
#import "FullAgendaCollectionViewCell.h"
#import "FullAgendaTableViewCell.h"
#import "SessionHeader.h"
#define SYSTEM_VERSION_GREATERTHAN_OR_EQUALTO(v) ([[[UIDevice currentDevice]systemVersion] compare:v options:NSNumericSearch]!=NSOrderedAscending)

@interface FullAgendaViewController ()

@end

@implementation FullAgendaViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.segView.tintColor=[UIColor clearColor];
    [self.segView setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    
    
    self.line1.hidden=YES;
    self.line2.hidden=YES;
    self.line3.hidden=YES;
    self.line4.hidden=YES;
    
    self.all_authors=[[NSMutableArray alloc]init];
    self.all_sessions=[[NSMutableArray alloc]init];
    _headerArray=[[NSMutableArray alloc]init];
    _sessionModels=[[NSMutableArray alloc]init];
    

    day = @"Tuesday";
    self.navigationItem.backBarButtonItem.title=@"Back";
    
    UIBarButtonItem *newBackButton =
    [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                     style:UIBarButtonItemStylePlain
                                    target:nil
                                    action:nil];
    [[self navigationItem] setBackBarButtonItem:newBackButton];
    
}

-(void)getAgendaWSCall
{
    
    _tickArr=[[NSMutableArray alloc]init];
    
    self.all_papers=[[NSMutableArray alloc]init];
    
    self.user_sessions=[[NSMutableArray alloc]init];
    _prog_id_arr=[[NSMutableArray alloc]init];
    _session_id_arr=[[NSMutableArray alloc]init];
    
    [_indicator startAnimating];
    
    NSString *savedvalue2=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
    NSString *myst2=[NSString stringWithFormat:@"emailid=%@&day=%@",savedvalue2,day];
    NSLog(@"get agenda parameters===%@",myst2);
    
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    
    NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:get_agenda]];
    
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
        NSUInteger l = agenda.count;
        int j = 0;
        NSArray *agendaHeaders=[responsedict objectForKey:@"agenda_header"];
        
        if(l != 0 ) {
            [_headerArray removeAllObjects];
            [_sessionModels removeAllObjects];
            for (NSDictionary *dict1 in agendaHeaders)
            {
                SessionHeader *ch=[[SessionHeader alloc]init];
                ch.starttime=dict1[@"start_time"];
                ch.items=dict1[@"items"];
                [self.headerArray addObject:ch.starttime];
                
                int agItemsInSection=[ch.items intValue];
                ch.sectionNo=dict1[@"section_no"];
                int itemNo = 0;
                [_all_sessions removeAllObjects];
                SessionModel *sectionModel=[[SessionModel alloc]init];
                sectionModel.headerText=ch.starttime;
                sectionModel.sessionArray=[[NSMutableArray alloc]init];
                [sectionModel.sessionArray removeAllObjects];
                for (; j < l && agItemsInSection > 0; j++, agItemsInSection--)
                {
                    NSDictionary *dict=agenda[j];
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
                    sess.remaining=dict[@"remaining"];
                    
                    if(sess!=NULL)
                    {
                        [self.all_sessions addObject:sess];
                        [sectionModel.sessionArray addObject:sess];
                    }
                    else
                    {
                    }
                }
                
                NSLog(@"ch.starttime & agenda array size=%@:array size%lu",ch.starttime,_all_sessions.count);
                if(sectionModel!=NULL)
                {
                    [_sessionModels addObject:sectionModel];
                }
                else
                {
                }
            }
        }
        
        for(SessionModel *sessionModel in _sessionModels)
        {
            NSLog(@"sectionModel=%@:array size%lu",sessionModel.headerText,sessionModel.sessionArray.count);
            
        }
            dispatch_async(dispatch_get_main_queue(), ^{
        
            [self.tableView reloadData];
        });
    }];
    
    [tassk resume];
    
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
    NSLog(@"segvaluechanged called   *************");
    
    if(_segView.selectedSegmentIndex==0)
    {
        day = @"Tuesday";
        
        self.line1.hidden=NO;
        self.line2.hidden=YES;
        self.line3.hidden=YES;
        self.line4.hidden=YES;
    }
    else if(_segView.selectedSegmentIndex==1)
    {
        day = @"Wednesday";
        self.line1.hidden=YES;
        self.line2.hidden=NO;
        self.line3.hidden=YES;
        self.line4.hidden=YES;
    }
    else if(_segView.selectedSegmentIndex==2)
    {
        day = @"Thursday";
        self.line1.hidden=YES;
        self.line2.hidden=YES;
        self.line3.hidden=NO;
        self.line4.hidden=YES;
    }
    else if(_segView.selectedSegmentIndex==3)
    {
        day = @"Friday";
        self.line1.hidden=YES;
        self.line2.hidden=YES;
        self.line3.hidden=YES;
        self.line4.hidden=NO;
        
    }
    NSLog(@"**day is==%@",day);
    [self getAgendaWSCall];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _sessionModels.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    SessionModel *sessionModel =_sessionModels[section];
    _sessArr= sessionModel.sessionArray;
    return _sessArr.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FullAgendaTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

    SessionModel *sessionModel = _sessionModels[indexPath.section];
    self.session = sessionModel.sessionArray;
    
    Session_itherm *sess=self.session[indexPath.row];
    cell.sessionName.text=sess.session_name;
    cell.startTime.text=sess.start_time;
    cell.endTime.text=sess.end_time;
    cell.locationName.text=sess.room_name;
    cell.date.text=sess.date;
    cell.category.text=sess.category;
    [_indicator stopAnimating];
    [_segView setUserInteractionEnabled:YES];
    
   
    if([cell.category.text isEqualToString:@"Keynote"])
    {
           cell.category.backgroundColor=[UIColor colorWithRed:255.0/255.0 green:237.0/255.0 blue:202.0/255.0 alpha:1.0];
           cell.category.layer.borderColor=([UIColor colorWithRed:(247.0/225.0) green:(209.0/225.0) blue:(148.0/255.0)alpha:1.0].CGColor);
        cell.category.layer.borderWidth=1.1;
        cell.category.clipsToBounds=YES;
        cell.category.layer.masksToBounds=YES;
    
    }
    else if([cell.category.text isEqualToString:@"Techtalk"])
    {
         cell.category.backgroundColor=[UIColor colorWithRed:205.0/255.0 green:241.0/255.0 blue:249.0/255.0 alpha:1.0];

         cell.category.layer.borderColor=([UIColor colorWithRed:(130.0/225.0) green:(217.0/225.0) blue:(224.0/255.0)alpha:1.0].CGColor);
        cell.category.layer.borderWidth=1.1;
        cell.category.clipsToBounds=YES;
        cell.category.layer.masksToBounds=YES;
      
    }
    else if([cell.category.text isEqualToString:@"Panel"])
    {
         cell.category.backgroundColor=[UIColor colorWithRed:255.0/255.0 green:227.0/255.0 blue:227.0/255.0 alpha:1.0];
        cell.category.layer.borderColor=([UIColor colorWithRed:(252.0/225.0) green:(197.0/225.0) blue:(197.0/255.0)alpha:1.0].CGColor);
        
        cell.category.layer.borderWidth=1.1;
        cell.category.clipsToBounds=YES;
        cell.category.layer.masksToBounds=YES;
    }
    
    else if([cell.category.text isEqualToString:@"Course"])
    {
        cell.category.backgroundColor=[UIColor colorWithRed:225.0/255.0 green:255.0/255.0 blue:231.0/255.0 alpha:1.0];

        cell.category.layer.borderColor=([UIColor colorWithRed:(166.0/225.0) green:(224.0/225.0) blue:(176.0/255.0)alpha:1.0].CGColor);
        
        cell.category.layer.borderWidth=1.1;
        cell.category.clipsToBounds=YES;
        cell.category.layer.masksToBounds=YES;
        
    }
    else if([cell.category.text isEqualToString:@"Invited"])
    {
           cell.category.backgroundColor=[UIColor colorWithRed:223.0/255.0 green:230.0/255.0 blue:247.0/255.0 alpha:1.0];
        cell.category.layer.borderColor=([UIColor colorWithRed:(163.0/225.0) green:(188.0/225.0) blue:(239.0/255.0)alpha:1.0].CGColor);

        cell.category.layer.borderWidth=1.1;
        cell.category.clipsToBounds=YES;
        cell.category.layer.masksToBounds=YES;
    }
    else if([cell.category.text isEqualToString:@"Women"])
    {
        cell.category.backgroundColor=[UIColor colorWithRed:255.0/255.0 green:230.0/255.0 blue:247.0/255.0 alpha:1.0];
         cell.category.layer.borderColor=([UIColor colorWithRed:(249.0/225.0) green:(183.0/225.0) blue:(230.0/255.0)alpha:1.0].CGColor);
        
        cell.category.layer.borderWidth=1.1;
        cell.category.clipsToBounds=YES;
        cell.category.layer.masksToBounds=YES;
        
    }
    else if([cell.category.text isEqualToString:@"Poster"])
    {
        cell.category.backgroundColor=[UIColor colorWithRed:255.0/255.0 green:254.0/255.0 blue:222.0/255.0 alpha:1.0];
        cell.category.layer.borderColor=([UIColor colorWithRed:(229.0/225.0) green:(223.0/225.0) blue:(140.0/255.0)alpha:1.0].CGColor);
        
        cell.category.layer.borderWidth=1.1;
        cell.category.clipsToBounds=YES;
        cell.category.layer.masksToBounds=YES;
    }
    else if([cell.category.text isEqualToString:@"Break"])
    {
    cell.category.backgroundColor=[UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1.0];
    cell.category.layer.borderColor=([UIColor colorWithRed:(204.0/225.0) green:(204.0/225.0) blue:(204.0/255.0)alpha:1.0].CGColor);
    
        cell.category.layer.borderWidth=1.1;
        cell.category.clipsToBounds=YES;
        cell.category.layer.masksToBounds=YES;
    }
    else
    {
        cell.category.backgroundColor=[UIColor colorWithRed:243.0/255.0 green:224.0/255.0 blue:252.0/255.0 alpha:1.0];
       cell.category.layer.borderColor=([UIColor colorWithRed:(220.0/225.0) green:(184.0/225.0) blue:(244.0/255.0)alpha:1.0].CGColor);
      
        cell.category.layer.borderWidth=1.1;
        cell.category.clipsToBounds=YES;
        cell.category.layer.masksToBounds=YES;

    }
    
   [cell.button  setBackgroundImage:[UIImage imageNamed:@"addNew.png"] forState:UIControlStateNormal];
    
//    SEL twoParameterSelector = @selector(buttonclicked:);
//    [cell.button addTarget:self action:twoParameterSelector forControlEvents:UIControlEventTouchUpInside];

    [cell.button addTarget:self action:@selector(buttonclicked:) forControlEvents:UIControlEventTouchUpInside];
   



    
    
    UIImageView *alarm_done=[[UIImageView alloc]initWithFrame:CGRectMake(8.0f,15.0f,50.0f,50.0f)];
    alarm_done.image=[UIImage imageNamed:@"addedNew.png"];

//    if([sess.category isEqualToString:@"Break"])
//    {
//        NSLog(@"****BREAK......");
//        [cell.button setHidden:YES];
//        [cell.button setBackgroundImage:[UIImage imageNamed:@"right.png"] forState:UIControlStateNormal];
//        [cell.button setEnabled:NO];
//        
//        
//    }
    
    
    if([sess.category isEqualToString:@"Session"])
    {
        
        if([sess.remaining isEqualToString:@"0"])
        {
            NSLog(@"Paper details count=%@",sess.remaining);
            NSLog(@"User Paper count=%@",@"0");
            [cell.button  setBackgroundImage:[UIImage imageNamed:@"addedNew.png"] forState:UIControlStateNormal];
            NSLog(@"ALARM DONE CLICKED-%@",cell.button);
        }
        else
        {
            cell.button.tag=indexPath.row;
            
            NSLog(@"ALARM NOT DONE CLICKED-%@",cell.button);
        }
        
    }
    if([sess.category isEqualToString:@"Course"])
    {
        
        if([sess.remaining isEqualToString:@"0"])
        {
            [cell.button  setBackgroundImage:[UIImage imageNamed:@"addedNew.png"] forState:UIControlStateNormal];
            
        }
        else
        {
            cell.button.tag=indexPath.row;
        }
        
    }
    
    if([sess.category isEqualToString:@"Techtalk"])
    {
        
        if([sess.remaining isEqualToString:@"0"])
        {
            [cell.button  setBackgroundImage:[UIImage imageNamed:@"addedNew.png"] forState:UIControlStateNormal];
            
        }
        else
        {
            cell.button.tag=indexPath.row;
        }
        
    }
    
    
    if([sess.category isEqualToString:@"Invited"])
    {
        
        if([sess.remaining isEqualToString:@"0"])
        {
            [cell.button  setBackgroundImage:[UIImage imageNamed:@"addedNew.png"] forState:UIControlStateNormal];
            
        }
        else
        {
            cell.button.tag=indexPath.row;
        }
        
    }
    if([sess.category isEqualToString:@"Keynote"])
    {
        
        if([sess.remaining isEqualToString:@"0"])
        {
            [cell.button  setBackgroundImage:[UIImage imageNamed:@"addedNew.png"] forState:UIControlStateNormal];
            
        }
        else
        {
            cell.button.tag=indexPath.row;
        }
        
    }
    if([sess.category isEqualToString:@"Women"])
    {
        
        if([sess.remaining isEqualToString:@"0"])
        {
            [cell.button  setBackgroundImage:[UIImage imageNamed:@"addedNew.png"] forState:UIControlStateNormal];
            
        }
        else
        {
            cell.button.tag=indexPath.row;
        }
        
    }
    if([sess.category isEqualToString:@"Panel"])
    {
        
        if([sess.remaining isEqualToString:@"0"])
        {
            [cell.button  setBackgroundImage:[UIImage imageNamed:@"addedNew.png"] forState:UIControlStateNormal];
            
        }
        else
        {

            cell.button.tag=indexPath.row;
        }
        
    }
    
    else
    {
        /*
            if (![self itemHasReminder:sess.session_id]) {  //uncomment dis for getting remainder alert on top of device
               // NSLog(@"in if loop");
                //cell.accessoryView=cell.button;;
                cell.button.tag=indexPath.row;
            }
            else
            {
                
               //cell.accessoryView =alarm_done;
            }
        */
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
            [cell.button  setBackgroundImage:[UIImage imageNamed:@"addedNew.png"] forState:UIControlStateNormal];
            
            
            //[cell.accessoryView setImage:[UIImage imageNamed:@"tick-blue.png"] forState:UIControlStateNormal];
            
            
        }
        
        //        else{
        //             NSLog(@"***Show gray........");
        //        }
        //
    }
    
    
    
    
    //cell.accessoryView=_button; //if we uncoment dis we will get our reminder button and action  (for testing purpose)
    /*  static NSString *cellIdentifier = @"HeaderCell";
     
     UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
     
     if (!cell1)
     {
     cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
     }
     
     NSDictionary *dictionary = self.session[indexPath.section];
     NSArray *array = dictionary[@"session"];
     NSString *cellvalue = array[indexPath.row];
     
     cell1.textLabel.text = cellvalue;
     
     return cell1;
     */
    
      return cell;

}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionHeaderView = [[UIView alloc] initWithFrame:
                                 CGRectMake(0,0, tableView.frame.size.width, 50.0)];
    sectionHeaderView.backgroundColor = (__bridge UIColor * _Nullable)((__bridge CGColorRef _Nullable)([UIColor colorWithRed:(241/255.0) green:(241/255.0) blue:(242/255.0)alpha:1]));
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:
                            CGRectMake(6.0,0.0, sectionHeaderView.frame.size.width, 20.0)];
    
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.textAlignment = NSTextAlignmentLeft;
    [headerLabel setFont:[UIFont fontWithName:@"Verdana" size:11.0]];
    [sectionHeaderView addSubview:headerLabel];
    headerLabel.text = _headerArray[section];
    return sectionHeaderView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 25;
}


-(void)buttonclicked:(id)sender
{
    
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
        
        
        
    
    UIAlertController * alert=[UIAlertController
                               
                               alertControllerWithTitle:@"ALERT" message:@"Do you want to add in my schedule?"preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes,please"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    
                                    UIButton *button = sender;
                                   /* FullAgendaTableViewCell * cell = (FullAgendaTableViewCell *)button.superview;
                                    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
                                    NSLog(@"%@",indexPath);

                                    SessionModel *sessionModel = _sessionModels[indexPath.section];
                                    self.session = sessionModel.sessionArray;*/
                                    //NSIndexPath *indexPath=
                                    
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
    
    if([[segue identifier]isEqualToString:@"showBreakfast"])
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

     
 FullAgendaTableViewCell *cell=[_tableView cellForRowAtIndexPath:indexPath];
 _startb_str=cell.startTime.text;
 _endb_str=cell.endTime.text;
 _locationb_str=cell.locationName.text;
 _date_str=cell.date.text;
 _session_str=cell.sessionName.text;
 
 NSLog(@" start time  %@    lbl  %@",_startb_str,cell.startTime.text);
 
     SessionModel *sessionModel = _sessionModels[indexPath.section];
     self.session = sessionModel.sessionArray;
     
 Session_itherm *sess=[_session objectAtIndex:indexPath.row];
 NSString *tempstr=sess.program_type_id;
 _tempstr2=sess.session_id;
 
 NSLog(@"selected program id===%@",tempstr);
 
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
 [self performSegueWithIdentifier:@"showBreakfast" sender:nil];
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

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
//    /* Create custom view to display section header... */
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 18)];
//    [label setFont:[UIFont boldSystemFontOfSize:12]];
//    NSString *string =[_session objectAtIndex:section];
//    /* Section header is in 0th index... */
//    [label setText:string];
//    [view addSubview:label];
//    [view setBackgroundColor:[UIColor colorWithRed:166/255.0 green:177/255.0 blue:186/255.0 alpha:1.0]]; //your background color...
//    return view;
//}

//-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    // 1. The view for the header
//    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 22)];
//
//    // 2. Set a custom background color and a border
//    headerView.backgroundColor = [UIColor colorWithWhite:0.5f alpha:1.0f];
//    headerView.layer.borderColor = [UIColor colorWithWhite:0.5 alpha:1.0].CGColor;
//    headerView.layer.borderWidth = 1.0;
//
//    // 3. Add a label
//    UILabel* headerLabel = [[UILabel alloc] init];
//    headerLabel.frame = CGRectMake(5, 2, tableView.frame.size.width - 5, 18);
//    headerLabel.backgroundColor = [UIColor clearColor];
//    headerLabel.textColor = [UIColor whiteColor];
//    headerLabel.font = [UIFont boldSystemFontOfSize:16.0];
//    headerLabel.text = @"This is the custom header view";
//    headerLabel.textAlignment = NSTextAlignmentLeft;
//
//    // 4. Add the label to the header view
//    [headerView addSubview:headerLabel];
//
//    // 5. Finally return
//    return headerView;
//}
/*
 
 -(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
 {
 return 30.0;
 }
 
 -(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
 {
 //
 //    // 1. Dequeue the custom header cell
 //    CustomHeaderCell * headerCell = [tableView dequeueReusableCellWithIdentifier:@"HeaderCell"];
 //
 //    // 2. Set the various properties
 //    headerCell.starttime.text = @"08:00 am";
 //    [headerCell.starttime sizeToFit];
 //
 //    headerCell.endtime.text = @"10:00 am";
 //    [headerCell.endtime sizeToFit];
 //
 //    headerCell.image.image = [UIImage imageNamed:@"time-dark.png"];
 //
 //    // 3. And return
 //    return headerCell;
 //
 
 UIView *sectionHeaderView = [[UIView alloc] initWithFrame:
 CGRectMake(0, 0, tableView.frame.size.width, 50.0)];
 sectionHeaderView.backgroundColor = [UIColor cyanColor];
 
 UILabel *headerLabel = [[UILabel alloc] initWithFrame:
 CGRectMake(15, 15, sectionHeaderView.frame.size.width, 25.0)];
 
 headerLabel.backgroundColor = [UIColor clearColor];
 headerLabel.textAlignment = NSTextAlignmentCenter;
 [headerLabel setFont:[UIFont fontWithName:@"Verdana" size:20.0]];
 [sectionHeaderView addSubview:headerLabel];
 
 switch (section) {
 case 0:
 headerLabel.text = @"08:00 am to 09:00am";
 return sectionHeaderView;
 break;
 case 1:
 headerLabel.text = @"09:00 am to 10:00 am";
 return sectionHeaderView;
 break;
 case 2:
 headerLabel.text = @"10:30 am to 11:30 am";
 return sectionHeaderView;
 break;
 default:
 break;
 }
 
 return sectionHeaderView;
 
 }
 
 - (void)collectionView:(UICollectionView *)collectionView
 didSelectItemAtIndexPath:(NSIndexPath *)indexPath
 
 {
 NSLog(@"did select row clicked....");
 }
 */
/*
 
 //image in tableview section header
 
 - (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
 if (section == 5) {
 return 30;
 } else {
 return 0;
 }
 }
 
 - (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
 if (section == 5) {
 UIImage *myImage = [UIImage imageNamed:@"photo.png"];
 UIImageView *imageView = [[UIImageView alloc] initWithImage:myImage];
 imageView.frame = CGRectMake(10, 10, 60, 60);
 UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 70)];
 [view addSubview:imageView];
 
 return view;
 } else {
 return nil;
 }
 }
 
 */





@end


