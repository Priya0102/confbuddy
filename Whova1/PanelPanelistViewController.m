//
//  PanelPanelistViewController.m
//  ITherm
//
//  Created by Anveshak on 12/13/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import "PanelPanelistViewController.h"
#import "PanelPanelistTableViewCell.h"
#import "PanelPanelist.h"
#import "Constant.h"
@interface PanelPanelistViewController ()

@end

@implementation PanelPanelistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    
    [_tableview setSeparatorColor:[UIColor clearColor]];
    _sessionid.text=_tempsessionid;
    NSLog(@"panel sess id==%@",_tempsessionid);
    _panelistarr=[[NSMutableArray alloc]init];

    
    _que=[[NSOperationQueue alloc]init];
    
    [self panelparsing];
}


-(void)panelparsing
{
    
    
    NSBlockOperation *op1=[NSBlockOperation blockOperationWithBlock:^{
        
        [_panelistarr removeAllObjects];
        NSString *myst=[NSString stringWithFormat:@"session_id=%@",_tempsessionid];
        NSLog(@"POST CONTAINT....%@",myst);
       
        NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:panelcopy]];
        
        //NSString *url=@"http://192.168.1.100/phpmyadmin/itherm/panelcopy.php";
    
        NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
        NSError *error=nil;
        if(error)
        {
            NSLog(@"%@",error.description);
        }
        
        
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
                                            
                                            
                                            NSLog(@"panel response===%@",response);
                                            
                                            
                                            NSDictionary *outerdic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                            NSArray *panelarr=[outerdic objectForKey:@"all_panel"];
                                            for(NSDictionary *outerdic1 in panelarr)
                                            {
                                                //  _session_namestr=[outerdic objectForKey:@"session_name"];
                                                _sessionstr=[outerdic1 objectForKey:@"session_name"];
                                                _abstractstr=[outerdic1 objectForKey:@"abstract"];
                                                _chairnamestr=[outerdic1 objectForKey:@"chair"];
                                                _universitystr=[outerdic1 objectForKey:@"university"];
                                                _panelnamestr=[outerdic1 objectForKey:@"panel_name"];
                                                
                                                [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                                                    _sessionName.text=_sessionstr;
                                                    _abstract.text=_abstractstr;
                                                    _chairname.text=_chairnamestr;
                                                    _university.text=_universitystr;
                                                    _panelname.text=_panelnamestr;
                                                    
                                                }];
                                                
                                                NSArray *panelarr2=[outerdic1 objectForKey:@"panelist"];
                                                for(NSDictionary *temp in panelarr2)
                                                {
                                                    PanelPanelist *w=[[PanelPanelist alloc]init];
                                                    w.pname=temp[@"panelist_name"];
                                                    w.puniversity=temp[@"panelist_university"];
                                                    
                                                    [_panelistarr addObject:w];
                                                    
                                                    [_tableview reloadData];
                                                }
                                                
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
    return _panelistarr.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PanelPanelistTableViewCell  *cell=[_tableview dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    PanelPanelist *w=[_panelistarr objectAtIndex:indexPath.row];
    cell.panelist_name.text=w.pname;
    cell.panelist_university.text=w.puniversity;
    
    
    return cell;
}

@end
