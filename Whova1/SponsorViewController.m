
#import "SponsorViewController.h"

@interface SponsorViewController ()

@end

@implementation SponsorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.goldsponsors=[[NSArray alloc]init];
    self.silversponsers=[[NSArray alloc]init];
    self.exhibitors=[[NSArray alloc]init];
//    self.partners=[[NSArray alloc]init];
//    self.programSponsers=[[NSArray alloc]init];
    
    
    /**** Gold Sponsors ****/
    Sponsor *s=[[Sponsor alloc]init];
    s.name=@"Intel";
    s.imgurl=@"intel.png";
    s.url=@"http://www.intel.com/";
    
   
    Sponsor *s1=[[Sponsor alloc]init];
    s1.name=@"Binghamton University S3IP Center";
    s1.imgurl=@"s3ip.png";
    s1.url=@"http://www.binghamton.edu/s3ip";
    
    Sponsor *s2=[[Sponsor alloc]init];
    s2.name=@"Microsanj";
    s2.imgurl=@"microsanj.png";
    s2.url=@"http://microsanj.com/";
    
    /**** Silver Sponsers ****/
    
    Sponsor *s3=[[Sponsor alloc]init];
    s3.name=@"Huawei Technologies Co";
    s3.imgurl=@"huawei.png";
    s3.url=@"http://www.huawei.com/en/";
    
    Sponsor *s33=[[Sponsor alloc]init];
    s33.name=@"IBM Corp.";
    s33.imgurl=@"ibm.png";
    s33.url=@"http://www.research.ibm.com";
    
    
    /**** Partners ****/
    
    Sponsor *s4=[[Sponsor alloc]init];
    s4.name=@"Therminic";
    s4.imgurl=@"therminic.png";
    s4.url=@"http://www.therminic2016.eu/";
    
    /**** Exhibitors ****/
    
    Sponsor *s5=[[Sponsor alloc]init];
    s5.name=@"Innovative Research, LLC";
    s5.imgurl=@"inres.png";
    s5.url=@"http://www.inresllc.com/";
    
   
    
    Sponsor *s6=[[Sponsor alloc]init];
    s6.name=@"Staubli";
    s6.imgurl=@"staubli.png";
    s6.url=@"https://www.staubli.com/";

    
    Sponsor *s7=[[Sponsor alloc]init];
    s7.name=@"World Scientific";
    s7.imgurl=@"wspc.png";
    s7.url=@"http://www.electronicspackaging.org/";
    
    
    
    Sponsor *s8=[[Sponsor alloc]init];
    s8.name=@"University of MaryLand";
    s8.imgurl=@"jc.png";
    s8.url=@"https://www.eng.umd.edu/";
    
    Sponsor *s9=[[Sponsor alloc]init];
    s9.name=@"Polyonics";
    s9.imgurl=@"polyonics.png";
    s9.url=@"polyonics.com";
    
    /***Partners****/
    
//    Sponsor *s10=[[Sponsor alloc]init];
//    s10.name=@"ECTC 2017";
//    s10.imgurl=@"ectc.png";
//    s10.url=@"http://www.electronicspackaging.org/";
//    
//    
//    
//    Sponsor *s11=[[Sponsor alloc]init];
//    s11.name=@"University of MaryLand";
//    s11.imgurl=@"jc.png";
//    s11.url=@"https://www.eng.umd.edu/";
//    
//    Sponsor *s12=[[Sponsor alloc]init];
//    s12.name=@"Polyonics";
//    s12.imgurl=@"polyonics.png";
//    s12.url=@"polyonics.com";

    
    
    self.goldsponsors=[NSArray arrayWithObjects:s,s1,s2,nil];
    self.silversponsers=[NSArray arrayWithObjects:s3,s33,nil];
    self.exhibitors=[NSArray arrayWithObjects:s5,s6,s7,s8,s9,nil];
    self.partners=[NSArray arrayWithObjects:s4,nil];
