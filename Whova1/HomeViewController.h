

#import <UIKit/UIKit.h>
//#import "ProfileViewController.h"
#import "Reachability.h"

@interface HomeViewController : UIViewController <UITextFieldDelegate,NSURLConnectionDelegate>
@property (weak, nonatomic) IBOutlet UITextField *firstname;
@property (weak, nonatomic) IBOutlet UITextField *lastname;
@property (weak, nonatomic) IBOutlet UIImageView *user;
@property (weak, nonatomic) IBOutlet UIImageView *pass;
@property (weak, nonatomic) IBOutlet UIButton *loginbtn;
@property (weak, nonatomic) IBOutlet UIButton *neruserbtn;

@property (nonatomic,strong) NSString *result;
@property (strong,nonatomic) NSString *email;
@property (strong,nonatomic) NSString *failure;
@property(nonatomic,strong)UIColor *progressIndicator;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;

@property(weak,nonatomic)IBOutlet NSLayoutConstraint *widthConstraint;
@property(weak,nonatomic)IBOutlet NSLayoutConstraint *heightConstraint;
@end
