//
//  ScheduleTableViewCell.m
//  ITherm
//
//  Created by Anveshak on 5/8/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import "ScheduleTableViewCell.h"

@implementation ScheduleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
  
    
    _category.layer.masksToBounds=YES;
    _category.layer.cornerRadius=8.0;
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

  
}

@end
