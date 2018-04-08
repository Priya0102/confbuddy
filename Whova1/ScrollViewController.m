


#import "ScrollViewController.h"
#import "Constant.h"
@interface ScrollViewController ()

@end

@implementation ScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [_scrollView setShowsHorizontalScrollIndicator:NO];
    [_scrollView setShowsVerticalScrollIndicator:NO];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    

    // Do any additional setup after loading the view.
    
    Attendee *a1=[[Attendee alloc]init];
    
    self.myprofile=[[NSMutableArray alloc]init];
    NSString *savedValue = [[NSUserDefaults standardUserDefaults] stringForKey:@"email"];
    
    
    NSString *myst=[NSString stringWithFormat:@"emailid=%@",savedValue];
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
 
  NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:getprofile]];
    
    //NSURL * url = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/getprofile.php"];


    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
    NSError *error=nil;
    if(error)
    {
    }
    
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                      {
                                          if(error)
                                          {
                                          }
                                          
                                          NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                                          NSError *er=nil;
                                          NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&er];
                                          if(er)
                                          {
                                          }
                                          
                                          NSArray *myattend=[responseDict objectForKey:@"attendees"];
                                         
                                          for(NSDictionary * dict in myattend)
                                          {
                                              
                                              a1.first_name=dict[@"first_name"];
                                              a1.last_name=[dict objectForKey:@"last_name"];
                                              a1.salutation=[dict objectForKey:@"salutation"];
                                              a1.mobile_no=[dict objectForKey:@"mobile_no"];
                                              a1.country_name=[dict objectForKey:@"country_name"];
                                              a1.role_name=[dict objectForKey:@"role_name"];
                                              a1.emailid=[dict objectForKey:@"emailid"];
                                              a1.role_name=[dict objectForKey:@"role_name"];
                                              a1.affiliation=[dict objectForKey:@"affiliation"];
                                              a1.fax=dict[@"fax"];
                                              //   a1.mainid=dict[@"id"];
                                              a1.userid=dict[@"user_id"];
                                              self.userid=dict[@"user_id"];
                                              // self.myid=dict[@"id"];
                                           
                                              [self.myprofile addObject:a1];
                                             
                                          }
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              
                                              if(a1.first_name==(NSString *) [NSNull null])
                                              {
                                                  a1.first_name=@"not given";
                                              }
                                              if(a1.last_name==(NSString *) [NSNull null])
                                              {
                                                  a1.last_name=@"not given";
                                              }
                                              if(a1.salutation==(NSString *) [NSNull null])
                                              {
                                                  a1.salutation=@"";
                                              }
                                              if(a1.role_name==(NSString *) [NSNull null])
                                              {
                                                  a1.role_name=@"not given";
                                              }
                                              if(a1.country_name==(NSString *) [NSNull null])
                                              {
                                                  a1.country_name=@"not given";
                                              }
                                              if(a1.mobile_no==(NSString *) [NSNull null])
                                              {
                                                  a1.mobile_no=@"";
                                              }
                                              if(a1.fax==(NSString *) [NSNull null])
                                              {
                                                  a1.fax=@"";
                                              }
                                              if(a1.affiliation==(NSString *) [NSNull null])
                                              {
                                                  a1.affiliation=@"---";
                                              }
                                              
                                              self.first_name.text=a1.first_name;
                                              self.last_name.text=a1.last_name;
                                              self.country_name.text=a1.country_name;
                                              self.myemail.text=a1.emailid;
                                              self.country_name.text=a1.country_name;
                                              self.affiliation.text=a1.affiliation;
                                              self.mobile_no.text=a1.mobile_no;
                                              self.fax.text=a1.fax;
                                              
                                              
                                              [[NSUserDefaults standardUserDefaults]setValue:a1.salutation forKey:@"salutation"];
                                              NSLog(@"salutation = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"salutation"]);
                                              
                                              [[NSUserDefaults standardUserDefaults]setValue:a1.first_name forKey:@"firstname"];
                                              NSLog(@"firstname = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"firstname"]);
                                              [[NSUserDefaults standardUserDefaults]setValue:a1.last_name forKey:@"lastname"];
                                              NSLog(@"lastname = %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"lastname"]);
                                              
                                              
                                          });
                                      }];
    
    [dataTask resume];
    

}
- (IBAction)updateclicked:(id)sender {
    
    NSString *st=[NSString stringWithFormat:@"user_id=%@&first_name=%@&last_name=%@&country_name=%@&emailid=%@&affiliation=%@&mobile_no=%@&fax=%@",self.userid,self.first_name.text,self.last_name.text,self.country_name.text,self.myemail.text,self.affiliation.text,self.mobile_no.text,self.fax.text];
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];

    NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:update]];
    
    //NSURL * url = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/update.php"];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[st dataUsingEncoding:NSUTF8StringEncoding]];
    //NSError *error=nil;
    
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if(error == nil)
        {
            NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
        }
        NSError *er=nil;
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&er];
        if(er)
        {
        }
        self.success=[responseDict objectForKey:@"success"];
        self.message=[responseDict objectForKey:@"message"];
        dispatch_async(dispatch_get_main_queue(), ^{
            if([self.success isEqualToString:@"1"])
            {
            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Success" message:self.message preferredStyle:UIAlertControllerStyleAlert];
            
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
            else
            {
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Failure" message:@"Profile not updated successfully" preferredStyle:UIAlertControllerStyleAlert];
                
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

        
    }];
    
    [dataTask resume];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return  YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)textFieldDidBeginEditing:(UITextField *)sender
{
    self.activeField = sender;
}

- (IBAction)textFieldDidEndEditing:(UITextField *)sender
{
    self.activeField = nil;
}

- (void) keyboardDidShow:(NSNotification *)notification
{
    NSDictionary* info = [notification userInfo];
    CGRect kbRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
 
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbRect.size.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbRect.size.height;
    if (!CGRectContainsPoint(aRect, self.activeField.frame.origin) ) {
        [self.scrollView scrollRectToVisible:self.activeField.frame animated:YES];
    }
}

- (void)keyboardWillBeHidden:(NSNotification *)notification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}


@end
