//
//  UpcomingSessionTableViewCell.m
//  ITherm
//
//  Created by Anveshak on 3/1/18.
//  Copyright © 2018 Anveshak . All rights reserved.
//

#import "UpcomingSessionTableViewCell.h"

@implementation UpcomingSessionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.addMySchBtn.layer.masksToBounds=YES;
    self.addMySchBtn.layer.cornerRadius=8;
    self.addMySchBtn.layer.borderColor=(__bridge CGColorRef _Nullable)([UIColor colorWithRed:(88/225.0) green:(211/225.0) blue:(244/255.0)alpha:1]);
    
    self.viewSession.layer.masksToBounds=YES;
    self.viewSession.layer.cornerRadius=8;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
