//
//  MainViewController.h
//  ITherm
//
//  Created by Anveshak on 2/27/18.
//  Copyright © 2018 Anveshak . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UIScrollView *scroll2;
@property (strong, nonatomic) IBOutlet UIView *contentview2;
@property (strong, nonatomic) IBOutlet UIImageView *imgView2;
@property (strong, nonatomic) IBOutlet UIView *view1;
@property (strong, nonatomic) IBOutlet UIView *view2;
@property (strong, nonatomic) IBOutlet UIButton *signInBtn;
@property (strong, nonatomic) IBOutlet UIButton *registerBtn;
@property (strong, nonatomic) IBOutlet UIImageView *profilePic;
@property (strong, nonatomic) IBOutlet UIButton *btnTotalSession;
@property (strong, nonatomic) IBOutlet UIButton *keynoteBtn;
@property (strong, nonatomic) IBOutlet UIButton *myScheduleBtn;
    @property (strong, nonatomic) IBOutlet UILabel *location;

    @property (strong, nonatomic) IBOutlet UILabel *startTime;
    @property (strong, nonatomic) IBOutlet UILabel *CurrentDate;
    @property (strong, nonatomic) IBOutlet UILabel *sessionName;
    @property (strong, nonatomic) IBOutlet UILabel *keynoteCount;
    @property (strong, nonatomic) IBOutlet UILabel *totalSessionCount;
    @property (strong, nonatomic) IBOutlet UIView *view3;
    @property (strong, nonatomic) IBOutlet UIButton *viewSessionBtn;
    @property (strong, nonatomic) IBOutlet UIButton *addSchBtn;

    @property (strong, nonatomic) IBOutlet UILabel *sessionDetails;
    
@property(nonatomic,retain)NSString *sessionNameStr,*sessionidStr,*startTimeStr,*dateStr,*roomnameStr,*programidStr,*categoryStr,*sessionDetailsStr;
//-(void)upcomingSessionparsing;
@property(nonatomic,retain)NSOperationQueue *que;

@property (weak, nonatomic) IBOutlet UITableView *tableview2;

@property (strong,nonatomic) NSMutableArray *upcomingSessions,*upcomingDateArray,*upcomingTimeArray,*upcomingLocationArr,*upcomingSessionArr,*upcomingSessDetailArr;

@property(nonatomic,retain)NSString *tempname,*tempdesc,*tempdate,*temptime,*tempnotify_id,*success,*tempSessid,*startstr,*locationstr,*datestr,*sessionnamestr,*endstr,*sessiondetailsstr;


@end
