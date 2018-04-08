//
//  PanelistViewController.m
//  ITherm
//
//  Created by Anveshak on 12/13/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import "PanelistViewController.h"
#import "PanelistTableViewCell.h"
#import "Constant.h"
@interface PanelistViewController ()

@end

@implementation PanelistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        [self.tableview setSeparatorColor:[UIColor clearColor]];
    
    _tableview.delegate=self;
    _tableview.dataSource=self;
    
    _panelist_namearr=[[NSMutableArray alloc]init];
    _panelist_universityarr=[[NSMutableArray alloc]init];
    
      _que=[[NSOperationQueue alloc]init];
    
    [self womenparsing];
}



-(void)womenparsing
{
    
    NSBlockOperation *op1=[NSBlockOperation blockOperationWithBlock:^{
        
        
        [_panelist_universityarr removeAllObjects];
        [_panelist_namearr removeAllObjects];
     
        NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:women]];
        
       // NSString *url=@"http://192.168.1.100/phpmyadmin/itherm/women.php";
        //         NSString *url=@"http://siddhantedu.com/iOSAPI/women.php";
        
        NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
        
        NSURLSessionConfiguration *configuration=[NSURLSessionConfiguration defaultSessionConfiguration];
        
        NSURLSession *session=[NSURLSession sessionWithConfiguration:configuration];
        
        NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                    {
                                        
                                        if(data==nil)
                                        {
                                            NSLog(@"Data is nil");
                                            
                                        }
                                        
                                        else
                                        {
                                            
                                            
                                            NSLog(@"%@",response);
                                            
                                            
                                            NSDictionary *outerdic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                            
                                            
                                            _mod_namestr=[outerdic objectForKey:@"mod_name"];
                                            _mod_universitystr=[outerdic objectForKey:@"mod_university"];
                                            _comod_namestr=[outerdic objectForKey:@"comod_name"];
                                            _comod_universitystr=[outerdic objectForKey:@"comod_university"];
                                            _infostr=[outerdic objectForKey:@"information"];
                                            
                                            
                                            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                                                _mod_name.text=_mod_namestr;
                                                _mod_university.text=_mod_universitystr;
                                                _comod_name.text=_comod_namestr;
                                                _comod_university.text=_comod_universitystr;
                                                _information.text=_infostr;
                                                
                                            }];
                                            
                                            NSArray *commonarr=[outerdic objectForKey:@"common"];
                                            for(NSDictionary *temp in commonarr)
                                            {
                                                NSString *str1=[temp objectForKey:@"panelist_name"];
                                                NSString *str2=[temp objectForKey:@"panelist_university"];
                                                
                                                NSLog(@"%@    %@   ",str1,str2);
                                                [_panelist_namearr addObject:str1];
                                                [_panelist_universityarr addObject:str2];
                                            }
                                            [_tableview reloadData];
                                        }
                                        
                                        [_tableview performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
                                    }];
        [task resume];
    }];
    
    [_que addOperation:op1];
    
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return _panelist_namearr.count;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        
       PanelistTableViewCell  *cell=[_tableview dequeueReusableCellWithIdentifier:@"cell"];
        cell.panelist_name.text=[_panelist_namearr objectAtIndex:indexPath.row];
        cell.panelist_university.text=[_panelist_universityarr objectAtIndex:indexPath.row];
    
   
    return cell;
}

@end
