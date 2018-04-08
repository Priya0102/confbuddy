//
//  PanelSchViewController.m
//  ITherm
//
//  Created by Anveshak on 12/21/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import "PanelSchViewController.h"
#import "PanelSch.h"
#import "PanelSchCom.h"
#import "PanelSchTableViewCell.h"
#import "PanelSchComTableViewCell.h"
#import "AbsViewController.h"
#import "PanelPanelistViewController.h"
#import "Constant.h"
@interface PanelSchViewController ()

@end

@implementation PanelSchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_indicator startAnimating];
    
    [self.tableview setSeparatorColor:[UIColor clearColor]];
    
    _tableview2.delegate=self;
    _tableview2.dataSource=self;
    
    _tableview.delegate=self;
    _tableview.dataSource=self;
    
    _panelistarr=[[NSMutableArray alloc]init];
    _panelnamearr=[[NSMutableArray alloc]init];
    _paneluniversityarr=[[NSMutableArray alloc]init];
    _commentarray=[[NSMutableArray alloc]init];
    
    _starttime.text=_stimeStr;
    _endtime.text=_etimeStr;
    _location.text=_locStr;
    _sessionid.text=_tempsessionid;
    
    _que=[[NSOperationQueue alloc]init];
    NSLog(@"SESSION ID...%@",_tempsessionid);
    
    _imgarr=[[NSMutableArray alloc]init];
    _commentarr=[[NSMutableArray alloc]init];
    _usernamearr=[[NSMutableArray alloc]init];
    _datearr=[[NSMutableArray alloc]init];
    
    _comments.delegate =self;
    
    
    [self getLikes];
    [self getComments];
    [self getCommentCount];
    [self dataParsing];
    
    
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
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return  YES;
}

- (IBAction)addComments:(id)sender {
    
    _tempcomment =_comments.text;
    
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
-(void)addComment{
    
    NSString *savedValue3=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
    
    NSString *myst3=[NSString stringWithFormat:@"emailid=%@&session_id=%@&comment=%@",savedValue3,_tempsessionid,_tempcomment];
    NSLog(@"my add comments string=%@",myst3);
    
    NSURLSessionConfiguration *config3=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session3=[NSURLSession sessionWithConfiguration:config3 delegate:self delegateQueue:nil];
    
    NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:add_women_comment]];
    
    //NSURL *url=[NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/add_women_comment.php"];
    
    
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
                                             [self getComments];
                                             [self getCommentCount];
                                             
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
    
    
    
    NSString *myst2=[NSString stringWithFormat:@"session_id=%@",_tempsessionid];
    
    NSLog(@"GET  session_id ID.....:%@",myst2);
    
    NSURL * url2 = [NSURL URLWithString:[mainUrl stringByAppendingString:get_women_comments]];
    
    //NSURL *url2=[NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/get_women_comments.php"];
  
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
                                             PanelSchCom *f=[[PanelSchCom alloc]init];
                                             f.name=temp[@"user"];
                                             //f.comments=temp[@"comment"];
                                             f.date1=temp[@"date"];
                                             
                                             [_commentarray addObject:f];
                                             
                                             NSString *str=@" \"";
                                             f.comments=[str stringByAppendingFormat:@"%@%@",temp[@"comment"],str];
                                             
                                             
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
    NSLog(@"****scroll view height after adding cell in talk info tab: %@", self.consContainerHeight);
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
    
    NSString *myst=[NSString stringWithFormat:@"emailid=%@&session_id=%@",savedValue,_tempsessionid];
    
    NSLog(@"my string=%@",myst);
    
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    
    NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:add_women_likes]];
    
   // NSURL *url=[NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/add_women_likes.php"];

    
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
    
    NSString *myst2=[NSString stringWithFormat:@"session_id=%@",_tempsessionid];
    
    NSLog(@"paper ID.....:%@",myst2);
    
    NSURL * url2 = [NSURL URLWithString:[mainUrl stringByAppendingString:get_women_likes]];
    
    //NSURL *url2=[NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/get_women_likes.php"];
    
    
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
    
    NSString *myst2=[NSString stringWithFormat:@"session_id=%@",_tempsessionid];
    
    NSLog(@"Paper ID Comment count.....:%@",myst2);
    
    NSURL * url2 = [NSURL URLWithString:[mainUrl stringByAppendingString:get_women_comment_count]];
    
   // NSURL *url2=[NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/get_women_comment_count.php"];
    
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


