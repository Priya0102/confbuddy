//
//  InvitedSheduleViewController.h
//  ITherm
//
//  Created by Anveshak on 5/24/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>
#import <QuartzCore/QuartzCore.h>

@interface InvitedSheduleViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,NSURLSessionDelegate,UITextFieldDelegate,UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *invitedView;
@property (weak, nonatomic) IBOutlet UILabel *sessionName;
@property (weak, nonatomic) IBOutlet UILabel *startTime;
@property (weak, nonatomic) IBOutlet UILabel *endTime;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,retain)NSString *session_idstr;
@property(nonatomic,retain)NSMutableArray *invitedArray;
@property(nonatomic,retain)NSMutableArray *tickarray;

@property(nonatomic,retain)NSString *tempNamestr,*sessNamestr,*stime,*etime,*locationstr;
@property(nonatomic,retain)NSString *tempsession,*tempuni,*tempimg,*tempabstract,*temptalkName,*tempSpeakerName,*tempinvid;
@property (strong,nonatomic) NSMutableArray *paper_id;

//-(void)dataParsing;
@property(nonatomic,retain)NSOperationQueue *que;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicator;


- (IBAction)cellDeleteBtnClick:(id)sender;
- (IBAction)deleteBtn:(id)sender;

@property(nonatomic,retain)NSString *categorystr;

@end
