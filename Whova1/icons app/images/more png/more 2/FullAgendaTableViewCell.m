//
//  FullAgendaTableViewCell.m
//  ITherm
//
//  Created by Anveshak on 2/20/18.
//  Copyright © 2018 Anveshak . All rights reserved.
//

#import "FullAgendaTableViewCell.h"

@implementation FullAgendaTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _category.layer.masksToBounds=YES;
    _category.layer.cornerRadius=8.0;
    _category.layer.borderWidth=1.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
