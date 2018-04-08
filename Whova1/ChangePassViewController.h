

#import <UIKit/UIKit.h>

@interface ChangePassViewController : UIViewController<UITextFieldDelegate>
//@property (weak, nonatomic) IBOutlet UITextField *password;
@property (strong,nonatomic) NSString *username;
@property (weak, nonatomic) IBOutlet UITextField *old_password;

@property (weak, nonatomic) IBOutlet UITextField *confirm_password;
@property (weak, nonatomic) IBOutlet UITextField *password;



@property (strong,nonatomic) NSString *success;
@property (strong,nonatomic) NSString *message;

@end
