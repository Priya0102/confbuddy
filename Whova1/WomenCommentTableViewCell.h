//
//  WomenCommentTableViewCell.h
//  ITherm
//
//  Created by Anveshak on 12/13/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WomenCommentTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *date1;


@property (strong, nonatomic) IBOutlet UITextView *comments;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UIImageView *images;
@property (strong, nonatomic) IBOutlet UITextField *comments_txt_fld;
@end
