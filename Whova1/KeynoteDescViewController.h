//
//  KeynoteDescViewController.h
//  ITherm
//
//  Created by Anveshak on 11/17/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeynoteDescViewController : UIViewController<NSURLConnectionDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate,NSURLSessionDelegate>
{
    dispatch_queue_t queue;
    
}
@property (weak, nonatomic) IBOutlet UILabel *addKeyLbl;
@property (weak, nonatomic) IBOutlet UIImageView *kimgview;
@property (weak, nonatomic) IBOutlet UILabel *namelabel;
@property (weak, nonatomic) IBOutlet UILabel *universitylabel;
@property (weak, nonatomic) IBOutlet UILabel *keynotelabel;
@property (weak, nonatomic) IBOutlet UILabel *starttime;
@property (weak, nonatomic) IBOutlet UILabel *endtime;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UILabel *sessionid;
@property (weak, nonatomic) IBOutlet UILabel *abstractlabel;
@property(nonatomic,retain)NSString *namestr,*unistr,*keystr,*abstrctstr,*newurlstr,*indxpath;

@property(nonatomic,retain)UIImage *kimg;

@property(nonatomic,retain)NSMutableArray *kimgarray,*abstrarray;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (strong, nonatomic) IBOutlet UIButton *addMyScheduleBtn;
@property (strong, nonatomic) IBOutlet UIButton *addMyScheduleLargeBtn;

@property (strong,nonatomic) NSString *success;
@property (strong,nonatomic) NSString *message;
@property (strong, nonatomic) IBOutlet UILabel *count_lbl;
@property (strong, nonatomic) IBOutlet UILabel *count_comment;
@property (strong, nonatomic) IBOutlet UIButton *likeBtnClicked;
@property (strong, nonatomic) IBOutlet UIButton *btnRead;


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *allnotifications,*imgarr,*usernamearr,*commentarr,*datearr;

@property(nonatomic,retain)NSString *tempname,*tempName,*tempdate,*temptime,*tempnotify_id,*tempimg;

@property (strong, nonatomic) IBOutlet UITextField *comments;

@property(nonatomic,retain)NSString *tempsessionid,*tempcomment;

@property(nonatomic,retain)NSString *imgstr,*keynamestr,*universitystr,*sess_namestr,*abstractstr,*emailstr,*catstr,*addedstr;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *consContainerHeight;
@property (strong, nonatomic) IBOutlet UIButton *postBtn;

@property (weak, nonatomic) IBOutlet UIView *popUpView;

@end
