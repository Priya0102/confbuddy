//
//  TalkSchTableViewCell.h
//  ITherm
//
//  Created by Anveshak on 5/24/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TalkSchTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *talkName;

@property (strong, nonatomic) IBOutlet UIButton *delBtn;

@property (weak, nonatomic) IBOutlet UILabel *talkid;
@end
