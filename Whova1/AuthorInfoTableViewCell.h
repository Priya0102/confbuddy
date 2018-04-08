//
//  AuthorInfoTableViewCell.h
//  ITherm
//
//  Created by Anveshak on 11/22/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuthorInfoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *affiliation;
@property (weak, nonatomic) IBOutlet UILabel *authorid;
@property (weak, nonatomic) IBOutlet UILabel *paperid;
@property (weak, nonatomic) IBOutlet UILabel *authorname;

@end
