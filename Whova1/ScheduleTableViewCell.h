//
//  ScheduleTableViewCell.h
//  ITherm
//
//  Created by Anveshak on 5/8/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScheduleTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *sessionName;
@property (weak, nonatomic) IBOutlet UILabel *locationName;
@property (weak, nonatomic) IBOutlet UILabel *startTime;
@property (weak, nonatomic) IBOutlet UILabel *endTime;
@property (weak, nonatomic) IBOutlet UILabel *tolabel;

@property (weak, nonatomic) IBOutlet UILabel *lineLabel;

@property (weak, nonatomic) IBOutlet UIImageView *duration;
@property (weak, nonatomic) IBOutlet UIImageView *location;
@property (weak, nonatomic) IBOutlet UILabel *date
;
@property (weak, nonatomic) IBOutlet UILabel *category;
@property (weak, nonatomic) IBOutlet UILabel *time_flag;
@property (weak, nonatomic) IBOutlet UILabel *sessidLbl;

@property (weak, nonatomic) IBOutlet UIButton *delBtn;




@end
