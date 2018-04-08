//
//  MoreViewController.m
//  ITherm
//
//  Created by Anveshak on 3/29/18.
//  Copyright © 2018 Anveshak . All rights reserved.
//

#import "MoreViewController.h"
#import "Attendee.h"
#import "Constant.h"
@interface MoreViewController ()

@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _image.layer.masksToBounds=YES;
    _image.layer.borderWidth=1.1;
    _image.layer.cornerRadius=_image.frame.size.width/2;

    _image.layer.borderColor=([UIColor colorWithRed:(211.0/225.0) green:(211.0/225.0) blue:(211.0/255.0)alpha:1.0].CGColor);

    _image.clipsToBounds=YES;
    
    
    
   
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    NSString *emailid=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
    if (emailid==NULL) {
        self.fullname.text=@"Guest";
    }
    else {
        
        [self getNameParsing];
        
    }

}
-(void)getNameParsing{
    
    Attendee *a1=[[Attendee alloc]init];
    
    self.myprofile=[[NSMutableArray alloc]init];
    NSString *savedValue = [[NSUserDefaults standardUserDefaults] stringForKey:@"email"];
    
    
    NSString *myst=[NSString stringWithFormat:@"emailid=%@",savedValue];
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:getprofile]];
    
    
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
                                          
                                          //NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
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
                                              
                                                                                          self.affiliation.text=a1.affiliation;
                                              
                                              self.fullname.text = [NSString stringWithFormat: @"%@ %@ %@", a1.salutation,a1.first_name,a1.last_name];
                                              
                                              NSLog(@"fullname==%@",self.fullname.text);
                                              
                                          });
                                      }];
    
    [dataTask resume];

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
