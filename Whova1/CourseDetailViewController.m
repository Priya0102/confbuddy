//
//  CourseDetailViewController.m
//  ITherm
//
//  Created by Anveshak on 6/1/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import "CourseDetailViewController.h"
#import "CourseDetailTableViewCell.h"
#import "CourseCommentTableViewCell.h"
#import "Course_Leader.h"
#import "AbsViewController.h"
#import "LeaderViewController.h"
#import "CourseComment.h"
#import "Course_itherm.h"
#import "Constant.h"
@interface CourseDetailViewController ()

@end

@implementation CourseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _popUpView.hidden=YES;
    self.popUpView.layer.cornerRadius = 5;
    self.popUpView.layer.shadowOpacity = 0.8;
    self.popUpView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
   
    [self.tableView1 setSeparatorColor:[UIColor clearColor]];
    [self getLikes];
    [self getComments];
    [self getCommentCount];
    [self authordataParsing];

    _tableview2.delegate=self;
    _tableview2.dataSource=self;
    
    _tableView1.delegate=self;
    _tableView1.dataSource=self;
    
    _tableView1.scrollEnabled=NO;
    _leaders_arr=[[NSMutableArray alloc]init];
    _university_arr=[[NSMutableArray alloc]init];
    _sessionname.text=_tempSessionName;
    _coursename.text=_tempCourseName;
    _sessionid.text=_tempsessionid;
    _que=[[NSOperationQueue alloc]init];
    
    NSLog(@"COURSE ID----->%@......SESSION ID--->%@ SESS NAME=%@",_tempcoursid,_tempsessionid,_tempSessionName);
    
    _imgarr=[[NSMutableArray alloc]init];
    _commentarr=[[NSMutableArray alloc]init];
    _usernamearr=[[NSMutableArray alloc]init];
    _datearr=[[NSMutableArray alloc]init];
    
    _comments.delegate =self;
    _seemoreOutlet.hidden=YES;

    self.coursename.text=self.tempCourseName;
    self.course_id.text=self.tempcoursid;
    self.locationlbl.text=self.locationstr;
    self.starttime.text=self.starttimestr;
    self.endtime.text=self.endtimestr;
    self.courseno.text=self.coursenoStr;
    
  //  self.courselbl.textColor=(__bridge UIColor * _Nullable)([UIColor colorWithRed:20.0/255.0 green:102.0/255.0 blue:152.0/255.0 alpha:1.0].CGColor);
    
    
    self.courselbl.text = [NSString stringWithFormat: @"%@ %@", self.coursenoStr, self.tempCourseName];
    
    NSLog(@"Session course no ==%@",self.courseno.text);
    
    [[NSUserDefaults standardUserDefaults]setValue:self.tempcoursid forKey:@"course_id"];
    NSLog(@"course_id = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"course_id"]);
    
    self.session=[[NSMutableArray alloc]init];
    _sessionname.text=_tempSessionName;
    self.course_abstract.text=_tempcourseabs;
    NSLog(@"ABS=== %@",_course_abstract);
    self.commentarray=[[NSMutableArray alloc]init];
    _authorinfoarr=[[NSMutableArray alloc]init];
    
    self.postBtn.layer.masksToBounds=YES;
    self.postBtn.layer.borderColor=[UIColor colorWithRed:20.0/255.0 green:72.0/255.0 blue:114.0/255.0 alpha:1.0].CGColor;
    self.postBtn.layer.borderWidth=1.1;
    self.postBtn.layer.cornerRadius=5;
    
    _comments.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    _comments.layer.borderWidth=1.0;
    
    self.viewMap.layer.masksToBounds=YES;
    self.viewMap.layer.borderColor=[UIColor colorWithRed:20.0/255.0 green:72.0/255.0 blue:114.0/255.0 alpha:1.0].CGColor;
    self.viewMap.layer.borderWidth=1.1;
    self.viewMap.layer.cornerRadius=10;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return  YES;
}
-(void)viewWillAppear:(BOOL)animated{
    
    [self.tableview2 reloadData];
    [self getCourseDetailStatus];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView==self.tableView1) {
        return 1;
    }
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.tableView1) {
        return _authorinfoarr.count;
    }
    return _commentarray.count; //for second tableview2
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (tableView==self.tableView1) {
        
        CourseDetailTableViewCell *cell=[self.tableView1 dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
        Course_Leader *a=self.authorinfoarr[indexPath.row];
        
        cell.leader.text=a.leader;
        cell.university.text=a.university;
        
        
        NSLog(@"****leader===%@,university==%@",cell.leader.text,cell.university.text);
        
    }
    else if(tableView==self.tableview2){
        CourseCommentTableViewCell *cell = [self.tableview2 dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
        CourseComment *ktemp=[_commentarray objectAtIndex:indexPath.row];
        
        cell.name.text=ktemp.name;
        cell.comments.text=ktemp.comments;
        cell.date1.text=ktemp.date1;
        
        //              NSString *kImgLink=[_imgarr objectAtIndex:indexPath.row];
        //
        //
        //
        //         dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //         // retrive image on global queue
        //         UIImage * img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:kImgLink]]];
        //
        //         dispatch_async(dispatch_get_main_queue(), ^{
        //
        //
        //         // assign cell image on main thread
        //         cell.images.image = img;
        //
        //         //                if(img==(UIImage *) [NSNull null])
        //         //                {
        //         //                   // cell.images.image=;
        //         //                }
        //         });
        //         });
        //
        
        NSLog(@"commentss ==== %@",cell.comments);
        NSLog(@"comment date ==== %@",cell.date1);
    }
    return cell;
}


- (IBAction)addComments:(id)sender {
    
    NSString *emailid=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
    if (emailid==NULL) {
        UIAlertController * alert=[UIAlertController
                                   
                                   alertControllerWithTitle:@"Alert!" message:@"Please login to add comments"preferredStyle:UIAlertControllerStyleAlert];
        
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
    
    _tempcomment = _comments.text;
    
    if(_tempcomment.length!=0)
    {
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
}
-(void)addComment{
    
    NSString *savedValue3=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
    
    NSString *myst3=[NSString stringWithFormat:@"emailid=%@&course_id=%@&comment=%@",savedValue3,_tempcoursid,_tempcomment];
    NSLog(@"my add comments string=%@",myst3);
    
    NSURLSessionConfiguration *config3=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session3=[NSURLSession sessionWithConfiguration:config3 delegate:self delegateQueue:nil];
    
    NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:add_course_comment]];
    
    //NSURL *url=[NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/add_course_comment.php"];
 
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
    
    [_commentarray removeAllObjects];
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSString *myst2=[NSString stringWithFormat:@"course_id=%@",_tempcoursid];
    
    NSLog(@"GET  course ID.....:%@",myst2);
    
    NSURL * url2 = [NSURL URLWithString:[mainUrl stringByAppendingString:get_course_comments]];
    
    //NSURL *url2=[NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/get_course_comments.php"];
    

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
                                             CourseComment *f=[[CourseComment alloc]init];
                                             f.name=temp[@"user"];
                                             f.date1=temp[@"date"];
                                             NSString *str=@" \"";
                                             f.comments=[str stringByAppendingFormat:@"%@%@",temp[@"comment"],str];
                                             
                                             [_commentarray addObject:f];
                                
                                         }
                             
                                     }
                                     dispatch_async(dispatch_get_main_queue(), ^{
                                         [_tableview2 reloadData];
                                         [self scrollViewHeight];
                                     });
                                     
                                 }];
    
    [task4 resume];
    
}
-(void)scrollViewHeight{
    [self.tableview2 layoutIfNeeded];
    CGFloat tbleViewHeight = self.tableview2.contentSize.height;
    self.consContainerHeight.constant =tbleViewHeight;
   // NSLog(@"****scroll view height after adding cell in talk info tab: %@", self.consContainerHeight);
}
-(NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section   {
     if (tableView==self.tableview2){
    NSString *message = @"";
    
    NSInteger numberOfRowsInSection = [self tableView:self.tableview2 numberOfRowsInSection:section ];
    
    if (numberOfRowsInSection == 0) {
        message = @"No Comments yet...";
    }
    return message;
  }
    return 0;
}
- (IBAction)likeBtnClicked:(id)sender {
    NSString *emailid=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
    if (emailid==NULL) {
        UIAlertController * alert=[UIAlertController
                                   
                                   alertControllerWithTitle:@"Alert!" message:@"Please login to like course."preferredStyle:UIAlertControllerStyleAlert];
        
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
    [self likeSession];
}
    }
-(void)likeSession
{
    NSString *savedValue=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
    
    NSString *myst=[NSString stringWithFormat:@"emailid=%@&course_id=%@",savedValue,_tempcoursid];
    
    NSLog(@"my string=%@",myst);
    
    
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    
    //NSURL *url=[NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/add_course_likes.php"];
    
    NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:add_course_likes]];
  
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
    
    NSString *myst2=[NSString stringWithFormat:@"course_id=%@",_tempcoursid];
    
    NSLog(@"course ID.....:%@",myst2);
    
    NSURL * url2 = [NSURL URLWithString:[mainUrl stringByAppendingString:get_course_likes]];
    
   // NSURL *url2=[NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/get_course_likes.php"];
    
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
    
    NSString *myst2=[NSString stringWithFormat:@"course_id=%@",_tempcoursid];
    
    NSLog(@"Course ID Comment count.....:%@",myst2);
    
    
    NSURL * url2 = [NSURL URLWithString:[mainUrl stringByAppendingString:get_course_comment_count]];
    
    //NSURL *url2=[NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/get_course_comment_count.php"];
 
    
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

