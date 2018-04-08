//
//  InvitedDetailTableViewCell.m
//  ITherm
//
//  Created by Anveshak on 12/11/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import "InvitedDetailTableViewCell.h"

@implementation InvitedDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.images.layer.cornerRadius = self.images.frame.size.width / 2;
    self.images.clipsToBounds = YES;
    
    _comments.editable=NO;
    
    [_comments_txt_fld  setEnabled:NO];
    _comments_txt_fld.borderStyle = UITextBorderStyleNone;
    [_comments_txt_fld setBackgroundColor:[UIColor clearColor]];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
