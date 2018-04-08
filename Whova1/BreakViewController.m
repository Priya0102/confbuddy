//
//  BreakViewController.m
//  ITherm
//
//  Created by Anveshak on 4/3/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import "BreakViewController.h"

@interface BreakViewController ()

@end

@implementation BreakViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _starttime_lbl.text=_startstr;
    _endtime_lbl.text=_endstr;
    _location_lbl.text=_locationstr;
    
    NSLog(@" break %@",_startstr);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
