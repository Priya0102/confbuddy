//
//  PanelPanelistTableViewCell.h
//  ITherm
//
//  Created by Anveshak on 12/13/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PanelPanelistTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *panelist_name;
@property (weak, nonatomic) IBOutlet UILabel *panelist_university;
@property (weak, nonatomic) IBOutlet UILabel *sessionid;
@end
