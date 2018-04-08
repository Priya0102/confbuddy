//
//  WomenViewController.h
//  ITherm
//
//  Created by Anveshak on 3/30/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WomenViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,NSURLSessionDelegate,UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *addSchLbl;

    @property (weak, nonatomic) IBOutlet UILabel *information;
    @property (retain, nonatomic) IBOutlet UILabel *mod_name;
    @property (weak, nonatomic) IBOutlet UILabel *mod_university;
    @property (weak, nonatomic) IBOutlet UILabel *comod_name;
    @property (weak, nonatomic) IBOutlet UILabel *comod_university;
@property (weak, nonatomic) IBOutlet UILabel *starttime;
@property (weak, nonatomic) IBOutlet UILabel *endtime;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UILabel *sessionid;

    @property (strong, nonatomic) IBOutlet UITableView *tableview;

@property (nonatomic,retain) NSMutableArray *panelist_namearr;
@property (retain,nonatomic) NSMutableArray *panelist_universityarr,*imgarr,*commentarr,*usernamearr,*datearr,*commentarray,*panelistarr;

@property(nonatomic,retain)NSString *session_namestr,*mod_namestr,*mod_universitystr,*comod_namestr,*comod_universitystr,*infostr,*sessionidStr,*stimeStr,*etimeStr,*locStr,*tempcomment,*success,*message;
-(void)womenparsing;

@property(nonatomic,retain)NSOperationQueue *que;

@property (strong, nonatomic) IBOutlet UITableView *tableview2;
@property (strong, nonatomic) IBOutlet UILabel *count_like;
@property (strong, nonatomic) IBOutlet UILabel *count_comment;
@property (strong, nonatomic) IBOutlet UIButton *likeBtnClicked;
@property (strong, nonatomic) IBOutlet UITextField *comments;
@property (strong, nonatomic) IBOutlet UIButton *addMyScheduleBtn;
@property (strong, nonatomic) IBOutlet UIButton *addMyScheduleLargeBtn;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *consContainerHeight;
@property (strong, nonatomic) IBOutlet UIButton *viewMap;


@property (strong, nonatomic) IBOutlet UIButton *postBtn;

@property (weak, nonatomic) IBOutlet UIView *popUpView;

- (void)showInView:(UIView *)aView animated:(BOOL)animated;
@end
