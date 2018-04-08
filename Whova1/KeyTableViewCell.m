//
//  KeyTableViewCell.m
//  ITherm
//
//  Created by Anveshak on 11/17/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import "KeyTableViewCell.h"

@implementation KeyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.kimagev.layer.cornerRadius = self.kimagev.frame.size.width / 2;
    self.kimagev.clipsToBounds = YES;
    self.kimagev.layer.borderColor=[UIColor lightGrayColor].CGColor;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
