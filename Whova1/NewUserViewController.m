
#import "NewUserViewController.h"
#import "Constant.h"
@interface NewUserViewController ()

@end

@implementation NewUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   /* if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        UIAlertAction *myAlert=[[UIAlertAction alloc]init];
        
        
        [myAlertView show];
        
    }*/
    self.registerBtn.layer.masksToBounds=YES;
    self.registerBtn.layer.cornerRadius=8;
    
    self.signInBtn.layer.masksToBounds=YES;
    self.signInBtn.layer.cornerRadius=8;
    //self.signInBtn.layer.borderColor=(__bridge CGColorRef _Nullable)[UIColor whiteColor];
    _signInBtn.layer.borderWidth = 1.0f;
    _signInBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    
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
    
}




- (IBAction)saveclicked:(id)sender {
    
    NSString *myst=[NSString stringWithFormat:@"first_name=%@&last_name=%@&affiliation=%@&country_name=%@&emailid=%@&password=%@",self.firstname.text,self.lastname.text,self.affiliation.text,self.country.text,self.emailid.text,self.password.text];
    
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
     if([self.password.text isEqualToString:self.confirm_password.text] && self.password.text.length>0 && self.confirm_password.text.length>0)
    {
        NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:new_register]];
   
        NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
        [urlRequest setHTTPMethod:@"POST"];
        [urlRequest setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
        NSError *error=nil;
        NSLog(@"error=%@",error);
        
        NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            if(error == nil)
            {
                NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                NSLog(@"data =%@",text);
                self.result= [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                
                
            }
            NSError *er=nil;
            NSDictionary *dictionary=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&er];
            if(er)
            {
            }
            
            self.result=[dictionary objectForKey:@"success"];
            self.message=[dictionary objectForKey:@"message"];
            

            dispatch_async(dispatch_get_main_queue(), ^{
                if([self.result isEqualToString:@"1"])
                {
                    
                 //  [self dataUploadingInServer];
                                        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:nil message:self.message preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction* ok = [UIAlertAction
                                         actionWithTitle:@"OK"
                                         style:UIAlertActionStyleDefault
                                         handler:^(UIAlertAction * action)
                                         {
                                             
                                             [alertView dismissViewControllerAnimated:YES completion:nil];
                                             [self performSegueWithIdentifier:@"Home" sender:self];

                                             
                                         }];
                    
                    [alertView addAction:ok];
                    [[NSUserDefaults standardUserDefaults] setObject:self.emailid.text forKey:@"email"];
                    [[NSUserDefaults standardUserDefaults] synchronize];

                    [self presentViewController:alertView animated:YES completion:nil];


                    
                }
                else
                {
                    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:nil message:self.message preferredStyle:UIAlertControllerStyleAlert];
                    
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
    
    
    else
    {
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:nil message:@"Confirm Password doesn't match" preferredStyle:UIAlertControllerStyleAlert];
        
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
/*-(void)dataUploadingInServer{
    
    // Dictionary that holds post parameters. You can set your post parameters that your server accepts or programmed to accept.
    NSMutableDictionary* _params = [[NSMutableDictionary alloc] init];
    [_params setObject:@"1.0" forKey:@"ver"];
    [_params setObject:@"en" forKey:@"lan"];
//    [_params setObject:[NSString stringWithFormat:@"%@", _firstname.text] forKey:@"first_name"];
//    [_params setObject:[NSString stringWithFormat:@"%@",_lastname.text] forKey:@"last_name"];
//    [_params setObject:[NSString stringWithFormat:@"%@", _affiliation.text] forKey:@"affiliation"];
//    [_params setObject:[NSString stringWithFormat:@"%@",_country.text] forKey:@"country_name"];
//    [_params setObject:[NSString stringWithFormat:@"%@", _emailid.text] forKey:@"emailid"];
//    [_params setObject:[NSString stringWithFormat:@"%@",_password.text] forKey:@"password"];
    [_params setObject:[NSString stringWithFormat:@"%@", _imageView.image] forKey:@"profile_image"];
    
    
    // the boundary string : a random string, that will not repeat in post data, to separate post data fields.
    NSString *BoundaryConstant = @"----------V2ymHFg03ehbqgZCaKO6jy";
    
    // string constant for the post parameter 'file'. My server uses this name: `file`. Your's may differ
    NSString* FileParamConstant = @"profile_image";
    
    // the server url to which the image (or the media) is uploaded. Use your server url here
    NSURL * requestURL = [NSURL URLWithString:[mainUrl stringByAppendingString:profile_pic_uploaded]];
    // create request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:30];
    [request setHTTPMethod:@"POST"];
    
    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", BoundaryConstant];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // post body
    NSMutableData *body = [NSMutableData data];
    
    // add params (all params are strings)
    for (NSString *param in _params) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", param] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n", [_params objectForKey:param]] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    // add image data
    NSData *imageData = UIImageJPEGRepresentation(_imageView.image, 1.0);
    
    if (imageData) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"image.jpg\"\r\n", FileParamConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:imageData];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    
    // set the content-length
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    // set URL
    [request setURL:requestURL];
}
*/
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
                                       
                                       alertControllerWithTitle:@"Alert!" message:@"Please Enter at least 8 digit password"preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* yesButton = [UIAlertAction
                                        actionWithTitle:@"OK"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action)
                                        {
                                          
                                            NSLog(@"you pressed Yes, please button");
                                           [alert dismissViewControllerAnimated:YES completion:nil];
                                        }];


            [alert addAction:yesButton];

            return false;
        }

    return true;
    
}