-(void)authordataParsing
{
    
    [_authorinfoarr removeAllObjects];

    
    NSString *myst=[NSString stringWithFormat:@"course_id=%@",_tempcoursid];
    NSLog(@"***course author loop==%@",myst);
    
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *sess=[NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURL * urlstr = [NSURL URLWithString:[mainUrl stringByAppendingString:get_leader_info]];
    
    //NSString *urlstr=@"http://192.168.1.100/phpmyadmin/itherm/get_leader_info.php";
    
    NSMutableURLRequest *req=[NSMutableURLRequest requestWithURL:urlstr];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask *task=[sess dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data==nil) {
            NSLog(@"dATA IS NIL");
        }
        else{
            NSLog(@"response other facility==%@",response);
            
            NSDictionary *outerdic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSArray *arr=[outerdic objectForKey:@"authorinfo"];
            NSString *count=[NSString stringWithFormat:@"%lu",(unsigned long)arr.count];
            b = [count integerValue];
            NSLog(@"%ld",(long)b);
            for(NSDictionary *temp in arr){
                Course_Leader *f=[[Course_Leader alloc]init];
                f.course_id=temp[@"course_id"];
                f.leader=temp[@"leader"];
                f.university=temp[@"university"];
                
                [_authorinfoarr addObject:f];
                [_tableView1 reloadData];
                
                
            }
            [_tableView1 reloadData];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (b<=2)
            {
                
                _seemoreOutlet.hidden=YES;
                
            }else
            {
                _seemoreOutlet.hidden=NO;

                
            }
            
            [_tableView1 reloadData];
        });
        
    }];
    
    [task resume];
    [_tableView1 reloadData];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if([[segue identifier] isEqualToString:@"tocourseabstract"]){
        
        AbsViewController *ab=[segue destinationViewController];
        ab.absStr=_course_abstract.text;
        
        NSLog(@"ABSS IN SEGUE.....*********%@",ab.absStr);
    }
    
    
    if([[segue identifier] isEqualToString:@"toleader"]){
        
        LeaderViewController *ab=[segue destinationViewController];
        ab.courseidstr=_course_id.text;
        
        NSLog(@"Course id IN SEGUE.....*********%@",ab.courseidstr);
    }
}

