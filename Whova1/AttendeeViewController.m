
#import "AttendeeViewController.h"
#import "AuthorDetailViewController.h"
#import "Constant.h"
@interface AttendeeViewController ()

@end
//http://stackoverflow.com/documentation/ios/635/uilocalnotification#t=201701250926278226598
@implementation AttendeeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIActivityIndicatorView *indicator=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.frame=CGRectMake(self.view.window.center.x,self.view.window.center.y, 40.0, 40.0);
    indicator.center=self.view.center;
    [self.view addSubview:indicator];
    
    
    indicator.tintColor=[UIColor redColor];
    indicator.backgroundColor=[UIColor blackColor];
    [indicator bringSubviewToFront:self.view];
    // [UIApplication sharedApplication].networkActivityIndicatorVisible=true;
    [indicator startAnimating];
    
    self.paper_id=[[NSMutableArray alloc]init];
    self.paper_name=[[NSMutableArray alloc]init];
    self.all_authors=[[NSMutableArray alloc]init];
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];

   // NSURL * url = [NSURL URLWithString:@"http://192.168.1.100/phpmyadmin/itherm/speakers_last.php"];
     NSURL * url = [NSURL URLWithString:[mainUrl stringByAppendingString:speakers_last]];

    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(error == nil)
        {
            
            NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
            NSLog(@"data=%@",text);
            NSError *er=nil;
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&er];
            if(er)
            {
                NSLog(@"error is %@",er.description);
            }
            NSLog(@"data=%@",responseDict);
            NSArray *arr=[responseDict objectForKey:@"all_papers"];
            
            NSString *pid=0;
            NSString *pname;

            for(NSDictionary *dict in arr)
            {
                pid=dict[@"paper_id"];
                pname=dict[@"paper_name"];
                [self.paper_id addObject:pid];
                [self.paper_name addObject:pname];
                
                NSLog(@"pid is %@",pid);
                
                NSArray *authors=dict[@"author"];
                //NSLog(@"array is %@",authors);
                for(NSDictionary *dictionary in authors)
                {
                    Paper_author *aut=[[Paper_author alloc]init];
                    aut.paper_id=pname;
                    aut.emailid=dictionary[@"emailid"];
                    aut.first_name=dictionary[@"first_name"];
                    aut.last_name=dictionary[@"last_name"];
                    aut.country=dictionary[@"country"];
                    aut.affiliation=dictionary[@"affiliation"];
                    aut.salutation=dictionary[@"salutation"];
                    aut.mobile_no=dictionary[@"mobile_no"];
                    [self.all_authors addObject:aut];
                    //NSLog(@"name is %@",dictionary[@"first_name"]);
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                NSPredicate *predicate=[NSPredicate predicateWithFormat:@"paper_id matches 'p130'"];
                NSArray *filtered = [self.all_authors filteredArrayUsingPredicate:predicate];
                
                for(Paper_author *aut in filtered)
                {
                    NSLog(@"fn is %@",aut.first_name);
                    NSLog(@"ln is %@",aut.last_name);
                    NSLog(@"em is %@",aut.emailid);
                    NSLog(@"co is %@",aut.country);
                    NSLog(@"id is %@",aut.paper_id);
                    
                    
                }
            });
            
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            
            [indicator stopAnimating];
            //            NSString *match = @"P130";
            //
            //            NSPredicate *predicate1=[NSPredicate predicateWithFormat:@"SELF like[cd] %@",match];
            //            self.filteredarray = [self.paper_id filteredArrayUsingPredicate:predicate1];
            //            NSLog(@"%lu",(unsigned long)self.filteredarray.count);
            
        });
    }];
    
    [dataTask resume];
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.definesPresentationContext = YES;
    [self.searchController.searchBar sizeToFit];
    
    self.result=[[NSMutableArray alloc]init];
    //    self.searchresult=[[NSMutableArray alloc]init];
    
    
    
    self.searchController.searchBar.delegate=self;
    
    
    NSError *error=nil;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}


- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    
    NSString *searchString = searchController.searchBar.text;
    
    if(searchString.length >0)
    {
        
        NSPredicate *predicate1=[NSPredicate predicateWithFormat:@"SELF contains[cd] %@",searchString];
        self.filteredarray = [self.paper_name filteredArrayUsingPredicate:predicate1];
        NSLog(@"hi");
        // NSString *str=[self.searchresult objectAtIndex:0];
        //NSLog(@"string is %@",str);
    }
    // [self.tableView reloadData];
    
    [self.tableView reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    [self updateSearchResultsForSearchController:self.searchController];
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    
    searchBar.showsCancelButton=false;
    [searchBar resignFirstResponder];
    searchBar.text=@"";
    
    
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    //searchBar.showsCancelButton = NO;
    NSString *str=[self.searchresult objectAtIndex:0];
    NSLog(@"string is %@",str);
    
    [self.tableView reloadData];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(self.searchController.isActive)
    {
        NSLog(@"hi");
        NSLog(@"%lu",(unsigned long)self.filteredarray.count);
        
        return self.filteredarray.count;
    }
    return self.paper_name.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PaperTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if(self.paper_name[indexPath.row]==(NSString *) [NSNull null])
    {
        self.paper_name[indexPath.row]=@"";
    }
    //Author *a1=self.result[indexPath.row];
    //cell.papername.text=@"hello";
    if(self.searchController.isActive)
    {
        cell.papername.text=self.filteredarray[indexPath.row];
    }
    else
    {
        cell.papername.text=self.paper_name[indexPath.row];
    }
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // NSIndexPath *selectedRow = [[self tableView] indexPathForSelectedRow];
    
    NSIndexPath *path=[[self tableView] indexPathForSelectedRow];
    // Author *a1=self.result[path.row];
    NSString *paper_name=self.paper_name[path.row];
    if(self.searchController.isActive)
    {

       // NSString *paper_id=self.paper_id[path.row];

        paper_name=self.filteredarray[path.row];
        NSPredicate *predicate=[NSPredicate predicateWithFormat:@"paper_id matches %@",paper_name];
        NSArray *filtered = [self.all_authors filteredArrayUsingPredicate:predicate];
        
        for(Paper_author *aut in filtered)
        {
            NSLog(@"fn is %@",aut.first_name);
            NSLog(@"ln is %@",aut.last_name);
            NSLog(@"em is %@",aut.emailid);
            NSLog(@"co is %@",aut.country);
            NSLog(@"id is %@",aut.paper_id);
        }
        AuthorDetailViewController *avc=[segue destinationViewController];
        //avc.a1=[self.result objectAtIndex:path.row];
        avc.authors=filtered;
        avc.paper=paper_name;
        

    }
    else
    {
    
        NSString *paper_id=self.paper_id[path.row];
        NSLog(@"selected  is %@",paper_id);
        
     //   paper_id=self.filteredarray[path.row];
        NSLog(@"selected paperid is %@",paper_id);
        NSPredicate *predicate=[NSPredicate predicateWithFormat:@"paper_id matches %@",paper_name];
        NSArray *filtered = [self.all_authors filteredArrayUsingPredicate:predicate];

    for(Paper_author *aut in filtered)
    {
        NSLog(@"fn is %@",aut.first_name);
        NSLog(@"ln is %@",aut.last_name);
        NSLog(@"em is %@",aut.emailid);
        NSLog(@"co is %@",aut.country);
        NSLog(@"id is %@",aut.paper_id);
    }
        AuthorDetailViewController *avc=[segue destinationViewController];
        //avc.a1=[self.result objectAtIndex:path.row];
        avc.authors=filtered;
        avc.paper=paper_name;
    }
//    AuthorDetailViewController *avc=[segue destinationViewController];
//    //avc.a1=[self.result objectAtIndex:path.row];
//    avc.authors=filtered;
//    avc.paper=paper_name;
//    
//    // [self performSegueWithIdentifier:@"showAuthor" sender:nil];
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //[self prepareForSegue:@"showAuthor" sender:nil];
    [self performSegueWithIdentifier:@"showAuthor" sender:nil];
}

@end
