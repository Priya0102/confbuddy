#import "ViewController.h"
#import "PatternViewCell.h"
#import "CommitteeViewController.h"
#import "AttendeeViewController.h"
#import "WebViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Constant.h"

#define IDIOM UI_USER_INTERFACE_IDIOM()
#define IPAD UIUserInterfaceIdiomPad
@interface ViewController ()
{
    NSUserDefaults *defaults;
    NSString *str;
}
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (strong, nonatomic) IBOutlet UIImageView *imgView2;

/* http://stackoverflow.com/questions/16832459/ios-launch-image-sizes */
@end

@implementation ViewController
@synthesize message;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.imgView2.layer.masksToBounds=YES;
    self.imgView2.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.imgView2.layer.borderWidth=1.1;
    //self.imgView2.layer.cornerRadius=10;
    self.imgView2.layer.shadowColor=[UIColor redColor].CGColor;
    
    self.navigationItem.hidesBackButton = NO;
    [self setupScrollView:self.scroll];
    [self setupScrollView2:self.scroll2];
    
   
    
    self.navigationItem.backBarButtonItem.title=@"Back";
        UIBarButtonItem *newBackButton =
        [[UIBarButtonItem alloc] initWithTitle:@""
                                         style:UIBarButtonItemStylePlain
                                        target:nil
                                        action:nil];
        [[self navigationItem] setBackBarButtonItem:newBackButton];
    
    NSString *savedValue = [[NSUserDefaults standardUserDefaults] stringForKey:@"email"];
    
    
    NSString *myst=[NSString stringWithFormat:@"user=%@",savedValue];
    
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    
   //NSURL * url = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/iOSAPI/2.php"];
    
//   NSURL *url=[NSURL URLWithString:@"http://www.siddhantedu.com/iOSAPI/2.php"];//server

    
    NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:two_2]];

    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[myst dataUsingEncoding:NSUTF8StringEncoding]];
   
    
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if(error == nil)
        {
            NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
            NSLog(@"data=%@",text);
            self.role_id=text;
        }
        NSError *er=nil;
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&er];
        if(er)
        {

        }
        self.role_id=[responseDict objectForKey:@"status"];
    }];
  
    
    [dataTask resume];

    UIPageControl *pgCtr=[[UIPageControl alloc]initWithFrame:CGRectMake(0, 264, 480,50)];
    [pgCtr setTag:12];
    pgCtr.numberOfPages=11;
    pgCtr.autoresizingMask=UIViewAutoresizingNone;
    [self.contentview addSubview:pgCtr];
    
    UIPageControl *pgCtr2=[[UIPageControl alloc]init];//WithFrame:CGRectMake(0, 264, 480,50)];
    [pgCtr2 setTag:5];
    pgCtr2.numberOfPages=11;
    pgCtr2.autoresizingMask=UIViewAutoresizingNone;
    [self.contentview2 addSubview:pgCtr2];
    
    defaults=[NSUserDefaults standardUserDefaults];//this will keep track as to weather notifications is on or off
    UIUserNotificationType types=UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    UIUserNotificationSettings *mySettings=[UIUserNotificationSettings settingsForTypes:types categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
    
    self.patternImagesArray=@[@"about@1x.png",@"agenda@1x.png",@"committee@1x.png",@"sponsors1@1x",@"myschedule@1x.png",@"speakers@1x.png",@"notifications1@1x.png",@"hotel@1x.png",@"maps2.png"];
    
    self.labelArray=@[@"About ITherm",@"Agenda",@"Committee",@"Exhibitors",@"My Schedule",@"Keynote Speakers",@"Notifications",@"Hotel",@"Art & Science"];
}

-(void)setupScrollView2:(UIScrollView *)scrMain{
    for (int i=1; i<=11; i++) {
        UIImage *image=[UIImage imageNamed:[NSString stringWithFormat:@"therminic.png"]];
        UIImage *image2=[UIImage imageNamed:[NSString stringWithFormat:@"eptc.png"]];
        UIImage *image3=[UIImage imageNamed:[NSString stringWithFormat:@"uci.png"]];
        UIImage *image4=[UIImage imageNamed:[NSString stringWithFormat:@"future.png"]];
        UIImage *image5=[UIImage imageNamed:[NSString stringWithFormat:@"polyonics.png"]];
        UIImage *image6=[UIImage imageNamed:[NSString stringWithFormat:@"jc.png"]];
        UIImage *image7=[UIImage imageNamed:[NSString stringWithFormat:@"wspc.png"]];
        UIImage *image8=[UIImage imageNamed:[NSString stringWithFormat:@"ieee.png"]];
        UIImage *image9=[UIImage imageNamed:[NSString stringWithFormat:@"huawei.png"]];
        UIImage *image10=[UIImage imageNamed:[NSString stringWithFormat:@"s3ip.png"]];
        UIImage *image11=[UIImage imageNamed:[NSString stringWithFormat:@"intel.png"]];
        // UIImage *image12=[UIImage imageNamed:[NSString stringWithFormat:@"h14.jpg"]];
        
        [_imgView2 setImage:image];
        _imgView2.animationImages=@[image,image2,image3,image4,image5,image6,image7,image8,image9,image10,image11];
        _imgView2.animationDuration=25.0;
        _imgView2.tag=i+1;
        
        [_imgView2 startAnimating];
    }
    
    
    [NSTimer scheduledTimerWithTimeInterval:8 target:self selector:@selector(scrollingTimer2) userInfo:nil repeats:YES];
}


