//
//  ScheduleViewController.h
//  ITherm
//
//  Created by Anveshak on 1/30/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Session_itherm.h"
#import "AgendaViewCell.h"
@interface ScheduleViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,NSURLSessionDelegate>
{
    NSString *day;
}
@property (strong,nonatomic) NSMutableArray *all_sessions,*user_papers,*all_papers;
@property (strong,nonatomic) NSMutableArray *session,*papers;
//@property (strong,nonatomic) NSArray *papers;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segView;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property(nonatomic,retain)NSString *tempcatog,*tempsessionName,*tempsessid,*tempstart,*tempend,*temploc;
@property(nonatomic, strong) UIRefreshControl *refreshControl;
//-(void)paperParsing;
-(void)sessionParsing;

- (IBAction)deleteButtonClick:(id)sender;
@property(nonatomic,retain)NSString *tempstr2;
@property(nonatomic,retain)NSString *startb_str,*endb_str,*locationb_str,*date_str,*session_str,*category_str;
    @property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (strong, nonatomic) IBOutlet UITextView *noSchedule;
@property (strong, nonatomic) IBOutlet UIView *line1;
@property (strong, nonatomic) IBOutlet UIView *line2;
@property (strong, nonatomic) IBOutlet UIView *line3;
@property (strong, nonatomic) IBOutlet UIView *line4;

@property (strong,nonatomic) NSMutableArray *headerArray,*sessionModels,*sessArr;
@end
