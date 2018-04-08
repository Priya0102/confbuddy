//
//  AuthorInfoViewController.m
//  ITherm
//
//  Created by Anveshak on 11/22/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import "AuthorInfoViewController.h"
#import "AuthorDetails.h"
#import "AuthorInfoTableViewCell.h"
#import "Constant.h"
@interface AuthorInfoViewController ()

@end

@implementation AuthorInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView setSeparatorColor:[UIColor clearColor]];
    

    _tableView.delegate=self;
    _tableView.dataSource=self;
    _paper_id.text=self.paperidstr;
    _authorinfoarr=[[NSMutableArray alloc]init];
    
    [self authordataParsing];
}

-(void)authordataParsing
{
    
    [_authorinfoarr removeAllObjects];
    
    NSString *myst=[NSString stringWithFormat:@"paper_id=%@",_paperidstr];
    NSLog(@"***paper_id author loop==%@",myst);
    
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *sess=[NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURL * urlstr = [NSURL URLWithString:[mainUrl stringByAppendingString:get_author_info]];
    
    //NSString *urlstr=@"http://192.168.1.100/phpmyadmin/itherm/get_author_info.php";
    
    NSMutableURLRequest *req=[NSMutableURLRequest requestWithURL:urlstr];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask *task=[sess dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data==nil) {
            NSLog(@"dATA IS NIL");
        }
        else{
            NSLog(@"response other facility==%@",response);
            
            NSDictionary *outerdic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSArray *arr=[outerdic objectForKey:@"authorinfo"];
            NSLog(@"authorinfo Array=%@",arr);
            
            for(NSDictionary *temp in arr){
                AuthorDetails *f=[[AuthorDetails alloc]init];
                f.authoridStr=temp[@"author_id"];
                f.authornameStr=temp[@"author_name"];
                f.affiliationStr=temp[@"affiliation"];
                
                [_authorinfoarr addObject:f];
                [_tableView reloadData];
                
                
            }
            [_tableView reloadData];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
        
    }];
    
    [task resume];
    [_tableView reloadData];
    
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
    AuthorInfoTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    AuthorDetails *sess=self.authorinfoarr[indexPath.row];
    cell.authorname.text=sess.authornameStr;
    cell.authorid.text=sess.authoridStr;
    cell.paperid.text=sess.paperidStr;
    cell.affiliation.text=sess.affiliationStr;
   
    return cell;
}
@end
