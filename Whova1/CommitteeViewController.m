
#import "CommitteeViewController.h"

@interface CommitteeViewController ()

@end

@implementation CommitteeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

  [self.segC addTarget:self action:@selector(segValueChanged:)forControlEvents:UIControlEventValueChanged];

    [_collection setShowsHorizontalScrollIndicator:NO];
    [_collection setShowsVerticalScrollIndicator:NO];
    self.conference=[[NSArray alloc]init];
    self.component=[[NSArray alloc]init];
    self.system=[[NSArray alloc]init];
    self.mechanics=[[NSArray alloc]init];
    self.fundamental=[[NSArray alloc]init];
    self.administrative=[[NSArray alloc]init];
    self.communication=[[NSArray alloc]init];
    self.award=[[NSArray alloc]init];
    self.technical=[[NSArray alloc]init];
    self.women=[[NSArray alloc]init];
    
    self.exCom=[[NSArray alloc]init];
    self.headertext=[[NSArray alloc]init];
    
    
    
    /**** Conference  Level***/
    
    /****<<<!>>>> Leadership Team****/
    
    Committee *l1=[[Committee alloc]init];
    l1.name=@"Dr.Thomas Brunschwiler";
    l1.img=@"thomas.png";
    l1.designation=@"General Chair";
    l1.university=@"IBM Research-Zurich";
    
    Committee *l2=[[Committee alloc]init];
    l2.name=@"Prof.Jeffrey Suhling";
    l2.img=@"jeff.png";
    l2.designation=@"Program Chair";
    l2.university=@"Auburn University";
    
    
    Committee *l3=[[Committee alloc]init];
    l3.name=@"Dr.Vadim Gektin";
    l3.img=@"vadim.jpg";
    l3.designation=@"Vice Program Chair";
    l3.university=@"Huawei";
    
    Committee *l4=[[Committee alloc]init];
    l4.name=@"Prof.Justin Weibel";
    l4.img=@"weibel.png";
    l4.designation=@"Communication Chair";
    l4.university=@"Purdue University";
    
    /**** <<2>>>Component Level****/
    
    Committee *c3=[[Committee alloc]init];
    c3.name=@"Dr.Baris Dogrouz";
    c3.img=@"bdogruoz.png";
    c3.designation=@"Chair";
    c3.university=@"Cisco";
    
    Committee *c4=[[Committee alloc]init];
    c4.name=@"Dr.Kamal Sikka";
    c4.img=@"kamal.jpg";
    c4.designation=@"Co-Chair";
    c4.university=@"IBM";
    
    
    Committee *c5=[[Committee alloc]init];
    c5.name=@"Dr.Reza Khiabani";
    c5.img=@"chair.png";
    c5.designation=@"Co-Chair";
    c5.university=@"Google";
    
    /****<<3>> System Level****/
    
    Committee *c6=[[Committee alloc]init];
    c6.name=@"Dr.Mehdi Saeidi";
    c6.img=@"mehdi.jpg";
    c6.designation=@"Chair";
    c6.university=@"Qualcomm";
    
    
    Committee *c7=[[Committee alloc]init];
    c7.name=@"Dr.Ashish Gupta";
    c7.img=@"ashish.png";
    c7.designation=@"Co-Chair";
    c7.university=@"Intel";
    
    
    Committee *c8=[[Committee alloc]init];
    c8.name=@"Dr.Ali Merrikh";
    c8.img=@"chair.png";
    c8.designation=@"Co-Chair";
    c8.university=@"Qualcomm";
    
    /****<<4>> Mechanics & Realibility Track ****/
    
    
    Committee *c9=[[Committee alloc]init];
    c9.name=@"Dr.Jin Yang";
    c9.img=@"jin.png";
    c9.designation=@"Co-Chair";
    c9.university=@"Intel Corporation";
    
    Committee *c10=[[Committee alloc]init];
    c10.name=@"Prof.Bernhard Wunderle ";
    c10.img=@"bernhard.jpg";
    c10.designation=@"Co-Chair";
    c10.university=@"TU Chemnitz";
    
    Committee *c11=[[Committee alloc]init];
    c11.name=@"Dr.Krishna Tunga";
    c11.img=@"krishna.jpg";
    c11.designation=@"Co-Chair";
    c11.university=@"IBM";
    
    
    /*** <<5>> Emerging Technologies & Fundamental Task ***/
    
    Committee *c12=[[Committee alloc]init];
    c12.name=@"Prof.Satish Kumar";
    c12.img=@"satish.png";
    c12.designation=@"Chair";
    c12.university=@"Georgia Institute of Technology";
    
    Committee *c13=[[Committee alloc]init];
    c13.name=@"Dr.Amir H.Shooshtari";
    c13.img=@"amir.png";
    c13.designation=@"Co-Chair";
    c13.university=@"University of Maryland";
    
    Committee *c14=[[Committee alloc]init];
    c14.name=@"Prof.Amy Marconnet";
    c14.img=@"amy.png";
    c14.designation=@"Co-Chair";
    c14.university=@"Purdue University";
    
    Committee *c15=[[Committee alloc]init];
    c15.name=@"Dr.Banafsheh Barabadi";
    c15.img=@"barabadi.png";
    c15.designation=@"Co-Chair";
    c15.university=@"MIT";
    
    /**** <<<7>>> Administrative Committee ***/
    
    Committee *a1=[[Committee alloc]init];
    a1.name=@"Ms.Damaris Betancourt";
    a1.img=@"damaris.jpg";
    a1.designation=@"Admin Assistant";
    
    Committee *a2=[[Committee alloc]init];
    a2.name=@"Dr.Dustin Demetriou";
    a2.img=@"Dustin.png";
    a2.designation=@"Finance Chair";
    a2.university=@"IBM";
    
    Committee *a3=[[Committee alloc]init];
    a3.name=@"Dr.Pritish Parida";
    a3.img=@"Pritish.png";
    a3.designation=@"Operations Chair";
    a3.university=@"IBM Research";
    
    Committee *a4=[[Committee alloc]init];
    a4.name=@"Dr.Yoonjin Won";
    a4.img=@"Yoojin.png";
    a4.designation=@"Operations Chair";
    a4.university=@"University of California,Irvine";
    
    Committee *a5=[[Committee alloc]init];
    a5.name=@"Dr.Joshua Gess";
    a5.img=@"Joshua.png";
    a5.designation=@"Sponsoring & Exhibitor Chair";
    a5.university=@"Oregon State University";
    
    
    Committee *a6=[[Committee alloc]init];
    a6.name=@"Dr.Shlomo Novotny";
    a6.img=@"novotny.jpg";
    a6.designation=@"Sponsoring & Exhibitor Co-Chair";
    a6.university=@"Nortek";
    
    Committee *a7=[[Committee alloc]init];
    a7.name=@"Dr.Mike Ellsworth";
    a7.img=@"mike.jpg";
    a7.designation=@"Sponsoring & Exhibitor Co-Chair";
    a7.university=@"IBM";
    


       /****<<8>>> Communication *******/
    
    Committee *co1=[[Committee alloc]init];
    co1.name=@"Dr.Sandeep Tonapi";
    co1.img=@"Sandeep.png";
    co1.designation=@"Paper Management Tool Chair";
    co1.university=@"Anveshak Technology & Knowledege Solutions";
    
    Committee *co2=[[Committee alloc]init];
    co2.name=@"Prof.Jeffrey Suhling";
    co2.img=@"jeff.png";
    co2.designation=@"Paper Management Tool Accessibility";
    co2.university=@"Auburn University";
    
    Committee *co3=[[Committee alloc]init];
    co3.name=@"Dr.Paul Wesling";
    co3.img=@"paul.png";
    co3.designation=@"Conference Proceeding Manager";
    
    Committee *co4=[[Committee alloc]init];
    co4.name=@"Ms.Damaris Betancourt";
    co4.img=@"chair.png";
    co4.designation=@"Conference Proceeding Co-Manager";
  
    Committee *co5=[[Committee alloc]init];
    co5.name=@"Prof.Jeffrey Suhling";
    co5.img=@"jeff.png";
    co5.designation=@"Technical Program and Design";
    co5.university=@"Auburn University";
    
    Committee *co6=[[Committee alloc]init];
    co6.name=@"Dr.Vadim Gektin";
    co6.img=@"chair.png";
    co6.designation=@"Technical Program and Design";
    co6.university=@"Huawei";
    
    Committee *co7=[[Committee alloc]init];
    co7.name=@"Dr.Sreekant Narumanchi";
    co7.img=@"chair.png";
    co7.designation=@"Website Design";
    co7.university=@"NREL";
    
    Committee *co8=[[Committee alloc]init];
    co8.name=@"Mr.Shashank Thakur";
    co8.img=@"shashank.png";
    co8.designation=@"Webmaster";
    co8.university=@"Anveshak Technology & Knowledege Solutions";
    
    Committee *co9=[[Committee alloc]init];
    co9.name=@"Mr.Kedar Khire";
    co9.img=@"kedar.png";
    co9.designation=@"Webmaster";
    co9.university=@"Anveshak Technology & Knowledege Solutions";
    
    Committee *co10=[[Committee alloc]init];
    co10.name=@"Prof.Vaibhav Bahadur ";
    co10.img=@"bahadur.jpg";
    co10.designation=@"Outreach & Engagement";
    co10.university=@"UT Austin";
    
    Committee *co11=[[Committee alloc]init];
    co11.name=@"Prof.John(Jack) Maddox";
    co11.img=@"maddox.jpg";
    co11.designation=@"Publicity";
    co11.university=@"Univ of Kentucky";
    
    Committee *co12=[[Committee alloc]init];
    co12.name=@"Dr.Farah Singer";
    co12.img=@"Farah.png";
    co12.designation=@"Social & Social Media";
    co12.university=@"University of Maryland";

    
    /*** <<<10>>> Award Committee ***/
    
    Committee *c28=[[Committee alloc]init];
    c28.name=@"Prof.Sushil Bhavnani";
    c28.img=@"Sushil.png";
    c28.designation=@"ITherm Achievement Award:Chair";
    c28.university=@"Auburn University";
    
    Committee *c29=[[Committee alloc]init];
    c29.name=@"Dr.Koneru Ramakrishna";
    c29.img=@"koneru.png";
    c29.designation=@"ITherm Achievement Award:Co-Chair";
    c29.university=@"Cirrus Logic";
    
    Committee *c30=[[Committee alloc]init];
    c30.name=@"Dr.Yogendra K. Joshi";
    c30.img=@"yogendra.png";
    c30.designation=@"Best Paper Award:Chair";
    c30.university=@"Georgia Institute of Technology";
    
    Committee *c31=[[Committee alloc]init];
    c31.name=@"Dr.Koneru Ramakrishna";
    c31.img=@"koneru.png";
    c31.designation=@"Best Paper Award:Co-Chair";
    c31.university=@"Cirrus Logic";
    
    /****<<<6>>>>Other teachnical contribution*/
    
    Committee *c32=[[Committee alloc]init];
    c32.name=@"Dr.Victor Chiriac";
    c32.img=@"victor.jpg";
    c32.designation=@"Panel Chair";
    c32.university=@"Qualcomm";
    
    Committee *c33=[[Committee alloc]init];
    c33.name=@"Prof.Sung Jin Kim";
    c33.img=@"sung-jin-kim.png";
    c33.designation=@"Panel Co-Chair";
    c33.university=@"KAIST";
    
    Committee *c34=[[Committee alloc]init];
    c34.name=@"Dr.Peter de Bock";
    c34.img=@"peter.png";
    c34.designation=@"Tech-Talk Chair";
    c34.university=@"GE Global Research";
    
    Committee *c35=[[Committee alloc]init];
    c35.name=@"Dr.David H Altman";
    c35.img=@"chair.png";
    c35.designation=@"TechTalk Co-Chair";
    c35.university=@"Raytheon";
    

    Committee *c36=[[Committee alloc]init];
    c36.name=@"Dr.Madhu Iyengar";
    c36.img=@"madhu.png";
    c36.designation=@"TechTalk Co-Chair";
    c36.university=@"Google";
    
    Committee *c37=[[Committee alloc]init];
    c37.name=@"Prof.John Thome";
    c37.img=@"chair.png";
    c37.designation=@"Keynote & Invited Talk Chair";
    c37.university=@"EPFL";
    
    Committee *c38=[[Committee alloc]init];
    c38.name=@"Prof.Suresh Garmimella";
    c38.img=@"suresh.jpg";
    c38.designation=@"Keynote & Invited Talk Co-Chair";
    c38.university=@"Purdue University";
    
    Committee *c39=[[Committee alloc]init];
    c39.name=@"Dr.Lauren Boteler";
    c39.img=@"lauren.png";
    c39.designation=@"Keynote & Invited Talk Co-Chair";
    c39.university=@"Army Research Laboratory";
    
    Committee *c40=[[Committee alloc]init];
    c40.name=@"Dr.Mahsa Ebrahim";
    c40.img=@"mahsa.png";
    c40.designation=@"Student Poster & Art-in-Science Chair";
    c40.university=@"Villanova University";
    
    
    Committee *c41=[[Committee alloc]init];
    c41.name=@"Prof.Amir H.Shooshtari";
    c41.img=@"amir.png";
    c41.designation=@"Student Poster & Art-in-Science Chair";
    c41.university=@"University of Maryland";
    
    Committee *c42=[[Committee alloc]init];
    c42.name=@"Prof.Patrick Mc Cluskey";
    c42.img=@"chair.png";
    c42.designation=@"Short Course Chair";
    c42.university=@"University of Maryland";
    
    Committee *c43=[[Committee alloc]init];
    c43.name=@"Prof.Jeffrey Suhling";
    c43.img=@"jeff.png";
    c43.designation=@"Short Course Co-Chair";
    c43.university=@"Auburn University";
    
    //------****<<<9>>> Women & Diversity ACHIVERS****-------------
    
    Committee *w1=[[Committee alloc]init];
    w1.name=@"Prof.Cristina Amon";
    w1.img=@"cristina.png";
    w1.designation=@"Chair";
    w1.university=@"U Toronto";
    
    Committee *w2=[[Committee alloc]init];
    w2.name=@"Dr.Yoonjin Won";
    w2.img=@"Yoojin.png";
    w2.designation=@"Founding Member";
    w2.university=@"University of California";
    
    Committee *w3=[[Committee alloc]init];
    w3.name=@"Dr.Banafsheh Barabadi";
    w3.img=@"barabadi.png";
    w3.designation=@"Founding Member";
    w3.university=@"MIT";
    
    
    Committee *w4=[[Committee alloc]init];
    w4.name=@"Dr.Farah Singer";
    w4.img=@"Farah.png";
    w4.designation=@"Founding Member";
    w4.university=@"University of Maryland";
    
    Committee *w5=[[Committee alloc]init];
    w5.name=@"Dr.Anahit Raygani";
    w5.img=@"anahit.png";
    w5.designation=@"Founding Member";
    w5.university=@"NM^2Inc.";
    
    Committee *w6=[[Committee alloc]init];
    w6.name=@"Dr.Damena Agonafer";
    w6.img=@"chair.png";
    w6.designation=@"Founding Member";
    w6.university=@"Washington University";
    
    Committee *w7=[[Committee alloc]init];
    w7.name=@"Prof.Samuel Graham";
    w7.img=@"samuel.jpg";
    w7.designation=@"Committee Member";
    w7.university=@"Georgia Institute of Technology";

    /*** ExCom for 2017 ***/
    
    Committee *d=[[Committee alloc]init];
    d.name=@"Prof.Dereje Agonafer";
    d.img=@"agonafer.png";
    d.university=@"University of Texas at Arlington,USA";
    
    Committee *d1=[[Committee alloc]init];
    d1.name=@"Prof.Cristina H.Amon";
    d1.img=@"Cristina.png";
    d1.university=@"University of Toronto,CAN";
    
    Committee *d2=[[Committee alloc]init];
    d2.name=@"Prof.Mehdi Asheghi";
    d2.img=@"Asheghi-Medhi.png";
    d2.university=@"Standford University,USA";
    
    Committee *d3=[[Committee alloc]init];
    d3.name=@"Prof.Avram Bar-Cohen";
    d3.img=@"avram.png";
    d3.university=@"University of Maryland and DARPA,USA";
    
    Committee *d4=[[Committee alloc]init];
    d4.name=@"Prof.Sushil H.Bhavnani";
    d4.img=@"Sushil.png";
    d4.university=@"Auburn University,USA";
    

    Committee *d5=[[Committee alloc]init];
    d5.name=@"Prof.Madhu Iyengar";
    d5.img=@"madhu.png";
    d5.university=@"Google,USA";
    
    Committee *d6=[[Committee alloc]init];
    d6.name=@"Prof.Yogendra K. Joshi";
    d6.img=@"yogendra.png";
    d6.university=@"Georgia Institue of Technology,USA";
    
    Committee *d7=[[Committee alloc]init];
    d7.name=@"Dr.Gary B.Kromann";
    d7.img=@"Gary.png";
    d7.university=@"Freescale semiconductor Inc.,Austin,TX,USA";
    
    Committee *d8=[[Committee alloc]init];
    d8.name=@"Dr.Tom Lee";
    d8.img=@"Lee-Tom.png";
    d8.university=@"Xilinx";
    
    
    Committee *d9=[[Committee alloc]init];
    d9.name=@"Prof.Michael Ohadi";
    d9.img=@"ohadi_new.png";
    d9.university=@"University of Maryland";
    
    
    Committee *d10=[[Committee alloc]init];
    d10.name=@"Prof.Alfonso Ortega";
    d10.img=@"Alfonso.png";
    d10.university=@"Villanova University,USA";
    
    Committee *d11=[[Committee alloc]init];
    d11.name=@"Dr.Koneru Ramakrishna";
    d11.img=@"koneru.png";
    d11.university=@"Cirrus Logic";
    
    
    Committee *d12=[[Committee alloc]init];
    d12.name=@"Prof.Bhagat Sammakia";
    d12.img=@"Bahgat.png";
    d12.university=@"State University of New York at Binghamton,USA";
    
    
    Committee *d13=[[Committee alloc]init];
    d13.name=@"Dr.Sandeep Tonapi";
    d13.img=@"Sandeep.png";
    d13.university=@"Anveshak Technology & Knowledege Solutions,USA";
    
    
    
    self.conference=[NSArray arrayWithObjects:l1,l2,l3,l4,nil];
    self.component=[NSArray arrayWithObjects:c3,c4,c5,nil];
    self.system=[NSArray arrayWithObjects:c6,c7,c8,nil];
    self.mechanics=[NSArray arrayWithObjects:c9,c10,c11,nil];
    self.fundamental=[NSArray arrayWithObjects:c12,c13,c14,c15,nil];
    self.administrative=[NSArray arrayWithObjects:a1,a2,a3,a4,a5,a6,a7,nil];
    self.communication=[NSArray arrayWithObjects:co1,co2,co3,co4,co5,co6,co7,co8,co9,co10,co11,co12,nil];
    self.award=[NSArray arrayWithObjects:c28,c29,c30,c31,nil];
    self.technical=[NSArray arrayWithObjects:c32,c33,c34,c35,c36,c37,c38,c39,c40,c41,c42,c43,nil];
    self.women=[NSArray arrayWithObjects:w1,w2,w3,w4,w5,w6,w7,nil];
    self.exCom=[NSArray arrayWithObjects:d,d1,d2,d3,d4,d5,d6,d7,d8,d9,d10,d11,d12,d13,nil];
    
    
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if(self.segC.selectedSegmentIndex==0)
    {
    return 10;
    }
    else{
        return 1;
    }
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(self.segC.selectedSegmentIndex==0)
    {
    if(section==0)
    {
        return self.conference.count;
    }
    else if(section==1)
    {
        return self.component.count;
    }
    else if(section==2)
    {
        return self.system.count;
        
    }
    else if(section==3)
    {
        return self.mechanics.count;
    }
    else if(section==4)
    {
        return self.fundamental.count;
        
    }
    else if(section==5)
    {
        return self.administrative.count;
        
    }
    else if(section==6)
    {
        return self.communication.count;
        
    }
    else if(section==7)
    {
        return self.award.count;
        
    }
    else if(section==8)
    {
        return self.technical.count;
        
    }
    else if(section==9)
    {
        return self.women.count;
        
    }
    }
    
        return self.exCom.count;
    
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CommitteeCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    if(self.segC.selectedSegmentIndex==0){
        
    
    if(indexPath.section==0)
    {
        Committee *c=self.conference[indexPath.row];
        
        cell.img.image=[UIImage imageNamed:c.img];
        cell.name.text=c.name;
        cell.designation.text=c.designation;
        cell.university.text=c.university;
    }
    
    if(indexPath.section==1)
    {
        Committee *c=self.component[indexPath.row];
        
        cell.img.image=[UIImage imageNamed:c.img];
        cell.name.text=c.name;
        cell.designation.text=c.designation;
        cell.university.text=c.university;
    }
    if(indexPath.section==2)
    {
        Committee *c=self.system[indexPath.row];
        
        cell.img.image=[UIImage imageNamed:c.img];
        cell.name.text=c.name;
        cell.designation.text=c.designation;
        cell.university.text=c.university;
    }
    if(indexPath.section==3)
    {
        Committee *c=self.mechanics[indexPath.row];
        
        cell.img.image=[UIImage imageNamed:c.img];
        cell.name.text=c.name;
        cell.designation.text=c.designation;
        cell.university.text=c.university;
    }
    
    if(indexPath.section==4)
    {
        Committee *c=self.fundamental[indexPath.row];
        
        cell.img.image=[UIImage imageNamed:c.img];
        cell.name.text=c.name;
        cell.designation.text=c.designation;
        cell.university.text=c.university;
    }
    if(indexPath.section==5)
    {
        Committee *c=self.administrative[indexPath.row];
        
        cell.img.image=[UIImage imageNamed:c.img];
        cell.name.text=c.name;
        cell.designation.text=c.designation;
        cell.university.text=c.university;
    }
    if(indexPath.section==6)
    {
        Committee *c=self.communication[indexPath.row];
        
        cell.img.image=[UIImage imageNamed:c.img];
        cell.name.text=c.name;
        cell.designation.text=c.designation;
        cell.university.text=c.university;
    }
    if(indexPath.section==7)
    {
        Committee *c=self.award[indexPath.row];
        
        cell.img.image=[UIImage imageNamed:c.img];
        cell.name.text=c.name;
        cell.designation.text=c.designation;
        cell.university.text=c.university;
    }
    if(indexPath.section==8)
        {
            Committee *c=self.technical[indexPath.row];
            
            cell.img.image=[UIImage imageNamed:c.img];
            cell.name.text=c.name;
            cell.designation.text=c.designation;
            cell.university.text=c.university;
        }
    if(indexPath.section==9)
        {
            Committee *c=self.women[indexPath.row];
            
            cell.img.image=[UIImage imageNamed:c.img];
            cell.name.text=c.name;
            cell.designation.text=c.designation;
            cell.university.text=c.university;
        }
}
    if(self.segC.selectedSegmentIndex==1) {
        
        Committee *c=self.exCom[indexPath.row];
        
        cell.img.image=[UIImage imageNamed:c.img];
        cell.name.text=c.name;
        cell.university.text=c.university;
        cell.designation.text=@"";
        
    }
    return  cell;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(320.0, 125.0);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        HCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
       
        if(self.segC.selectedSegmentIndex==0){
  //          headerView.header.text=self.headertext[indexPath.section];
            
                    if(indexPath.section==0)
                    {
                        headerView.header.text=@"Leadership Team";
                    }
                    if(indexPath.section==1)
                    {
                        headerView.header.text=@"Thermal Management 1:Component Level";
                    }
                    if(indexPath.section==2)
                    {
                        headerView.header.text=@"Thermal Management 2:System Level";
                    }
                    if(indexPath.section==3)
                    {
                        headerView.header.text=@"Mechanics & Reliability Track";
                    }
                    if(indexPath.section==4)
                    {
                        headerView.header.text=@"Emerging Technologies & Fundamental Track";
                    }
                    if(indexPath.section==5)
                    {
                        headerView.header.text=@"Administrative Committee";
                    }
                    if(indexPath.section==6)
                    {
                        headerView.header.text=@"Communication";
                    }
                    if(indexPath.section==7)
                    {
                        headerView.header.text=@"Awards";
                    }
                    if(indexPath.section==8)
                    {
                       headerView.header.text=@"Other Technical Contributions";
                    }if(indexPath.section==9)
                    {
                        headerView.header.text=@"Women and Diversity Achievers Panel";
                    }
        }
        else
        {
            headerView.header.text=@"Ex-Com for 2018 Committee";
        }
        reusableview = headerView;
    }
    
    return reusableview;
    
}

-(void)segValueChanged:(UISegmentedControl *)paramSender{
    
    if ([paramSender isEqual:self.segC]) {
       
         [self.collection reloadData];
        [self.collection scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]
                                atScrollPosition:UICollectionViewScrollPositionTop
                                        animated:YES];
    }
    
}


@end
