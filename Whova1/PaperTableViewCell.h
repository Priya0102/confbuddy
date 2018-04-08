//
//  PaperTableViewCell.h
//  ITherm
//
//  Created by Anveshak on 12/01/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaperTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *papername;
@property (weak, nonatomic) IBOutlet UIImageView *arrowimg;
@property (weak, nonatomic) IBOutlet UILabel *paper_abstract;
@property (weak, nonatomic) IBOutlet UILabel *start_time;

@property (weak, nonatomic) IBOutlet UIButton *reminderButton;


@end
