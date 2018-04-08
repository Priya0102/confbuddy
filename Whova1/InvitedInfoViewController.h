//
//  InvitedInfoViewController.h
//  ITherm
//
//  Created by Anveshak on 5/18/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>
#import <QuartzCore/QuartzCore.h>

@interface InvitedInfoViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,NSURLSessionDelegate>

@property (strong, nonatomic) IBOutlet UIButton *viewMap;
@property (weak, nonatomic) IBOutlet UILabel *sessionName;
@property (weak, nonatomic) IBOutlet UILabel *startTime;
@property (weak, nonatomic) IBOutlet UILabel *endTime;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,retain)NSString *session_idstr;
@property(nonatomic,retain)NSMutableArray *invitedArray;
@property(nonatomic,retain)NSMutableArray *tickarray;

@property(nonatomic,retain)NSString *tempNamestr,*sessNamestr,*stime,*etime,*locationstr,*tempTalkName,*tempSpeakerName,*tempTalkid,*success,*added;
@property(nonatomic,retain)NSString *tempsession,*tempuni,*tempimg,*tempabstract;
@property (strong,nonatomic) NSMutableArray *paper_id;

-(void)dataParsing;
    @property(nonatomic,retain)NSOperationQueue *que;
    @property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
    
- (IBAction)tickButtonClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *setButton;
@property (weak, nonatomic) IBOutlet UIImageView *setImage;
    
@end
