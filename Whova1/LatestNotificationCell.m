//
//  LatestNotificationCell.m
//  ITherm
//
//  Created by Anveshak on 2/28/18.
//  Copyright © 2018 Anveshak . All rights reserved.
//

#import "LatestNotificationCell.h"

@implementation LatestNotificationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.view.layer.masksToBounds = YES;
    //self.notification.layer.masksToBounds = YES;
    _view.layer.cornerRadius=8;
   // _notification.layer.cornerRadius=10;
    self.notification.layer.borderColor=(__bridge CGColorRef _Nullable)([UIColor colorWithRed:(226/225.0) green:(57/225.0) blue:(23/255.0)alpha:1]);
    
    
    self.view2.layer.masksToBounds=YES;
    _view2.layer.cornerRadius=8;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
