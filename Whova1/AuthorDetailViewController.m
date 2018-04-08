

#import "AuthorDetailViewController.h"
#import "AbsViewController.h"
#import "DTCustomColoredAccessory.h"
#import <QuartzCore/QuartzCore.h>
#import "Comment.h"
#import "CommentTableViewCell.h"
#import "AuthordetailTableViewCell.h"
#import "AuthorInfo.h"
#import "AuthorInfoViewController.h"
#import "Constant.h"
#import "AuthorViewController.h"
@interface AuthorDetailViewController ()

@end

@implementation AuthorDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

//    NSUInteger length=0;
//    if (_sessionname.text==nil) {
//        length=0;
//    }
//    else{
//        length=[_sessionname.text length];
   // }
    //_popUpView.hidden=YES;
    
    
   
    
    _popUpView.hidden=YES;
    self.popUpView.layer.cornerRadius = 5;
    self.popUpView.layer.shadowOpacity = 0.8;
    self.popUpView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    
    [self.tableView1 setSeparatorColor:[UIColor clearColor]];
    
    _tableview2.delegate=self;
    _tableview2.dataSource=self;
    
    _tableView1.delegate=self;
    _tableView1.dataSource=self;
    
    _tableView1.scrollEnabled=NO;
    
    _imgarr=[[NSMutableArray alloc]init];
    _commentarr=[[NSMutableArray alloc]init];
    _usernamearr=[[NSMutableArray alloc]init];
    _datearr=[[NSMutableArray alloc]init];
    
    _authornamearr=[[NSMutableArray alloc]init];
    _affilitionarr=[[NSMutableArray alloc]init];
    _authorinfoarr=[[NSMutableArray alloc]init];
    _paperidarr=[[NSMutableArray alloc]init];
    _authoridarr=[[NSMutableArray alloc]init];
    _salutionarr=[[NSMutableArray alloc]init];
    _firstnamearr=[[NSMutableArray alloc]init];
    _lastnamearr=[[NSMutableArray alloc]init];
    
    _comments.delegate =self;
    _seemoreOutlet.hidden=YES;
    
    self.viewMapBtn.layer.masksToBounds=YES;
    self.viewMapBtn.layer.borderColor=[UIColor colorWithRed:20.0/255.0 green:72.0/255.0 blue:114.0/255.0 alpha:1.0].CGColor;
    self.viewMapBtn.layer.borderWidth=1.1;
    self.viewMapBtn.layer.cornerRadius=10;
    
    self.postBtn.layer.masksToBounds=YES;
    self.postBtn.layer.borderColor=[UIColor colorWithRed:20.0/255.0 green:72.0/255.0 blue:114.0/255.0 alpha:1.0].CGColor;
    self.postBtn.layer.borderWidth=1.1;
    self.postBtn.layer.cornerRadius=5;
    
    
    _comments.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    _comments.layer.borderWidth=1.0;
    
    self.papername.text=self.paper;
    self.paper_id.text=self.paperidstr;
    self.location.text=self.locationstr;
    self.starttime.text=self.starttimestr;
    self.endtime.text=self.endtimestr;
    
    NSLog(@"Session PAPER ID ==%@",_paperidstr);
    
    [[NSUserDefaults standardUserDefaults]setValue:self.paperidstr forKey:@"paper_id"];
    NSLog(@"paper_id = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"paper_id"]);
    
    self.session=[[NSMutableArray alloc]init];
    _sessionname.text=_tempSessionName;
    _sessionid.text=_sessionidStr;
    self.paper_abstract.text=_abstractstr;
    
    
    NSLog(@"Session ID ==%@",_sessionidStr);

     self.commentarray=[[NSMutableArray alloc]init];
     _authorinfoarr=[[NSMutableArray alloc]init];
    
    [self getLikes];
    [self getComments];
    [self getCommentCount];
    [self authordataParsing];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.tableview2 reloadData];
    [self getPaperDetailStatus];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return  YES;
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
        _comments.text=@"";
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
    NSString *savedpaperid=[[NSUserDefaults standardUserDefaults]stringForKey:@"paper_id"];
    
    NSString *myst3=[NSString stringWithFormat:@"emailid=%@&paper_id=%@&comment=%@",savedValue3,savedpaperid,_tempcomment];
    NSLog(@"my add comments string=%@",myst3);
    
    
    NSURLSessionConfiguration *config3=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session3=[NSURLSession sessionWithConfiguration:config3 delegate:self delegateQueue:nil];
    
       NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:add_comment]];
    
   // NSURL *url=[NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/add_comment.php"];
  
    
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
                                           //  [self getComments];
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
    
    
    
    NSString *myst2=[NSString stringWithFormat:@"paper_id=%@",_paperidstr];
    
    NSLog(@"GET  Paper ID.....:%@",myst2);
    
     NSURL * url2 = [NSURL URLWithString:[mainUrl stringByAppendingString:get_comments]];
    
