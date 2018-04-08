//
//  BreakViewController.h
//  ITherm
//
//  Created by Anveshak on 4/3/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BreakViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *starttime_lbl;
@property (weak, nonatomic) IBOutlet UILabel *endtime_lbl;
@property (weak, nonatomic) IBOutlet UILabel *location_lbl;
@property (weak, nonatomic) IBOutlet UIImageView *img;



@property(nonatomic,retain)NSString *startstr,*endstr,*locationstr;

@end
