
#import "SettingsViewController.h"
#import "HomeViewController.h"
@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)logoutclicked:(id)sender {
  [[NSUserDefaults standardUserDefaults] setObject:NULL forKey:@"email"];
}


@end