//-(void)textFieldDidEndEditing:(UITextField *)textField{
//    
//    textField=_password;
//    int numberofCharacters = 0;
//    BOOL lowerCaseLetter = false,upperCaseLetter = false,digit = false,specialCharacter = 0;
//    if([_password.text length] >= 8)
//    {
//        for (int i = 0; i < [_password.text length]; i++)
//        {
//            unichar c = [_password.text characterAtIndex:i];
//            if(!lowerCaseLetter)
//            {
//                lowerCaseLetter = [[NSCharacterSet lowercaseLetterCharacterSet] characterIsMember:c];
//            }
//            if(!upperCaseLetter)
//            {
//                upperCaseLetter = [[NSCharacterSet uppercaseLetterCharacterSet] characterIsMember:c];
//            }
//            if(!digit)
//            {
//                digit = [[NSCharacterSet decimalDigitCharacterSet] characterIsMember:c];
//            }
//            if(!specialCharacter)
//            {
//                specialCharacter = [[NSCharacterSet symbolCharacterSet] characterIsMember:c];
//            }
//        }
//        
//        if(specialCharacter && digit && lowerCaseLetter && upperCaseLetter)
//        {
//            //do what u want
//        }
//        else
//        {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
//                                                            message:@"Please Ensure that you have at least one lower case letter, one upper case letter, one digit and one special character"
//                                                           delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [alert show];
//        }
//        
//    }
//    else
//    {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
//                                                        message:@"Please Enter at least 8 digit password"
//                                                       delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//    }
//}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.firstname resignFirstResponder];
    [self.lastname resignFirstResponder];
    [self.confirm_password resignFirstResponder];
    [self.affiliation resignFirstResponder];
    [self.password resignFirstResponder];
    [self.country resignFirstResponder];
    [self.emailid resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField==self.firstname)
    {
    [textField resignFirstResponder];
    [self.lastname becomeFirstResponder];
    }
    else if(textField==self.lastname)
    {
        [textField resignFirstResponder];
        [self.country becomeFirstResponder];
    }
    else if(textField==self.country)
    {
        [textField resignFirstResponder];
        [self.emailid becomeFirstResponder];
    }
    else if(textField==self.emailid)
    {
        [textField resignFirstResponder];
        [self.affiliation becomeFirstResponder];
    }
    else if(textField==self.affiliation)
    {
        [textField resignFirstResponder];
        [self.password becomeFirstResponder];
    }
    else if(textField==self.password)
    {
        [textField resignFirstResponder];
        [self.confirm_password becomeFirstResponder];
    }
    else
    {
        [textField resignFirstResponder];
    }
    return  YES;
}
- (IBAction)textFieldDidBeginEditing:(UITextField *)sender
{
    self.activeField = sender;
}

//- (IBAction)textFieldDidEndEditing:(UITextField *)sender
//{
//    self.activeField = nil;
//}

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


- (IBAction)takePhoto:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}
- (IBAction)selectPhoto:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
    
}

/*- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
 */
/*
 
//NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:mainsignup]];
 
 // NSURL * url = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/mainsignup.php"];
 
 
 // NSURL * url = [NSURL URLWithString:@"http://www.siddhantedu.com/iosDemo/mainsignup.php"];//server
 //NSURL * url = [NSURL URLWithString:@"http://www.siddhantedu.com/iOSAPI/mainsignup2.php"];
 //    if(self.password.text.length==0)
 //    {
 //        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:nil message:@"Please fill all details" preferredStyle:UIAlertControllerStyleAlert];
 //
 //        UIAlertAction* ok = [UIAlertAction
 //                             actionWithTitle:@"OK"
 //                             style:UIAlertActionStyleDefault
 //                             handler:^(UIAlertAction * action)
 //                             {
 //                                 [alertView dismissViewControllerAnimated:YES completion:nil];
 //
 //                             }];
 //
 //        [alertView addAction:ok];
 //        [self presentViewController:alertView animated:YES completion:nil];
 //
 // }
 
 
 //    int numberofCharacters = 0;
 //    BOOL lowerCaseLetter = false,upperCaseLetter = false,digit = false,specialCharacter = 0;
 //    if([_password.text length] >= 8)
 //    {
 //        for (int i = 0; i < [_password.text length]; i++)
 //        {
 //            unichar c = [_password.text characterAtIndex:i];
 //            if(!lowerCaseLetter)
 //            {
 //                lowerCaseLetter = [[NSCharacterSet lowercaseLetterCharacterSet] characterIsMember:c];
 //            }
 //            if(!upperCaseLetter)
 //            {
 //                upperCaseLetter = [[NSCharacterSet uppercaseLetterCharacterSet] characterIsMember:c];
 //            }
 //            if(!digit)
 //            {
 //                digit = [[NSCharacterSet decimalDigitCharacterSet] characterIsMember:c];
 //            }
 //            if(!specialCharacter)
 //            {
 //                specialCharacter = [[NSCharacterSet symbolCharacterSet] characterIsMember:c];
 //            }
 //        }
 //
 //        if(specialCharacter && digit && lowerCaseLetter && upperCaseLetter)
 //        {
 //            //do what u want
 //        }
 //        else
 //        {
 //            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
 //                                                            message:@"Please Ensure that you have at least one lower case letter, one upper case letter, one digit and one special character"
 //                                                           delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
 //            [alert show];
 //        }
 //
 //    }
 //    else
 //    {
 //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
 //                                                        message:@"Please Enter at least 8 digit password"
 //                                                       delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
 //        [alert show];
 //    }
 
 //[self checkPassword:_password];
 
 //    if([self checkPassword:_password])
 //    {
 //    }
 //    else
 //    {
 //        
 //    }
 

 
 */
@end
