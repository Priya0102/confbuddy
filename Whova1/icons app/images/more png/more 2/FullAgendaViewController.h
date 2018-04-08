//
//  FullAgendaViewController.h
//  ITherm
//
//  Created by Anveshak on 2/20/18.
//  Copyright © 2018 Anveshak . All rights reserved.
//

#import "ViewController.h"
#import "AgendaViewCell.h"
#import "AppDelegate.h"
#import <UIKit/UIKit.h>
#import "SessionViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Paper_author.h"
#import "Session_itherm.h"
#import "Paper_itherm.h"
#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>
#import "WomenViewController.h"
#import "KeyViewController.h"
#import "BreakViewController.h"
#import "CourseViewController.h"
#import "PosterViewController.h"

@interface FullAgendaViewController : UIViewController<NSURLSessionDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSString *day;
}
@property (strong,nonatomic) NSArray *fetchreminders;

@property (strong,nonatomic) NSMutableArray *all_authors,*prog_id_arr,*session_id_arr;
@property (strong,nonatomic) NSMutableArray *all_sessions;
@property (strong,nonatomic) NSMutableArray *all_papers;

@property (strong,nonatomic) NSMutableArray *user_sessions;
@property (strong,nonatomic) NSMutableArray *headerArray,*sessionModels,*sessArr;



@property (strong, nonatomic) IBOutlet UIView *line1;
@property (strong, nonatomic) IBOutlet UIView *line2;
@property (strong, nonatomic) IBOutlet UIView *line3;
@property (strong, nonatomic) IBOutlet UIView *line4;

@property (strong,nonatomic) NSArray *session;

//@property (weak, nonatomic) IBOutlet UILabel *date;

@property (strong, nonatomic) EKEventStore *eventStore;
@property (copy, nonatomic) NSArray *reminders;
@property (strong,nonatomic) NSMutableArray <EKReminder *>  *myrem;
@property (strong,nonatomic) NSMutableArray <NSString *>  *rem;
@property (nonatomic) BOOL isAccessToEventStoreGranted;

@property (strong, nonatomic) IBOutlet UITableView *tableView;


//@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segView;

@property(nonatomic,strong) IBOutlet NSString *bottomBorder;
@property(nonatomic,strong) NSArray *result;

@property (strong,nonatomic) NSString *program_type_id;
@property(nonatomic,retain)NSString *tempstr2;


@property(nonatomic,retain)NSString *startb_str,*endb_str,*locationb_str,*date_str,*session_str,*absStr,*uniStr,*keyNameStr;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property(nonatomic,retain)NSMutableArray *tickArr;



@end
