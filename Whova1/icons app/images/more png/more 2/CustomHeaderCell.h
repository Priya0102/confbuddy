//
//  CustomHeaderCell.h
//  ITherm
//
//  Created by Anveshak on 2/21/18.
//  Copyright © 2018 Anveshak . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomHeaderCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel* starttime;
@property (nonatomic, weak) IBOutlet UILabel* endtime;

@property (nonatomic, weak) IBOutlet UIImageView* image; 
@end
