//
//  ExhibitorTableViewCell.m
//  ITherm
//
//  Created by Anveshak on 11/23/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import "ExhibitorTableViewCell.h"

@implementation ExhibitorTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _kurl.userInteractionEnabled = YES;
    UITapGestureRecognizer *gestureRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openUrl:)];
    gestureRec.numberOfTouchesRequired = 1;
    gestureRec.numberOfTapsRequired = 1;
    [_kurl addGestureRecognizer:gestureRec];
    //[gestureRec release];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (void)openUrl:(id)sender {
    UIGestureRecognizer *rec = (UIGestureRecognizer *)sender;
    id hitLabel = [self.kurl hitTest:[rec locationInView:self.kurl] withEvent:UIEventTypeTouches];
    if ([hitLabel isKindOfClass:[UILabel class]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:((UILabel *)hitLabel).text]];
    }
}


@end
