//
//  CourseSchInfoViewController.m
//  ITherm
//
//  Created by Anveshak on 12/21/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import "CourseSchInfoViewController.h"
#import "Course_itherm.h"
#import "Course_Leader.h"
#import "AbsViewController.h"
#import "CourseSchCom.h"
#import "CourseSchComTableViewCell.h"
#import "CourseSchInfoTableViewCell.h"
#import "LeaderViewController.h"
#import "Constant.h"
@interface CourseSchInfoViewController ()

@end

@implementation CourseSchInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self getLikes];
    [self getComments];
    [self getCommentCount];
    
    
    [self.tableView1 setSeparatorColor:[UIColor clearColor]];
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
    
    _seemoreOutlet.hidden=YES;
    
    _comments.delegate =self;
    
    self.coursename.text=self.tempCourseName;
    self.course_id.text=self.tempcoursid;
    self.locationlbl.text=self.locationstr;
    self.starttime.text=self.starttimestr;
    self.endtime.text=self.endtimestr;
    self.courseno.text=self.coursenoStr;
    
    NSLog(@"Session course no ==%@",self.courseno.text);
    
    [[NSUserDefaults standardUserDefaults]setValue:self.tempcoursid forKey:@"course_id"];
    NSLog(@"course_id = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"course_id"]);
    
    self.session=[[NSMutableArray alloc]init];
    _sessionname.text=_tempSessionName;
    self.course_abstract.text=_tempcourseabs;
    NSLog(@"ABS=== %@",_course_abstract);
    self.commentarray=[[NSMutableArray alloc]init];
    _authorinfoarr=[[NSMutableArray alloc]init];
    
      [self authordataParsing];
    
    
    _comments.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    _comments.layer.borderWidth=1.0;
    
    self.postBtn.layer.masksToBounds=YES;
    self.postBtn.layer.borderColor=[UIColor colorWithRed:20.0/255.0 green:72.0/255.0 blue:114.0/255.0 alpha:1.0].CGColor;
    self.postBtn.layer.borderWidth=1.1;
    self.postBtn.layer.cornerRadius=5;
    
    _popUpView.hidden=YES;
    self.popUpView.layer.cornerRadius = 5;
    self.popUpView.layer.shadowOpacity = 0.8;
    self.popUpView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    
    [self.tableview2 setSeparatorColor:[UIColor clearColor]];
    
    _comments.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    _comments.layer.borderWidth=1.0;
    
    
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return  YES;
}
-(void)viewWillAppear:(BOOL)animated{
   

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
        
        CourseSchInfoTableViewCell *cell=[self.tableView1 dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
        Course_Leader *a=self.authorinfoarr[indexPath.row];
        
        cell.leader.text=a.leader;
        cell.university.text=a.university;
        
        
        NSLog(@"****leader===%@,university==%@",cell.leader.text,cell.university.text);
        
    }
    else if(tableView==self.tableview2){
        CourseSchComTableViewCell *cell = [self.tableview2 dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
        CourseSchCom *ktemp=[_commentarray objectAtIndex:indexPath.row];
        
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
-(void)addComment{
    
    NSString *savedValue3=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
    
    NSString *myst3=[NSString stringWithFormat:@"emailid=%@&course_id=%@&comment=%@",savedValue3,_tempcoursid,_tempcomment];
    NSLog(@"my add comments string=%@",myst3);
    // NSString *myst=[NSString stringWithFormat:@"emailid=rohini@anveshak.com & session_id=s2"];
    
    
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
                                             
                                             // [_send setUserInteractionEnabled:NO];
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
    
   // NSURL *url2=[NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/get_course_comments.php"];

    
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
                                             CourseSchCom *f=[[CourseSchCom alloc]init];
                                             f.name=temp[@"user"];
                                             //f.comments=temp[@"comment"];
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
       [self likeSession];

    //  [_likeBtnClicked setImage:[UIImage imageNamed:@"liked.png"] forState:UIControlStateNormal];
}
-(void)likeSession
{
    NSString *savedValue=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
    
    NSString *myst=[NSString stringWithFormat:@"emailid=%@&course_id=%@",savedValue,_tempcoursid];
    
    NSLog(@"my string=%@",myst);
    
    
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    
    NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:add_course_likes]];
    
    //NSURL *url=[NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/add_course_likes.php"];
    
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
                                    // self.message=[responsedict objectForKey:@"message"];
                                    
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
    
    //NSURL *url2=[NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/get_course_likes.php"];
    

    
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
    
   // NSURL *url2=[NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/get_course_comment_count.php"];
  
    
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
    
    if([[segue identifier] isEqualToString:@"tocourseabs"]){
        AbsViewController *ab=[segue destinationViewController];
        ab.absStr=_course_abstract.text;
        
        NSLog(@"Abs IN SEGUE.....*********%@",ab.absStr);
    }
    
    
    if([[segue identifier] isEqualToString:@"toleadersch"]){
        LeaderViewController *ab=[segue destinationViewController];
        ab.courseidstr=_course_id.text;
        
        NSLog(@"Course id IN SEGUE.....*********%@",ab.courseidstr);
    }
}

- (IBAction)deleteBtn:(id)sender {
    
    UIAlertController *alert=[UIAlertController
                               
                               alertControllerWithTitle:@"ALERT" message:@"Do You Want To Delete Record?"preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes,please"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                  
                                    [self deleteSession];
                                    NSLog(@"You pressed Yes,please button");
                                    [self.navigationController popViewControllerAnimated:YES];
                                
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


-(void)deleteSession
{
    NSString *savedValue=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
    
    NSString *myst=[NSString stringWithFormat:@"emailid=%@&course_id=%@&session_id=%@",savedValue,_tempcoursid,_tempsessionid];
    NSLog(@"my string after delete=%@",myst);
   
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    
    NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:coursedel]];
    
    //NSURL * url = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/coursedel.php"];
   
    
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
    self.tableview2.allowsSelectionDuringEditing =NO;
    self.tableview2.allowsSelection = NO;
    
    
}



@end
