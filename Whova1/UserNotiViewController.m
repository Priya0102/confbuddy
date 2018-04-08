
//  UserNotiViewController.m
//  ITherm
//  Created by Anveshak on 5/17/17.
//  Copyright © 2017 Anveshak . All rights reserved.

#import "UserNotiViewController.h"
#import "DetailNotiViewController.h"
#import "NotificationsTableViewCell.h"
#import "Constant.h"
#import "LatestNotify.h"
#import "LatestNotificationCell.h"
#import "AfterLoginMainViewController.h"
@interface UserNotiViewController ()

@end

@implementation UserNotiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    self.allnotifications=[[NSMutableArray alloc]init];
    [_tableview2 setShowsHorizontalScrollIndicator:NO];
    [_tableview2 setShowsVerticalScrollIndicator:NO];
    _clearBtn.layer.cornerRadius=8;
    
    
    _tableview1.delegate=self;
    _tableview1.dataSource=self;
    _tableview1.scrollEnabled=NO;
    
    _tableview2.delegate=self;
    _tableview2.dataSource=self;
    
    _latestNotification=[[NSMutableArray alloc]init];
    
   
    self.navigationController.delegate = self;

}


-(void)viewWillAppear:(BOOL)animated
{
    [self dataFetching];
    [self dataFetchingLatest];
    [self sendReadStatus];
   // [_allnotifications removeAllObjects];
    [_tableview2 reloadData];
    [_tableview1 reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView==self.tableview2) {
        return 1;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView==self.tableview2) {
    return self.allnotifications.count;
    }
    return _latestNotification.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (tableView==self.tableview2) {
        
    NotificationsTableViewCell *cell = [self.tableview2 dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    // cell.notification.text=@"hi";
    Notify *obj=self.allnotifications[indexPath.row];
    cell.notification.text=obj.notification_name;
    cell.desc.text=obj.notify_description;
    cell.date.text=obj.date;
    cell.notify_time.text=obj.notify_time;
    cell.notify_id.text=obj.notify_id;
    NSLog(@"time====%@",obj.notify_time);
    
    NSString *currentMessage=obj.read;
    
    if([currentMessage isEqualToString:@"0"])
    {
        [cell.notification setFont:[UIFont boldSystemFontOfSize:16]];
        [cell.notification setTextColor:[UIColor colorWithRed:(20/225.0) green:(72/225.0) blue:(114/255.0)alpha:1]];//uncoment dis if read status color required blue
        [cell.notification setTextColor:[UIColor blackColor]];
    }
    else {
        [cell.notification setFont:[UIFont systemFontOfSize:16]];
        [cell.notification setTextColor:[UIColor blackColor]];
    }
    }
    else if(tableView==self.tableview1){
        
        LatestNotificationCell *cell=[self.tableview1 dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
        LatestNotify *obj=self.latestNotification[indexPath.row];
        cell.notification.text=obj.notification_name;
        cell.desc.text=obj.notify_description;
        cell.date.text=obj.date;
    }
    return cell;
    
    
    /*
     
     NotificationsTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
     // cell.notification.text=@"hi";
     Notify *obj=self.allnotifications[indexPath.row];
     cell.notification.text=obj.notification_name;
     cell.desc.text=obj.notify_description;
     cell.date.text=obj.date;
     cell.notify_time.text=obj.notify_time;
     cell.notify_id.text=obj.notification_id;
     NSLog(@"time====%@",obj.notify_time);
     
     NSString *currentMessage=obj.read;
     
     if([currentMessage isEqualToString:@"0"])
     {
     [cell.notification setFont:[UIFont boldSystemFontOfSize:16]];
     [cell.notification setTextColor:[UIColor blueColor]];
     }
     else {
     [cell.notification setFont:[UIFont systemFontOfSize:16]];
     [cell.notification setTextColor:[UIColor blackColor]];
     }
     
     return cell;
     */
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NotificationsTableViewCell *cell=[_tableview2 cellForRowAtIndexPath:indexPath];
//    _tempname=cell.notification.text;
//    NSLog(@"****temp notification name %@",cell.notification.text);
//    _tempdesc=cell.desc.text;
//    _tempdate=cell.date.text;
//    _temptime=cell.notify_time.text;
//    _tempnotify_id=cell.notify_id.text;
//    
    
    Notify *n=[_allnotifications objectAtIndex:indexPath.row];
    _tempname=n.notification_name;
    _tempdesc=n.notify_description;
    _tempdate=n.date;
    _temptime=n.notify_time;
    _tempnotify_id=n.notify_id;
    
    NSLog(@"****name==%@",_tempname);
    NSLog(@"did select decricption==%@",_tempdesc);
    
//    NSString *currentMessage=_tempnotify_id;
//    
//    if([currentMessage isEqualToString:@"0"])
//    {
//        [cell.notification setFont:[UIFont boldSystemFontOfSize:16]];
//        [cell.notification setTextColor:[UIColor blueColor]];
//    }
//    else {
//        [cell.notification setFont:[UIFont systemFontOfSize:16]];
//        [cell.notification setTextColor:[UIColor blackColor]];
//    }
//    
    //[self sendReadStatus];

    
   [self performSegueWithIdentifier:@"showdetailNotification" sender:nil];
    
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier]isEqualToString:@"showdetailNotification"])
    {
        DetailNotiViewController *d=[segue destinationViewController];
        d.namestr=_tempname;
        d.descstr=_tempdesc;
        d.timestr=_temptime;
        d.datestr=_tempdate;
        d.notifystr=_tempnotify_id;
        
        NSLog(@"segue decricption==%@",d.descstr);
    }
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return  YES;
}
- (IBAction)clearBtnClicked:(id)sender {
    
    
    UIAlertController * alert=[UIAlertController
                               
                               alertControllerWithTitle:@"ALERT" message:@"Do You Want To Clear All Notification?"preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes, please"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    //What we write here????????**
                                    [self clearRecords];
                                    NSLog(@"you pressed Yes,please button");
                                    // call method whatever u need
                                }];
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"No, thanks"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               {
                                   //What we write here????????**
                                   NSLog(@"you pressed No,thanks button");
                                   // call method whatever u need
                               }];
    
    [alert addAction:yesButton];
    [alert addAction:noButton];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}
