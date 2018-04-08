//
//  CourseSchViewController.m
//  ITherm
//
//  Created by Anveshak on 12/21/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import "CourseSchViewController.h"
#import "Course_Leader.h"
#import "CourseSchInfoViewController.h"
#import "Constant.h"
@interface CourseSchViewController ()

@end

@implementation CourseSchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // [_indicator startAnimating];
    
    _tableview.delegate=self;
    _tableview.dataSource=self;
    _endTime.text=_etimestr;
    _startTime.text=_stimestr;
    _loca.text=_locationstr;
    _date.text=_datestr;
    _session_name.text=_sessionnamestr;
    _que=[[NSOperationQueue alloc]init];
    
    
    NSLog(@"SESSION ID IN COURSE....%@",_temp_session_id);
    self.user_papers=[[NSMutableArray alloc]init];
    self.all_papers=[[NSMutableArray alloc]init];
    
    self.result=[[NSMutableArray alloc]init];
    
    [self.tableview setSeparatorColor:[UIColor clearColor]];
}
-(void)viewWillAppear:(BOOL)animated{
    [self paperParsing];
    [self usercourseget];
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
    CourseSchTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    Course_itherm *paper=self.all_papers[indexPath.row];
    
    cell.coursename.text=paper.coursename;
    cell.courseid.text=paper.course_id;
    cell.starttime.text=paper.start_time;
    cell.deleteButton.tag=indexPath.row;
    cell.courseabstract.text=paper.courseabstract;
    cell.courseno.text=paper.course_no;
    
   // [_indicator stopAnimating];
    
    NSLog(@"Course abs==%@& course id==%@ & course name=%@",cell.courseabstract.text,cell.courseid.text,cell.coursename.text);
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    CourseSchTableViewCell *cell=[_tableview cellForRowAtIndexPath:indexPath];
    _stimestr=cell.starttime.text;
    _coursenamestr=cell.coursename.text;
    _courseabstractstr=cell.courseabstract.text;
    _courseidstr=cell.courseid.text;
    _coursenostr=cell.courseno.text;

    NSLog(@"IN DID SELECT. abstract==..%@ & course id=%@ & coursename==%@",_courseabstractstr,_courseidstr,_coursenamestr);
    
    
    
    [self performSegueWithIdentifier:@"showInfoSchCourse" sender:nil];
    
    
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    if([[segue identifier]isEqualToString:@"showInfoSchCourse"])
    {
        CourseSchInfoViewController *stlk=[segue destinationViewController];
        stlk.tempcoursid=_courseidstr;
        stlk.starttimestr=_stimestr;
        stlk.locationstr=_locationstr;
        stlk.endtimestr=_etimestr;
        stlk.tempCourseName=_coursenamestr;
        stlk.tempcourseabs=_courseabstractstr;
        stlk.tempSessionName=_sessionnamestr;
        stlk.coursenoStr=_coursenostr;
        stlk.tempsessionid=_temp_session_id;
        
        NSLog(@"IN Prepare for segue. abstract==%@&course id=%@ &coursename==%@ session name==%@ course no=%@ session id==%@",_courseabstractstr,_courseidstr,_coursenamestr,_sessionnamestr,_coursenostr,_temp_session_id);
        
    }
}
- (IBAction)cellDeleteBtnClick:(id)sender {
    
    UIButton *btn=(UIButton *)sender;
    NSLog(@"%ld",(long)btn.tag);
    
    Course_itherm *s3=self.all_papers[btn.tag];
    
    NSLog(@"paper id is=%@",s3.course_id);
    
    
    
    UIAlertController * alert=[UIAlertController
                               
                               alertControllerWithTitle:@"ALERT" message:@"Do You Want To Delete Record?"preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes, please"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    
                                    Course_itherm *s2=self.all_papers[btn.tag];
                                    
                                    NSLog(@"%@",s2);
                                    [_all_papers removeObjectAtIndex:btn.tag];
                                    
                                    NSLog(@"course id is=%@",s3.course_id);
                                    NSString *savedValue=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
                                    
                                    NSString *myst=[NSString stringWithFormat:@"emailid=%@&course_id=%@&session_id=%@",savedValue,s3.course_id,_temp_session_id];
                                    NSLog(@"my string after delete=%@",myst);
                                
                                    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
                                    NSURLSession *session=[NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
                                    
                                    NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:coursedel]];
                                    
                                   // NSURL * url = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/coursedel.php"];
                                   
                                    
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
                                                            
                                                                    [_tableview reloadData];
                                                                    
                                                                }];
                                    [_tableview reloadData];
                                    
                                    if(_all_papers.count == 0)
                                    {
                                        self.courseView.hidden = YES;
                                    }
                                    else
                                    {
                                        self.courseView.hidden = NO;
                                    }
                                    
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

