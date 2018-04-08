//
//  AfterLoginMainViewController.h
//  ITherm
//
//  Created by Anveshak on 3/1/18.
//  Copyright © 2018 Anveshak . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AfterLoginMainViewController : UIViewController<NSURLSessionDelegate,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
{
    dispatch_queue_t queue;
}
@property (strong,nonatomic) NSString *role_id;
@property (strong,nonatomic) NSArray *session;
@property (strong, nonatomic) IBOutlet UIScrollView *scroll2;
@property (strong, nonatomic) IBOutlet UIView *contentview2;
@property (strong, nonatomic) IBOutlet UIImageView *imgView2;
@property (strong, nonatomic) IBOutlet UIView *view1;

@property (strong, nonatomic) IBOutlet UIButton *btnTotalSession;
@property (strong, nonatomic) IBOutlet UIButton *keynoteBtn;
@property (strong, nonatomic) IBOutlet UIButton *myScheduleBtn;

@property (weak, nonatomic) IBOutlet UITableView *tableview1;
@property (strong,nonatomic) NSMutableArray *latestNotification,*upcomingSessions,*upcomingDateArray,*upcomingTimeArray,*upcomingLocationArr,*upcomingSessionArr,*upcomingSessDetailArr;

@property(nonatomic,retain)NSString *tempname,*tempdesc,*tempdate,*temptime,*tempnotify_id,*success,*tempSessid,*startstr,*locationstr,*datestr,*sessionnamestr,*endstr,*sessiondetailsstr;

@property (weak, nonatomic) IBOutlet UITableView *tableview2;
@property (strong, nonatomic) IBOutlet UILabel *todaySessionCount;
@property (strong, nonatomic) IBOutlet UILabel *sessionAttendedCount;
@property (strong, nonatomic) IBOutlet UILabel *scheduledItemsCount;



@end
