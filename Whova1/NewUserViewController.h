
#import <UIKit/UIKit.h>

@interface NewUserViewController : UIViewController <UITextFieldDelegate,UIScrollViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>


@property (weak, nonatomic) IBOutlet UITextField *firstname;
@property (weak, nonatomic) IBOutlet UITextField *lastname;
@property (weak, nonatomic) IBOutlet UITextField *affiliation;
@property (weak, nonatomic) IBOutlet UITextField *emailid;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *confirm_password;
@property (weak, nonatomic) IBOutlet UITextField *country;
@property (strong,nonatomic) NSString *result;
@property (strong,nonatomic) NSString *message;
@property (weak, nonatomic) UITextField *activeField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
//@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIButton *registerBtn;
@property (strong, nonatomic) IBOutlet UIButton *signInBtn;

//- (IBAction)takePhoto:  (UIButton *)sender;
//- (IBAction)selectPhoto:(UIButton *)sender;
@end
