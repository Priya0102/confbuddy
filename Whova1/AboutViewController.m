

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_scrollview setShowsVerticalScrollIndicator:NO];
    [_scrollview setShowsHorizontalScrollIndicator:NO];
//    if (self.view.frame.size.height==768.0f)
//    {
//        self.heightConstraint.constant=320;
//    }
//    else
//    {
//       // return CGSizeMake(103.0,73.0);
//        self.heightConstraint.constant=100;
//    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
