//
//  TalkTableViewCell.h
//  ITherm
//
//  Created by Anveshak on 5/19/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TalkTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *talkName;
@property (weak, nonatomic) IBOutlet UILabel *talkid;
@property (strong, nonatomic) IBOutlet UIButton *tickButton;
@property (weak, nonatomic) IBOutlet UILabel *starttime;




@end
