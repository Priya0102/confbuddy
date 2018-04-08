//
//  PanelistViewController.h
//  ITherm
//
//  Created by Anveshak on 12/13/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PanelistViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,retain) NSMutableArray *panelist_namearr;
@property (retain,nonatomic) NSMutableArray *panelist_universityarr;

@property(nonatomic,retain)NSString *session_namestr,*mod_namestr,*mod_universitystr,*comod_namestr,*comod_universitystr,*infostr;
-(void)womenparsing;
@property(nonatomic,retain)NSOperationQueue *que;
@property (weak, nonatomic) IBOutlet UILabel *information;
@property (retain, nonatomic) IBOutlet UILabel *mod_name;
@property (weak, nonatomic) IBOutlet UILabel *mod_university;
@property (weak, nonatomic) IBOutlet UILabel *comod_name;
@property (weak, nonatomic) IBOutlet UILabel *comod_university;
@end
