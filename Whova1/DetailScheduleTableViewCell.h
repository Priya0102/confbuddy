//
//  DetailScheduleTableViewCell.h
//  ITherm
//
//  Created by Anveshak on 5/8/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailScheduleTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *paperNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *paperid;
@property (weak, nonatomic) IBOutlet UIButton *deletebtn;

@property (weak, nonatomic) IBOutlet UILabel *abstractLbl;



@end
