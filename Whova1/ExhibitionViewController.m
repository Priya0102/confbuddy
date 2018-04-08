//
//  ExhibitionViewController.m
//  ITherm
//
//  Created by Anveshak on 2/9/18.
//  Copyright © 2018 Anveshak . All rights reserved.


#import "ExhibitionViewController.h"
#import "Constant.h"
#import "Exhibition.h"
#import "ExhibitionTableViewCell.h"
@interface ExhibitionViewController ()
{
    CGFloat *isClicked;
}
@end

@implementation ExhibitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView setSeparatorColor:[UIColor clearColor]];
    
    [_tableView setShowsHorizontalScrollIndicator:NO];
    [_tableView setShowsVerticalScrollIndicator:NO];
    
    _namearr=[[NSMutableArray alloc]init];
    _numberarr=[[NSMutableArray alloc]init];
    _imgarray=[[NSMutableArray alloc]init];
    _artidArr=[[NSMutableArray alloc]init];
    _likedArr=[[NSMutableArray alloc]init];
    
    _exhibitionArr=[[NSMutableArray alloc]init];
    _artArr=[[NSMutableArray alloc]init];
    _tickArr=[[NSMutableArray alloc]init];
    
    _tableView.delegate=self;
    _tableView.dataSource=self;
    
    [self parsingArtExhibition];
   
 
}

-(void)viewWillAppear:(BOOL)animated
{
     [self artExhibitionLiked];
}

-(void)parsingArtExhibition
{
    queue=dispatch_queue_create("images", DISPATCH_QUEUE_CONCURRENT);
    queue=dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0);
    
    [_namearr removeAllObjects];
    [_imgarray removeAllObjects];
    [_numberarr removeAllObjects];
    [_exhibitionArr removeAllObjects];
    [_artidArr removeAllObjects];
  
    NSURL * urlstr = [NSURL URLWithString:[mainUrl stringByAppendingString:art_exhibition]];
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:urlstr];
    _newurlpass=_urlstr;
    
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
                                        
                                        NSArray *keyarr=[outerdic objectForKey:@"art_exhibition"];
                                        
                                        for(NSDictionary *temp in keyarr)
                                        {
                                            NSString *str1=[[temp objectForKey:@"name"]description];
                                            NSString *str2=[[temp objectForKey:@"number"]description];
                                            
                                            NSString *str3=[temp objectForKey:@"images"];
                                            NSString *str4=[temp objectForKey:@"art_id"];
                                           
                                            
                                            [_imgarray addObject:str3];
                                            NSLog(@"str4  %@",str3);
                                            Exhibition *k1=[[Exhibition alloc]init];
                                            k1.name=str1;
                                            k1.number=str2;
                                            k1.imgurl=str3;
                                            k1.artidStr=str4;
                                   
                                            
                                            NSLog(@"***Art id in loop***%@",str4);
                                   
                                            [[NSUserDefaults standardUserDefaults]setValue:str4 forKey:@"art_id"];
                                            NSLog(@"art_id in exhibition parsing data= %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"art_id"]);
                                            
                                            [_exhibitionArr addObject:k1];
                                            
                                            [_tableView reloadData];
                                        }
                                        [_tableView reloadData];
                                    }
                                    [_tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
                                }];
    [task resume];
    
    [_tableView reloadData];
    
}

