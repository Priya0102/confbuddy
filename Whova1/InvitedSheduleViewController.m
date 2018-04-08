//
//  InvitedSheduleViewController.m
//  ITherm
//
//  Created by Anveshak on 5/24/17.
//  Copyright © 2017 Anveshak . All rights reserved.x
//

#import "InvitedSheduleViewController.h"
#import "InvitedTableViewCell.h"
#import "Invited.h"
#import "InvSchViewController.h"
#import "InvitedSchTableViewCell.h"
#import "Constant.h"
#define SYSTEM_VERSION_GREATERTHAN_OR_EQUALTO(v) ([[[UIDevice currentDevice]systemVersion] compare:v options:NSNumericSearch]!=NSOrderedAscending)
@interface InvitedSheduleViewController ()

@end

@implementation InvitedSheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //[_invitedArray removeAllObjects];
    //[_indicator startAnimating];
    _que=[[NSOperationQueue alloc]init];
    _tickarray=[[NSMutableArray alloc]init];
    self.paper_id=[[NSMutableArray alloc]init];
    
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _invitedArray=[[NSMutableArray alloc]init];
    _sessionName.text=_sessNamestr;
    _endTime.text=_etime;
    _startTime.text=_stime;
    _location.text=_locationstr;
    
    NSLog(@"category...%@",_categorystr);
    NSLog(@"SESSION ID INVITED%@",_session_idstr);
    
    [self.tableView setSeparatorColor:[UIColor clearColor]];
   
}
-(void)viewWillAppear:(BOOL)animated
{
     [self invitedParsing];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _invitedArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InvitedSchTableViewCell *cell=[_tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    Invited *inv=[_invitedArray objectAtIndex:indexPath.row];
    //[_indicator stopAnimating];
    cell.invitedName.text=inv.invName;
    cell.delBtn.tag=indexPath.row;
    
    
//    NSString *tempadd=inv.added;
//    NSString *pprid=inv.paper_id;
    
 
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Invited *i=[_invitedArray objectAtIndex:indexPath.row];
    _tempNamestr=i.nameStr;
    _tempimg=i.invImage;
    _tempuni=i.invUniversit;
    _tempabstract=i.abstract;
    _tempsession=i.sessionName;
    _temptalkName=i.invName;
    _tempSpeakerName=i.nameStr;
    _tempinvid=i.invid;
   // _session_idstr=i.session_id;
    
   // NSLog(@"sess inv id==%@",_session_idstr);
    
    [self performSegueWithIdentifier:@"showInvitedSchDetail" sender:nil];
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if([[segue identifier] isEqualToString:@"showInvitedSchDetail"]){
    InvSchViewController *invd=[segue destinationViewController];
    invd.namestr=_tempNamestr;
    invd.universitystr=_tempuni;
    invd.abstractstr=_tempabstract;
    invd.imgstr=_tempimg;
    invd.sess_namestr=_tempsession;
    invd.temptalkname=_temptalkName;
    invd.tempSpeakerName=_tempSpeakerName;
    invd.locationstr=_locationstr;
    invd.tempTalkid=_tempinvid;
    invd.starttimestr=_stime;
    invd.endtimestr=_etime;
    invd.tempsessionid=_session_idstr;
    
        
         NSLog(@"session inv id==%@",_session_idstr);

}

}

-(IBAction)cellDeleteBtnClick:(id)sender {
 
    UIButton *btn=(UIButton *)sender;
    NSLog(@"%ld",(long)btn.tag);
    
    Invited *s3=self.invitedArray[btn.tag];
    
    NSLog(@"paper id is=%@",s3.invid);
    
    
    
    UIAlertController * alert=[UIAlertController
                               
                               alertControllerWithTitle:@"ALERT" message:@"Do You Want To Delete Record?"preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes, please"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    
                                    Invited *s2=self.invitedArray[btn.tag];
                                    [_invitedArray removeObjectAtIndex:btn.tag];
                                    
                                    NSLog(@"paper id is=%@",s2.invid);
                                    NSString *savedValue=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
                                    
                                    NSString *myst=[NSString stringWithFormat:@"emailid=%@&paper_id=%@&session_id=%@",savedValue,s2.invid,_session_idstr];
                                    NSLog(@"my string after delete=%@",myst);
                                   
                                    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
                                    NSURLSession *session=[NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
                                    
                                    NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:invited_delete]];
                                    
                                    // NSURL * url = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/invited_delete.php"];

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
                                    
                                    if(_invitedArray.count == 0)
                                    {
                                        self.invitedView.hidden = YES;
                                    }
                                    else
                                    {
                                        self.invitedView.hidden = NO;
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
    
    NSString *myst=[NSString stringWithFormat:@"emailid=%@&session_id=%@&category=%@",savedValue,_session_idstr,_categorystr];
    NSLog(@"*****my string in delte sess=%@",myst);
   
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    
    NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:sessiondel_invited]];
    
    //NSURL * url = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/sessiondel_invited.php"];
   
    
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
-(void)invitedParsing{
        [_invitedArray removeAllObjects];
        NSString *savedvalue2=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
        NSString *myst2=[NSString stringWithFormat:@"emailid=%@&session_id=%@",savedvalue2,_session_idstr];//2
        
        
        NSLog(@"MY STATEMENT. course. %@",myst2);
        
        NSURLSessionConfiguration *defaultConfigObject2=[NSURLSessionConfiguration defaultSessionConfiguration];
        
        NSURLSession *defaultSession2=[NSURLSession sessionWithConfiguration:defaultConfigObject2 delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
        
        NSURL * url1 = [NSURL URLWithString:[mainUrl stringByAppendingString:user_invited_get6]];
        
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
                                                 _invitedView.hidden=YES;
                                             }
                                             else{
                                                 _invitedView.hidden=NO;
                                             }
                                             for(NSDictionary *dict in agenda){
                                                 Invited *pi=[[Invited alloc]init];
                                                 pi.invName=dict[@"invited_name"];
                                                 
                                                 NSLog(@".....******%@",pi.invName);
                                                 
                                                 pi.start_time=dict[@"start_time"];
                                                 pi.end_time=dict[@"end_time"];
                                                 pi.roomname=dict[@"roomname"];
                                                 pi.invid=dict[@"invited_id"];
                                                 
                                                 pi.date=dict[@"date"];
                                                 pi.sessionName=dict[@"session_name"];
                                                 pi.nameStr=dict[@"name"];
                                                 pi.invUniversit=dict[@"university"];
                                                 pi.abstract=dict[@"abstract"];
                                                 pi.day=dict[@"day"];
                                                 [self.invitedArray addObject:pi];
                                                 
                                                 NSLog(@"PAPER IDDD=%@",pi.invid);
                                             }
                                             
                                             //[_indicator stopAnimating];
                                             
                                             [self.tableView reloadData];
                                         }];
        [dataTask2 resume];
}
    





