//
//  CourseSchComTableViewCell.m
//  ITherm
//
//  Created by Anveshak on 12/21/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import "CourseSchComTableViewCell.h"

@implementation CourseSchComTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.images.layer.cornerRadius = self.images.frame.size.width / 2;
    self.images.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
