//
//  LeaderTableViewCell.h
//  ITherm
//
//  Created by Anveshak on 12/6/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeaderTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *leadername;
@property (strong, nonatomic) IBOutlet UILabel *courseid;
@property (strong, nonatomic) IBOutlet UILabel *university;
@property (strong, nonatomic) IBOutlet UILabel *leaderid;

@end
