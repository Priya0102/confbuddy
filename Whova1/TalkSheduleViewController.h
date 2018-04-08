//
//  TalkSheduleViewController.h
//  ITherm
//
//  Created by Anveshak on 5/24/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>
#import <QuartzCore/QuartzCore.h>

@interface TalkSheduleViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,NSURLSessionDelegate>

@property (weak, nonatomic) IBOutlet UILabel *sessionName;
@property (weak, nonatomic) IBOutlet UILabel *startTime;
@property (weak, nonatomic) IBOutlet UILabel *endTime;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (strong, nonatomic) IBOutlet UILabel *chairname;
@property (strong, nonatomic) IBOutlet UILabel *chairuniversity;
@property (strong, nonatomic) IBOutlet UIView *talkView;

@property (strong, nonatomic) IBOutlet UIImageView *chairimage;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,retain)NSString *session_idstr;
@property(nonatomic,retain)NSMutableArray *talkArray;

@property(nonatomic,retain)NSString *tempNamestr,*sessNamestr,*stime,*etime,*locationstr;
@property(nonatomic,retain)NSString *tempsession,*tempuni,*tempabstract;

@property(nonatomic,retain)NSString *temptalkname,*temptalkuni,*tempabs,*tempspeakerName,*tempspuni,*temptalkid;
@property (strong,nonatomic) NSMutableArray *paper_id,*user_papers;

@property(nonatomic,retain)NSMutableArray *tickarray;
-(void)dataParsing;
@property(nonatomic,retain)NSOperationQueue *que;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

@property(nonatomic,retain)NSString *categorystr;

- (IBAction)cellDeleteBtnClick:(id)sender;
- (IBAction)deleteBtn:(id)sender;




@end
