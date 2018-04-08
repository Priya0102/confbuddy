//
//  AbsViewController.h
//  ITherm
//
//  Created by Anveshak on 5/20/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AbsViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *abslabel;
@property(nonatomic,retain)NSString *absStr;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;

@end
