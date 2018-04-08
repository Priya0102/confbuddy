//
//  ExhibitionTableViewCell.h
//  ITherm
//
//  Created by Anveshak on 2/9/18.
//  Copyright © 2018 Anveshak . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExhibitionTableViewCell : UITableViewCell<UIScrollViewDelegate,NSURLSessionDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *kimagev;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet UILabel *artid;
@property (strong, nonatomic) IBOutlet UIButton *likeBtn;
@property (strong, nonatomic) IBOutlet UILabel *count_like;
//@property (strong, nonatomic) IBOutlet UIButton *likeBtnClicked;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain) NSString *success;
@end