-(void)deleteSession
{
    NSString *savedValue=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
    NSString *myst=[NSString stringWithFormat:@"emailid=%@&session_id=%@",savedValue,_temp_session_id];
     NSLog(@"my string in course schedule=%@",myst);
    
    
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    
    NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:sessiondel_course]];
    
   // NSURL * url = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/sessiondel_course.php"];
    
    
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
                        
                                }];
    [task resume];
}

-(void)dataParsing
 {
 NSBlockOperation *op1=[NSBlockOperation blockOperationWithBlock:^{
 NSString *savedvalue2=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
 
 NSString *myst=[NSString stringWithFormat:@"session_id=%@&email=%@",_temp_session_id,savedvalue2];
 
 NSURL * urlstr = [NSURL URLWithString:[mainUrl stringByAppendingString:course_new]];
 
 // NSString *urlstr=@"http://192.168.1.100/phpmyadmin/itherm/course_new.php";
 
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
 [_tableview reloadData];
 }
 [_tableview performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
 }];
 [task resume];
 }];
 
 [_que addOperation:op1];
 }

 
 -(void)usercourseget{
 
 NSString *savedvalue2=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];//1 email-id is used to save in user defaults,this can be done to store value once and can be used anywhere where we required
 NSString *myst2=[NSString stringWithFormat:@"emailid=%@&session_id=%@",savedvalue2,_temp_session_id];
 
 NSLog(@"MYSTRING===%@",myst2);
 
 NSURLSessionConfiguration *defaultConfigObject2=[NSURLSessionConfiguration defaultSessionConfiguration];
 
 NSURLSession *defaultSession2=[NSURLSession sessionWithConfiguration:defaultConfigObject2 delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
 
 NSURL * url2 = [NSURL URLWithString:[mainUrl stringByAppendingString:user_course_get]];
 
 // NSURL * url2 = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/user_course_get.php"];
 
 
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
 }
 [self.tableview reloadData];
 });
 }];
 
 [dataTask2 resume];
 
 }
 

