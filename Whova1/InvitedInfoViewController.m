//
//  InvitedInfoViewController.m
//  ITherm
//
//  Created by Anveshak on 5/18/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import "InvitedInfoViewController.h"
#import "InvitedTableViewCell.h"
#import "Invited.h"
#import "InvitedDetailViewController.h"
#import "Constant.h"
#define SYSTEM_VERSION_GREATERTHAN_OR_EQUALTO(v) ([[[UIDevice currentDevice]systemVersion] compare:v options:NSNumericSearch]!=NSOrderedAscending)

@interface InvitedInfoViewController ()

@end

@implementation InvitedInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView setSeparatorColor:[UIColor clearColor]];
    
    
    [_invitedArray removeAllObjects];
    [_indicator startAnimating];
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
    
    
    NSLog(@"SESSION ID INVITED%@",_session_idstr);

    self.setButton.layer.masksToBounds=YES;
    //self.setButton.layer.borderColor=[UIColor blueColor].CGColor;
   // self.setButton.layer.borderWidth=1.1;
   // self.setButton.layer.cornerRadius=10;
    
    self.viewMap.layer.masksToBounds=YES;
    self.viewMap.layer.borderColor=[UIColor colorWithRed:20.0/255.0 green:72.0/255.0 blue:114.0/255.0 alpha:1.0].CGColor;
    self.viewMap.layer.borderWidth=1.1;
    self.viewMap.layer.cornerRadius=10;
    
}
-(void)viewWillAppear:(BOOL)animated{
 
     [self dataParsing];
    //[self getInvitedDetailStatus];
    //[self.tableView reloadData];
    
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
    InvitedTableViewCell *cell=[_tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    Invited *inv=[_invitedArray objectAtIndex:indexPath.row];
    [_indicator stopAnimating];
    cell.invitedName.text=inv.invName;
    cell.tickButton.tag=indexPath.row;
    cell.invitedid.text=inv.invid;

    NSString *tempadd=inv.added;
    NSString *pprid=inv.paper_id;
    
    if ([tempadd isEqual:[NSNull null]]) {
        NSLog(@"Tempdata is null.....");
        [cell.tickButton setImage:[UIImage imageNamed:@"addNew.png"] forState:UIControlStateNormal];
        [cell.tickButton setUserInteractionEnabled:YES];
    }
    else{
        NSLog(@"Show blue.......");
        // [_tickarray addObject:tempadd];
        [cell.tickButton setImage:[UIImage imageNamed:@"addedNew.png"] forState:UIControlStateNormal];
        [cell.tickButton setUserInteractionEnabled:NO];
        //         NSLog(@"tick array value********%@",_tickarray[indexPath.row]);
    }
    
    
    NSLog(@"Array Length : %lu",(unsigned long)_tickarray.count);
    for(int i=0;i<_tickarray.count;i++)
    {
        NSString *str;
        str=[NSString stringWithFormat:@"%@",_tickarray[i]];
        
        NSLog(@". Paper id in scroll....paper id in tick array  %@..%@..at location %d",pprid,str,i);
        if([str isEqualToString:pprid])
        {
            NSLog(@". print tick..%@..%@",pprid,str);
            [cell.tickButton setImage:[UIImage imageNamed:@"addedNew.png"] forState:UIControlStateNormal];
            
            
        }
        
        
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Invited *i=[_invitedArray objectAtIndex:indexPath.row];
   
    _tempimg=i.invImage;
    _tempuni=i.invUniversit;
    _tempabstract=i.abstract;
    _tempsession=i.sessionName;
    _tempTalkName=i.invName;
    _tempSpeakerName=i.nameStr;
    _tempTalkid=i.invid;
    _session_idstr=i.session_id;
 
    [self performSegueWithIdentifier:@"showInvitedDetail" sender:nil];
    
}
- (IBAction)setButton:(id)sender {
    
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
    
    UIButton *btn =(UIButton *)sender;
    
    NSLog(@"Btn Click...........%ld",(long)btn.tag);
    
    //Paper_itherm *p2=self.all_papers[btn.tag];
    
    NSLog(@"* set alarm btn click");
    
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
                                        
                                        NSLog(@"you pressed Yes, please button");
                                        
                                        for(int i=0;i<_tickarray.count;i++)
                                        {// 2
                                            NSLog(@"***********************************%@",_tickarray[i]);
                                            
                                            NSString *invitedid=[NSString stringWithFormat:@"%@",_tickarray[i]];
                                            
                                            Invited *p2=self.invitedArray[btn.tag];
                                            NSLog(@"******alarm btn click");
                                            NSLog(@"%@paper...............",p2);
                                            [self.invitedArray addObject:p2];//sending object directly to array for getting user sessions as per user cliked
                                            
                                            NSLog(@"%@",p2.start_time);
                                            if(SYSTEM_VERSION_GREATERTHAN_OR_EQUALTO(@"10.0"))
                                            { //3
                                                UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
                                                [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert)
                                                                      completionHandler:^(BOOL granted, NSError * _Nullable error) {
                                                                          if (!error) {
                                                                              NSLog(@"request authorization succeeded!");
                                                                              // [self showAlert];
                                                                              [btn setBackgroundImage:[UIImage imageNamed:@"addedNew.png"] forState:UIControlStateNormal];
                                                                              [self.tableView reloadData];
                                                                              
                                                                          }
                                                                          else
                                                                          {
                                                                              NSLog(@"user notification failed");
                                                                          }
                                                                      }];
                                            }
                                            else
                                            {
                                                
                                                
                                            }
                                            
                                            //    [sender setUserInteractionEnabled:NO];
                                            //    [sender setEnabled:NO];
                                            
                                            NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
                                            NSURLSession *session=[NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
                                            
                                            
                                            
                                            NSString *savedValue=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];//used to retrieve user's emailid which we have stored in nsuserdefaults for key email(those user login dat person mail id will get using userdefaults)
                                            
                                            NSString *myst=[NSString stringWithFormat:@"emailid=%@&invited_id=%@&session_id=%@",savedValue,invitedid,_session_idstr];
                                            
                                            NSLog(@"Invited My SAtatement...***%@",myst);
                                         
                                            NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:schedule_invited]];
                                            
                                         //   NSURL *url=[NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/schedule_invited.php"];
                                            
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{


    if([[segue identifier] isEqualToString:@"showInvitedDetail"]){
        InvitedDetailViewController *tlk=[segue destinationViewController];
        
        tlk.temptalkname=_tempTalkName;
        tlk.abstractstr=_tempabstract;
        tlk.tempSpeakerName=_tempSpeakerName;
        tlk.universitystr=_tempuni;
        tlk.sess_namestr=_sessNamestr;
        tlk.locationstr=_locationstr;
        tlk.tempTalkid=_tempTalkid;
        tlk.starttimestr=_stime;
        tlk.endtimestr=_etime;
        tlk.sessionidstr=_session_idstr;
        
}

}

-(void)dataParsing
{
    [_invitedArray removeAllObjects];
    NSBlockOperation *op1=[NSBlockOperation blockOperationWithBlock:^{
        NSString *savedvalue2=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
    
    
    NSString *myst=[NSString stringWithFormat:@"session_id=%@&email=%@",_session_idstr,savedvalue2];
    NSLog(@"POST CONTAINT....%@",myst);
    
        NSURL * urlstr = [NSURL URLWithString:[mainUrl stringByAppendingString:invited_info]];
        
       // NSString *urlstr=@"http://192.168.1.100/phpmyadmin/itherm/invited_info.php";
        

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
    
                                        
                                        }
                                        
                                        [_tableView reloadData];
                                    }
                                  
                                    [_tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
                                }];
    [task resume];
    }];
    
    [_que addOperation:op1];
}




