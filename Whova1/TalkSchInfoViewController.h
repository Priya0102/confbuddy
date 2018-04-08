//
//  TalkSchInfoViewController.h
//  ITherm
//
//  Created by Anveshak on 12/19/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TalkSchInfoViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,NSURLSessionDelegate,UITextViewDelegate,NSURLConnectionDelegate>

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *consContainerHeight;
@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UILabel *sessionName;
@property (strong, nonatomic) IBOutlet UILabel *talk;
@property (strong, nonatomic) IBOutlet UILabel *speakeruniversity;
@property (strong, nonatomic) IBOutlet UILabel *speakerName;
@property (strong, nonatomic) IBOutlet UILabel *abstract;
@property (strong, nonatomic) IBOutlet UILabel *starttime;
@property (strong, nonatomic) IBOutlet UILabel *endtime;
@property (strong, nonatomic) IBOutlet UILabel *location;
@property (strong, nonatomic) IBOutlet UILabel *talk_id;
@property (weak, nonatomic) IBOutlet UILabel *session_id;

@property(nonatomic,retain)NSString *imgstr,*namestr,*universitystr,*sess_namestr,*abstractstr,*indxpath,*success,*message,*keynotetiltestr,*tempname,*tempName,*tempdate,*temptime,*tempnotify_id,*tempimg,*talkidstr,*locationstr,*starttimestr,*endtimestr,*tempsessionid,*tempcomment,*addedStr;

-(void)keynoteparsing;
@property(nonatomic,retain)NSOperationQueue *que;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (strong,nonatomic) NSMutableArray *allnotifications,*imgarr,*usernamearr,*commentarr,*datearr,*keynotecommentarr,*kimgarray,*abstrarray;

@property (strong, nonatomic) IBOutlet UITextField *comments;

@property (strong, nonatomic) IBOutlet UIButton *addMyScheduleBtn;
@property (strong, nonatomic) IBOutlet UIButton *addMyScheduleLargeBtn;

@property (strong, nonatomic) IBOutlet UILabel *count_like;
@property (strong, nonatomic) IBOutlet UILabel *count_comment;
@property (strong, nonatomic) IBOutlet UIButton *likeBtnClicked;

@property(nonatomic,retain)NSString *tempTalkName,*tempAbstract,*tempSpeakerName,*tempSpeakeruni,*tempSessionName;
@property (strong, nonatomic) IBOutlet UIButton *postBtn;

@property (weak, nonatomic) IBOutlet UIView *popUpView;

- (void)showInView:(UIView *)aView animated:(BOOL)animated;


@end