-(void)dataFetching
{
    [_allnotifications removeAllObjects];
    
    NSString *savedvalue=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
    
    NSString *myst=[NSString stringWithFormat:@"emailid=%@",savedvalue];//2
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:user_notification_get3]];
  
    //NSURL * url = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/user_notification_get3.php"];

      //NSURL * url = [NSURL URLWithString:@"http://www.siddhantedu.com/iOSAPI/user_notification_get2.php"];//server
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    
    [urlRequest setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
    NSError *error=nil;
    if (error) {
        NSLog(@"%@",error.description);
    }
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(error == nil)
        {
            
            NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
            NSLog(@"data=%@",text);
            NSError *er=nil;
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&er];
            
            NSLog(@"....%@",responseDict);
            if(er)
            {
            }
            NSArray *mynotification=[responseDict objectForKey:@"all_notifications"];
            
            NSLog(@"Notification count %lu",(unsigned long)mynotification.count);
            
            if(mynotification.count==0)
            {
                _latestUpdateLbl.hidden=YES;
                _allNotifiLabel.hidden=YES;
                _clearBtn.hidden=YES;
                _tableview2.hidden=YES;
                _tableview1.hidden=YES;
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:nil message:@"No New Notifications" preferredStyle:UIAlertControllerStyleAlert];
                
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
            else{
                
                for(NSDictionary * dict in mynotification)
                {
                    Notify *obj=[[Notify alloc]init];
                    obj.notification_name=dict[@"name"];
                    obj.date=dict[@"date"];
                    obj.notify_time=dict[@"time"];
                    NSLog(@"aaaaaaa%@",obj.notify_time);
                    obj.notify_description=dict[@"description"];
                    obj.read=dict[@"read"];
                    obj.notify_id=dict[@"notification_id"];
                    
                    [self.allnotifications addObject:obj];
                    //[indicator stopAnimating];
                }
                [self.tableview2 reloadData];
            }
            [self.tableview2 reloadData];
        }
        
        
        
    }];
    
    [dataTask resume];
    
    
    
}
-(void)dataFetchingLatest
{
    [_latestNotification removeAllObjects];
    
    NSString *savedvalue=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
    
    NSString *myst=[NSString stringWithFormat:@"emailid=%@",savedvalue];//2
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:user_notification_get3]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    
    [urlRequest setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
    NSError *error=nil;
    if (error) {
        NSLog(@"%@",error.description);
    }
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(error == nil)
        {
            
            NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
            NSLog(@"data=%@",text);
            NSError *er=nil;
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&er];
            
            NSLog(@"....%@",responseDict);
            if(er)
            {
            }
            NSArray *mynotification=[responseDict objectForKey:@"all_notifications"];
            
            NSLog(@"Notification count %lu",(unsigned long)mynotification.count);
            
            if(mynotification.count==0)
            {
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:nil message:@"No New Notifications" preferredStyle:UIAlertControllerStyleAlert];
                
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
            else{
                
                for(NSDictionary * dict in mynotification)
                {
                    LatestNotify *obj=[[LatestNotify alloc]init];
                    obj.notification_name=dict[@"name"];
                    obj.date=dict[@"date"];
                    obj.notify_time=dict[@"time"];
                    NSLog(@"aaaaaaa%@",obj.notify_time);
                    obj.notify_description=dict[@"description"];
                    obj.read=dict[@"read"];
                    obj.notification_id=dict[@"notification_id"];
                    
                    [self.latestNotification addObject:obj];
                    //[indicator stopAnimating];
                }
                [self.tableview1 reloadData];
            }
            [self.tableview1 reloadData];
        }
        
        
        
    }];
    
    [dataTask resume];
    
    
    
}

