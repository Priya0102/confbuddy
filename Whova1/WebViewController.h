
#import <UIKit/UIKit.h>
#import "Sponsor.h"

@interface WebViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *webview;

@property (nonatomic,strong) NSString *myurl;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicaor;

//@property  Sponsor *s1;
@end
