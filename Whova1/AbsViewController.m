//
//  AbsViewController.m
//  ITherm
//
//  Created by Anveshak on 5/20/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import "AbsViewController.h"

@interface AbsViewController ()

@end

@implementation AbsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _abslabel.text=_absStr;
    
    [_scrollview setShowsHorizontalScrollIndicator:NO];
    [_scrollview setShowsVerticalScrollIndicator:NO];
    // Do any additional setup after loading the view.
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
