

#import "HomeViewController.h"
#import "Constant.h"
@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
   
    self.loginbtn.layer.masksToBounds=YES;
    self.loginbtn.layer.cornerRadius=8;
    self.loginbtn.layer.borderColor=(__bridge CGColorRef _Nullable)([UIColor colorWithRed:(23/225.0) green:(167/225.0) blue:(186/255.0)alpha:1]);
    
    
    
    self.neruserbtn.layer.masksToBounds=YES;
    self.neruserbtn.layer.borderColor=[UIColor whiteColor].CGColor;
    self.neruserbtn.layer.cornerRadius=8;
    self.neruserbtn.layer.borderWidth=0.2;
    
//    self.loginbtn.layer.masksToBounds=YES;
//    self.loginbtn.layer.borderColor=(__bridge CGColorRef _Nullable)([UIColor colorWithRed:(84/225.0) green:(211/225.0) blue:(199/255.0)alpha:1]);
//    self.loginbtn.layer.borderWidth=1.1;
//    self.loginbtn.layer.cornerRadius=10;
//    self.loginbtn.layer.shadowColor=[UIColor redColor].CGColor;
//    
//    self.neruserbtn.layer.masksToBounds=YES;
//    self.neruserbtn.layer.borderColor=[UIColor whiteColor].CGColor;
//    self.neruserbtn.layer.borderWidth=1.1;
//    self.neruserbtn.layer.cornerRadius=10;
//    self.neruserbtn.layer.shadowColor=[UIColor redColor].CGColor;
    
//    [_firstname setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
//    [_lastname setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    [_scrollview setShowsHorizontalScrollIndicator:NO];
    [_scrollview setShowsVerticalScrollIndicator:NO];
    [self testInternetConnection];
    self.navigationItem.hidesBackButton = YES;


    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Alert!" message:@"No internet connection" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alertView dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        [alertView addAction:ok];
        
     
    }
    UIView *paddingview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, self.firstname.frame.size.height)];
    self.firstname.leftView=paddingview;
    self.firstname.leftViewMode=UITextFieldViewModeAlways;
    
    UIView *paddingview2=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, self.lastname.frame.size.height)];
    self.lastname.leftView=paddingview2;
    self.lastname.leftViewMode=UITextFieldViewModeAlways;
    
   
   // NSString *savedValue = [[NSUserDefaults standardUserDefaults] stringForKey:@"email"];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@"ITHERM "
                                                                             attributes:@{NSUnderlineStyleAttributeName: @(NSUnderlineStyleNone)}]];
    [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@" "
                                                                             attributes:@{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle),
                                                                                          NSBackgroundColorAttributeName: [UIColor whiteColor]}]];
    [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@"2018"]];

   


}
//-(void)tapReceived:(UITapGestureRecognizer *)tapGestureRecognizer {
//    [self.view endEditing:YES];
//    [_lastname resignFirstResponder];
//    
//}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];

}
- (IBAction)loginclicked:(id)sender {

    
    UIActivityIndicatorView *indicator=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.frame=CGRectMake(self.view.window.center.x,self.view.window.center.y, 40.0, 40.0);
    indicator.center=self.view.center;
    [self.view addSubview:indicator];
    
    
    indicator.tintColor=[UIColor redColor];
    indicator.backgroundColor=[UIColor blackColor];
    [indicator bringSubviewToFront:self.view];
   // [UIApplication sharedApplication].networkActivityIndicatorVisible=true;
    [indicator startAnimating];
    if(self.firstname.text.length==0 && self.lastname.text.length==0)
    {
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:nil message:@"Enter username and password" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alertView dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        [alertView addAction:ok];
        [indicator stopAnimating];

        [self presentViewController:alertView animated:YES completion:nil];
        
    }
    if(self.firstname.text.length==0)
    {
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:nil message:@"Please enter your email-id" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alertView dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        [alertView addAction:ok];


        [indicator stopAnimating];

        [self presentViewController:alertView animated:YES completion:nil];
    }
    if(self.lastname.text.length==0)
    {
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:nil message:@"Please enter your password" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alertView dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        [alertView addAction:ok];
        [indicator stopAnimating];

        [self presentViewController:alertView animated:YES completion:nil];
    }
 
   
    if(self.firstname.text.length>0 && self.lastname.text.length>0)
    {
    NSString *myst=[NSString stringWithFormat:@"username=%@&password=%@",self.firstname.text,self.lastname.text];
    self.email=self.lastname.text;
    

    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];

        NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:mainlogin]];
        
       // NSURL * url = [NSURL URLWithString:@""http://192.168.1.100/phpmyadmin/itherm/mainlogin.php];//local

    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error=nil;
        NSLog(@"%@",error);
       NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        if(error == nil)
        {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
            
            if ([httpResponse statusCode]!=200)
            {
                return;
            }
            
            NSString * text = [[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding];
            NSLog(@"%@",text);
            NSError *er=nil;
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&er];
            if(er)
            {
            }
          
            
           // NSMutableString *stringUserInfo = [[NSMutableString alloc] init];
            
        
            self.failure=[responseDict objectForKey:@"message"];
            self.result=[responseDict objectForKey:@"success"];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if([self.result isEqualToString:@"1"])
            {
                [[NSUserDefaults standardUserDefaults] setObject:self.firstname.text forKey:@"email"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                [indicator stopAnimating];

                [self performSegueWithIdentifier:@"ToAgenda" sender:self];
            }
            else
            {
                    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:nil message:self.failure preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction* ok = [UIAlertAction
                                         actionWithTitle:@"OK"
                                         style:UIAlertActionStyleDefault
                                         handler:^(UIAlertAction * action)
                                         {
                                             [alertView dismissViewControllerAnimated:YES completion:nil];
                                         }];
                    
                    [alertView addAction:ok];
                [indicator stopAnimating];
                    [self presentViewController:alertView animated:YES completion:nil];
            }
        });
        
    }];
    [dataTask resume];
    }
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"ToProfile"])
    {
        //ProfileViewController *controller=segue.destinationViewController;
        //controller.email=self.email;
    }
}
- (IBAction)forgotpassword:(id)sender {
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.firstname resignFirstResponder];
    [self.lastname resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return  YES;
}

- (void)testInternetConnection
{
    __weak typeof(self) weakSelf = self;
    
    Reachability *internetReachable = [Reachability reachabilityForInternetConnection];
   // NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];

    internetReachable = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    // Internet is reachable
    internetReachable.reachableBlock = ^(Reachability*reach)
    {
        // Update the UI on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            //Make sure user interaction on whatever control is enabled
        });
    };
    
    // Internet is not reachable
    internetReachable.unreachableBlock = ^(Reachability*reach)
    {
        // Update the UI on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{

            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"No Internet Connection" message:@"Please connect to the internet." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [alertView dismissViewControllerAnimated:YES completion:nil];
                                 }];
            [alertView addAction:ok];
            [self presentViewController:alertView animated:YES completion:nil];
            //Make sure user interaction on whatever control is disabled
        });
    };
    
    [internetReachable startNotifier];
}
@end
