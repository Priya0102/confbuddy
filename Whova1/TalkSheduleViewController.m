//
//  TalkSheduleViewController.m
//  ITherm
//
//  Created by Anveshak on 5/24/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import "TalkSheduleViewController.h"
#import "TalkSchInfoViewController.h"
#import "TalkTableViewCell.h"
//#import "Talk.h"
#import "Talk_itherm.h"
#import "TalkSchTableViewCell.h"
#import "Constant.h"
#define SYSTEM_VERSION_GREATERTHAN_OR_EQUALTO(v) ([[[UIDevice currentDevice]systemVersion] compare:v options:NSNumericSearch]!=NSOrderedAscending)
@interface TalkSheduleViewController ()

@end

@implementation TalkSheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSLog(@"view did load .........");
    self.chairimage.layer.cornerRadius = self.chairimage.frame.size.width / 2;
    self.chairimage.clipsToBounds = YES;
    [_indicator startAnimating];
    _tickarray=[[NSMutableArray alloc]init];
    self.paper_id=[[NSMutableArray alloc]init];
        
    
    [_talkArray removeAllObjects];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _talkArray=[[NSMutableArray alloc]init];
    _sessionName.text=_sessNamestr;
    _endTime.text=_etime;
    _startTime.text=_stime;
    _location.text=_locationstr;
    _que=[[NSOperationQueue alloc]init];
    
    NSLog(@"CATEGORY STRING....%@",_categorystr);
    
    NSLog(@"SESSION ID IN TECH TALK....%@",_session_idstr);
    
    [[NSUserDefaults standardUserDefaults]setValue:self.session_idstr forKey:@"sessionid"];
    NSLog(@"sessionid = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionid"]);
    
    [self.tableView setSeparatorColor:[UIColor clearColor]];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [self techtalkParsing];
    
    NSLog(@"view will appear.........");
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _talkArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TalkSchTableViewCell *cell=[_tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    Talk_itherm *t=[_talkArray objectAtIndex:indexPath.row];
    cell.talkName.text=t.talkName;
    cell.delBtn.tag=indexPath.row;
    cell.talkid.text=t.talkid;
    [_indicator stopAnimating];

    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Talk_itherm *i=[_talkArray objectAtIndex:indexPath.row];
    _temptalkname=i.talkName;
    _tempabs=i.abstract;
    _tempspeakerName=i.speakerName;
    _tempspuni=i.speakerUni;
    _location.text=i.location;
    _temptalkid=i.talkid;
    
      NSString *sessid=[[NSUserDefaults standardUserDefaults]stringForKey:@"sessionid"];
    NSLog(@"sess talk %@",sessid);
    _session_idstr=sessid;
    NSLog(@"sess id talk %@",_session_idstr);
    

    NSLog(@"IN DidSelect..  %@",_temptalkname);
    [self performSegueWithIdentifier:@"showSchTalk" sender:nil];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
     if([[segue identifier] isEqualToString:@"showSchTalk"]){
    
    TalkSchInfoViewController *tlk=[segue destinationViewController];
    
    tlk.tempTalkName=_temptalkname;
    tlk.abstractstr=_tempabs;
    tlk.tempSpeakerName=_tempspeakerName;
    tlk.tempSpeakeruni=_tempspuni;
    tlk.sess_namestr=_sessNamestr;
    tlk.locationstr=_locationstr;
    tlk.talkidstr=_temptalkid;
    tlk.starttimestr=_stime;
    tlk.endtimestr=_etime;
         
    NSString *sessid=[[NSUserDefaults standardUserDefaults]stringForKey:@"sessionid"];
    tlk.tempsessionid=sessid;
         
         NSLog(@"Session id==%@",sessid);
}
}

-(IBAction)cellDeleteBtnClick:(id)sender {
    
    UIButton *btn=(UIButton *)sender;
    NSLog(@"%ld",(long)btn.tag);
    
    Talk_itherm *s3=self.talkArray[btn.tag];
    
    NSLog(@"paper id is=%@",s3.talkid);
    
    
    
    UIAlertController *alert=[UIAlertController
                               
                               alertControllerWithTitle:@"ALERT" message:@"Do You Want To Delete Record?"preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *yesButton = [UIAlertAction
                                actionWithTitle:@"Yes, please"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    
                                    Talk_itherm *s2=self.talkArray[btn.tag];
                                    NSLog(@"%@",s2);
                                    [_talkArray removeObjectAtIndex:btn.tag];
                                    
                                    NSLog(@"talk id s3 is=%@",s3.talkid);
                                    NSString *savedValue=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];//used to retrieve user's emailid which we have stored in nsuserdefaults for key email(those user login dat person mail id will get using userdefaults)
                                    
                                    NSString *myst=[NSString stringWithFormat:@"emailid=%@&talk_id=%@&session_id=%@",savedValue,s3.talkid,_session_idstr];
                                    NSLog(@"my string after delete=%@",myst);
                                    // NSString *myst=[NSString stringWithFormat:@"emailid=rohini@anveshak.com & session_id=s2"];
                                    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
                                    NSURLSession *session=[NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
                                    
                                    NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:techtalk_delete]];
                                    
                                   // NSURL * url = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/techtalk_delete.php"];
                                 
                                
                                    
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
                                                              [_tableView reloadData];
                                                                    
                                                                }];
                                    [_tableView reloadData];
                                    
                                    if (_talkArray.count==0) {
                                        self.talkView.hidden=YES;
                                    }
                                    else{
                                        self.talkView.hidden=NO;
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



-(void)deleteSession
{
    NSString *savedValue=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
    
    NSString *myst=[NSString stringWithFormat:@"emailid=%@&session_id=%@&category=%@",savedValue,_session_idstr,_categorystr];
     NSLog(@"my string=%@",myst);
  
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    
    NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:sessiondel_talk]];
    
   // NSURL * url = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/sessiondel_talk.php"];
    
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
                                    NSLog(@"data in techtalk sch******=%@",text);
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

