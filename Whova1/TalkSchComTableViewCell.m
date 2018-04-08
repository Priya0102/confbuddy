//
//  TalkSchComTableViewCell.m
//  ITherm
//
//  Created by Anveshak on 12/19/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import "TalkSchComTableViewCell.h"

@implementation TalkSchComTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.images.layer.masksToBounds=YES;
    self.images.layer.borderColor=[UIColor blackColor].CGColor;
    self.images.layer.borderWidth=1.1;
    self.images.layer.cornerRadius=20;
    self.images.layer.shadowColor=[UIColor redColor].CGColor;
    
    _comments.editable=NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