-(void)addArtVote
{
    NSString *savedValue=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
    
    NSString *artid=[[NSUserDefaults standardUserDefaults]stringForKey:@"art_id"];
    
    NSString *myst=[NSString stringWithFormat:@"emailid=%@&art_id=%@",savedValue,artid];
    
    
    NSLog(@"**my string in exhibition=%@",myst);
    
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    
    NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:add_art_likes]];
    
    
    NSMutableURLRequest *urlrequest=[NSMutableURLRequest requestWithURL:url];
    [urlrequest setHTTPMethod:@"POST"];
    [urlrequest setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
    NSError *error=nil;
    if(error)
    {
        NSLog(@"%@",error.description);
    }
    
    
    
    NSURLSessionDataTask *task=[session dataTaskWithRequest:urlrequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                {
                                    if (error)
                                    {
                                        NSLog(@"%@",error.description);
                                    }
                                    NSString *text=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                    NSLog(@"data=%@",text);
                                    
                                    NSError *error1=nil;
                                    NSDictionary *responsedict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error1];
                                    if(error1)
                                    {
                                        NSLog(@"error 1 is %@",error1.description);
                                    }
                                    
                                    self.success=[responsedict objectForKey:@"success"];
                                    
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        
                                        if([self.success isEqualToString:@"1"])
                                        {
                                            [self getLikes];
                                            NSLog(@"Liked click.......");
                                            
                                            // [_likeBtnClicked setImage:[UIImage imageNamed:@"liked.png"] forState:UIControlStateNormal];
                                            //[_likeBtnClicked setUserInteractionEnabled:NO];
                                            
                                        }
                                        else
                                        {
                                            NSLog(@"Failure.......");
                                        }
                                    });
                                    
                                    NSLog(@"json = %@",responsedict);
                                    
                                    
                                }];
    [task resume];
    
}
-(void)artExhibitionLiked{
    
    queue=dispatch_queue_create("images", DISPATCH_QUEUE_CONCURRENT);
    queue=dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0);
    
    [_namearr removeAllObjects];
    [_imgarray removeAllObjects];
    [_numberarr removeAllObjects];
    [_exhibitionArr removeAllObjects];
    [_artidArr removeAllObjects];
    [_likedArr removeAllObjects];
    

    
        NSString *savedValue=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
        
        NSString *artid=[[NSUserDefaults standardUserDefaults]stringForKey:@"art_id"];
        
        NSString *myst=[NSString stringWithFormat:@"emailid=%@&art_id=%@",savedValue,artid];
        
        
        NSLog(@"**my string in exhibition in liked=%@",myst);
    
    
    NSURL * urlstr = [NSURL URLWithString:[mainUrl stringByAppendingString:art_exhibition_liked]];
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:urlstr];
    _newurlpass=_urlstr;
    
    NSURLSessionConfiguration *configuration=[NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session=[NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    
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
                                        
                                        NSArray *keyarr=[outerdic objectForKey:@"art_exhibition"];
                                        
                                        for(NSDictionary *temp in keyarr)
                                        {
                                            NSString *str1=[[temp objectForKey:@"name"]description];
                                            NSString *str2=[[temp objectForKey:@"number"]description];
                                            
                                            NSString *str3=[temp objectForKey:@"images"];
                                            NSString *str4=[temp objectForKey:@"art_id"];
                                            NSString *str5=[temp objectForKey:@"liked"];
                                            
                                            [_imgarray addObject:str3];
                                            NSLog(@"str4  %@",str3);
                                            Exhibition *k1=[[Exhibition alloc]init];
                                            k1.name=str1;
                                            k1.number=str2;
                                            k1.imgurl=str3;
                                            k1.artidStr=str4;
                                             k1.liked=str5;
                                            
                                            NSLog(@"***Art id in loop***%@",str4);
                                            
                                            [[NSUserDefaults standardUserDefaults]setValue:str4 forKey:@"art_id"];
                                            NSLog(@"art_id in exhibition parsing data= %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"art_id"]);
                                            
                                            [_exhibitionArr addObject:k1];
                                            
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
    return _exhibitionArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     ExhibitionTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    Exhibition *ktemp=[_exhibitionArr objectAtIndex:indexPath.row];
    
    cell.name.text=ktemp.name;
    cell.number.text=ktemp.number;
    cell.artid.text=ktemp.artidStr;
    cell.likeBtn.tag=indexPath.row;
    
    NSLog(@"likee btn tag===%ld",(long)cell.likeBtn.tag);
    
   [cell.likeBtn addTarget:self action:@selector(likeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
//    if ((ktemp.liked=@"1")) {
//        
//     [cell.likeBtn setBackgroundImage:[UIImage imageNamed:@"liked.png"] forState:UIControlStateNormal];
//    }else{
//         [cell.likeBtn setBackgroundImage:[UIImage imageNamed:@"like.png"] forState:UIControlStateNormal];
//    }
    
    NSString *tempadd=ktemp.liked;
    //NSString *likeid=ktemp.liked;
//NSLog(@"liked count==%@",ktemp.liked);
    
    if ([tempadd isEqual:NULL]) {
        NSLog(@"Tempdata is null.....");
        [cell.likeBtn setBackgroundImage:[UIImage imageNamed:@"like.png"] forState:UIControlStateNormal];
        //[cell.likeBtn setUserInteractionEnabled:YES];
    }
    else{
        NSLog(@"Show liked.......");
        
        [cell.likeBtn setBackgroundImage:[UIImage imageNamed:@"liked.png"] forState:UIControlStateNormal];
        //[cell.likeBtn setUserInteractionEnabled:NO];
    }

    
//    if ([[ktemp objectForKey:@"liked"]CFBooleanGetValue]) {
//        [cell.likeBtn setBackgroundImage:[UIImage imageNamed:@"liked.png"] forState:UIControlStateNormal];
//    }
//    if (cell.likeBtn.tag==1) {
//        [cell.likeBtn setBackgroundImage:[UIImage imageNamed:@"liked.png"] forState:UIControlStateNormal];
//        
//        NSLog(@"***liked image....");
//    }
//    else{
//        [cell.likeBtn setBackgroundImage:[UIImage imageNamed:@"like.png"] forState:UIControlStateNormal];
//        NSLog(@"***like image....");
//    }
    
    [_indicator stopAnimating];
    //  NSString *tempimgstr=ktemp.keyimage;
    //[cell.imageView sd_setImageWithURL:[NSURL URLWithString:tempimgstr]
    //placeholderImage:[UIImage imageNamed:@"default.png"]];
/*    NSString *kImgLink=[_imgarray objectAtIndex:indexPath.row];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // retrive image on global queue
        UIImage * img = [UIImage imageWithData:[NSData dataWithContentsOfURL:     [NSURL URLWithString:kImgLink]]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // assign cell image on main thread
            cell.kimagev.image = img;
        });
    });
    
    */ //uncomment to come image from server


    return cell;
}
-(void)likeBtnClicked:(id)sender{
    
    UIButton *senderButton=(UIButton *)sender;
    NSLog(@"current row=%ld",(long)senderButton.tag);
    
    Exhibition *tempObject=[_exhibitionArr objectAtIndex:senderButton.tag];
    NSLog(@"temp object=%@",tempObject.artidStr);
    
    
    [[NSUserDefaults standardUserDefaults]setValue:tempObject.artidStr forKey:@"artid"];
    
    
    NSLog(@"***art_id in like  exhibition parsing data= %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"artid"]);

    
    NSString *savedValue=[[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
    
    NSString *artid=[[NSUserDefaults standardUserDefaults]stringForKey:@"artid"];
    
    NSString *myst=[NSString stringWithFormat:@"emailid=%@&art_id=%@",savedValue,artid];
    
    
    NSLog(@"**my string in exhibition=%@",myst);
    
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    
    NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:add_art_likes]];
    
    
    NSMutableURLRequest *urlrequest=[NSMutableURLRequest requestWithURL:url];
    [urlrequest setHTTPMethod:@"POST"];
    [urlrequest setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
    NSError *error=nil;
    if(error)
    {
        NSLog(@"%@",error.description);
    }
    
    
    
    NSURLSessionDataTask *task=[session dataTaskWithRequest:urlrequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                {
                                    if (error)
                                    {
                                        NSLog(@"%@",error.description);
                                    }
                                    NSString *text=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                    NSLog(@"data=%@",text);
                                    
                                    NSError *error1=nil;
                                    NSDictionary *responsedict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error1];
                                    if(error1)
                                    {
                                        NSLog(@"error 1 is %@",error1.description);
                                    }
                                    
                                    self.success=[responsedict objectForKey:@"success"];
                                    
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        
                                        if([self.success isEqualToString:@"1"])
                                        {
                                            [self getLikes];
                                            NSLog(@"Liked click.......");
                                        
                                          NSIndexPath *indexpath = [NSIndexPath indexPathForRow:senderButton.tag inSection:0];
                                            
                                         ExhibitionTableViewCell   *tappedCell = (ExhibitionTableViewCell *)[_tableView cellForRowAtIndexPath:indexpath];
                                            
                                            
                                            if ([tappedCell.likeBtn.imageView.image isEqual:[UIImage imageNamed:@"liked.png"]])
                                            {
                                                [tappedCell.likeBtn setImage:[UIImage imageNamed:@"like.png"] forState:UIControlStateNormal];
                                                NSLog(@"like*****");
                                            }
                                           else
                                            {
                                                [tappedCell.likeBtn setImage:[UIImage imageNamed:@"liked.png"] forState:UIControlStateNormal];
                                                NSLog(@"likedddd*****");
                                            }
                                        }
                                        else
                                        {
                                            NSLog(@"Failure.......");
                                        }
                                    });
                                    [self.tableView reloadData];
                                    NSLog(@"json = %@",responsedict);
                                }];
    [task resume];
    

}

-(void)getLikes{
    
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSString *artid=[[NSUserDefaults standardUserDefaults]stringForKey:@"art_id"];
    
    NSString *myst2=[NSString stringWithFormat:@"art_id=%@",artid];
    
    NSLog(@"Art ID.....:%@",myst2);
    
    NSURL * url2 = [NSURL URLWithString:[mainUrl stringByAppendingString:get_art_likes]];
    
    // NSURL * url2 = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/get_keynote_likes.php"];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url2];
    
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[myst2 dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(error == nil)
        {
            NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
            //_count_like.text=text;
        
            NSLog(@"count.......*****%@",text);
        }
    }];
    
    [dataTask resume];
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray *selectedRows = [tableView indexPathsForSelectedRows];
    for(NSIndexPath *i in selectedRows)
    {
        if(![i isEqual:indexPath])
        {
            [tableView deselectRowAtIndexPath:i animated:NO];
            NSLog(@"***in did select row in exhibition....***");
        }
    }
    
}
@end