- (IBAction)addMyScheduleBtn:(id)sender {
    
//    UIAlertController * alert=[UIAlertController
//                               
//                               alertControllerWithTitle:@"ALERT" message:@"Do You Want To Add Record?"preferredStyle:UIAlertControllerStyleAlert];
//    
//    UIAlertAction* yesButton = [UIAlertAction
//                                actionWithTitle:@"Yes, please"
//                                style:UIAlertActionStyleDefault
//                                handler:^(UIAlertAction * action)
//                                {
//                                    [self addSession];
//                                    NSLog(@"you pressed Yes, please button");
//                                    [_addMyScheduleBtn setImage:[UIImage imageNamed:@"added-other.png"] forState:UIControlStateNormal];
//                                    
//                                }];
//    UIAlertAction* noButton = [UIAlertAction
//                               actionWithTitle:@"No, thanks"
//                               style:UIAlertActionStyleDefault
//                               handler:^(UIAlertAction * action)
//                               {
//                                   NSLog(@"you pressed No, thanks button");
//                                   
//                               }];
//    
//    [alert addAction:yesButton];
//    [alert addAction:noButton];
//    
//    [self presentViewController:alert animated:YES completion:nil];
    
}

- (IBAction)addMyScheduleLargeBtn:(id)sender {
    
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
    
    UIAlertController * alert=[UIAlertController
                               
                               alertControllerWithTitle:@"ALERT" message:@"Do You Want To Add Record?"preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes, please"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    [self addSession];
                                  
                                    NSLog(@"you pressed Yes, xplease button");
                                    //[self.navigationController popViewControllerAnimated:YES];
                                     [_addMyScheduleBtn setImage:[UIImage imageNamed:@"added-other.png"] forState:UIControlStateNormal];
                                 
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
-(void)addSession{
    
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    
    
    
    NSString *savedValue=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
    
    NSString *myst=[NSString stringWithFormat:@"emailid=%@&course_id=%@&session_id=%@",savedValue,_tempcoursid,_tempsessionid];
    NSLog(@"my string course details==%@",myst);
    
;
    
    NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:course_reminder_add]];
    
   // NSURL * url = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/course_reminder_add.php"];//local
    
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


-(void)getCourseDetailStatus{
    
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    
    NSString *savedValue=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
    
    NSString *myst=[NSString stringWithFormat:@"emailid=%@&course_id=%@&session_id=%@",savedValue,_tempcoursid,_tempsessionid];
    
    NSLog(@"Get course details status SAtatement...***%@",myst);
    
    NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:get_course_details_status]];
    
    //NSURL * url = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/get_course_details_status.php"];//local
    
    
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
                                    
                                    self.success=[responsedict objectForKey:@"success"];
                                    self.liked=[responsedict objectForKey:@"liked"];
                                    self.added=[responsedict objectForKey:@"added"];
                                    
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        
                                        if([self.success isEqualToString:@"1"] && [self.added isEqualToString:@"1"])
                                        {
                                                  NSLog(@"Show blue clicked tick.......");
                                                                     [_addMyScheduleBtn setImage:[UIImage imageNamed:@"added-other.png"] forState:UIControlStateNormal];
                                                                     [_addMyScheduleBtn setUserInteractionEnabled:NO];
                                            [_addMyScheduleLargeBtn setUserInteractionEnabled:NO];
                                            
                                             self.addSchLbl.text = @"Added to My Schedule";

                                        }
                                        else
                                        {
                                            [_addMyScheduleBtn setImage:[UIImage imageNamed:@"add-other.png"] forState:UIControlStateNormal];
                                            [_addMyScheduleBtn setUserInteractionEnabled:YES];
                                            [_addMyScheduleLargeBtn setUserInteractionEnabled:YES];
                                             self.addSchLbl.text = @"Add to My Schedule";

                                        }
                                    });

                                    NSLog(@"json course add to myschedule = %@",responsedict);
                     
                                }];
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
    //    [UIView animateWithDuration:.25 animations:^{
    //        self.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
    //        self.view.alpha = 0.0;
    //    } completion:^(BOOL finished) {
    //        if (finished) {
    //           // [self.view removeFromSuperview];
    //        }
    //    }];
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
    self.tableView1.allowsSelectionDuringEditing =NO;
    self.tableView1.allowsSelection = NO;
    
    self.tableview2.allowsSelectionDuringEditing =NO;
    self.tableview2.allowsSelection = NO;
}