-(void)invitedParsing1
{
    [_invitedArray removeAllObjects];
    NSBlockOperation *op1=[NSBlockOperation blockOperationWithBlock:^{
        NSString *savedvalue2=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
        
        
        NSString *myst=[NSString stringWithFormat:@"session_id=%@&emailid=%@",_session_idstr,savedvalue2];
        NSLog(@"POST CONTAINT....%@",myst);
        
        NSURL * urlstr = [NSURL URLWithString:[mainUrl stringByAppendingString:get_invited_schedule]];
        
        // NSString *urlstr=@"http://192.168.1.100/phpmyadmin/itherm/get_invited_schedule.php";
        
        
        
        NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:urlstr];
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
                                        NSString *text=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                        NSLog(@"data.....******=%@",text);
                                        if(data==nil)
                                        {
                                            NSLog(@"Data is nil");
                                            
                                        }
                                        
                                        else
                                        {
                                            
                                            
                                            NSLog(@"%@",response);
                                            
                                            
                                            NSDictionary *outerdic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                            
                                            NSArray *keyarr=[outerdic objectForKey:@"inviteds"];
                                            
                                            if (keyarr.count==0) {
                                                _invitedView.hidden=YES;
                                            }
                                            else{
                                                _invitedView.hidden=NO;
                                            }
                                            
                                            for(NSDictionary *temp in keyarr)
                                            {
                                                NSString *str1=[[temp objectForKey:@"speaker_name"]description];
                                                NSString *str2=[[temp objectForKey:@"invited_id"]description];
                                                NSString *str3=[temp objectForKey:@"invited_name"];
                                                NSString *str4=[temp objectForKey:@"session_id"];
                                                NSString *str5=[temp objectForKey:@"session_name"];
                                                NSString *str6=[temp objectForKey:@"university"];
                                                NSString *str7=[temp objectForKey:@"abstract"];
                                                NSString *str9=[temp objectForKey:@"added"];
                                                NSString *str8=[temp objectForKey:@"images"];
                                                if([[temp objectForKey:@"images"] isEqual:[NSNull null]])
                                                {
                                                    str8=@"chair.png";
                                                }else
                                                {
                                                    str8=[temp objectForKey:@"images"];
                                                }
                                                Invited *i1=[[Invited alloc]init];
                                                i1.nameStr=str1;
                                                i1.invid=str2;
                                                i1.invName=str3;
                                                i1.session_id=str4;
                                                i1.sessionName=str5;
                                                i1.invUniversit=str6;
                                                i1.abstract=str7;
                                                i1.invImage=str8;
                                                i1.added=str9;
                                                [_invitedArray addObject:i1];
                                                
                                            }
                                            //[_indicator stopAnimating];
                                            [_tableView reloadData];
                                            
                                        }
                                        
                                        [_tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
                                    }];
        [task resume];
    }];
    
    [_que addOperation:op1];
}



