//
//  CourseTableViewCell.h
//  ITherm
//
//  Created by Anveshak on 6/1/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CourseTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *coursename;
@property (weak, nonatomic) IBOutlet UILabel *courseid;

@property (weak, nonatomic) IBOutlet UILabel *starttime;
@property (weak, nonatomic) IBOutlet UILabel *courseabstract;
@property (weak, nonatomic) IBOutlet UILabel *courseno;

@property (weak, nonatomic) IBOutlet UIButton *reminderButton;

    
@end