-(void)techtalkParsing
{
    [_talkArray removeAllObjects];
    NSString *savedvalue2=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
    NSString *myst2=[NSString stringWithFormat:@"emailid=%@&session_id=%@",savedvalue2,_session_idstr];//2

    NSLog(@"MY STATEMENT. course. %@",myst2);
    
    NSURLSessionConfiguration *defaultConfigObject2=[NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *defaultSession2=[NSURLSession sessionWithConfiguration:defaultConfigObject2 delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURL * url1 = [NSURL URLWithString:[mainUrl stringByAppendingString:user_talk_get6]];
    
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
                                             _talkView.hidden=YES;
                                         }
                                         else{
                                             _talkView.hidden=NO;
                                         }
                                         for(NSDictionary *dict in agenda){
                                             Talk_itherm *pi=[[Talk_itherm alloc]init];
                                             pi.talkName=dict[@"talk"];
                                             
                                             NSLog(@".....******%@",pi.talkName);
                                             
                                             pi.start_time=dict[@"start_time"];
                                             pi.end_time=dict[@"end_time"];
                                             pi.room_name=dict[@"room_name"];
                                             pi.talkid=dict[@"talk_id"];
                                             
                                             pi.date=dict[@"date"];
                                             
                                             pi.speakerName=dict[@"speaker_name"];
                                             pi.speakerUni=dict[@"speaker_university"];
                                             pi.abstract=dict[@"abstract"];
                                             
                                             pi.day=dict[@"day"];
                                             [self.talkArray addObject:pi];
                                             
                                             NSLog(@"PAPER IDDD=%@",pi.talkid);
                                         }
                                         
                                         
                                         [self.tableView reloadData];
                                     }];
    [dataTask2 resume];
}
/*
 -(void)dataParsing
 {
 [_talkArray removeAllObjects];
 
 NSBlockOperation *op1=[NSBlockOperation blockOperationWithBlock:^{
 NSString *savedvalue2=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
 
 NSString *myst=[NSString stringWithFormat:@"session_id=%@&emailid=%@",_session_idstr,savedvalue2];
 
 NSURL * urlstr = [NSURL URLWithString:[mainUrl stringByAppendingString:get_tech_talk_schedule]];
 
 //NSString *urlstr=@"http://192.168.1.100/phpmyadmin/itherm/get_tech_talk_schedule.php";
 
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
 
 NSArray *keyarr=[outerdic objectForKey:@"talk_details"];
 
 if (keyarr.count==0) {
 _talkView.hidden=YES;
 }
 else{
 _talkView.hidden=NO;
 }
 
 for(NSDictionary *temp in keyarr)
 {
 //NSString *str1=[[temp objectForKey:@"name"]description];
 
 NSString *str4=[temp objectForKey:@"session_id"];
 NSString *str5=[temp objectForKey:@"session_name"];
 NSString *str6=[temp objectForKey:@"university"];
 NSString *str8=[temp objectForKey:@"chair"];
 
 NSLog(@"%@ %@",str4,str5);
 
 [[NSOperationQueue mainQueue]addOperationWithBlock:^{
 // _sessionName.text=str5;
 _chairname.text=str8;
 _chairuniversity.text=str6;
 }];
 NSArray *personarr=[temp objectForKey:@"person"];
 for(NSDictionary *persondic in personarr)
 {
 
 NSString *str2=[[persondic objectForKey:@"talk_id"]description];
 NSString *str3=[persondic objectForKey:@"talk"];
 NSString *str9=[persondic objectForKey:@"speaker_name"];
 NSString *str10=[persondic objectForKey:@"speaker_university"];
 NSString *str7=[persondic objectForKey:@"abstract"];
 NSString *str8=[persondic objectForKey:@"added"];
 //  NSString *str11=[persondic objectForKey:@"start_time"];
 Talk_itherm *i1=[[Talk_itherm alloc]init];
 //i1.nameStr=str1;
 i1.talkid=str2;
 i1.talkName=str3;
 // i1.session_id=str4;
 //i1.sessionName=str5;
 // i1.talkUniversity=str6;
 i1.abstract=str7;
 i1.speakerName=str9;
 i1.speakerUni=str10;
 i1.added=str8;
 // i1.start_time=str11;
 [_talkArray addObject:i1];
 
 [_tableView reloadData];
 }
 // [_tableView reloadData];
 }
 [_tableView reloadData];
 }
 [_tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
 }];
 [task resume];
 }];
 
 [_que addOperation:op1];
 }
*/



@end

