//
//  AfterLoginTableViewCell.h
//  ITherm
//
//  Created by Anveshak on 3/1/18.
//  Copyright © 2018 Anveshak . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AfterLoginTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *notification;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (strong, nonatomic) IBOutlet UIView *view2;

@property (weak, nonatomic) IBOutlet UITextView *desc;
@property (weak, nonatomic) IBOutlet UILabel *notify_time;
@property (weak, nonatomic) IBOutlet UILabel *notify_id;
@property (strong, nonatomic) IBOutlet UIView *view;
@property (strong, nonatomic) IBOutlet UITextView *noNewNotification;
@end
