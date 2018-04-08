//
//  PanelCommentTableViewCell.m
//  ITherm
//
//  Created by Anveshak on 12/13/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import "PanelCommentTableViewCell.h"

@implementation PanelCommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    self.images.layer.cornerRadius = self.images.frame.size.width / 2;
    self.images.clipsToBounds = YES;
    
    self.images.layer.masksToBounds=YES;
    self.images.layer.borderColor=[UIColor blackColor].CGColor;
    self.images.layer.borderWidth=1.1;
    //self.images.layer.cornerRadius=20;
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
