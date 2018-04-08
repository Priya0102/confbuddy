//
//  PosterViewController.m
//  ITherm
//
//  Created by Anveshak on 4/3/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import "PosterViewController.h"
#import "Constant.h"
@interface PosterViewController ()

@end

@implementation PosterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _que=[[NSOperationQueue alloc]init];
    [self posterparsing];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)posterparsing
{
    
    
    NSBlockOperation *op1=[NSBlockOperation blockOperationWithBlock:^{
    
      NSURL * urlstr = [NSURL URLWithString:[mainUrl stringByAppendingString:poster]];
   // NSString *urlstr=@"http://192.168.1.100/phpmyadmin/itherm/poster.php";
        
        NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:urlstr];
        
        NSURLSessionConfiguration *configuration=[NSURLSessionConfiguration defaultSessionConfiguration];
        
        NSURLSession *session=[NSURLSession sessionWithConfiguration:configuration];
        
        NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                    {
                                        
                                        if(data==nil)
                                        {
                                            NSLog(@"Data is nil");
                                            
                                        }
                                        
                                        else
                                        {
                                            
                                            
                                            NSLog(@"%@",response);
                                            
                                            
                                            NSDictionary *outerdic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                            
                                            NSArray *tech_panelarr=[outerdic objectForKey:@"poster_art"];
                                            
                                            for(NSDictionary *temp in tech_panelarr)
                                            {
                                                NSString *str1=[temp objectForKey:@"session_name"];
                                                NSString *str2=[temp objectForKey:@"poster_info"];
                                                NSString *str3=[temp objectForKey:@"art_title"];
                                                NSString *str4=[temp objectForKey:@"art_info"];
                                                NSString *str5=[temp objectForKey:@"session_id"];
                                                
                                                NSLog(@"%@    %@    %@      %@ ",str1,str2,str3,str4);
                                                
                                                if([str5 isEqualToString:_temp_seesionid_str])
                                                {
                                                    [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                                                        _poster_infostr=str2;
                                                        _poster_titlestr=str1;
                                                        _art_titlestr=str3;
                                                        _art_infostr=str4;
                                                        
                                                        _poster_title.text=_poster_titlestr;
                                                        _poster_info.text=_poster_infostr;
                                                        _art_title.text=_art_titlestr;
                                                        _art_info.text=_art_infostr;
                                                        
                                                    }];
                                                }
                                            }
                                        }
                                    }];
        [task resume];
        
    }];
    
    [_que addOperation:op1]; 
    
    
    
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
