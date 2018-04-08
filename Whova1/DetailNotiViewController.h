//
//  DetailNotiViewController.h
//  ITherm
//
//  Created by Anveshak on 4/27/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailNotiViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *desc;


@property(nonatomic,retain)NSString *namestr;
@property(nonatomic,retain)NSString *datestr;
@property(nonatomic,retain)NSString *timestr;
@property(nonatomic,retain)NSString *descstr,*notifystr;

@property (weak, nonatomic) IBOutlet UITextView *desctextview;

@end
