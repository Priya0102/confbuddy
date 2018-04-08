
//  SessTalkViewController.h
//  ITherm
//
//  Created by Anveshak on 5/19/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>
#import <QuartzCore/QuartzCore.h>
#import "Talk_itherm.h"
@interface SessTalkViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,NSURLSessionDelegate>
    
@property (strong, nonatomic) IBOutlet UIButton *viewMapBtn;
    @property (weak, nonatomic) IBOutlet UILabel *sessionName;
    @property (weak, nonatomic) IBOutlet UILabel *startTime;
    @property (weak, nonatomic) IBOutlet UILabel *endTime;
    @property (weak, nonatomic) IBOutlet UILabel *location;
    @property (strong, nonatomic) IBOutlet UILabel *chairname;
    @property (strong, nonatomic) IBOutlet UILabel *chairuniversity;
    
@property (strong, nonatomic) IBOutlet UIImageView *chairimage;
    @property (weak, nonatomic) IBOutlet UILabel *date;
    
    @property (weak, nonatomic) IBOutlet UITableView *tableView;
    @property(nonatomic,retain)NSString *session_idstr;
    @property(nonatomic,retain)NSMutableArray *talkArray;
    
    @property(nonatomic,retain)NSString *tempNamestr,*sessNamestr,*stime,*etime,*locationstr;
    @property(nonatomic,retain)NSString *tempsession,*tempuni,*tempabstract;
@property (strong,nonatomic) Session_itherm *sess;
@property (strong,nonatomic) Talk_itherm *pi;
    @property(nonatomic,retain)NSString *temptalkname,*temptalkuni,*tempabs,*tempspeakerName,*tempspuni,*temptalkid,*datestr;
@property (strong,nonatomic) NSMutableArray *talk_id,*user_papers,*talkArr;

@property(nonatomic,retain)NSMutableArray *tickarray;
-(void)dataParsing;
    @property(nonatomic,retain)NSOperationQueue *que;
    @property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

//- (IBAction)tickButtonClick:(id)sender;
//- (IBAction)alramButtonClick:(id)sender;
//-(void)techtalkuser;
@property (weak, nonatomic) IBOutlet UIButton *setButton;


@end
