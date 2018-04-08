//
//  InvSchViewController.h
//  ITherm
//
//  Created by Anveshak on 12/19/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InvSchViewController : UIViewController<NSURLConnectionDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate,NSURLSessionDelegate>
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *consContainerHeight;

@property (weak, nonatomic) IBOutlet UIImageView *images;
@property (weak, nonatomic) IBOutlet UILabel *speakername;
@property (weak, nonatomic) IBOutlet UILabel *university;
@property (weak, nonatomic) IBOutlet UILabel *session_name;
@property (weak, nonatomic) IBOutlet UILabel *invited_name;
@property (weak, nonatomic) IBOutlet UILabel *invited_id;
@property (weak, nonatomic) IBOutlet UILabel *abstract;


@property (weak, nonatomic) IBOutlet UILabel *starttime;
@property (weak, nonatomic) IBOutlet UILabel *endtime;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UILabel *session_id;



@property(nonatomic,retain)NSString *imgstr,*namestr,*universitystr,*sess_namestr,*abstractstr,*indxpath,*success,*message,*keynotetiltestr,*temptalkname,*tempSpeakerName,*tempTalkid;

//-(void)keynoteparsing;
@property(nonatomic,retain)NSOperationQueue *que;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicator;


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *allnotifications,*imgarr,*usernamearr,*commentarr,*datearr,*keynotecommentarr;

@property(nonatomic,retain)NSString *tempname,*tempName,*tempdate,*temptime,*tempnotify_id,*tempimg,*locationstr,*starttimestr,*endtimestr;

@property (strong, nonatomic) IBOutlet UITextField *comments;

@property(nonatomic,retain)NSString *tempsessionid,*tempcomment;
@property (strong, nonatomic) IBOutlet UIButton *addMyScheduleBtn;
@property (strong, nonatomic) IBOutlet UIButton *addMyScheduleLargeBtn;
@property (strong, nonatomic) IBOutlet UILabel *count_lbl;
@property (strong, nonatomic) IBOutlet UILabel *count_comment;
@property (strong, nonatomic) IBOutlet UIButton *likeBtnClicked;

@property(nonatomic,retain)NSMutableArray *kimgarray,*abstrarray;
@property (strong, nonatomic) IBOutlet UIButton *postBtn;


@property (weak, nonatomic) IBOutlet UIView *popUpView;

- (void)showInView:(UIView *)aView animated:(BOOL)animated;


@end
