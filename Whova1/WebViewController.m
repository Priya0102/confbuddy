
#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_indicaor startAnimating];
    
            self.navigationItem.backBarButtonItem.title=@"Back";
            UIBarButtonItem *newBackButton =
            [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                             style:UIBarButtonItemStylePlain
                                            target:nil
                                            action:nil];
            [[self navigationItem] setBackBarButtonItem:newBackButton];
    
    NSURLRequest *req=[NSURLRequest requestWithURL:[NSURL URLWithString:self.myurl]];
   
    [self.webview loadRequest:req];
    
    [_indicaor stopAnimating];
}

@end
