
#import "ChangePassViewController.h"
#import "Constant.h"
@interface ChangePassViewController ()

@end

@implementation ChangePassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.password.secureTextEntry=YES;
    //UIView *paddingview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 35, self.password.frame.size.height)];
   // self.password.leftView=paddingview;
   // self.password.leftViewMode=UITextFieldViewModeAlways;
    NSString *savedValue = [[NSUserDefaults standardUserDefaults] stringForKey:@"email"];
    
    
    
    self.username=[[NSUserDefaults standardUserDefaults] stringForKey:@"email"];
    
    

}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.password resignFirstResponder];
    [self.confirm_password resignFirstResponder];
    [self.old_password resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return  YES;
}


- (IBAction)okclicked:(id)sender {
    
    if([self checkPassword:_password])
    {
        NSLog(@"PASSRORD IS WRONG!!!!....");
    }
    else
    {
        NSLog(@"DATA SAVED!!!!!!....");
        
    }
    
    if(self.password.text.length >0)
    {
    
    NSString *myst=[NSString stringWithFormat:@"username=%@&new_pass=%@&c_pass=%@&old_pass=%@",self.username,self.password.text,self.confirm_password.text,self.old_password.text];
        
        NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:changepassword]];
        
     // NSURL * url = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/changepassword.php"];
        
        
        
        
        
      //NSURL * url = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/iOSAPI/changepassword.php"];
// NSURL * url = [NSURL URLWithString:@"http://www.siddhantedu.com/iOSAPI/changepassword.php"];
        //NSURL *url=[NSURL URLWithString:@"http://www.siddhantedu.com/admin_ith/changepassword.php"];//server api

    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *mysession=[NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask *mytask=[mysession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error)
        {
        }
        else
        {
            NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
        }
        
        NSError *er=nil;
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&er];
        if(er)
        {
        }
        self.success=[responseDict objectForKey:@"status"];
        self.message=[responseDict objectForKey:@"message"];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if([self.success isEqualToString:@"success"])
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
                self.password.text=@"";
                self.confirm_password.text=@"";
                self.old_password.text=@"";
                [self presentViewController:alertView animated:YES completion:nil];
                
            }
            else
            {
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Failure" message:self.message preferredStyle:UIAlertControllerStyleAlert];
                
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
    
    [mytask resume];
    }
    
else
    {
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Enter new password" preferredStyle:UIAlertControllerStyleAlert];
        
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

    
}



-(BOOL)checkPassword:(UITextField *)textField
{
    
    
    int numberofCharacters = 0;
    BOOL lowerCaseLetter = false,upperCaseLetter = false,digit = false,specialCharacter = 0;
    if([textField.text length] >= 8)
    {
        for (int i = 0; i < [textField.text length]; i++)
        {
            unichar c = [textField.text characterAtIndex:i];
            if(!lowerCaseLetter)
            {
                lowerCaseLetter = [[NSCharacterSet lowercaseLetterCharacterSet] characterIsMember:c];
            }
            if(!upperCaseLetter)
            {
                upperCaseLetter = [[NSCharacterSet uppercaseLetterCharacterSet] characterIsMember:c];
            }
            if(!digit)
            {
                digit = [[NSCharacterSet decimalDigitCharacterSet] characterIsMember:c];
            }
            if(!specialCharacter)
            {
                specialCharacter = [[NSCharacterSet symbolCharacterSet] characterIsMember:c];
            }
        }
        
        if(specialCharacter && digit && lowerCaseLetter && upperCaseLetter)
        {
            //do what u want
            return true;
        }
        else
        {
            //                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
            //                                                                message:@"Please Ensure that you have at least one lower case letter, one upper case letter, one digit and one special character"
            //                                                               delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            //                [alert show];
            //                return false;
        }
        
    }
    else
    {
        UIAlertController * alert=[UIAlertController
                                   
                                   alertControllerWithTitle:@"Error" message:@"Please Enter at least 8 digit password"preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"OK"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action)
                                    {
                                        //What we write here????????**
                                        
                                        NSLog(@"you pressed Yes, please button");
                                         }];
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
        

//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
//                                                        message:@"Please Enter at least 8 digit password"
//                                                       delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
        return false;
    }
    
    return true;
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
