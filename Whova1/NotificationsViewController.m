

#import "NotificationsViewController.h"
#import "DetailNotiViewController.h"
#import "NotificationsTableViewCell.h"
#import "Notify.h"
#import "Constant.h"
@interface NotificationsViewController ()

@end

@implementation NotificationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.allnotifications=[[NSMutableArray alloc]init];
    [self.tableView setSeparatorColor:[UIColor clearColor]];
    [_tableView setShowsHorizontalScrollIndicator:NO];
    [_tableView setShowsVerticalScrollIndicator:NO];
    _desc.delegate =self;
    
     self.clearBtn.layer.borderColor=(__bridge CGColorRef _Nullable)([UIColor colorWithRed:(88/225.0) green:(211/225.0) blue:(244/255.0)alpha:1]);
    self.clearBtn.layer.cornerRadius=8;
    self.send.layer.cornerRadius=8;
    self.message.layer.borderColor=(__bridge CGColorRef _Nullable)([UIColor lightGrayColor]);
    self.desc.layer.borderColor=(__bridge CGColorRef _Nullable)([UIColor lightGrayColor]);
    
    
    self.navigationItem.backBarButtonItem.title=@"Back";
    UIBarButtonItem *newBackButton =
    [[UIBarButtonItem alloc] initWithTitle:@""
                                     style:UIBarButtonItemStylePlain
                                    target:nil
                                    action:nil];
    [[self navigationItem] setBackBarButtonItem:newBackButton];
}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    _desc.text = @"";
    _desc.textColor = [UIColor blackColor];
    return YES;
}

-(void)viewWillAppear:(BOOL)animated
{
     [self dataFetching];
    [self clearRecords];
    [self sendReadStatus];
    //[_allnotifications removeAllObjects];
    [_tableView reloadData];
    
   
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allnotifications.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NotificationsTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    

   // cell.notification.text=@"hi";
    Notify *obj=self.allnotifications[indexPath.row];
    cell.notification.text=obj.notification_name;
    cell.desc.text=obj.notify_description;
    cell.date.text=obj.date;
    cell.notify_time.text=obj.notify_time;
    cell.notify_id.text=obj.notify_id;
    //NSLog(@"time====%@",obj.notify_time);
   
    
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
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NotificationsTableViewCell *cell=[_tableView cellForRowAtIndexPath:indexPath];
    _tempname=cell.notification.text;
   // NSLog(@"****%@",cell.notification.text);
    _tempdesc=cell.desc.text;
    _tempdate=cell.date.text;
    _temptime=cell.notify_time.text;
    //NSLog(@"****%@",cell.notify_time.text);
     _tempnotify_id=cell.notify_id.text;
    NSLog(@"did select decricption==%@",_tempdesc);
    
    NSString *currentMessage=_tempnotify_id;
    

    if([currentMessage isEqualToString:@"0"])
    {
        [cell.notification setFont:[UIFont boldSystemFontOfSize:16]];
        [cell.notification setTextColor:[UIColor blueColor]];
    }
    else {
        [cell.notification setFont:[UIFont systemFontOfSize:16]];
        [cell.notification setTextColor:[UIColor blackColor]];
    }
    
   // [self sendReadStatus];
    
    [self performSegueWithIdentifier:@"showDetailnotification" sender:nil];

    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier]isEqualToString:@"showDetailnotification"])
    {
    DetailNotiViewController *d=[segue destinationViewController];
    d.namestr=_tempname;
    d.descstr=_tempdesc;
    d.timestr=_temptime;
    d.datestr=_tempdate;
    d.notifystr=_tempnotify_id;
        NSLog(@"decricption==%@",d.descstr);
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
                               
                                    [self clearRecords];
                                    NSLog(@"you pressed Yes,please button");
                                 
                                }];
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"No, thanks"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               {
                       
                                   NSLog(@"you pressed No,thanks button");
                                
                               }];
    
    [alert addAction:yesButton];
    [alert addAction:noButton];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}
