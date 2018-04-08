//
//  KeyViewController.h
//  ITherm
//
//  Created by Anveshak on 3/31/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeyViewController : UIViewController<NSURLConnectionDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate,NSURLSessionDelegate>



@property (strong, nonatomic) IBOutlet UILabel *addSchLbl;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *consContainerHeight;
    @property (weak, nonatomic) IBOutlet UIImageView *images;
    @property (weak, nonatomic) IBOutlet UILabel *name;
    @property (weak, nonatomic) IBOutlet UILabel *university;
    @property (weak, nonatomic) IBOutlet UILabel *session_name;
    @property (weak, nonatomic) IBOutlet UILabel *abstract;


@property (weak, nonatomic) IBOutlet UILabel *starttime;
@property (weak, nonatomic) IBOutlet UILabel *endtime;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UILabel *session_id;


@property(nonatomic,retain)NSString *imgstr,*namestr,*universitystr,*sess_namestr,*abstractstr,*indxpath,*success,*message,*keynotetiltestr,*tempname,*tempName,*tempdate,*temptime,*tempnotify_id,*tempimg,*sessionidstr,*locationstr,*starttimestr,*endtimestr,*tempsessionid,*tempcomment,*keynamestr,*addedstr;
;

-(void)keynoteparsing;
@property(nonatomic,retain)NSOperationQueue *que;
    @property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

    
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *allnotifications,*imgarr,*usernamearr,*commentarr,*datearr,*keynotecommentarr,*kimgarray,*abstrarray;


@property (strong, nonatomic) IBOutlet UITextField *comments;

@property (strong, nonatomic) IBOutlet UIButton *addMyScheduleBtn;
@property (strong, nonatomic) IBOutlet UIButton *addMyScheduleLargeBtn;
@property (strong, nonatomic) IBOutlet UILabel *count_lbl;
@property (strong, nonatomic) IBOutlet UILabel *count_comment;
@property (strong, nonatomic) IBOutlet UIButton *likeBtnClicked;

@property (strong, nonatomic) IBOutlet UIButton *postBtn;

@property (weak, nonatomic) IBOutlet UIView *popUpView;

- (void)showInView:(UIView *)aView animated:(BOOL)animated;
@property (strong, nonatomic) IBOutlet UIButton *viewMap;

@end
