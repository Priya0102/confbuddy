//
//  CommentTableViewCell.m
//  ITherm
//
//  Created by Anveshak on 11/21/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import "CommentTableViewCell.h"

@implementation CommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
   self.images.layer.masksToBounds=YES;
   self.images.layer.borderColor=[UIColor lightGrayColor].CGColor;
   self.images.layer.borderWidth=1.1;
//    self.images.layer.cornerRadius=20;
//    self.images.layer.shadowColor=[UIColor redColor].CGColor;
    
    _comments.editable=NO;
    
    [_comments_txt_fld  setEnabled:NO];
    _comments_txt_fld.borderStyle = UITextBorderStyleNone;
    [_comments_txt_fld setBackgroundColor:[UIColor clearColor]];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
