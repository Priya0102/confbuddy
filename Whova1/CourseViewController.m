//
//  CourseViewController.m
//  ITherm
//
//  Created by Anveshak on 3/31/17.
//  Copyright © 2017 Anveshak . All rights reserved.


#import "CourseViewController.h"
#import "Session_itherm.h"
#import "Constant.h"
#define SYSTEM_VERSION_GREATERTHAN_OR_EQUALTO(v) ([[[UIDevice currentDevice]systemVersion] compare:v options:NSNumericSearch]!=NSOrderedAscending)
@interface CourseViewController ()

@end

@implementation CourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_indicator startAnimating];
    
    _tableview.delegate=self;
    _tableview.dataSource=self;
    

    _endTime.text=_etimestr;
    _startTime.text=_stimestr;
    _loca.text=_locationstr;
    _date.text=_datestr;
    _session_name.text=_sessionnamestr;
    _sessionidLbl.text=_temp_session_id;
    
    NSLog(@"sesss id=%@ & session name=%@",_temp_session_id,_sessionnamestr);
    
    _que=[[NSOperationQueue alloc]init];
    
    
    _tickarray=[[NSMutableArray alloc]init];
    
    
    self.setButton.layer.masksToBounds=YES;
    self.setButton.layer.borderColor=[UIColor colorWithRed:20.0/255.0 green:72.0/255.0 blue:114.0/255.0 alpha:1.0].CGColor;
    self.setButton.layer.borderWidth=1.1;
    
    self.viewMapBtn.layer.masksToBounds=YES;
    self.viewMapBtn.layer.borderColor=[UIColor colorWithRed:20.0/255.0 green:72.0/255.0 blue:114.0/255.0 alpha:1.0].CGColor;
    self.viewMapBtn.layer.borderWidth=1.1;
    self.viewMapBtn.layer.cornerRadius=10;
    

    
    self.user_papers=[[NSMutableArray alloc]init];
    self.all_papers=[[NSMutableArray alloc]init];
    
    self.result=[[NSMutableArray alloc]init];
    
 
   // [self showCourseLeader];
   // [self usercourseget];
   
    
    [self.tableview setSeparatorColor:[UIColor clearColor]];
}



