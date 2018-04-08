//
//  InvitedTableViewCell.h
//  ITherm
//
//  Created by Anveshak on 5/18/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InvitedTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *invitedName;
@property (weak, nonatomic) IBOutlet UILabel *invitedid;

@property (strong, nonatomic) IBOutlet UIButton *tickButton;
@end
