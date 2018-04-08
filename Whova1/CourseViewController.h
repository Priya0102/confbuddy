//
//  CourseViewController.h
//  ITherm
//
//  Created by Anveshak on 3/31/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseTableViewCell.h"
#import "Course_itherm.h"
#import "CourseDetailViewController.h"
#import "Course_Leader.h"
#import <UserNotifications/UserNotifications.h>
#import <QuartzCore/QuartzCore.h>
@interface CourseViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NSURLSessionDelegate>
   
   
    @property (strong, nonatomic) IBOutlet UITableView *tableview;
    
    @property (weak, nonatomic) IBOutlet UILabel *startTime;
    @property (weak, nonatomic) IBOutlet UILabel *endTime;
    @property (weak, nonatomic) IBOutlet UILabel *date;
    @property (weak, nonatomic) IBOutlet UILabel *loca;
    @property (weak, nonatomic) IBOutlet UILabel *session_name;
@property (weak, nonatomic) IBOutlet UILabel *sessionidLbl;
 @property(nonatomic,retain)NSString *temp_session_id,*tempCourse,*templeader,*tempuni;

@property(nonatomic,retain)NSString *stimestr,*etimestr,*locationstr,*datestr,*sessionnamestr,*courseidstr,*coursenamestr,*leadernamestr,*courseabstractstr,*coursenostr;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
//-(void)dataParsing;
@property(nonatomic,retain)NSOperationQueue *que;

@property(nonatomic,retain)NSMutableArray *courseNameArray,*leaderNameArray,*courseid,*courseNamearr;



@property (strong,nonatomic) Session_itherm *sess;

@property (strong,nonatomic) Course_itherm *pi;
@property (strong,nonatomic) NSMutableArray *paper_id;
@property (strong,nonatomic) NSMutableArray *course_name,*added;
@property (strong,nonatomic) NSMutableArray *all_authors;
@property (strong,nonatomic) NSMutableArray *course_abstract;
@property (strong,nonatomic) NSArray *filtered;

@property (weak, nonatomic) IBOutlet UILabel *line;


- (IBAction)alramButtonClick:(id)sender;
//-(void)paperParsing;
@property (weak, nonatomic) IBOutlet UIButton *setButton;
@property (weak, nonatomic) IBOutlet UIImageView *setImage;

@property(nonatomic,retain)NSMutableArray *tickarray;

@property (strong, nonatomic) IBOutlet UIButton *viewMapBtn;

@property (strong,nonatomic) NSMutableArray *all_papers,*user_papers,*result;



@end