-(void)dataParsing
{
    NSBlockOperation *op1=[NSBlockOperation blockOperationWithBlock:^{
        NSString *savedvalue2=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
        
        NSString *myst=[NSString stringWithFormat:@"session_id=%@&emailid=%@",_temp_session_id,savedvalue2];
        
        NSURL * urlstr = [NSURL URLWithString:[mainUrl stringByAppendingString:course_new]];
        
        //NSString *urlstr=@"http://192.168.1.100/phpmyadmin/itherm/course_new.php";
    
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
                        
                                            NSDictionary *outerdic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                            
                                            NSLog(@"*************************%@",outerdic);
                                            
                                            NSArray *keyarr=[outerdic objectForKey:@"course_info"];
                                            
                                            for(NSDictionary *dict1 in keyarr)
                                            {
                                                Course_itherm *pi=[[Course_itherm alloc]init];
                                                pi.course_id=dict1[@"course_id"];
                                                pi.coursename=dict1[@"course_name"];
                                                
                                                if([dict1[@"course_abstract"]isEqual:[NSNull null]])
                                                {
                                                    pi.courseabstract=@"--";
                                                    NSLog(@"Course abstract===%@",pi.courseabstract);
                                                }
                                                else
                                                {
                                                    pi.courseabstract=dict1[@"course_abstract"];
                                                    NSLog(@"course_abstract Name in loop....!%@",pi.courseabstract);
                                                }
                                                pi.start_time=dict1[@"start_time"];
                                                pi.session_id=dict1[@"session_id"];
                                                pi.added=dict1[@"added"];
                                                pi.course_no=dict1[@"course_no"];
                                                
                                                //NSLog(@"********start time:****%@ & *****courseabstract=%@ ***course no=%@",pi.start_time,pi.courseabstract,pi.course_no);
                                                
                                                NSString *str=[NSString stringWithFormat:@"%@",pi.added];
                                                
                                                //NSLog(@".....String LEngth  %lu \t String : %@",(unsigned long)str.length,str);
                                                
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
                                                    
                                                    Course_Leader *aut=[[Course_Leader alloc]init];
                                                    aut.course_id=dict1[@"course_id"];
                                                    aut.leader=dict[@"leader"];
                                                    aut.university=dict[@"university"];
                                                    
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


/*-(void)showcoursenew{
    NSString *savedvalue=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
    NSString *myst=[NSString stringWithFormat:@"emailid=%@&session_id=%@",savedvalue,_temp_session_id];
    NSLog(@"session_id.......%@",myst);
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    
    // NSURL *url=[NSURL URLWithString:@"http://siddhantedu.com/iOSAPI/agenda_new.php"];//server
    //NSURL * url = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/iOSAPI/agenda_new.php"];//local
    NSURL * url = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/course_new.php"];
    
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
                Course_itherm *pi=[[Course_itherm alloc]init];
                pi.course_id=dict1[@"course_id"];
                pi.coursename=dict1[@"course_name"];
               
                if([dict1[@"course_abstract"]isEqual:[NSNull null]])
                {
                    pi.courseabstract=@"--";
                    NSLog(@"Course abstract===%@",pi.courseabstract);
                }
                else
                {
                pi.courseabstract=dict1[@"course_abstract"];
                     NSLog(@"course_abstract Name in loop....!%@",pi.courseabstract);
                }
                pi.start_time=dict1[@"start_time"];
                pi.session_id=dict1[@"session_id"];
                pi.added=dict1[@"added"];
                pi.course_no=dict1[@"course_no"];
                
                NSLog(@"********start time:****%@ & *****courseabstract=%@ ***course no=%@",pi.start_time,pi.courseabstract,pi.course_no);
                
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
                    
                    Course_Leader *aut=[[Course_Leader alloc]init];
                    aut.course_id=dict1[@"course_id"];
                    aut.leader=dict[@"leader"];
                    aut.university=dict[@"university"];
                    
                    [self.all_authors addObject:aut];
                }
            }
            dispatch_async(dispatch_get_main_queue() , ^{
               
                [self.tableview reloadData];
            });
        }
    }];
    
    [dataTask resume];
}
 */
-(void)usercourseget{
    
    NSString *savedvalue2=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];//1 email-id is used to save in user defaults,this can be done to store value once and can be used anywhere where we required
    NSString *myst2=[NSString stringWithFormat:@"emailid=%@&session_id=%@",savedvalue2,_temp_session_id];
    
    NSLog(@"MYSTRING===%@",myst2);
    
    NSURLSessionConfiguration *defaultConfigObject2=[NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *defaultSession2=[NSURLSession sessionWithConfiguration:defaultConfigObject2 delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURL * url2 = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/user_course_get.php"];
    //NSURL * url1 = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/iOSAPI/changedapis/user_paper_get6.php"];//local
    //NSURL *url1=[NSURL URLWithString:@"http://siddhantedu.com/iOSAPI/user_paper_get6.php"];//server
    
    
    NSMutableURLRequest *urlRequest2=[NSMutableURLRequest requestWithURL:url2];
    [urlRequest2 setHTTPMethod:@"POST"];//we get to knw dat we r sending post mtd to above url
    [urlRequest2 setHTTPBody:[myst2 dataUsingEncoding:NSUTF8StringEncoding]]; //3 this is used to encode data
    
    
    NSURLSessionDataTask *dataTask2=[defaultSession2 dataTaskWithRequest:urlRequest2 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)//wen we create datatask it resume first and den dat url(task/api) is go through completion handler block...
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
                                             Course_itherm *pi=[[Course_itherm alloc]init];
                                             
                                             pi.coursename=dict[@"course_name"];
                                             pi.start_time=dict[@"start_time"];
                                             pi.course_no=dict[@"course_no"];
                                             pi.room_name=dict[@"room_name"];
                                             pi.course_id=dict[@"course_id"];
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

-(void)showCourseLeader{
    

    self.courseid=[[NSMutableArray alloc]init];
    self.courseNamearr=[[NSMutableArray alloc]init];
    self.all_authors=[[NSMutableArray alloc]init];
    self.course_abstract=[[NSMutableArray alloc]init];
    
    
    NSURLSessionConfiguration *defaultConfigObject2 = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession3 = [NSURLSession sessionWithConfiguration: defaultConfigObject2 delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL * url3 = [NSURL URLWithString:[mainUrl stringByAppendingString:course_leader]];
   
    //NSURL * url3 = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/course_leader.php"];
    
    NSMutableURLRequest * urlRequest3 = [NSMutableURLRequest requestWithURL:url3];
    [urlRequest3 setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask * dataTask3 =[defaultSession3 dataTaskWithRequest:urlRequest3 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(error == nil)
        {
            
            NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
            NSLog(@"data data in course leader=%@",text);
            NSError *er=nil;
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&er];
            if(er)
            {
                NSLog(@"error is %@",er.description);
            }
            NSLog(@"data in course leader=%@",responseDict);
            NSArray *arr=[responseDict objectForKey:@"all_papers"];
            
            NSString *pid=0;
            for(NSDictionary *dict in arr)
            {
                pid=dict[@"course_id"];
                NSString *cname=dict[@"course_name"];
                NSString *abstract=dict[@"course_abstract"];
                NSString *starttime=dict[@"start_time"];
                NSLog(@"************ABSTRACT%@",abstract);
                [self.courseid addObject:pid];
               // NSLog(@"pid is %@",pid);
                // [self.paper_name addObject:_paper_name];
                
                NSArray *authors=dict[@"author"];
                //NSLog(@"array is %@",authors);
                for(NSDictionary *dictionary in authors)
                {
                    Course_Leader *aut=[[Course_Leader alloc]init];
                    aut.course_id=pid;
                    aut.leader=dictionary[@"leader"];
                    aut.university=dictionary[@"university"];
                    
                    
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

- (BOOL)itemHasReminder:(NSString *)item {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"course_id matches %@", item];
    NSLog(@"item is %@",item);
    NSArray *filtered = [self.user_papers filteredArrayUsingPredicate:predicate];
    //NSLog(@"filtered count is %lu",(unsigned long)filtered.count);
    return ([filtered count]);
}
- (void)viewWillAppear:(BOOL)animated
{
    [self.tableview reloadData];
    [self dataParsing];
   // (@"TICK ARRAY COUNT IN Will Appear....%lu",(unsigned long)_tickarray.count);
    //NSLog(@"hi");
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.all_papers.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CourseTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    Course_itherm *paper=self.all_papers[indexPath.row];
    
    cell.coursename.text=paper.coursename;
    cell.courseid.text=paper.course_id;
    cell.starttime.text=paper.start_time;
    cell.reminderButton.tag=indexPath.row;
    cell.courseabstract.text=paper.courseabstract;
    cell.courseno.text=paper.course_no;
    
    [_indicator stopAnimating];
    
   // NSLog(@"Course abs==%@& course id==%@ & course name=%@",cell.courseabstract.text,cell.courseid.text,cell.coursename.text);
    //NSLog(@"added status=%@",paper.added);
    
    NSString *tempadd=paper.added;
    NSString *pprid=paper.course_id;
    
    
    if ([tempadd isEqual:[NSNull null]]) {
        //NSLog(@"course Tempdata is null.....");
        [cell.reminderButton setImage:[UIImage imageNamed:@"addNew.png"] forState:UIControlStateNormal];
        [cell.reminderButton setUserInteractionEnabled:YES];
    }
    else{
       // NSLog(@" course Show blue.......");
        // [_tickarray addObject:tempadd];
        [cell.reminderButton setImage:[UIImage imageNamed:@"addedNew.png"] forState:UIControlStateNormal];
        [cell.reminderButton setUserInteractionEnabled:NO];
        //         NSLog(@"tick array value********%@",_tickarray[indexPath.row]);
    }
    
    NSLog(@"Array Length : %lu",(unsigned long)_tickarray.count);
    for(int i=0;i<_tickarray.count;i++)
    {
        NSString *str;
        str=[NSString stringWithFormat:@"%@",_tickarray[i]];
        
        //NSLog(@". Paper id in scroll....paper id in tick array  %@..%@..at location %d",pprid,str,i);
        if([str isEqualToString:pprid])
        {
            //NSLog(@". print tick..%@..%@",pprid,str);
            [cell.reminderButton setImage:[UIImage imageNamed:@"addedNew.png"] forState:UIControlStateNormal];
            
            
        }
        
//        UIImageView *alarm_done=[[UIImageView alloc]init];
//        alarm_done.image=[UIImage imageNamed:@"added.png"];
//        
//        if (![self itemHasReminder:paper.course_id]) {
//            // NSLog(@"in if loop");
//            cell.accessoryView=_setButton;
//            self.setButton.tag=indexPath.row;
//        }
//        else
//        {
//            cell.accessoryView =alarm_done;
//        }
        
        //cell.accessoryView=_setButton;// current time testing purpose
    }
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    

    if([[segue identifier]isEqualToString:@"showDetailCourse"])
    {
        CourseDetailViewController *stlk=[segue destinationViewController];
        stlk.tempcoursid=_courseidstr;
        stlk.starttimestr=_stimestr;
        stlk.locationstr=_locationstr;
        stlk.endtimestr=_etimestr;
        stlk.tempCourseName=_coursenamestr;
        stlk.tempcourseabs=_courseabstractstr;
        stlk.tempSessionName=_sessionnamestr;
        stlk.coursenoStr=_coursenostr;
        stlk.tempsessionid=_temp_session_id;
        
        // NSLog(@"IN Prepare for segue. abstract==%@&course id=%@ &coursename==%@ session name==%@ course no=%@ sessid=%@",_courseabstractstr,_courseidstr,_coursenamestr,_sessionnamestr,_coursenostr,_temp_session_id);
       
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    CourseTableViewCell *cell=[_tableview cellForRowAtIndexPath:indexPath];
    _stimestr=cell.starttime.text;
    _coursenamestr=cell.coursename.text;
    _courseabstractstr=cell.courseabstract.text;
    _courseidstr=cell.courseid.text;
    _coursenostr=cell.courseno.text;
    
   // NSLog(@"IN DID SELECT. abstract==..%@ & course id=%@ & coursename==%@",_courseabstractstr,_courseidstr,_coursenamestr);
    

    
    [self performSegueWithIdentifier:@"showDetailCourse" sender:nil];
    
    
    
}
- (IBAction)alramButtonClick:(id)sender {
    
    
    UIButton *btn =(UIButton *)sender;
    Course_itherm *paper=self.all_papers[btn.tag];
    //[btn setUserInteractionEnabled:YES];
    if([[btn imageForState:UIControlStateNormal]isEqual:[UIImage imageNamed:@"addNew.png"]])
    {
        [btn setImage:[UIImage imageNamed:@"addedNew.png"] forState:UIControlStateNormal];
       // NSLog(@"gray tick clicked...");
       // NSLog(@"PAPER ID:-...%@",paper.course_id);
        NSString *str=[NSString stringWithFormat:@"%@",paper.course_id];
        [_tickarray addObject:str];
        
       // NSLog(@"after adding count is %lu",(unsigned long)_tickarray.count);
    }
    
    else
    {
        //[btn setUserInteractionEnabled:NO];
        [btn setImage:[UIImage imageNamed:@"addNew.png"] forState:UIControlStateNormal];
        
       // NSLog(@"blue tick clicked...");
        NSString *str=[NSString stringWithFormat:@"%@",paper.course_id];
        if([_tickarray isEqual:[NSNull null]])
        {
           // NSLog(@"Array is EMPTY");
        }
        else
        {
            [_tickarray removeObject:str];
            
            //NSLog(@"after removing count is%lu",(unsigned long)_tickarray.count);
            
        }
    }
    
    //NSLog(@"Btn Click...........%ld",(long)btn.tag);
    
    
}



-(void)alarmMethod
{
   // NSLog(@"alram Method....Button Clicked....");
}


- (IBAction)setButton:(id)sender {
    
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
    
    UIButton *btn =(UIButton *)sender;
    
   // NSLog(@"Btn Click...........%ld",(long)btn.tag);
    
    //Paper_itherm *p2=self.all_papers[btn.tag];
    
    //NSLog(@"* set alarm btn click");
    
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
                                   
                                   alertControllerWithTitle:@"ALERT" message:@"Do You Want To Add in My Schedule?"preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"Yes, please"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action)
                                    {// 1
                                        
                                        //What we write here????????**
                                        
                                       // NSLog(@"you pressed Yes, please button");
                                        
                                        for(int i=0;i<_tickarray.count;i++)
                                        {// 2
                                            //NSLog(@"***********************************%@",_tickarray[i]);
                                            
                                            NSString *courseidstr=[NSString stringWithFormat:@"%@",_tickarray[i]];
                                            
                                            Course_itherm *p2=self.all_papers[btn.tag];
                                           // NSLog(@"******alarm btn click");
                                            //NSLog(@"%@paper...............",p2);
                                            [self.user_papers addObject:p2];//sending object directly to array for getting user sessions as per user cliked
                                            
                                           // NSLog(@"#####papers start time===%@",p2.start_time);
                                            if(SYSTEM_VERSION_GREATERTHAN_OR_EQUALTO(@"10.0"))
                                            { //3
                                                UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
                                                [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert)
                                                                      completionHandler:^(BOOL granted, NSError * _Nullable error) {
                                                                          if (!error) {
                                                                              //NSLog(@"request authorization succeeded!");
                                                
                                                         //  [btn setBackgroundImage:[UIImage imageNamed:@"addedNew.png"] forState:UIControlStateNormal];
                                                                              [self.tableview reloadData];
                                                                              
                                                                          }
                                                                          else
                                                                          {
                                                                              //NSLog(@"user notification failed");
                                                                          }
                                                                      }];
                                               
                                                UNMutableNotificationContent *objNotificationContent = [[UNMutableNotificationContent alloc] init];
                                                
                                                NSString *s=[NSString stringWithFormat:@"Start-time: %@",p2.start_time];
                                                NSLog(@"...%@",s);
                                                objNotificationContent.title = [NSString localizedUserNotificationStringForKey:p2.coursename arguments:nil];
                                                objNotificationContent.body = [NSString localizedUserNotificationStringForKey:s arguments:nil];
                                                objNotificationContent.sound = [UNNotificationSound defaultSound];
                                                
                                                /// 4. update application icon badge number
                                                //objNotificationContent.badge = @([[UIApplication sharedApplication] applicationIconBadgeNumber] + 1);
                                                objNotificationContent.badge=0;
                                                
                                                NSDateFormatter *dt=[[NSDateFormatter alloc]init];
                                                [dt setDateFormat:@"dd MMMM yyyy"];
                                                //NSDate *date=[dt dateFromString:@"24 November 2017"];// For current testing purpose use current date
                                                 NSDate *date=[dt dateFromString:p2.date];// for setting notification use the date of the session selected
                                                
                                                
                                                NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
                                                
                                                
                                                NSDateComponents *weekdayComponents =[gregorianCalendar components:(NSCalendarUnitDay | NSCalendarUnitMonth |NSCalendarUnitYear) fromDate:date];
                                                
                                              //  NSLog(@"date com %@",weekdayComponents);
                                                //weekdayComponents.hour=17;
                                                // weekdayComponents.minute=22;
                                                
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
                                                if ([p2.start_time isEqual:@"09:30 am"]) {
                                                    weekdayComponents.hour=9;
                                                    weekdayComponents.minute=25;
                                                }
                                                if ([p2.start_time isEqual:@"10:00 am"]) {
                                                    weekdayComponents.hour=9;
                                                    weekdayComponents.minute=55;
                                                }
                                                
                                                if ([p2.start_time isEqual:@"01:50 pm"]) {
                                                    weekdayComponents.hour=13;
                                                    weekdayComponents.minute=45;
                                                }
                                                if ([p2.start_time isEqual:@"02:00 am"]) {
                                                    weekdayComponents.hour=13;
                                                    weekdayComponents.minute=55;
                                                }
                                                if ([p2.start_time isEqual:@"02:30 am"]) {
                                                    weekdayComponents.hour=14;
                                                    weekdayComponents.minute=25;
                                                }
                                                if ([p2.start_time isEqual:@"03:00 pm"]) {
                                                    weekdayComponents.hour=14;
                                                    weekdayComponents.minute=55;
                                                }
                                                if ([p2.start_time isEqual:@"03:30 pm"]) {
                                                    weekdayComponents.hour=15;
                                                    weekdayComponents.minute=25;
                                                }
                                                
                                                // Deliver the notification in five seconds.
                                                
                                                UNTimeIntervalNotificationTrigger *trigger1 = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:50.f repeats:NO];
                                                
                                                UNCalendarNotificationTrigger *trigger=[UNCalendarNotificationTrigger triggerWithDateMatchingComponents:weekdayComponents repeats:NO];
                                                
                                                UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:p2.course_id
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
                                                if ([p2.start_time isEqual:@"09:30 am"]) {
                                                    weekdayComponents.hour=9;
                                                    weekdayComponents.minute=25;
                                                }
                                                if ([p2.start_time isEqual:@"10:00 am"]) {
                                                    weekdayComponents.hour=9;
                                                    weekdayComponents.minute=55;
                                                }
                                                
                                                if ([p2.start_time isEqual:@"01:50 pm"]) {
                                                    weekdayComponents.hour=13;
                                                    weekdayComponents.minute=45;
                                                }
                                                if ([p2.start_time isEqual:@"02:00 am"]) {
                                                    weekdayComponents.hour=13;
                                                    weekdayComponents.minute=55;
                                                }
                                                if ([p2.start_time isEqual:@"02:30 am"]) {
                                                    weekdayComponents.hour=14;
                                                    weekdayComponents.minute=25;
                                                }
                                                if ([p2.start_time isEqual:@"03:00 pm"]) {
                                                    weekdayComponents.hour=14;
                                                    weekdayComponents.minute=55;
                                                }
                                                if ([p2.start_time isEqual:@"03:30 pm"]) {
                                                    weekdayComponents.hour=15;
                                                    weekdayComponents.minute=25;
                                                }
                                                
                                                NSDate *date1=[gregorianCalendar dateFromComponents:weekdayComponents];//this is used to convert nsdatecomponents to nsdate and stored in date1 variable
                                                
                                                UILocalNotification *notification=[[UILocalNotification alloc]init];
                                                
                                                NSString *s=[NSString stringWithFormat:@"Start-time: %@",p2.start_time];
                                                
                                                notification.alertTitle=p2.coursename;
                                                
                                                notification.alertBody=s;
                                                
                                                notification.soundName=UILocalNotificationDefaultSoundName;
                                                notification.applicationIconBadgeNumber=0;
                                                
                                                [[UIApplication sharedApplication]scheduleLocalNotification:notification];
                                                
                                                notification.fireDate=date1;
                                                
//                                                weekdayComponents.hour=15;
//                                                weekdayComponents.minute=14;
//                                                weekdayComponents.day=24;
//                                                weekdayComponents.month=11;
//                                                weekdayComponents.year=2017;
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
                                               // NSDate *da2=[dt1 dateFromString:@"24 November 2017 03:14:00 pm"];
                                                
                                                
                                                
                                                NSLog(@"CODE FOR OLD VERSIONS");//code for old versions
                                            }
                                            
                                            //    [sender setUserInteractionEnabled:NO];
                                            //    [sender setEnabled:NO];
                                            
                                            NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
                                            NSURLSession *session=[NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
                                            
                                            
                                            
                                            NSString *savedValue=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];//used to retrieve user's emailid which we have stored in nsuserdefaults for key email(those user login dat person mail id will get using userdefaults)
                                            
                                            NSString *myst=[NSString stringWithFormat:@"emailid=%@&course_id=%@&session_id=%@",savedValue,courseidstr,_temp_session_id];
                                            
                                      NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:schedule_course]];
                                            
                                           // NSURL * url = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/schedule_course.php"];//local
                                            
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



@end
