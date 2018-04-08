//  DetaiScheduleViewController.m
//  ITherm
//
//  Created by Anveshak on 5/8/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import "DetaiScheduleViewController.h"
#import "DetailScheduleTableViewCell.h"
#import "Paper_itherm.h"
#import "ScheduleTableViewCell.h"
#import "PaperSchViewController.h"
#import "Constant.h"
@interface DetaiScheduleViewController ()

@end

@implementation DetaiScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[_indicator startAnimating];
    _tableVIew.delegate=self;
    _tableVIew.dataSource=self;
    
    _sessionLbl.text=_tempsessionName;
    _startTime.text=_startstr;
    _endTime.text=_endstr;
    _locationName.text=_locstr;
    
    NSLog(@"%@",_tempsessionName);
    NSLog(@"...%@",_tempsessionid);
    _pprarr=[[NSMutableArray alloc]init];
    _categoryStr=@"Session";
    
    NSLog(@"category String,....%@",_categoryStr);
    
     [self.tableVIew setSeparatorColor:[UIColor clearColor]];
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [self paperParsing];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _pprarr.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailScheduleTableViewCell *cell=[_tableVIew dequeueReusableCellWithIdentifier:@"cell"];
    Paper_itherm *p=[_pprarr objectAtIndex:indexPath.row];
    cell.paperNameLbl.text=p.paper_name;
    cell.paperid.text=p.paper_id;
    NSLog(@"CELL PAPER ID=%@",p.paper_name);
    if([p.paper_abstract isEqual:[NSNull null]])
    {
        cell.abstractLbl.text=@"--";
    }
    else
    {
    cell.abstractLbl.text=p.paper_abstract;
    }
    cell.deletebtn.tag=indexPath.row;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailScheduleTableViewCell *cell=[_tableVIew cellForRowAtIndexPath:indexPath];
    //cell.abstractLbl.text=_tempabstr;
    _tempabstr=cell.abstractLbl.text;
    _paperidstr=cell.paperid.text;
    _paperstr=cell.paperNameLbl.text;
    
    NSLog(@"Paper%@",_paperstr);
    
    [self performSegueWithIdentifier:@"showSchPaper" sender:self];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
        if([[segue identifier]isEqualToString:@"showSchPaper"])
        {
            PaperSchViewController *avc=[segue destinationViewController];
           
            avc.abstractstr=_tempabstr;
            avc.tempSessionName=_tempsessionName;
            avc.locationstr=_locstr;
            avc.starttimestr=_startstr;
            avc.endtimestr=_endstr;
            avc.paper=_paperstr;
            avc.paperidstr=_paperidstr;
            avc.sessionidStr=_tempsessionid;
            NSLog(@"PAPER ID==%@ & PAPER NAME=%@ & session_id=%@",_paperidstr,_paperstr,_tempsessionid);

        }
}

-(void)paperParsing
{
    [_pprarr removeAllObjects];
    NSString *savedvalue2=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
    NSString *myst2=[NSString stringWithFormat:@"emailid=%@&session_id=%@",savedvalue2,_tempsessionid];//2
    
    
    NSLog(@"MY STATEMENT.. %@",myst2);
    
    NSURLSessionConfiguration *defaultConfigObject2=[NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *defaultSession2=[NSURLSession sessionWithConfiguration:defaultConfigObject2 delegate:nil delegateQueue:[NSOperationQueue mainQueue]];

    NSURL * url1 = [NSURL URLWithString:[mainUrl stringByAppendingString:user_paper_get6]];
    
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
                                             _paperView.hidden=YES;
                                         }
                                         else{
                                              _paperView.hidden=NO;
                                         }
                                         for(NSDictionary *dict in agenda){
                                             Paper_itherm *pi=[[Paper_itherm alloc]init];
                                             pi.paper_name=dict[@"paper_name"];
                                             
                                             NSLog(@".....******%@",pi.paper_name);
                                             
                                             pi.start_time=dict[@"start_time"];
                                             pi.end_time=dict[@"end_time"];
                                             pi.room_name=dict[@"room_name"];
                                             pi.paper_id=dict[@"paper_id"];

                                             pi.date=dict[@"date"];
                                             pi.paper_abstract=dict[@"paper_abstract"];
                                             pi.day=dict[@"day"];
                                             [self.pprarr addObject:pi];
                                             
                                             NSLog(@"PAPER IDDD=%@",pi.paper_id);
                                         }
                                         
                                         //[_indicator stopAnimating];
                                             
                                             [self.tableVIew reloadData];
                                     }];
    [dataTask2 resume];
}




- (IBAction)cellDeleteBtnClick:(id)sender {
    
    UIButton *btn=(UIButton *)sender;
    NSLog(@"%ld",(long)btn.tag);

    Paper_itherm *s3=self.pprarr[btn.tag];
    
    NSLog(@"paper id is=%@",s3.paper_id);
    
    
    
    UIAlertController * alert=[UIAlertController
                               
                               alertControllerWithTitle:@"ALERT" message:@"Do You Want To Delete Record?"preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes, please"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    
                                    Paper_itherm *s2=self.pprarr[btn.tag];
                                    NSLog(@"%@",s2);
                                    [_pprarr removeObjectAtIndex:btn.tag];
                                    
                                    NSLog(@"paper id is=%@",s3.paper_id);
                                    NSString *savedValue=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
                                    
                                    NSString *myst=[NSString stringWithFormat:@"emailid=%@&paper_id=%@&session_id=%@",savedValue,s3.paper_id,_tempsessionid];
                                    NSLog(@"my string after delete=%@",myst);
                                    // NSString *myst=[NSString stringWithFormat:@"emailid=rohini@anveshak.com & session_id=s2"];
                                    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
                                    NSURLSession *session=[NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
                                    
                                    NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:paperdel]];
                                    
                                   // NSURL * url = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/paperdel.php"];
                                 
                                    
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
                                                                    [_tableVIew reloadData];
                                                                    
                                                                }];
                                    [_tableVIew reloadData];
                                    
                                    if(_pprarr.count == 0)
                                    {
                                        self.paperView.hidden = YES;
                                    }
                                    else
                                    {
                                        self.paperView.hidden = NO;
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
    
    NSString *myst=[NSString stringWithFormat:@"emailid=%@&session_id=%@&category=%@",savedValue,_tempsessionid,_categoryStr];
    
     NSLog(@"my string in schedule paper=%@",myst);
    
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    
    NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:sessiondel]];
    
 //NSURL * url = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/sessiondel.php"];
 
    
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

@end
