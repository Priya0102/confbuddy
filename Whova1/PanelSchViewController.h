//
//  PanelSchViewController.h
//  ITherm
//
//  Created by Anveshak on 12/21/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PanelSchViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UITextFieldDelegate,NSURLSessionDelegate>
@property (strong, nonatomic) IBOutlet UIButton *postBtn;

@property (weak, nonatomic) IBOutlet UILabel *sessionName;
@property (weak, nonatomic) IBOutlet UILabel *chairname;
@property (weak, nonatomic) IBOutlet UILabel *university;
@property (weak, nonatomic) IBOutlet UILabel *panelname;
@property (weak, nonatomic) IBOutlet UILabel *abstract;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property(nonatomic,retain)NSString *tempsessionid;
@property(nonatomic,retain)NSMutableArray *panelnamearr,*paneluniversityarr,*panelistarr,*commentarray,*imgarr,*commentarr,*usernamearr,*datearr;
@property(nonatomic,retain)NSString *sessionstr,*chairnamestr,*universitystr,*panelnamestr,*abstractstr,*stimeStr,*etimeStr,*locStr,*infostr,*sessionidStr,*success,*message,*tempcomment;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property(nonatomic,retain)NSOperationQueue *que;
-(void)dataParsing;
@property (weak, nonatomic) IBOutlet UILabel *starttime;
@property (weak, nonatomic) IBOutlet UILabel *endtime;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UILabel *sessionid;

@property (strong, nonatomic) IBOutlet UITableView *tableview2;
@property (strong, nonatomic) IBOutlet UILabel *count_like;
@property (strong, nonatomic) IBOutlet UILabel *count_comment;
@property (strong, nonatomic) IBOutlet UIButton *likeBtnClicked;
@property (strong, nonatomic) IBOutlet UITextField *comments;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *consContainerHeight;
@property (weak, nonatomic) IBOutlet UIView *popUpView;

- (void)showInView:(UIView *)aView animated:(BOOL)animated;
@end
