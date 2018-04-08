//
//  LeaderViewController.h
//  ITherm
//
//  Created by Anveshak on 12/6/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeaderViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong,nonatomic) NSMutableArray *authorinfoarr;
@property (weak, nonatomic) IBOutlet UILabel *course_id;

@property (strong,nonatomic) NSString *courseidstr;

@end