-(void)clearRecords

{
    
    [_allnotifications removeAllObjects];
    NSLog(@"BUTTON CLICK...");
    
    NSString *savedValue=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
    
    NSString *myst=[NSString stringWithFormat:@"emailid=%@",savedValue];
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:user_clear_notification]];
    
//NSURL * url = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/user_clear_notification.php"];

    
    //NSURL * url = [NSURL URLWithString:@"http://www.siddhantedu.com/iOSAPI/user_clear_notification.php"];
    
    
    NSMutableURLRequest *urlrequest=[NSMutableURLRequest requestWithURL:url];
    [urlrequest setHTTPMethod:@"POST"];
    [urlrequest setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
    NSError *error=nil;
    if(error)
    {
        NSLog(@"%@",error.description);
    }
    
    NSURLSessionDataTask *task=[defaultSession dataTaskWithRequest:urlrequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
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
                                    
                                    [self.tableview2 reloadData];
                                }];
    [task resume];
    
    [self.navigationController popViewControllerAnimated:YES];
    [self viewWillAppear:YES];
    
}
-(void)sendReadStatus
{
    NSString *savedValue=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
    
    NSString *myst=[NSString stringWithFormat:@"emailid=%@&notification_id=%@",savedValue,_tempnotify_id];
    NSLog(@"my string notify id*****=%@",myst);
 
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    
    NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:read_notification]];
    
     //NSURL * url = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/read_notification.php"];
    
    //NSURL *url=[NSURL URLWithString:@"http://www.siddhantedu.com/iOSAPI/Symp/read_notification.php"];
    
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
                                            
                                            NSLog(@"read text success.......");
                                            
                                        }
                                        else
                                        {
                                            NSLog(@"Error while reading text.......");
                                        }
                                    });
                                    
                                    NSLog(@"json = %@",responsedict);
                                    
                                    
                                }];
    [task resume];
}

//- (void) checkButtonClick:(id)sender {
//    
//    //get reference to the button that requested the action
//   // UIBarButtonItem *myButton = (UIBarButtonItem *)sender;
//   // NSLog(@"Clicked on one of the toolbar buttons");
//    
//    //check which button it is, if you have more than one button on the screen
//    //you must check before taking necessary action
////    switch (myButton.tag) {
////       
////            
////        case 1:
////            
//            //if the last view controller doesn't exists create it
//            if(self.detailnotification == nil){
//                DetailNotiViewController *lastView = [[DetailNotiViewController alloc] init];
//                self.detailnotification = lastView;
//            }
//            
//        {
//            //customize the back button, you must set this before pushing the latest view into the stack
//            UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle: @"Go Back"
//                                                                           style: UIBarButtonItemStylePlain
//                                                                          target: nil
//                                                                          action: nil];
//            
//            [self.navigationItem setBackBarButtonItem: backButton];
//        }
//            
//            //tell the navigation controller to push a new view into the stack
//            [self.navigationController pushViewController:self.detailnotification animated:YES];
////            break;
////            
////        case 3:
////            //pop the current view from the stack
////            [self.navigationController popViewControllerAnimated:YES];
////            
////        default:
////            break;
// //   }
//    
//}



@end