-(void)dataFetching
{
    [_allnotifications removeAllObjects];
    
    NSString *savedvalue=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];//1 email-id is used to save in user defaults,this can be done to store value once and can be used anywhere where we required
    NSString *myst=[NSString stringWithFormat:@"emailid=%@",savedvalue];//2
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:user_notification_get3]];
    
    // NSURL * url = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/user_notification_get3.php"];
    
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
                    Notify *obj=[[Notify alloc]init];
                    obj.notification_name=dict[@"name"];
                    obj.date=dict[@"date"];
                    obj.notify_time=dict[@"time"];
                    NSLog(@"aaaaaaa%@",obj.notify_time);
                    obj.notify_description=dict[@"description"];
                    obj.read=dict[@"read"];
                    obj.notify_id=dict[@"notification_id"];
                    obj.unread_count=dict[@"unread_count"];
                    
                    NSLog(@"****UnRead Count=.......%@",obj.unread_count);
                    NSLog(@"****Read=.......%@",obj.read);
                    NSLog(@"****Notification id=.......%@",obj.notify_id);
                    
                    
                    [self.allnotifications addObject:obj];
                    //[indicator stopAnimating];
                }
                [self.tableView reloadData];
            }
            [self.tableView reloadData];
        }
        
        

    }];
    
    [dataTask resume];

    
    
}
-(void)clearRecords

{
    
    [_allnotifications removeAllObjects];
    //NSLog(@"BUTTON CLICK...");
    
    NSString *savedValue=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];//used to retrieve user's emailid which we have stored in nsuserdefaults for key email(those user login dat person mail id will get using userdefaults)
    
    NSString *myst=[NSString stringWithFormat:@"emailid=%@",savedValue];
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:user_clear_notification]];
    
      //NSURL * url = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/user_clear_notification.php"];
  
    
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
                                  
                                     [self.tableView reloadData];
                                }];
    [task resume];
    
   // [self.navigationController popViewControllerAnimated:YES];
    //[self viewWillAppear:YES];
    
}
- (IBAction)sendclicked:(id)sender {
    
    NSString *myst=[NSString stringWithFormat:@"title=%@&body=%@",self.message.text,self.desc.text];
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    if(self.message.text.length > 0)
    {
        
        NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:sendnotification]];
        
       // NSURL * url = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/sendnotification.php"];

        NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
        [urlRequest setHTTPMethod:@"POST"];
        [urlRequest setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if(error == nil)
            {
                
                NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                NSLog(@"data=%@",text);
                
            }
            
            
        }];
        
        [dataTask resume];
        
        NSString *mystring=[NSString stringWithFormat:@"message=%@&description=%@",self.message.text,self.desc.text];
        
        
        NSURLSession *Session = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        
        NSURL * myurl = [NSURL URLWithString:[mainUrl stringByAppendingString:notification2]];
        
       // NSURL * myurl = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/notification2.php"];
        
        NSLog(@"mystring ....> %@",mystring);
       
        NSMutableURLRequest * myurlRequest = [NSMutableURLRequest requestWithURL:myurl];
        [myurlRequest setHTTPMethod:@"POST"];
        [myurlRequest setHTTPBody:[mystring dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        NSURLSessionDataTask * mydataTask =[Session dataTaskWithRequest:myurlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if(error == nil)
            {
                
                NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                NSLog(@"text===%@",text);
                
            }
            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Success" message:@"Notification has been sent successfully." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                            
                                     [self viewWillAppear:YES];
                                     
                                     _message.text=@"";
                                     _desc.text=@"";
                                 }];
            
            
            [alertView addAction:ok];
            
            
            [self presentViewController:alertView animated:YES completion:nil];
            
        }];
        
        [mydataTask resume];
    }
    
    
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
   // NSURL *url=[NSURL URLWithString:@"http://www.siddhantedu.com/iOSAPI/Symp/read_notification.php"];
    
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



@end