-(IBAction)tickButtonClick:(id)sender {
    
    UIButton *btn =(UIButton *)sender;
    Invited *inv=self.invitedArray[btn.tag];
    [btn setUserInteractionEnabled:YES];
    if([[btn imageForState:UIControlStateNormal]isEqual:[UIImage imageNamed:@"addNew.png"]])
    {
        [btn setImage:[UIImage imageNamed:@"addedNew.png"] forState:UIControlStateNormal];
        NSLog(@"gray tick clicked...");
        NSLog(@"PAPER ID:-...%@",inv.invid);
        NSString *str=[NSString stringWithFormat:@"%@",inv.invid];
        [_tickarray addObject:str];
        
        NSLog(@"after adding count is %lu",(unsigned long)_tickarray.count);
        
    }
    
    else
    {
        [btn setUserInteractionEnabled:NO];
        [btn setImage:[UIImage imageNamed:@"addNew.png"] forState:UIControlStateNormal];
        
        NSLog(@"blue tick clicked...");
        NSString *str=[NSString stringWithFormat:@"%@",inv.invid];
        if([_tickarray isEqual:[NSNull null]])
        {
            NSLog(@"Array is EMPTY");
        }
        else
        {
            [_tickarray removeObject:str];
            
            NSLog(@"after removing count is%lu",(unsigned long)_tickarray.count);
            
        }
    }
    
    
    
    NSLog(@"Btn Click...........%ld",(long)btn.tag);
    
}
/*-(void)getInvitedDetailStatus{
    
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    
    NSString *savedValue=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
    
    NSString *invid=[[NSUserDefaults standardUserDefaults]stringForKey:@"invitedid"];
    
    NSString *myst=[NSString stringWithFormat:@"emailid=%@&invited_id=%@&session_id=%@",savedValue,invid,_session_idstr];
    
    NSLog(@"****Get invited details status SAtatement...***%@",myst);
    
    NSURL * url = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/get_invited_details_status.php"];//local
    
    
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
//                                    self.liked=[responsedict objectForKey:@"liked"];
                                    self.added=[responsedict objectForKey:@"added"];
                                    
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        
                                        if([self.success isEqualToString:@"1"] && [self.added isEqualToString:@"1"])
                                        {
                                            NSLog(@"Show blue clicked tick.......");
//                                            [_setButton setImage:[UIImage imageNamed:@"added.png"] forState:UIControlStateNormal];
//                                            [_setButton setUserInteractionEnabled:NO];
//                                            
                                            
                                        }
                                        else
                                        {
//                                            [_setButton setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
//                                            [_setButton setUserInteractionEnabled:YES];
                                        
                                            
                                        }
                                    });
                                    
                                    NSLog(@"json course add to myschedule = %@",responsedict);
                                    
                                }];
    [task resume];
}
*/

@end
