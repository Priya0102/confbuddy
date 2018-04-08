//
//  LeaderViewController.m
//  ITherm
//
//  Created by Anveshak on 12/6/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import "LeaderViewController.h"
#import "LeaderTableViewCell.h"
#import "Leader.h"
#import "Constant.h"
@interface LeaderViewController ()

@end

@implementation LeaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableview setSeparatorColor:[UIColor clearColor]];
    
    
    _tableview.delegate=self;
    _tableview.dataSource=self;
    _course_id.text=self.courseidstr;
    NSLog(@"cOURSE ID sTR=%@",_courseidstr);
    
    _authorinfoarr=[[NSMutableArray alloc]init];
    
   [self authordataParsing];

}
-(void)authordataParsing
{
    
    [_authorinfoarr removeAllObjects];
    
    NSString *myst=[NSString stringWithFormat:@"course_id=%@",_courseidstr];
    NSLog(@"***course_id leader loop==%@",myst);
    
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *sess=[NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURL * urlstr = [NSURL URLWithString:[mainUrl stringByAppendingString:get_leader_info]];
    
   // NSString *urlstr=@"http://192.168.1.100/phpmyadmin/itherm/get_leader_info.php";
    
    NSMutableURLRequest *req=[NSMutableURLRequest requestWithURL:urlstr];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask *task=[sess dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data==nil) {
            NSLog(@"dATA IS NIL");
        }
        else{
            NSLog(@"response leader==%@",response);
            
            NSDictionary *outerdic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSArray *arr=[outerdic objectForKey:@"authorinfo"];
            NSLog(@"authorinfo leader Array=%@",arr);
            
            for(NSDictionary *temp in arr){
                Leader *f=[[Leader alloc]init];
                f.courseidStr=temp[@"course_id"];
                    f.leaderstr=temp[@"leader"];
                f.universitystr=temp[@"university"];
                
                [_authorinfoarr addObject:f];
                [_tableview reloadData];
                
                
            }
            [_tableview reloadData];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableview reloadData];
        });
        
    }];
    
    [task resume];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.authorinfoarr.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LeaderTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    Leader *sess=self.authorinfoarr[indexPath.row];
    cell.leaderid.text=sess.leaderidStr;
    cell.courseid.text=sess.courseidStr;
    cell.leadername.text=sess.leaderstr;
    cell.university.text=sess.universitystr;
    
    return cell;
}

@end