/*
 -(void)viewWillAppear:(BOOL)animated
 {
 [self courseparsing];
 
 }
 -(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
 {
 return 1;
 }
 
 -(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
 {
 return _leaders_arr.count;
 }
 
 -(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 {
 CourseDetailTableViewCell  *cell=[_tableview dequeueReusableCellWithIdentifier:@"cell"];
 cell.leader.text=[_leaders_arr objectAtIndex:indexPath.row];
 cell.university.text=[_university_arr objectAtIndex:indexPath.row];
 return cell;
 }
 -(void)courseparsing
 {
 
 
 NSBlockOperation *op1=[NSBlockOperation blockOperationWithBlock:^{
 
 NSString *savedvalue2=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
 NSString *myst=[NSString stringWithFormat:@"emailid=%@&session_id=%@",savedvalue2,_tempsessionid];
 NSLog(@"session_id.......%@",myst);
 
 
 NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
 
 NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
 
 //NSURL * url = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/iOSAPI/prov_dev_course.php"];//local
 NSURL * url = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/prov_dev_course.php"];
 //NSURL *url2=[NSURL URLWithString:@"http://siddhantedu.com/iOSAPI/speakers_last_3.php"];//server
 
 
 NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
 [urlRequest setHTTPMethod:@"POST"];
 [urlRequest setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
 
 
 NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
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
 NSLog(@"json=%@",responseDict);
 NSArray *arr=[responseDict objectForKey:@"courses"];
 
 
 for(NSDictionary *dict in arr)
 {
 
 NSString *str3=[dict objectForKey:@"course_id"];
 NSArray *lead=dict[@"leaders"];
 
 for(NSDictionary *dict1 in lead)
 {
 
 NSString *str5=[dict1 objectForKey:@"leader"];
 NSString *str6=[dict1 objectForKey:@"university"];
 if([str3 isEqualToString:_tempcoursid])
 {
 [_leaders_arr addObject:str5];
 [_university_arr addObject:str6];
 }
 
 [_tableview reloadData];
 }
 }
 [_tableview reloadData];
 
 }
 [_tableview performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
 }];
 
 [dataTask resume];
 }];
 
 [_que addOperation:op1];
 
 }
 
 */