-(void)paperParsing
{
    [_all_papers removeAllObjects];
    NSString *savedvalue2=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
    NSString *myst2=[NSString stringWithFormat:@"emailid=%@&session_id=%@",savedvalue2,_temp_session_id];//2
    
    
    NSLog(@"MY STATEMENT. course. %@",myst2);
    
    NSURLSessionConfiguration *defaultConfigObject2=[NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *defaultSession2=[NSURLSession sessionWithConfiguration:defaultConfigObject2 delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURL * url1 = [NSURL URLWithString:[mainUrl stringByAppendingString:user_course_get]];
    
    // NSURL * url1 = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/user_paper_get6.php"];
    
    
    
    NSMutableURLRequest *urlRequest1=[NSMutableURLRequest requestWithURL:url1];
    [urlRequest1 setHTTPMethod:@"POST"];
    [urlRequest1 setHTTPBody:[myst2 dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLSessionDataTask *dataTask2=[defaultSession2 dataTaskWithRequest:urlRequest1 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                     {
                                         NSLog(@"......DATA:-------%@",data);
                                         if (error) {
                                             
                                             NSLog(@"error=%@",error.description);
                                         }
                                         
                                         NSString *text=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                         NSLog(@"data is***************= %@",text);
                                         NSError *error1=nil;
                                         NSDictionary *responsedict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error1];
                                         if (error1) {
                                             NSLog(@"Error is %@",error1.description);
                                         }
                                         
                                         
                                         NSLog(@"json=%@",responsedict);
                                         
                                         NSArray *agenda=[responsedict objectForKey:@"paperdetails"];
                                         
                                         if (agenda.count==0) {
                                             _courseView.hidden=YES;
                                         }
                                         else{
                                             _courseView.hidden=NO;
                                         }
                                         for(NSDictionary *dict in agenda){
                                             Course_itherm *pi=[[Course_itherm alloc]init];
                                             pi.coursename=dict[@"course_name"];
                                             
                                             NSLog(@".....******%@",pi.coursename);
                                             
                                             pi.start_time=dict[@"start_time"];
                                             pi.end_time=dict[@"end_time"];
                                             pi.room_name=dict[@"room_name"];
                                             pi.course_id=dict[@"course_id"];
                                             
                                             pi.date=dict[@"date"];
                                             pi.courseabstract=dict[@"course_abstract"];
                                             pi.day=dict[@"day"];
                                             [self.all_papers addObject:pi];
                                             
                                             NSLog(@"PAPER IDDD=%@",pi.course_id);
                                         }
                                         
                                         //[_indicator stopAnimating];
                                         
                                         [self.tableview reloadData];
                                     }];
    [dataTask2 resume];
}

/*
 -(void)dataParsing1
 {
 [_all_papers removeAllObjects];
 
 NSString *savedvalue2=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
 
 NSString *myst=[NSString stringWithFormat:@"session_id=%@&emailid=%@",_temp_session_id,savedvalue2];
 NSLog(@"myst===%@",myst);
 
 NSURLSessionConfiguration *configuration=[NSURLSessionConfiguration defaultSessionConfiguration];
 
 NSURLSession *session=[NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
 
 NSURL * urlstr = [NSURL URLWithString:[mainUrl stringByAppendingString:get_course_schedule]];
 
 //NSURL * urlstr = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/get_course_schedule.php"];
 
 
 NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:urlstr];
 [request setHTTPMethod:@"POST"];
 [request setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
 //        NSError *error=nil;
 //        NSLog(@"POST CONTAINT get course....%@",myst);
 //        if(error)
 //        {
 //            NSLog(@"%@",error.description);
 //        }
 
 
 NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
 {
 NSLog(@"......DATA:-------%@",data);
 if (error) {
 
 NSLog(@"error=%@",error.description);
 }
 
 NSString *text=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
 NSLog(@"data is***************= %@",text);
 NSError *error1=nil;
 
 
 NSDictionary *outerdic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error1];
 if (error1) {
 NSLog(@"Error is %@",error1.description);
 }
 NSLog(@"json course sch=%@",outerdic);
 
 NSArray *keyarr=[outerdic objectForKey:@"course_info"];
 
 if (keyarr.count==0) {
 _courseView.hidden=YES;
 }
 else{
 _courseView.hidden=NO;
 }
 
 
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
 //}
 [_tableview reloadData];
 }
 // [_tableview performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
 }];
 [task resume];
 
 }
*/

/*
 -(void)showCourseLeader{
 
 
 self.courseid=[[NSMutableArray alloc]init];
 self.courseNamearr=[[NSMutableArray alloc]init];
 self.all_authors=[[NSMutableArray alloc]init];
 self.course_abstract=[[NSMutableArray alloc]init];
 
 
 NSURLSessionConfiguration *defaultConfigObject2 = [NSURLSessionConfiguration defaultSessionConfiguration];
 NSURLSession *defaultSession3 = [NSURLSession sessionWithConfiguration: defaultConfigObject2 delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
 
 NSURL * url3 = [NSURL URLWithString:[mainUrl stringByAppendingString:course_leader]];
 
 // NSURL * url3 = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/course_leader.php"];
 
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
 */



@end
