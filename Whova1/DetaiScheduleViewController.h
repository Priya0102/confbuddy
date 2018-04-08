//
//  DetaiScheduleViewController.h
//  ITherm
//
//  Created by Anveshak on 5/8/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetaiScheduleViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,NSURLSessionDelegate>

@property (weak, nonatomic) IBOutlet UILabel *sessionLbl;
@property (weak, nonatomic) IBOutlet UILabel *locationName;
@property (weak, nonatomic) IBOutlet UILabel *startTime;
@property (weak, nonatomic) IBOutlet UILabel *endTime;
@property (weak, nonatomic) IBOutlet UITableView *tableVIew;
@property(nonatomic,retain)NSString *tempsessionName,*tempsessionid,*tempabstr,*startstr,*endstr,*locstr,*paperstr,*paperidstr;

- (IBAction)cellDeleteBtnClick:(id)sender;
- (IBAction)deleteBtn:(id)sender;

@property(nonatomic,retain)NSMutableArray *pprarr;

    @property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

-(void)paperParsing;

@property(nonatomic,retain)NSString *categoryStr;
@property (strong, nonatomic) IBOutlet UIView *paperView;

@end