//    NSURL *url2=[NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/get_comments.php"];
   
    
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
                                             Comment *f=[[Comment alloc]init];
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
    [self.consContainerHeight setConstant:tbleViewHeight];
    
    ////NSLog(@"****scroll view height after adding cell in talk info tab: %@", \\self.consContainerHeight);
}
-(NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section   {
    if (tableView==self.tableview2){
    NSString *message = @"";
    
    NSInteger numberOfRowsInSection = [self tableView:self.tableview2 numberOfRowsInSection:section];
    
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
                                   
                                   alertControllerWithTitle:@"Alert!" message:@"Please login to like the session"preferredStyle:UIAlertControllerStyleAlert];
        
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
    //  [_likeBtnClicked setImage:[UIImage imageNamed:@"liked.png"] forState:UIControlStateNormal];
}
-(void)likeSession
{
    NSString *savedValue=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
     NSString *savedpaperid=[[NSUserDefaults standardUserDefaults]stringForKey:@"paper_id"];
    
    NSString *myst=[NSString stringWithFormat:@"emailid=%@&paper_id=%@",savedValue,savedpaperid];
    
    NSLog(@"my string=%@",myst);

    
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    
     NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:add_likes]];
    
    //NSURL *url=[NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/add_likes.php"];
 
    
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
    
    NSString *myst2=[NSString stringWithFormat:@"paper_id=%@",_paperidstr];
    
    NSLog(@"paper ID.....:%@",myst2);
    
     NSURL * url2 = [NSURL URLWithString:[mainUrl stringByAppendingString:get_likes]];
    
   // NSURL *url2=[NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/get_likes.php"];
    
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
    
    NSString *myst2=[NSString stringWithFormat:@"paper_id=%@",_paperidstr];
    
    NSLog(@"Paper ID Comment count.....:%@",myst2);
    
    NSURL * url2 = [NSURL URLWithString:[mainUrl stringByAppendingString:get_comment_count]];
    
   // NSURL *url2=[NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/get_comment_count.php"];
  
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
        
         AuthordetailTableViewCell *cell=[self.tableView1 dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
        AuthorInfo *a=self.authorinfoarr[indexPath.row];
        
                cell.affiliation.text=a.affiliationStr;
                cell.authorid.text=a.authoridStr;
             cell.authorname.text=a.authornameStr;

        NSLog(@"****Affiliation===%@,Author name==%@",cell.affiliation.text,cell.authorname.text);

    }
    else if(tableView==self.tableview2){
        CommentTableViewCell *cell = [self.tableview2 dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
        Comment *ktemp=[_commentarray objectAtIndex:indexPath.row];
        
        cell.name.text=ktemp.name;
        cell.comments.text=ktemp.comments;
        cell.date1.text=ktemp.date1;
        
  /*      NSString *kImgLink=[_imgarr objectAtIndex:indexPath.row];
        
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // retrive image on global queue
            UIImage * img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:kImgLink]]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                // assign cell image on main thread
                cell.images.image = img;
                
//                if(img==(UIImage *) [NSNull null])
//                {
//                   // cell.images.image=;
//                }
            });
        });
        
      */  
        NSLog(@"commentss ==== %@",cell.comments);
        NSLog(@"comment date ==== %@",cell.date1);
        
                
        
    }
    return cell;
}
-(void)authordataParsing
{
   
    [_authorinfoarr removeAllObjects];
    
        NSString *myst=[NSString stringWithFormat:@"paper_id=%@",_paperidstr];
        NSLog(@"***paper_id author loop==%@",myst);
        
        NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *sess=[NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURL * urlstr = [NSURL URLWithString:[mainUrl stringByAppendingString:get_author_info]];
    
    
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
                NSLog(@"authorinfo Array=%@",arr);
                NSString *count=[NSString stringWithFormat:@"%lu",(unsigned long)arr.count];
                b = [count integerValue];
                NSLog(@"%ld",(long)b);

                
                for(NSDictionary *temp in arr){
                    AuthorInfo *f=[[AuthorInfo alloc]init];
                    f.authoridStr=temp[@"author_id"];
                    f.authornameStr=temp[@"author_name"];
                    f.affiliationStr=temp[@"affiliation"];
                    
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




//-(void)addLabel{
//
//    self.btnRead.layer.masksToBounds=YES;
//    self.btnRead.layer.borderColor=[UIColor blueColor].CGColor;
//    self.btnRead.layer.borderWidth=1.1;
//    self.btnRead.layer.cornerRadius=10;
//}
/*
- (BOOL)tableView:(UITableView *)tableView canCollapseSection:(NSInteger)section
{
    
    if(section==0)
    {
        return YES;
    }
    else
        return NO;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView==self.tableView2) {
        return 1;
    }
    return 2;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.tableView2) {
         return _allnotifications.count;
    }
    else if([self tableView:tableView canCollapseSection:section])
    {
        if ([expandedSections containsIndex:section])
        {
            return _authors.count; // return rows when expanded
        }
        
        return 1; // only top row showing
    }
    
    // Return the number of rows in the section.
    return 1;
   
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    if (tableView==self.tableView2) {
        CommentTableViewCell *cell = [self.tableView2 dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
        Comment *ktemp=[_allnotifications objectAtIndex:indexPath.row];
        //Comment *ktemp=self.allnotifications[indexPath.row];
        cell.name.text=ktemp.name;
        cell.comments.text=ktemp.comments;
        cell.date1.text=ktemp.date1;
        NSString *kImgLink=[_imgarr objectAtIndex:indexPath.row];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // retrive image on global queue
            UIImage * img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:kImgLink]]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                // assign cell image on main thread
                cell.images.image = img;
            });
        });
        
        
        NSLog(@"commentss ==== %@",cell.comments);
        NSLog(@"comment date ==== %@",cell.date1);
        

        
    }
    else{
    AuthordetailTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
     Paper_author *aut=self.authors[indexPath.row];
    if ([self tableView:tableView canCollapseSection:indexPath.section])
    {
        if (!indexPath.row)
        {
            
            if(aut.first_name==(NSString *) [NSNull null])
            {
                aut.first_name=@"-";
            }
            if(aut.last_name==(NSString *) [NSNull null])
            {
                aut.last_name=@"-";
            }
            if(aut.salutation==(NSString *) [NSNull null])
            {
                aut.salutation=@"-";
            }
            if(aut.country==(NSString *) [NSNull null])
            {
                aut.country=@"-";
            }
            if(aut.emailid==(NSString *) [NSNull null])
            {
                aut.emailid=@"-";
            }
            if(aut.mobile_no==(NSString *) [NSNull null])
            {
                aut.mobile_no=@"-";
            }
            if(aut.affiliation==(NSString *) [NSNull null])
            {
                aut.affiliation=@"-";
                // cell.country.hidden=YES;
            }
            else
            {
           NSString *authorName=[NSString stringWithFormat:@"%@ %@ %@",aut.salutation,aut.first_name,aut.last_name];
                cell.authorname.text=authorName;
                
                [cell.email setHidden:NO];
                [cell.affiliation setHidden:NO];
                [cell.mobile setHidden:NO];
                [cell.country setHidden:NO];
                [cell.emailimgv setHidden:NO];
                [cell.mobimgv setHidden:NO];
                [cell.readbtn setHidden:YES];
                cell.email.text=aut.emailid;
                cell.affiliation.text=aut.affiliation;
                cell.mobile.text=aut.mobile_no;
                cell.country.text=aut.country;
            }
        
            if ([expandedSections containsIndex:indexPath.section])
            {
                cell.accessoryView = [DTCustomColoredAccessory accessoryWithColor:[UIColor grayColor] type:DTCustomColoredAccessoryTypeUp];
//                cell.accessoryView = [[ UIImageView alloc ] initWithImage:[UIImage imageNamed:@"tick-blue.png"]];
            }
            else
            {
                cell.accessoryView = [DTCustomColoredAccessory accessoryWithColor:[UIColor grayColor] type:DTCustomColoredAccessoryTypeDown];
            }
        }
        else
        {

            
            if(aut.first_name==(NSString *) [NSNull null])
            {
                aut.first_name=@"-";
            }
            if(aut.last_name==(NSString *) [NSNull null])
            {
                aut.last_name=@"-";
            }
            if(aut.salutation==(NSString *) [NSNull null])
            {
                aut.salutation=@"-";
            }
            if(aut.country==(NSString *) [NSNull null])
            {
                aut.country=@"-";
            }
            if(aut.emailid==(NSString *) [NSNull null])
            {
                aut.emailid=@"-";
            }
            if(aut.mobile_no==(NSString *) [NSNull null])
            {
                aut.mobile_no=@"-";
            }
            if(aut.affiliation==(NSString *) [NSNull null])
            {
                aut.affiliation=@"-";
    
            }
            else
            {
            NSString *name=[NSString stringWithFormat:@"%@ %@ %@",aut.salutation,aut.first_name,aut.last_name];
                    cell.authorname.text=name;
                
                [cell.email setHidden:NO];
                [cell.affiliation setHidden:NO];
                [cell.mobile setHidden:NO];
                [cell.country setHidden:NO];
                [cell.emailimgv setHidden:NO];
                [cell.mobimgv setHidden:NO];
                [cell.readbtn setHidden:YES];
                    cell.email.text=aut.emailid;
                    cell.affiliation.text=aut.affiliation;
                    cell.mobile.text=aut.mobile_no;
                    cell.country.text=aut.country;
            }
        }
    }
    
    if(indexPath.section==1)
    {
      cell.authorname.text=_abstractstr;
        [cell.authorname setNumberOfLines:4];
        [cell.authorname setTextAlignment:NSTextAlignmentJustified];
        [cell.authorname setFont:[UIFont systemFontOfSize:12]];
     //   cell.authorname.font=[UIFont systemFontOfSize:cell.country];
        [cell.email setHidden:YES];
        [cell.affiliation setHidden:YES];
        [cell.mobile setHidden:YES];
        [cell.country setHidden:YES];
        [cell.emailimgv setHidden:YES];
        [cell.mobimgv setHidden:YES];
        [cell.readbtn setHidden:NO];
        
    }
}
    return cell;
}

-(void)readclick
{
    NSLog(@"HEllo");
    
}

- (IBAction)btnRead:(id)sender {
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self tableView:tableView canCollapseSection:indexPath.section])
    {
        if (!indexPath.row)
        {
            // only first row toggles exapand/collapse
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            
            NSInteger section = indexPath.section;
            BOOL currentlyExpanded = [expandedSections containsIndex:section];
            NSInteger rows;
            
            NSMutableArray *tmpArray = [NSMutableArray array];
            
            if (currentlyExpanded)
            {
                rows = [self tableView:tableView numberOfRowsInSection:section];
                [expandedSections removeIndex:section];
                
            }
            else
            {
                [expandedSections addIndex:section];
                rows = [self tableView:tableView numberOfRowsInSection:section];
            }
            
            for (int i=1; i<rows; i++)
            {
                NSIndexPath *tmpIndexPath = [NSIndexPath indexPathForRow:i
                                                               inSection:section];
                [tmpArray addObject:tmpIndexPath];
            }
            
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            
            if (currentlyExpanded)
            {
                [tableView deleteRowsAtIndexPaths:tmpArray
                                 withRowAnimation:UITableViewRowAnimationTop];
                
                cell.accessoryView = [DTCustomColoredAccessory accessoryWithColor:[UIColor grayColor] type:DTCustomColoredAccessoryTypeDown];
                
            }
            else
            {
                [tableView insertRowsAtIndexPaths:tmpArray
                                 withRowAnimation:UITableViewRowAnimationTop];
                cell.accessoryView =  [DTCustomColoredAccessory accessoryWithColor:[UIColor grayColor] type:DTCustomColoredAccessoryTypeUp];
                
            }
        }
    }
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section==1)
    {
        return @"Abstract";
    }
    return 0;
}

*/
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if([[segue identifier] isEqualToString:@"toabstract"]){
    AbsViewController  *ab=[segue destinationViewController];
     ab.absStr=_abstractstr;
    }
    
    
    if([[segue identifier] isEqualToString:@"toauthor"]){
        AuthorInfoViewController *ab=[segue destinationViewController];
        ab.paperidstr=_paperidstr;
    }
    
   
    
    if([[segue identifier] isEqualToString:@"authorDesc"]){
        
        NSIndexPath *path=[[self tableView1] indexPathForSelectedRow];
        AuthorInfo *author=self.authorinfoarr[path.row];
        NSLog(@"SELECTED AUTHOR ID=%@",author.authoridStr);
        
        AuthorViewController *ab=[segue destinationViewController];
        ab.paperidstr=_paperidstr;
        ab.starttimeStr=_starttimestr;
        ab.endtimeStr=_endtimestr;
        ab.papernameStr=_paper;
        ab.authoridStr=author.authoridStr;
        
        NSLog(@"Author id==%@",ab.authoridStr);
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AuthordetailTableViewCell *cell=[self.tableView1 dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    AuthorInfo *a=self.authorinfoarr[indexPath.row];
    
    cell.affiliation.text=a.affiliationStr;
    cell.authorid.text=a.authoridStr;
    cell.authorname.text=a.authornameStr;
    
    NSLog(@"****Affiliation===%@,Author name==%@",cell.affiliation.text,cell.authorname.text);
    
    [self performSegueWithIdentifier:@"authorDesc" sender:[self.tableView1 cellForRowAtIndexPath:indexPath]];
    
}
/*- (void)addReadMoreStringToUILabel:(UILabel*)label
{
    NSString *readMoreText = @" ...Read More";
    NSInteger lengthForString = label.text.length;
    if (lengthForString >= 30)
    {
       // NSInteger lengthForVisibleString = [self fitString:label.text intoLabel:label];
        NSInteger lengthForVisibleString=label.text.length;
        NSMutableString *mutableString = [[NSMutableString alloc] initWithString:label.text];
        NSString *trimmedString = [mutableString stringByReplacingCharactersInRange:NSMakeRange(lengthForVisibleString, (label.text.length - lengthForVisibleString)) withString:@""];
        NSInteger readMoreLength = readMoreText.length;
        NSString *trimmedForReadMore = [trimmedString stringByReplacingCharactersInRange:NSMakeRange((trimmedString.length - readMoreLength), readMoreLength) withString:@""];
        NSMutableAttributedString *answerAttributed = [[NSMutableAttributedString alloc] initWithString:trimmedForReadMore attributes:@{
                                                                                                                                        NSFontAttributeName : label.font
                                                                                                                                        }];
        
        NSMutableAttributedString *readMoreAttributed = [[NSMutableAttributedString alloc] initWithString:readMoreText attributes:@{
                                                                                                                                    NSFontAttributeName :[UIFont systemFontOfSize:20.0],
                                                                                                                                    NSForegroundColorAttributeName :[UIColor whiteColor]
                                                                                                                                    }];
        
        [answerAttributed appendAttributedString:readMoreAttributed];
        label.attributedText = answerAttributed;
        
        UITapGestureRecognizer *readMoreGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(readMoreDidClickedGesture:)];
       // readMoreGesture.tag=1;
        readMoreGesture.numberOfTapsRequired = 1;
        [label addGestureRecognizer:readMoreGesture];
        
        label.userInteractionEnabled = YES;
    }
    else {
        
        NSLog(@"No need for 'Read More'...");
        
    }
}

*/
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
//                                    //What we write here????????**
////                                    [self addSession];
////                                    [self userpaperget];
//                                    NSLog(@"you pressed Yes, please button");
//                                    //[self.navigationController popViewControllerAnimated:YES];
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
                               
                               alertControllerWithTitle:@"ALERT" message:@"Do you want to add this in my schedule?"preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes,please"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    //[self addSession];
                                   [self paperReminderadd];
                                    NSLog(@"you pressed Yes,please button");
                                    //[self.navigationController popViewControllerAnimated:YES];
                                     [_addMyScheduleBtn setImage:[UIImage imageNamed:@"added-other.png"] forState:UIControlStateNormal];
                                   
                                }];
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"No,thanks"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               {
                                   NSLog(@"you pressed No,thanks button");
                                  
                               }];
    
    [alert addAction:yesButton];
    [alert addAction:noButton];
    
    [self presentViewController:alert animated:YES completion:nil];
    }
}
/*-(void)addSession
{
    NSString *savedValue=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
    
    NSString *myst=[NSString stringWithFormat:@"emailid=%@&paper_id=%@&session_id=%@",savedValue,_paperidstr,_sessionidStr];
    NSLog(@"my string paper details=%@",myst);
   
    
    
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    
   // NSURL * url = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/add_to_paper_schedule.php"];
    
    NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:paper_reminder_add]];
    
    // NSURL * url = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/paper_reminder_add.php"];
    
    
    //  NSURL *url=[NSURL URLWithString:@"http://www.siddhantedu.com/iOSAPI/Symp/add_to_schedule.php"];
    
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
                                    NSLog(@"data of papeper detailss=%@",text);
                                    NSError *error1=nil;
                                    NSDictionary *responsedict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error1];
                                    if(error1)
                                    {
                                        NSLog(@"error 1 is %@",error1.description);
                                    }
                                    self.success=[responsedict objectForKey:@"success"];
                                    self.message=[responsedict objectForKey:@"message"];
                                    
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        
                                        if([self.success isEqualToString:@"1"])
                                        {
                                            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Success" message:self.message preferredStyle:UIAlertControllerStyleAlert];
                                            
                                            UIAlertAction* ok = [UIAlertAction
                                                                 actionWithTitle:@"OK"
                                                                 style:UIAlertActionStyleDefault
                                                                 handler:^(UIAlertAction * action)
                                                                 {
                                                                     NSLog(@"Show blue clicked tick.......");
                                                                     [_addMyScheduleBtn setImage:[UIImage imageNamed:@"added-other.png"] forState:UIControlStateNormal];
                                                                     [_addMyScheduleBtn setUserInteractionEnabled:NO];
                                                                     
                                                                     [alertView dismissViewControllerAnimated:YES completion:nil];
                                                                     
                                                                 }];
                                            
                                            
                                            [alertView addAction:ok];
                                            
                                            [self presentViewController:alertView animated:YES completion:nil];
                                            
                                        }
                                        else
                                        {
                                            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Alert!" message:self.message preferredStyle:UIAlertControllerStyleAlert];
                                            
                                            UIAlertAction* ok = [UIAlertAction
                                                                 actionWithTitle:@"OK"
                                                                 style:UIAlertActionStyleDefault
                                                                 handler:^(UIAlertAction * action)
                                                                 {
                                                                     [alertView dismissViewControllerAnimated:YES completion:nil];
                                                                     
                                                                 }];
                                            
                                            
                                            [alertView addAction:ok];
                                            
                                            [self presentViewController:alertView animated:YES completion:nil];
                                            
                                        }
                                    });
                                    
                                    
                                    NSLog(@"json = %@",responsedict);
                                    
                                    
                                }];
    [task resume];
}
*/
-(void)paperReminderadd{
    
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    
    
    
    NSString *savedValue=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
    
    NSString *myst=[NSString stringWithFormat:@"emailid=%@&paper_id=%@&session_id=%@",savedValue,_paperidstr,_sessionidStr];
    
    NSLog(@".. My SAtatement. paper..***%@",myst);
    
    NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:paper_reminder_add]];
    
    //NSURL * url = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/paper_reminder_add.php"];//local
    
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

