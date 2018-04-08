//
//  ExhibitorTableViewCell.h
//  ITherm
//
//  Created by Anveshak on 11/23/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExhibitorTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *kimagev;
@property (weak, nonatomic) IBOutlet UILabel *kname;
@property (weak, nonatomic) IBOutlet UILabel *kurl;

@end
