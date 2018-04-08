//
//  CourseDetailViewController.h
//  ITherm
//
//  Created by Anveshak on 6/1/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseDetailTableViewCell.h"
#import "Course_Leader.h"
@interface CourseDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,UITextFieldDelegate,NSURLSessionDelegate,UITextViewDelegate>

{
    NSInteger b;
    
}
@property (strong, nonatomic) IBOutlet UIButton *postBtn;
@property (strong, nonatomic) IBOutlet UILabel *addSchLbl;
@property (weak, nonatomic) IBOutlet UILabel *sessionname;
@property (weak, nonatomic) IBOutlet UILabel *courselbl;
@property (weak, nonatomic) IBOutlet UILabel *coursename;
@property (weak, nonatomic) IBOutlet UILabel *courseno;
 @property (weak, nonatomic) IBOutlet UILabel *course_id;
@property (strong, nonatomic) IBOutlet UILabel *starttime;
@property (strong, nonatomic) IBOutlet UILabel *endtime;

@property (strong,nonatomic) NSMutableArray *leaders_arr,*university_arr;

@property(nonatomic,retain)NSString *tempSessionName,*tempCourseName,*tempsessionid,*tempcoursid,*tempcourseabs,*location,*starttimeStr,*leaderstr,*success,*message,*coursenoStr,*liked,*added;
    
@property (strong, nonatomic) IBOutlet UIButton *seemoreOutlet;
@property (strong, nonatomic) IBOutlet UIButton *viewMap;

@property (weak, nonatomic) IBOutlet UILabel *sessionid;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *course_abstract;
@property (weak, nonatomic) IBOutlet UIButton *btnRead;

@property(nonatomic,retain)NSString *abstractstr,*locationstr,*starttimestr,*endtimestr;
@property (weak, nonatomic) IBOutlet UILabel *locationlbl;


//- (IBAction)readClick:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *count_like;
@property (strong, nonatomic) IBOutlet UILabel *count_comment;
@property (strong, nonatomic) IBOutlet UIButton *likeBtnClicked;
@property (strong, nonatomic) IBOutlet UITextField *comments;

@property (strong,nonatomic) NSMutableArray *commentarray,*imgarr,*usernamearr,*commentarr,*datearr,*authornamearr,*affilitionarr,*authorinfoarr,*authoridarr,*salutionarr,*paperidarr,*firstnamearr,*lastnamearr,*session;

@property(nonatomic,retain)NSString *tempcomment,*temppaperid;
@property (weak, nonatomic) IBOutlet UITableView *tableView1;
@property (strong, nonatomic) IBOutlet UITableView *tableview2;

@property (strong, nonatomic) IBOutlet UIButton *addMyScheduleBtn;
@property (strong, nonatomic) IBOutlet UIButton *addMyScheduleLargeBtn;


    @property(nonatomic,retain)NSOperationQueue *que;


@property (strong, nonatomic) IBOutlet NSLayoutConstraint *consContainerHeight;



@property (weak, nonatomic) IBOutlet UIView *popUpView;
- (void)showInView:(UIView *)aView animated:(BOOL)animated;


@end

 
 
 
 
 
