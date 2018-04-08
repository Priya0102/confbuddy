//
//  PaperSchTableViewCell.h
//  ITherm
//
//  Created by Anveshak on 12/19/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaperSchTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *affiliation;
@property (weak, nonatomic) IBOutlet UILabel *authorid;
@property (weak, nonatomic) IBOutlet UILabel *paperid;
@property (weak, nonatomic) IBOutlet UILabel *authorname;

@end
