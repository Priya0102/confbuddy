//
//  DetailNotiViewController.m
//  ITherm
//
//  Created by Anveshak on 4/27/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import "DetailNotiViewController.h"
#import "AbsViewController.h"
#import "UserNotiViewController.h"
@interface DetailNotiViewController ()

@end

@implementation DetailNotiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _name.text=_namestr;
    
    NSLog(@"%@",_namestr);
    _date.text=_datestr;
    _time.text=_timestr;
    //_desc.text=_descstr;
    _desctextview.text=_descstr;
    

    
//    UINavigationBar *navbar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
//    //do something like background color, title, etc you self
//    [self.view addSubview:navbar];
    
//    UINavigationItem *item = [[UINavigationItem alloc]
//                              init];
//    navbar.items= @[item];
//    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
//                                   initWithTitle:@"< Back"
//                                   style:UIBarButtonItemStylePlain
//                                   target:self
//                                   action:@selector(backBtnClicked:)];
//    item.leftBarButtonItem = backButton;
}
//-(void)backBtnClicked:(id)sender{
//    
//   
//    
//}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    AbsViewController *ab=[segue destinationViewController];
    ab.absStr=_desc.text;
    
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
