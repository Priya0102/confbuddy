//
//  UserNotiViewController.h
//  ITherm
//
//  Created by Anveshak on 5/17/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Notify.h"
//#import "DetailNotiViewController.h"
#import "NotificationsTableViewCell.h"


@interface UserNotiViewController : UIViewController<NSURLConnectionDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,NSURLSessionDelegate,UITextViewDelegate,UINavigationControllerDelegate,UINavigationBarDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableview2;
@property (strong,nonatomic) NSMutableArray *allnotifications,*latestNotification;

@property(nonatomic,retain)NSString *tempname,*tempdesc,*tempdate,*temptime,*tempnotify_id,*success;
@property (strong, nonatomic) IBOutlet UIButton *clearBtn;
@property (strong, nonatomic) IBOutlet UITableView *tableview1;
@property (strong, nonatomic) IBOutlet UILabel *latestUpdateLbl;
@property (strong, nonatomic) IBOutlet UILabel *allNotifiLabel;

//@property (strong, nonatomic) DetailNotiViewController *detailnotification;
@end