-(void)setupScrollView:(UIScrollView *)scrMain{
    for (int i=1; i<=5; i++) {
        UIImage *image=[UIImage imageNamed:[NSString stringWithFormat:@"hotell1.png"]];
        UIImage *image2=[UIImage imageNamed:[NSString stringWithFormat:@"hotell2.png"]];
        UIImage *image3=[UIImage imageNamed:[NSString stringWithFormat:@"hotell3.png"]];
        UIImage *image4=[UIImage imageNamed:[NSString stringWithFormat:@"hotell4.png"]];
        UIImage *image5=[UIImage imageNamed:[NSString stringWithFormat:@"hotell5.png"]];
       
        [_imgView setImage:image];
        _imgView.animationImages=@[image,image2,image3,image4,image5];
        _imgView.animationDuration=30.0;
        _imgView.tag=i+1;
        
        [_imgView startAnimating];
    }
   
    
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(scrollingTimer) userInfo:nil repeats:YES];
}

-(void)scrollingTimer{
    UIScrollView *scrMain=(UIScrollView *)[self.view viewWithTag:1];
    UIPageControl *pgCtr=(UIPageControl*)[self.view viewWithTag:24];
    CGFloat contentOffset=self.scroll.contentOffset.x;
    
    
   int nextPage=(int)(contentOffset/self.scroll.frame.size.width)+1;
    
    if (nextPage!=5){
        [self.scroll scrollRectToVisible:CGRectMake(nextPage*self.scroll.frame.size.width,0,self.scroll.frame.size.width,self.scroll.frame.size.height)animated:YES];
        pgCtr.currentPage=nextPage;
    }else{
        [self.scroll scrollRectToVisible:CGRectMake(0,0,self.scroll.frame.size.width,self.scroll.frame.size.height)animated:YES];
        
        pgCtr.currentPage=0;
    }
}
-(void)scrollingTimer2{
    UIScrollView *scrMain=(UIScrollView *)[self.view viewWithTag:1];
    UIPageControl *pgCtr2=(UIPageControl*)[self.view viewWithTag:24];
    CGFloat contentOffset=self.scroll2.contentOffset.x;
    
    
    int nextPage=(int)(contentOffset/self.scroll2.frame.size.width)+1;
    
    if (nextPage!=12){
        [self.scroll2 scrollRectToVisible:CGRectMake(nextPage*self.scroll2.frame.size.width,0,self.scroll2.frame.size.width,self.scroll2.frame.size.height)animated:YES];
        pgCtr2.currentPage=nextPage;
    }else{
        [self.scroll2 scrollRectToVisible:CGRectMake(0,0,self.scroll2.frame.size.width,self.scroll2.frame.size.height)animated:YES];
        
        pgCtr2.currentPage=0;
    }
}



-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.patternImagesArray count];
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PatternViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"Pattern Cell" forIndexPath:indexPath];
    
    NSString *myPatternString=[self.patternImagesArray objectAtIndex:indexPath.row];
    cell.patternImageView.image=[UIImage imageNamed:myPatternString];
    cell.lbl2.text=self.labelArray[indexPath.row];
    return  cell;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//    if(self.view.frame.size.width==768.0f)
//    {
//        return 10.0;
//    }
    return 1.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1.0;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if(self.view.frame.size.height==1024.0f)
    {
        return CGSizeMake(206.0, 206.0);
    }
    if(self.view.frame.size.height==1366.0f)
    {
        return CGSizeMake(315.0, 260.0);
    }
    else
    {
        return CGSizeMake(103.0,73.0);
    }
    
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if([self.role_id isEqualToString:@"13"])
    {
        
        NSArray *segues=@[@"showAbout",@"showAgenda",@"showCommittee",@"showSponsor",@"showReminders",@"showKeynote",@"ToNotifications",@"showHotel",@"showHotelMap"];
        NSString *segueID=segues[indexPath.row];
        [self performSegueWithIdentifier:segueID sender:self];
        
    }
    else
    {
        NSArray *segues=@[@"showAbout",@"showAgenda",@"showCommittee",@"showSponsor",@"showReminders",@"showKeynote",@"ToUserNotifications",@"showHotel",@"showHotelMap"];
       
        NSString *segueID=segues[indexPath.row];
        
        [self performSegueWithIdentifier:segueID sender:self];
    }
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    
//    WebViewController *wvc=[segue destinationViewController];
//    
//    if ([segue.identifier isEqualToString:@"showpdf"]) {
//     
//        
//        //wvc.myurl=@"http://192.168.1.100/phpmyadmin/iOSAPI/ITherm2017_Advance_Program.pdf";
//       wvc.myurl=@"http://siddhantedu.com/iOSAPI/images/ITherm2017_Advance_Program.pdf";
//    }

//}

@end
