//
//  AuthorInfoViewController.h
//  ITherm
//
//  Created by Anveshak on 11/22/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuthorInfoViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *authorinfoarr;

@property (weak, nonatomic) IBOutlet UILabel *paper_id;

@property (strong,nonatomic) NSString *paperidstr;
@end
