//
//  AuthorViewController.m
//  ITherm
//
//  Created by Anveshak on 2/15/18.
//  Copyright © 2018 Anveshak . All rights reserved.
//

#import "AuthorViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Constant.h"
@interface AuthorViewController ()

@end

@implementation AuthorViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.authorImage.layer.cornerRadius = self.authorImage.frame.size.width / 2;
    self.authorImage.clipsToBounds = YES;
    self.authorImage.layer.borderColor=[UIColor blackColor].CGColor;
    
    _papername.text=_papernameStr;
    _paperid.text=_paperidstr;
    _starttime.text=_starttimeStr;
    _endtime.text=_endtimeStr;
    _authorid.text=_authoridStr;
    
    
    [self authorDataParsing];
}
-(void)viewWillAppear:(BOOL)animated
{
    
    NSLog(@"In VIEW will appear....");
    
    int i=[_indxpath intValue];
    NSString *tempimgstr=[_kimgarray objectAtIndex:i];
    
    [_authorImage sd_setImageWithURL:[NSURL URLWithString:tempimgstr]
               placeholderImage:[UIImage imageNamed:@"default.png"]];
    
  
}
-(void)authorDataParsing{
    
    NSString *myst=[NSString stringWithFormat:@"paper_id=%@&author_id=%@",_paperidstr,_authoridStr];
    NSLog(@"paper_id...& AUTHOR ID....%@",myst);
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:author_details]];

    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSURLSessionDataTask *task=[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                {
                                    
                                    if(data==nil)
                                    {
                                        NSLog(@"Data is nil");
                                    }
                                    else
                                    {
                                        NSLog(@"%@",response);
                                        NSDictionary *outerdic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                        
                                        
                                        NSArray *keyarr=[outerdic objectForKey:@"authorinfo"];
                                    
                                        for(NSDictionary *temp in keyarr)
                                        {
                                            NSString *str1=[temp objectForKey:@"salutation"];
                                            NSString *str2=[temp objectForKey:@"first_name"];
                                            NSString *str3=[temp objectForKey:@"last_name"];
                                            NSString *str4=[temp objectForKey:@"images"];
                                            NSString *str5=[temp objectForKey:@"affiliation"];
                                            NSString *str6=[temp objectForKey:@"designation"];
                                             NSString *str7=[temp objectForKey:@"university"];
                                             NSString *str8=[temp objectForKey:@"biography"];
                                            NSString *str9=[temp objectForKey:@"paper_id"];
                                            
                                            if([str9 isEqualToString:_paperidstr])
                                            {
                                                _salutationStr=str1;
                                                _firstnameStr=str2;
                                                _lastnameStr=str3;
                                                _affiliationStr=str5;
                                                _designationStr=str6;
                                                _universityStr=str7;
                                                
                                                
                                                if([_biographyStr isEqual:[NSNull null]])
                                                {
                                                    _biographyStr=@"--";
                                                }
                                                else
                                                {
                                                    _biographyStr=str8;
                                                }
                                                NSString *tempimgstr=str4;
                                                [_authorImage sd_setImageWithURL:[NSURL URLWithString:tempimgstr]
                                                           placeholderImage:[UIImage imageNamed:@"default.png"]];
                                                
                                                [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                                                   
                                                    _authorName.text=[str1 stringByAppendingFormat:@"%@ %@",str2,str3];
                                                    
                                                _authorNameExchange.text=[@"Keep in touch with " stringByAppendingFormat:@"%@ %@ %@  %s",str1,str2,str3," by exchanging contact info"];
                                                    
                                                    
                                                    
                                                    
                                                    if([_universityStr isEqual:[NSNull null]])
                                                    {
                                                        _authorUniversity.text=@"--";
                                                    }
                                                    else
                                                    {
                                                        _authorUniversity.text=_universityStr;
                                                    }
                                                    
                                                    _authorAffiliation.text=_affiliationStr;
                                                    _authorDesignation.text=_designationStr;
                                                    
                                                    if([_biographyStr isEqual:[NSNull null]])
                                                    {
                                                        _biography.text=@"--";
                                                    }
                                                    else
                                                    {
                                                        _biography.text=_biographyStr;
                                                    }
                                                }];
                                            }
                                        }
                                        
                                    }
                                    
                                }];
    [task resume];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)exchangeBtnClicked:(id)sender {
}
- (IBAction)seeMoreBtnClicked:(id)sender {
}
@end
