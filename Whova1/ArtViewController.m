//
//  ArtViewController.m
//  ITherm
//
//  Created by Anveshak on 12/13/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import "ArtViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ArtCommentTableViewCell.h"
#import "ArtComment.h"
#import "Constant.h"
@interface ArtViewController ()

@end

@implementation ArtViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _que=[[NSOperationQueue alloc]init];
    
    self.chair_image.layer.masksToBounds=YES;
    self.chair_image.layer.borderColor=[UIColor blackColor].CGColor;
    self.chair_image.layer.borderWidth=1.1;
    self.chair_image.layer.shadowColor=[UIColor redColor].CGColor;
    
    self.chair_image.layer.cornerRadius = self.chair_image.frame.size.width / 2;
    self.chair_image.clipsToBounds = YES;
    
    self.cochair_image.layer.masksToBounds=YES;
    self.cochair_image.layer.borderColor=[UIColor blackColor].CGColor;
    self.cochair_image.layer.borderWidth=1.1;
    self.cochair_image.layer.shadowColor=[UIColor redColor].CGColor;
    
    self.cochair_image.layer.cornerRadius = self.cochair_image.frame.size.width / 2;
    self.cochair_image.clipsToBounds = YES;
    
    [self getLikes];
    [self getCommentCount];
    [self getComments];
    [self artparsing];
    
    _tableview.delegate=self;
    _tableview.dataSource=self;
    
    _artcommentarr=[[NSMutableArray alloc]init];
    
    _imgarr=[[NSMutableArray alloc]init];
    _commentarr=[[NSMutableArray alloc]init];
    _usernamearr=[[NSMutableArray alloc]init];
    _datearr=[[NSMutableArray alloc]init];
    
    
    _comments.delegate =self;
    
    [_scrollview setShowsHorizontalScrollIndicator:NO];
    [_scrollview setShowsVerticalScrollIndicator:NO];

}
-(void)viewWillAppear:(BOOL)animated
{
    
//    int i=[_indxpath intValue];
//    NSString *tempimgstr=[_kimgarray objectAtIndex:i];
//    
//    [_chair_image sd_setImageWithURL:[NSURL URLWithString:tempimgstr]
//               placeholderImage:[UIImage imageNamed:@"default.png"]];
//   
//    
//    [self.tableview reloadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _artcommentarr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ArtCommentTableViewCell *cell = [self.tableview dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    ArtComment *ktemp=[_artcommentarr objectAtIndex:indexPath.row];
    
    cell.name.text=ktemp.name;
    cell.comments.text=ktemp.comments;
    cell.date1.text=ktemp.date1;
    
    NSLog(@"keynote commentss ==== %@",cell.comments);
    NSLog(@"comment date ==== %@",cell.date1);
    
    return cell;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return  YES;
}
- (IBAction)addComments:(id)sender {
    
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
-(void)artparsing
{
    
    NSBlockOperation *op1=[NSBlockOperation blockOperationWithBlock:^{
        
       // NSString *urlstr=@"http://192.168.1.100/phpmyadmin/itherm/art.php";
        
        NSURL * urlstr = [NSURL URLWithString:[mainUrl stringByAppendingString:art]];
        
        NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:urlstr];
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
                                            
                                            NSArray *keyarr=[outerdic objectForKey:@"artscience"];
                        
                                            for(NSDictionary *temp in keyarr)
                                            {
                                                NSString *aid=[temp objectForKey:@"id"];
                                                NSString *sname=[temp objectForKey:@"session_name"];
                                                NSString *info=[temp objectForKey:@"information"];
                                                NSString *chair=[temp objectForKey:@"chair"];
                                                NSString *cuni=[temp objectForKey:@"chair_uni"];
                                                NSString *cimg=[temp objectForKey:@"chair_img"];
                                                NSString *cochair=[temp objectForKey:@"cochair"];
                                                NSString *couni=[temp objectForKey:@"cochair_uni"];
                                                NSString *coimg=[temp objectForKey:@"cochair_img"];
                                                NSString *sid=[temp objectForKey:@"session_id"];
                                                
//                                                if([sid isEqualToString:_sessionidStr])
//                                                {
                                                    _artidStr=aid;
                                                    _session_namestr=sname;
                                                    _infostr=info;
                                                    _chair_namestr=chair;
                                                    _chair_universitystr=cuni;
                                                    _cochair_namestr=cochair;
                                                    _cochair_universitystr=couni;
                                                    _sessionidStr=sid;
                                                    
                                                    NSString *tempimgstr=cimg;
                                                    
                                                    [_chair_image sd_setImageWithURL:[NSURL URLWithString:tempimgstr]
                                                               placeholderImage:[UIImage imageNamed:@"default.png"]];
                                                    NSString *tempimgstr2=coimg;
                                                    
                                                    [_cochair_image sd_setImageWithURL:[NSURL URLWithString:tempimgstr2]
                                                                    placeholderImage:[UIImage imageNamed:@"default.png"]];
                                                    
                                                    [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                                                        _sessionname.text=_session_namestr;
                                                        _information.text=_infostr;
                                                        _chair_name.text=_chair_namestr;
                                                        _chair_university.text=_chair_universitystr;
                                                        _cochair_name.text=_cochair_namestr;
                                                        _cochair_university.text=_cochair_universitystr;
                                                        _sessionid.text=_sessionidStr;
                                                        
                                                        [[NSUserDefaults standardUserDefaults]setValue:self.sessionidStr forKey:@"sessionid"];
                                                        NSLog(@"**sessionid Art = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"]);
                                          }];
                                
                                            }
                                        }
                                        
                                    }];
        [task resume];
    }];
    
    [_que addOperation:op1];
}

