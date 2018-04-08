//
//  AfterLoginTableViewCell.m
//  ITherm
//
//  Created by Anveshak on 3/1/18.
//  Copyright © 2018 Anveshak . All rights reserved.
//

#import "AfterLoginTableViewCell.h"

@implementation AfterLoginTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
        self.view2.layer.masksToBounds=YES;
        self.view2.layer.borderColor=[UIColor lightGrayColor].CGColor;
        self.view2.layer.cornerRadius=8;
        self.view2.layer.borderWidth=0.2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
