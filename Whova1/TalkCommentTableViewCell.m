//
//  TalkCommentTableViewCell.m
//  ITherm
//
//  Created by Anveshak on 11/24/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import "TalkCommentTableViewCell.h"

@implementation TalkCommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.images.layer.masksToBounds=YES;
    self.images.layer.borderColor=[UIColor blackColor].CGColor;
    self.images.layer.borderWidth=1.1;
    self.images.layer.cornerRadius=20;
    self.images.layer.shadowColor=[UIColor redColor].CGColor;
    
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