-(void)addComment{
    
    NSString *savedValue=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
    NSString *savedsessionid=[[NSUserDefaults standardUserDefaults]stringForKey:@"sessionid"];
    
    //_tempcomment = _comments.text;
    
    NSString *myst=[NSString stringWithFormat:@"emailid=%@&session_id=%@&comment=%@",savedValue,savedsessionid,_tempcomment];
    NSLog(@"my string keynotes add comments=%@",myst);
    
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    
    NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:add_keynote_comment]];
    
   // NSURL *url=[NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/add_keynote_comment.php"];

    
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
    [task resume];
}



-(void)getComments{
    
    [_artcommentarr removeAllObjects];
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSString *savedsessionid=[[NSUserDefaults standardUserDefaults]stringForKey:@"sessionid"];
    
    NSString *myst2=[NSString stringWithFormat:@"session_id=%@",savedsessionid];
    
    NSLog(@"GET  Session ID.....:%@",myst2);
    
    
    NSURL * url2 = [NSURL URLWithString:[mainUrl stringByAppendingString:get_keynote_comments]];
    
    //NSURL * url2 = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/get_keynote_comments.php"];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url2];
    
    
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[myst2 dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask *task=[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                {
                                    
                                    if(data==nil)
                                    {
                                        NSLog(@"Data is nil");
                                    }
                                    else
                                    {
                                        NSLog(@"%@",response);
                                        
                                        NSDictionary *outerdic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                        
                                        
                                        NSArray *keyarr =[outerdic objectForKey:@"comments"];
                                        
                                        NSLog(@"%@kEY ARRRAY.....",keyarr);
                                        for(NSDictionary *temp in keyarr)
                                        {
                                            ArtComment *f=[[ArtComment alloc]init];
                                            f.name=temp[@"user"];
                                            f.date1=temp[@"date"];
                                            
                                            
                                            
                                            NSString *str=@" \"";
                                            f.comments=[str stringByAppendingFormat:@"%@%@",temp[@"comment"],str];
                                            
                                            [_artcommentarr addObject:f];
                                            
                                        }
                                    }
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        [_tableview reloadData];
                                        [self scrollViewHeight];
                                    });
                                    
                                }];
    
    [task resume];
    
}
-(void)scrollViewHeight{
    [self.tableview layoutIfNeeded];
    CGFloat tbleViewHeight = self.tableview.contentSize.height;
    self.consContainerHeight.constant = self.consContainerHeight.constant + tbleViewHeight;
    NSLog(@"****scroll view height after adding cell in Keynote tab: %@", self.consContainerHeight);
}
-(NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section   {
    
    NSString *message = @"";
    
    NSInteger numberOfRowsInSection = [self tableView:self.tableview numberOfRowsInSection:section ];
    
    if (numberOfRowsInSection == 0) {
        message = @"No Comments yet...";
    }
    
    return message;
}
- (IBAction)likeBtnClicked:(id)sender {
    [self likeSession];
    
    //  [_likeBtnClicked setImage:[UIImage imageNamed:@"liked.png"] forState:UIControlStateNormal];
}

-(void)likeSession
{
    NSString *savedValue=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
    
    NSString *savedsessionid=[[NSUserDefaults standardUserDefaults]stringForKey:@"sessionid"];
    
    NSString *myst=[NSString stringWithFormat:@"emailid=%@&session_id=%@",savedValue,savedsessionid];
    
    
    NSLog(@"my string=%@",myst);
    
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    
    NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:add_keynote_likes]];
    
   // NSURL * url = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/add_keynote_likes.php"];
    
    
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
    
    NSString *savedsessionid=[[NSUserDefaults standardUserDefaults]stringForKey:@"sessionid"];
    
    NSString *myst2=[NSString stringWithFormat:@"session_id=%@",savedsessionid];
    
    NSLog(@"Session ID.....:%@",myst2);
    
    NSURL * url2 = [NSURL URLWithString:[mainUrl stringByAppendingString:get_keynote_likes]];
    
   // NSURL * url2 = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/get_keynote_likes.php"];
  
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
    
    NSString *savedsessionid=[[NSUserDefaults standardUserDefaults]stringForKey:@"sessionid"];
    
    NSString *myst2=[NSString stringWithFormat:@"session_id=%@",savedsessionid];
    
    NSLog(@"Session ID.....:%@",myst2);
    
    NSURL * url2 = [NSURL URLWithString:[mainUrl stringByAppendingString:get_keynote_comment_count]];
    
    
   // NSURL * url2 = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/get_keynote_comment_count.php"];
  
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url2];
    
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[myst2 dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(error == nil)
        {
            NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
            
            _count_comment.text=text;
            NSLog(@"comment count==%@",_count_comment.text);
        }
    }];
    
    [dataTask resume];
    
    
}

@end