/*-(void)dataParsing2
 {
 [_invitedArray removeAllObjects];
 NSBlockOperation *op1=[NSBlockOperation blockOperationWithBlock:^{
 NSString *savedvalue2=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
 
 
 NSString *myst=[NSString stringWithFormat:@"session_id=%@&email=%@",_session_idstr,savedvalue2];
 NSLog(@"POST CONTAINT....%@",myst);
 // NSString *urlstr=@"http://192.168.1.100/phpmyadmin/iOSAPI/schedule_invited_info.php";
 //  NSString *urlstr=@"http://siddhantedu.com/iOSAPI/invited_new2.php";//server
 NSString *urlstr=@"http://192.168.1.100/phpmyadmin/itherm/get_invited_schedule.php";
 
 
 
 NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstr]];
 [request setHTTPMethod:@"POST"];
 [request setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
 NSError *error=nil;
 if(error)
 {
 NSLog(@"%@",error.description);
 }
 
 NSURLSessionConfiguration *configuration=[NSURLSessionConfiguration defaultSessionConfiguration];
 
 NSURLSession *session=[NSURLSession sessionWithConfiguration:configuration];
 
 
 //  NSMutableURLRequest *urlrequest=[NSMutableURLRequest requestWithURL:url];
 //        [urlrequest setHTTPMethod:@"POST"];
 //        [urlrequest setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
 //        NSError *error=nil;
 //        if(error)
 //        {
 //            NSLog(@"%@",error.description);
 //        }
 
 
 
 NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
 {
 NSString *text=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
 NSLog(@"data.....******=%@",text);
 if(data==nil)
 {
 NSLog(@"Data is nil");
 
 }
 
 else
 {
 
 
 NSLog(@"%@",response);
 
 
 NSDictionary *outerdic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
 
 NSArray *keyarr=[outerdic objectForKey:@"inviteds"];
 
 for(NSDictionary *temp in keyarr)
 {
 NSString *str1=[[temp objectForKey:@"name"]description];
 NSString *str2=[[temp objectForKey:@"invited_id"]description];
 NSString *str3=[temp objectForKey:@"invited_name"];
 NSString *str4=[temp objectForKey:@"session_id"];
 NSString *str5=[temp objectForKey:@"session_name"];
 NSString *str6=[temp objectForKey:@"university"];
 NSString *str7=[temp objectForKey:@"abstract"];
 NSString *str9=[temp objectForKey:@"added"];
 NSString *str8=[temp objectForKey:@"images"];
 if([[temp objectForKey:@"images"] isEqual:[NSNull null]])
 {
 str8=@"chair.png";
 }else
 {
 str8=[temp objectForKey:@"images"];
 }
 Invited *i1=[[Invited alloc]init];
 i1.nameStr=str1;
 i1.invid=str2;
 i1.invName=str3;
 i1.session_id=str4;
 i1.sessionName=str5;
 i1.invUniversit=str6;
 i1.abstract=str7;
 i1.invImage=str8;
 i1.added=str9;
 [_invitedArray addObject:i1];
 
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
 
 
 -(void)dataParsing1{
 
 [_invitedArray removeAllObjects];
 NSString *savedvalue2=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
 NSString *myst2=[NSString stringWithFormat:@"emailid=%@&session_id=%@",savedvalue2,_session_idstr];//2
 
 
 NSLog(@"MY STATEMENT.. %@",myst2);
 
 NSURLSessionConfiguration *defaultConfigObject2=[NSURLSessionConfiguration defaultSessionConfiguration];
 
 NSURLSession *defaultSession2=[NSURLSession sessionWithConfiguration:defaultConfigObject2 delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
 
 NSURL * url1 = [NSURL URLWithString:[mainUrl stringByAppendingString:user_invited_get6]];
 
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
 NSLog(@"agenda invited count==%lu",(unsigned long)agenda.count);
 
 if (agenda.count==0) {
 _invitedView.hidden=YES;
 }
 else{
 _invitedView.hidden=NO;
 }
 for(NSDictionary *dict in agenda){
 Invited *pi=[[Invited alloc]init];
 pi.invName=dict[@"invited_name"];
 
 NSLog(@".....******%@",pi.invName);
 
 pi.start_time=dict[@"start_time"];
 pi.end_time=dict[@"end_time"];
 pi.roomname=dict[@"roomname"];
 pi.invid=dict[@"invited_id"];
 
 pi.date=dict[@"date"];
 pi.invUniversit=dict[@"university"];
 pi.day=dict[@"day"];
 pi.sessionName=dict[@"session_name"];
 pi.nameStr=dict[@"name"];
 pi.abstract=dict[@"abstract"];
 
 [self.invitedArray addObject:pi];
 
 NSLog(@"invited IDDD=%@",pi.invid);
 }
 
 //[_indicator stopAnimating];
 
 [self.tableView reloadData];
 }];
 [dataTask2 resume];
 
 }

 */


@end
