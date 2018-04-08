
#import <UIKit/UIKit.h>

@interface ForgotViewController : UIViewController <NSURLConnectionDelegate,NSURLSessionDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;

@property (strong,nonatomic) NSString *success;
@property (strong,nonatomic) NSString *message;


@end
