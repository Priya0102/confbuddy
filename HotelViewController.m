
#import "HotelViewController.h"
#import "WebViewController.h"
#import "HotelMapViewController.h"
@interface HotelViewController ()

@end

@implementation HotelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imgHotel.image=[UIImage imageNamed:@"hotell3.png"];
    self.imgHotel.layer.masksToBounds=YES;
    self.imgHotel.layer.borderColor=[UIColor blackColor].CGColor;
    self.imgHotel.layer.borderWidth=1.1;
    self.imgHotel.layer.cornerRadius=10;
    self.imgHotel.layer.shadowColor=[UIColor redColor].CGColor;
    
    //_btnHotel.layer.cornerRadius=10;
    _callPhone.layer.cornerRadius=10;
    [_scrollview setShowsHorizontalScrollIndicator:NO];
    [_scrollview setShowsVerticalScrollIndicator:NO];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    WebViewController *wvc=[segue destinationViewController];
    if ([segue.identifier isEqualToString:@"showHotelInfo"]) {
       wvc.myurl=@"http://www.sheratonsandiegohotel.com";
    }

   if ([segue.identifier isEqualToString:@"showHotelMap"]){
            HotelMapViewController *h=[segue destinationViewController];
        }
    
    
    if ([segue.identifier isEqualToString:@"showEsta"]){
        wvc.myurl=@"https://esta.cbp.dhs.gov/esta/";
    }


}


-(IBAction)callPhone:(id)sender{

    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"8885442523"]];
}
@end
