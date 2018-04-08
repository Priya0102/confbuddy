

#import <UIKit/UIKit.h>
#import "Attendee.h"
@interface ScrollViewController : UIViewController<NSURLConnectionDelegate,UITextFieldDelegate>


@property (strong,nonatomic) NSString *email;
@property (weak, nonatomic) IBOutlet UITextField *first_name;
@property (strong,nonatomic) NSMutableArray *myprofile;
@property (weak, nonatomic) IBOutlet UITextField *last_name;

@property (weak, nonatomic) IBOutlet UITextField *country_name;
@property (weak, nonatomic) IBOutlet UITextField *myemail;
@property (weak, nonatomic) IBOutlet UITextField *mobile_no;
@property (weak, nonatomic) IBOutlet UITextField *affiliation;
@property (weak, nonatomic) IBOutlet UITextField *fax;
@property int myid;
@property (weak, nonatomic) NSString *userid;
@property (weak, nonatomic) UITextField *activeField;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong,nonatomic) NSString *success;
@property (strong,nonatomic) NSString *message;

@end