-(void)viewWillAppear:(BOOL)animated
{
    [_tableview2 reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView==self.tableview) {
        return 1;
    }
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.tableview) {
        return _panelistarr.count;
    }
    return _commentarray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (tableView==self.tableview) {
        
        PanelSchTableViewCell *cell=[_tableview dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
        PanelSch *w=[_panelistarr objectAtIndex:indexPath.row];
        cell.panelname.text=w.pname;
        cell.paneluniversity.text=w.puniversity;
        
        
    }
    else if(tableView==self.tableview2){
        
        PanelSchComTableViewCell *cell = [self.tableview2 dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
        PanelSchCom *ktemp=[_commentarray objectAtIndex:indexPath.row];
        
        cell.name.text=ktemp.name;
        cell.comments.text=ktemp.comments;
        cell.date1.text=ktemp.date1;
        
    }
    [_indicator stopAnimating];
    return cell;
}

-(void)dataParsing
{
    NSBlockOperation *op1=[NSBlockOperation blockOperationWithBlock:^{
        
        [_panelistarr removeAllObjects];
        NSString *myst=[NSString stringWithFormat:@"session_id=%@",_tempsessionid];
        NSLog(@"POST CONTAINT....%@",myst);
    
        NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:panelcopy]];
        
       // NSString *url=@"http://192.168.1.100/phpmyadmin/itherm/panelcopy.php";
      
        
        
        NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
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
                                        
                                        if(data==nil)
                                        {
                                            NSLog(@"Data is nil");
                                            
                                        }
                                        
                                        else
                                        {
                                            
                                            
                                            NSLog(@"%@",response);
                                            
                                            
                                            NSDictionary *outerdic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                            NSArray *panelarr=[outerdic objectForKey:@"all_panel"];
                                            for(NSDictionary *outerdic1 in panelarr)
                                            {
                                                //  _session_namestr=[outerdic objectForKey:@"session_name"];
                                                _sessionstr=[outerdic1 objectForKey:@"session_name"];
                                                _abstractstr=[outerdic1 objectForKey:@"abstract"];
                                                _chairnamestr=[outerdic1 objectForKey:@"chair"];
                                                _universitystr=[outerdic1 objectForKey:@"university"];
                                                _panelnamestr=[outerdic1 objectForKey:@"panel_name"];
                                                
                                                [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                                                    _sessionName.text=_sessionstr;
                                                    _abstract.text=_abstractstr;
                                                    _chairname.text=_chairnamestr;
                                                    _university.text=_universitystr;
                                                    _panelname.text=_panelnamestr;
                                                    
                                                }];
                                                
                                                NSArray *panelarr2=[outerdic1 objectForKey:@"panelist"];
                                                for(NSDictionary *temp in panelarr2)
                                                {
                                                    PanelSch *w=[[PanelSch alloc]init];
                                                    w.pname=temp[@"panelist_name"];
                                                    w.puniversity=temp[@"panelist_university"];
                                                    
                                                    [_panelistarr addObject:w];
                                                    
                                                    [_tableview reloadData];
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"showPanelSchabstract"])
    {
        AbsViewController *ab=[segue destinationViewController];
        ab.absStr=_abstract.text;
    }
    
    
}
- (IBAction)deleteBtn:(id)sender {
    
    UIAlertController * alert=[UIAlertController
                               
                               alertControllerWithTitle:@"ALERT" message:@"Do You Want To Delete Record?"preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes, please"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    //What we write here????????**
                                    [self deleteSession];
                                    NSLog(@"you pressed Yes, please button");
                                    [self.navigationController popViewControllerAnimated:YES];
                                    
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

-(void)deleteSession
{
    NSString *savedValue=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];//used to retrieve user's emailid which we have stored in nsuserdefaults for key email(those user login dat person mail id will get using userdefaults)
    
    NSString *myst=[NSString stringWithFormat:@"emailid=%@&session_id=%@",savedValue,_tempsessionid];
   
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    
  NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:delete_from_schedule]];
    
   // NSURL *url=[NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/delete_from_schedule.php"];
    
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
    self.tableview.allowsSelectionDuringEditing =NO;
    self.tableview.allowsSelection = NO;
    
    
}






@end
