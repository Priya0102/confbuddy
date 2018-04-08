//
//  MoreViewController.h
//  ITherm
//
//  Created by Anveshak on 3/29/18.
//  Copyright © 2018 Anveshak . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UILabel *fullname;
@property (strong, nonatomic) IBOutlet UILabel *affiliation;
@property (strong,nonatomic) NSMutableArray *myprofile;
@property (strong,nonatomic) NSString *email,*userid;
@end