//    self.programSponsers=[NSArray arrayWithObjects:s5,s6,s7,s8,s9,nil];
    

}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
   
    if(section==0)
    {
        return self.exhibitors.count;
    }
    else
    {
        return 1;
    }
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SponsorsCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
   
    if(indexPath.section==0)
    {
        Sponsor *s=self.exhibitors[indexPath.row];
        
        cell.image.image=[UIImage imageNamed:s.imgurl];
        cell.detail.text=s.name;
        
    }
    if(indexPath.section==1)
    {
        Sponsor *s4=[[Sponsor alloc]init];
        s4.name=@"Therminic";
        s4.imgurl=@"therminic.png";
        s4.url=@"http://www.therminic2016.eu/";
        
        cell.image.image=[UIImage imageNamed:s4.imgurl];
        cell.detail.text=s4.name;
        
    }
    return  cell;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(360.0, 140.0);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        HeaderCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
       
        if(indexPath.section==0)
        {
            headerView.header.text=@"Exhibitors";
        }
        if(indexPath.section==1)
        {
            headerView.header.text=@"Partners";
        }
        reusableview = headerView;
        
    }
    return reusableview;
}

//
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    return UIEdgeInsetsMake(2, 2, 2, 2);
//
//}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSString *urlstring;
    
    NSIndexPath *path=[self.collection indexPathForCell:sender];
    
    if(path.section==0)
    {
        Sponsor *s=self.exhibitors[path.row];
        urlstring=s.url;
        
    }
    if(path.section==1)
    {
        urlstring=@"http://www.therminic2016.eu/";
    }
    WebViewController *wvc=[segue destinationViewController];
    wvc.myurl=urlstring;
    
    //wvc.s1=[self.sponsors objectAtIndex:path.row];
    
    
}
/*
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 4;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(section==0)
    {
       return self.goldsponsors.count;
    }
    if(section==1)
    {
        return self.silversponsers.count;
    }

    if(section==2)
    {
    return self.exhibitors.count;
    }
    else
    {
        return 1;
    }
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SponsorsCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    if(indexPath.section==0)
    {
    Sponsor *s=self.goldsponsors[indexPath.row];
    
    cell.image.image=[UIImage imageNamed:s.imgurl];
    cell.detail.text=s.name;
    }
    if(indexPath.section==1)
    {
        Sponsor *s=self.silversponsers[indexPath.row];
        
        cell.image.image=[UIImage imageNamed:s.imgurl];
        cell.detail.text=s.name;
    }
    if(indexPath.section==2)
    {
        Sponsor *s=self.exhibitors[indexPath.row];
        
        cell.image.image=[UIImage imageNamed:s.imgurl];
        cell.detail.text=s.name;
        
    }
    if(indexPath.section==3)
    {
        Sponsor *s4=[[Sponsor alloc]init];
        s4.name=@"Therminic";
        s4.imgurl=@"therminic.png";
        s4.url=@"http://www.therminic2016.eu/";
        
        cell.image.image=[UIImage imageNamed:s4.imgurl];
        cell.detail.text=s4.name;
        
    }
    return  cell;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(360.0, 140.0);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        HeaderCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        if(indexPath.section==0)
        {
        headerView.header.text=@"Gold Sponsors";
        }
        if(indexPath.section==1)
        {
            headerView.header.text=@"Silver Sponsors";
        }
        if(indexPath.section==2)
        {
            headerView.header.text=@"Exhibitors";
        }
        if(indexPath.section==3)
        {
            headerView.header.text=@"Partners";
        }
        reusableview = headerView;
        
    }
    return reusableview;
}

//
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    return UIEdgeInsetsMake(2, 2, 2, 2);
//    
//}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSString *urlstring;
    
    NSIndexPath *path=[self.collection indexPathForCell:sender];
    if(path.section==0)
    {
    Sponsor *s=self.goldsponsors[path.row];
    urlstring=s.url;
    }
    if(path.section==1)
    {
        Sponsor *s=self.silversponsers[path.row];
        urlstring=s.url;
    }
    if(path.section==2)
    {
        Sponsor *s=self.exhibitors[path.row];
        urlstring=s.url;

    }
    if(path.section==3)
    {
        urlstring=@"http://www.therminic2016.eu/";
    }
    WebViewController *wvc=[segue destinationViewController];
    wvc.myurl=urlstring;
    
    //wvc.s1=[self.sponsors objectAtIndex:path.row];
    
    
}
*/

@end