//-(void)usercourseget{
//
//    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
//    NSURLSession *session=[NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
//
//
//
//    NSString *savedValue=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];//used to retrieve user's emailid which we have stored in nsuserdefaults for key email(those user login dat person mail id will get using userdefaults)
//
//    NSString *myst=[NSString stringWithFormat:@"emailid=%@&course_id=%@&session_id=%@",savedValue,_tempcoursid,_tempsessionid];
//
//    NSLog(@".. My SAtatement...***%@",myst);
//
//    NSURL * url = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/user_course.php"];//local
//
//    // NSURL * url = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/iOSAPI/user_paper6.php"];//local
//
//    //                                       NSURL *url=[NSURL URLWithString:@"http://siddhantedu.com/iOSAPI/user_paper6.php"];//server
//
//    NSMutableURLRequest *urlrequest=[NSMutableURLRequest requestWithURL:url];
//    [urlrequest setHTTPMethod:@"POST"];
//    [urlrequest setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
//    NSError *error=nil;
//    if(error)
//    {
//        NSLog(@"%@",error.description);
//    }
//    NSURLSessionDataTask *task=[session dataTaskWithRequest:urlrequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
//                                {
//                                    if (error) {
//                                        NSLog(@"%@",error.description);
//                                    }
//                                    NSString *text=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//                                    NSLog(@"data=%@",text);
//                                    NSError *error1=nil;
//                                    NSDictionary *responsedict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error1];
//                                    if(error1)
//                                    {
//                                        NSLog(@"error 1 is %@",error1.description);
//                                    }
//                                    NSLog(@"json = %@",responsedict);
//
//                                }];
//    [task resume];
//
//}
//-(void)showcoursenew{
//    NSString *savedvalue=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
//    NSString *myst=[NSString stringWithFormat:@"emailid=%@&session_id=%@",savedvalue,_tempsessionid];
//    NSLog(@"course details session_id.......%@",myst);
//
//    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
//    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
//
//
//    // NSURL *url=[NSURL URLWithString:@"http://siddhantedu.com/iOSAPI/agenda_new.php"];//server
//    //NSURL * url = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/iOSAPI/agenda_new.php"];//local
//    NSURL * url = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/course_new.php"];
//
//    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
//    [urlRequest setHTTPMethod:@"POST"];
//    [urlRequest setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
//
//
//    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        if(error == nil)
//        {
//
//            NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
//            NSLog(@"data=%@",text);
//            NSError *err=nil;
//            NSDictionary *responsedict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
//            if (err) {
//                NSLog(@"error is %@ ",err.description);
//            }
//            NSLog(@"dictionary is %@ ",responsedict);
//
//            NSArray *paper=responsedict[@"full_papers"];
//            // NSLog(@"full papers=%@",paper);
//            for (NSDictionary *dict1 in paper) {
//                Course_itherm *pi=[[Course_itherm alloc]init];
//                pi.course_id=dict1[@"course_id"];
//                pi.coursename=dict1[@"course_name"];
//
//                if([dict1[@"course_abstract"]isEqual:[NSNull null]])
//                {
//                    pi.courseabstract=@"--";
//                    NSLog(@"Course abstract===%@",pi.courseabstract);
//                }
//                else
//                {
//                    pi.courseabstract=dict1[@"course_abstract"];
//                    NSLog(@"course_abstract Name in loop....!%@",pi.courseabstract);
//                }
//                pi.start_time=dict1[@"start_time"];
//                pi.session_id=dict1[@"session_id"];
//                pi.added=dict1[@"added"];
//                pi.course_no=dict1[@"course_no"];
//
//                NSLog(@"********start time:****%@ & *****courseabstract=%@ ***course no=%@ *****added==%@",pi.start_time,pi.courseabstract,pi.course_no,pi.added);
//
//                NSString *str=[NSString stringWithFormat:@"%@",pi.added];
//
//                NSLog(@".....String LEngth  %lu \t String : %@",(unsigned long)str.length,str);
//
//                if([str isEqualToString:@"<null>"]){
//                //if ([str isEqualToString:@"false"]) {
//                    NSLog(@"******Tempdata is .....");
//                    [_addMyScheduleBtn setImage:[UIImage imageNamed:@"add-other.png"] forState:UIControlStateNormal];
//                    [_addMyScheduleBtn setUserInteractionEnabled:YES];
//                }
//                else{
//                    NSLog(@"*********Show blue tick.......");
//                    [_addMyScheduleBtn setImage:[UIImage imageNamed:@"added-other.png"] forState:UIControlStateNormal];
//                    [_addMyScheduleBtn setUserInteractionEnabled:NO];
//                }
//
//
//
//                NSArray *authors=dict1[@"author"];
//                for (NSDictionary *dict in authors) {
//
//                    Course_Leader *aut=[[Course_Leader alloc]init];
//                    aut.course_id=dict1[@"course_id"];
//                    aut.leader=dict[@"leader"];
//                    aut.university=dict[@"university"];
//
//                    [self.authorinfoarr addObject:aut];
//                }
//            }
//            dispatch_async(dispatch_get_main_queue() , ^{
//
//                [self.tableView1 reloadData];
//            });
//        }
//    }];
//
//    [dataTask resume];
//}

@end
