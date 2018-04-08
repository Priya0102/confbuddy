//
//  KeynoteViewController.m
//  ITherm
//
//  Created by Anveshak on 11/17/17.
//  Copyright © 2017 Anveshak . All rights reserved.
//

#import "KeynoteViewController.h"
#import "Keynote.h"
#import "KeynoteDescViewController.h"
#import "KeyTableViewCell.h"
#import "Constant.h"
@interface KeynoteViewController ()

@end

@implementation KeynoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView setSeparatorColor:[UIColor clearColor]];
    
    [_indicator startAnimating];
    // Do any additional setup after loading the view.
    _keynote=[[NSMutableArray alloc]init];
    _talk=[[NSMutableArray alloc]init];
    _abstrarray=[[NSMutableArray alloc]init];
    _imgarray=[[NSMutableArray alloc]init];
    _sessionidArr=[[NSMutableArray alloc]init];
    
    _tableView.delegate=self;
    _tableView.dataSource=self;
    
    [self parsingKeyNotes];
    //[self invitedParsing];
    
}
-(void)viewWillAppear:(BOOL)animated{
   // [self segvaluechanged:_segC];
}
-(void)parsingKeyNotes
{
    queue=dispatch_queue_create("images", DISPATCH_QUEUE_CONCURRENT);
    queue=dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0);
    
    [_abstrarray removeAllObjects];
    [_imgarray removeAllObjects];
    [_keynote removeAllObjects];
    [_sessionidArr removeAllObjects];
    
    NSURL * urlstr = [NSURL URLWithString:[mainUrl stringByAppendingString:keynote1]];
    
    // NSString *urlstr=@"http://192.168.1.100/phpmyadmin/itherm/keynote1.php";
    
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
                                        
                                        NSArray *keyarr=[outerdic objectForKey:@"keynotes"];
                                        
                                        for(NSDictionary *temp in keyarr)
                                        {
                                            NSString *str1=[[temp objectForKey:@"name"]description];
                                            NSString *str2=[[temp objectForKey:@"university"]description];
                                            NSString *str3=[temp objectForKey:@"session_name"];
                                            NSString *str4=[temp objectForKey:@"images"];
                                            NSString *abstractstr=[temp objectForKey:@"abstract"];
                                            NSString *sessid=[temp objectForKey:@"session_id"];
                                            
                                            NSLog(@"%@    %@    %@      %@ %@",str1,str2,str3,abstractstr,sessid);
                                            
                                            [_abstrarray addObject:abstractstr];
                                            [_imgarray addObject:str4];
                                            NSLog(@"str4  %@",str4);
                                            Keynote *k1=[[Keynote alloc]init];
                                            k1.speakerName=str1;
                                            k1.university=str2;
                                            k1.keynoteTitle=str3;
                                            k1.keyimage=str4;
                                            k1.sessnidStr=sessid;
                                            
                                            [_keynote addObject:k1];
                                            
                                            [_tableView reloadData];
                                        }
                                        //[_tableView reloadData];
                                    }
                                    [_tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
                                }];
    [task resume];
    
  //  [_tableView reloadData];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _keynote.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KeyTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    Keynote *ktemp=[_keynote objectAtIndex:indexPath.row];
    
    cell.knametextf.text=ktemp.speakerName;
    cell.kuniversitytext.text=ktemp.university;
    cell.knotetext.text=ktemp.keynoteTitle;
    cell.sessionid.text=ktemp.sessnidStr;
    
    [_indicator stopAnimating];
    //    NSString *tempimgstr=ktemp.keyimage;
    //    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:tempimgstr]
    //                      placeholderImage:[UIImage imageNamed:@"default.png"]];
    //
    cell.kimagev.image = [UIImage imageNamed:@"default.png"];
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



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    KeyTableViewCell *cell=[_tableView cellForRowAtIndexPath:indexPath];
    
    _namestr=cell.knametextf.text;
    _unistr=cell.kuniversitytext.text;
    _keynotestr=cell.knotetext.text;
    _keynoteimg=cell.kimagev.image;
    _sessionidStr=cell.sessionid.text;
    
    _indxp=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
    NSLog(@"%ld",(long)indexPath.row);
    
    [self performSegueWithIdentifier:@"keydesc"
                              sender:[self.tableView cellForRowAtIndexPath:indexPath]];
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
   
    if ([[segue identifier] isEqualToString:@"keydesc"])
    {
       
        KeynoteDescViewController *kvc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        
        kvc.namestr=_namestr;
        kvc.unistr=_unistr;
        kvc.keystr=_keynotestr;
        kvc.kimg=_keynoteimg;
        kvc.newurlstr=_newurlpass;
        kvc.indxpath=_indxp;
        kvc.abstrarray=_abstrarray;
        kvc.kimgarray=_imgarray;
        kvc.tempsessionid=_sessionidStr;
    }
}





@end
