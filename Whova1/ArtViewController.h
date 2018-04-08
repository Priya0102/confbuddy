//
//  ArtViewController.h
//  ITherm
//
//  Created by Anveshak on 12/13/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArtViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,NSURLSessionDelegate,UITextViewDelegate>

 @property (weak, nonatomic) IBOutlet UILabel *sessionname;
 @property (weak, nonatomic) IBOutlet UILabel *information;
@property (retain, nonatomic) IBOutlet UILabel *chair_name;
@property (weak, nonatomic) IBOutlet UILabel *chair_university;
 @property (weak, nonatomic) IBOutlet UIImageView *chair_image;
@property (weak, nonatomic) IBOutlet UIImageView *cochair_image;
@property (weak, nonatomic) IBOutlet UILabel *cochair_name;
@property (weak, nonatomic) IBOutlet UILabel *cochair_university;
@property (strong, nonatomic) IBOutlet UITableView *tableview;
 @property (weak, nonatomic) IBOutlet UILabel *sessionid;

@property (retain,nonatomic) NSMutableArray *imgarr,*commentarr,*usernamearr,*datearr,*commentarray,*kimgarray,*artcommentarr;

@property(nonatomic,retain)NSString *session_namestr,*chair_namestr,*chair_universitystr,*cochair_namestr,*cochair_universitystr,*infostr,*sessionidStr,*tempcomment,*success,*message,*indxpath,*artidStr;

-(void)artparsing;

@property(nonatomic,retain)NSOperationQueue *que;
@property (strong, nonatomic) IBOutlet UILabel *count_like;
@property (strong, nonatomic) IBOutlet UILabel *count_comment;
@property (strong, nonatomic) IBOutlet UIButton *likeBtnClicked;
@property (strong, nonatomic) IBOutlet UITextField *comments;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *consContainerHeight;


@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;

@end