-(void)getPaperDetailStatus{
    
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    
    NSString *savedValue=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
    
    NSString *myst=[NSString stringWithFormat:@"emailid=%@&paper_id=%@&session_id=%@",savedValue,_paperidstr,_sessionidStr];
    
    NSLog(@"Get paper details status SAtatement...***%@",myst);
    
       NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:get_paper_details_status]];
    
   // NSURL * url = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/get_paper_details_status.php"];//local
    
    
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
                                    if(data!=nil){
                                    
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
                                            self.addSchLbl.text = @"Added to My Schedule";
                                            [_addMyScheduleBtn setUserInteractionEnabled:NO];
                                            [_addMyScheduleLargeBtn setUserInteractionEnabled:NO];
                                            
                                            
                                        }
                                        else
                                        {
                                            [_addMyScheduleBtn setImage:[UIImage imageNamed:@"add-other.png"] forState:UIControlStateNormal];
                                             self.addSchLbl.text = @"Add to My Schedule";
                                            [_addMyScheduleBtn setUserInteractionEnabled:YES];
                                            [_addMyScheduleLargeBtn setUserInteractionEnabled:YES];
                                           
                                            
                                        }
                                    });
                                    
//                                    if([self.success isEqualToString:@"1"] && [self.liked isEqualToString:@"1"])
//                                    {
//                                        NSLog(@"like clicked tick.......");
//                                        [_likeBtnImg setImage:[UIImage imageNamed:@"liked.png"] forState:UIControlStateNormal];
//                                        [_likeBtnImg setUserInteractionEnabled:NO];
//                                        [_likeBtnClicked setUserInteractionEnabled:NO];
//                                        self.likeLbl.text = @"Liked";
//                                        
//                                    }
//                                    else
//                                    {
//                                        [_likeBtnImg setImage:[UIImage imageNamed:@"like.png"] forState:UIControlStateNormal];
//                                        [_likeBtnImg setUserInteractionEnabled:YES];
//                                        [_likeBtnClicked setUserInteractionEnabled:YES];
//                                        self.likeLbl.text = @"Like";
//                                        
//                                    }
                                

                                
                                    NSLog(@"json paper add to myschedule = %@",responsedict);
                                    
                                    }
                                    else
                                    {
                                        
                                        NSLog(@"Data is nil");
                                    }
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
    
//    self.tableview2.allowsSelectionDuringEditing =NO;
//    self.tableview2.allowsSelection = NO;

}

@end
