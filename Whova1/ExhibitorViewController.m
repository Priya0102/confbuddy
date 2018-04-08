//
//  ExhibitorViewController.m
//  ITherm
//
//  Created by Anveshak on 11/23/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import "ExhibitorViewController.h"
#import "ExhibitorTableViewCell.h"
#import "Exhibitor.h"
#import "Constant.h"
@interface ExhibitorViewController ()

@end

@implementation ExhibitorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    // Do any additional setup after loading the view.
    [self.tableView setSeparatorColor:[UIColor clearColor]];
    
    [_tableView setShowsHorizontalScrollIndicator:NO];
    [_tableView setShowsVerticalScrollIndicator:NO];
    // Do any additional setup after loading the view.
    _namearr=[[NSMutableArray alloc]init];
    _urlarr=[[NSMutableArray alloc]init];
    _imgarray=[[NSMutableArray alloc]init];
    _sponsorarr=[[NSMutableArray alloc]init];
    
    _tableView.delegate=self;
    _tableView.dataSource=self;
    
    [self parsingKeyNotes];
}

-(void)viewWillAppear:(BOOL)animated
{
    //_urlstr=@"http://siddhantedu.com/iOSAPI/key.php";
    
    // [self parsingKeyNotes];
}

-(void)parsingKeyNotes
{
    queue=dispatch_queue_create("images", DISPATCH_QUEUE_CONCURRENT);
    queue=dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0);
    
    [_namearr removeAllObjects];
    [_imgarray removeAllObjects];
    [_urlarr removeAllObjects];
    [_sponsorarr removeAllObjects];
    
   NSURL * urlstr = [NSURL URLWithString:[mainUrl stringByAppendingString:sponsor]];
    
    //NSString *urlstr=@"http://192.168.1.100/phpmyadmin/itherm/sponsor.php";
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:urlstr];
    _newurlpass=_urlstr;
    // NSLog(@"%@",_newurlpass);
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
                                        
                                        NSArray *keyarr=[outerdic objectForKey:@"sponsors"];
                                        
                                        for(NSDictionary *temp in keyarr)
                                        {
                                            NSString *str1=[[temp objectForKey:@"name"]description];
                                            NSString *str2=[[temp objectForKey:@"url"]description];
                                            
                                            NSString *str3=[temp objectForKey:@"images"];
                                            
                                            
                                            [_imgarray addObject:str3];
                                            NSLog(@"str4  %@",str3);
                                            Exhibitor *k1=[[Exhibitor alloc]init];
                                            k1.name=str1;
                                            k1.url=str2;
                                            k1.imgurl=str3;
                                            
                                            [_sponsorarr addObject:k1];
                                            
                                            [_tableView reloadData];
                                        }
                                        [_tableView reloadData];
                                    }
                                    [_tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
                                }];
    [task resume];
    
    [_tableView reloadData];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _sponsorarr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExhibitorTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    Exhibitor *ktemp=[_sponsorarr objectAtIndex:indexPath.row];
    
    cell.kname.text=ktemp.name;
    cell.kurl.text=ktemp.url;
    
    // cell.kurl.userInteractionEnabled = YES;
    
    //    UITapGestureRecognizer *gestureRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openUrl:)];
    //    gestureRec.numberOfTouchesRequired = 1;
    //    gestureRec.numberOfTapsRequired = 1;
    //    [cell.kurl addGestureRecognizer:gestureRec];
    //[gestureRec release];
    
    
    
    [_indicator stopAnimating];
    //  NSString *tempimgstr=ktemp.keyimage;
    //[cell.imageView sd_setImageWithURL:[NSURL URLWithString:tempimgstr]
    //placeholderImage:[UIImage imageNamed:@"default.png"]];
    NSString *kImgLink=[_imgarray objectAtIndex:indexPath.row];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // retrive image on global queue
        UIImage * img = [UIImage imageWithData:[NSData dataWithContentsOfURL:     [NSURL URLWithString:kImgLink]]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // assign cell image on main thread
            cell.kimagev.image = img;
        });
    });
    
    
    
    return cell;
}
@end
