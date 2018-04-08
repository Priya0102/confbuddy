//
//  ExhibitionTableViewCell.m
//  ITherm
//
//  Created by Anveshak on 2/9/18.
//  Copyright © 2018 Anveshak . All rights reserved.
//

#import "ExhibitionTableViewCell.h"
#import "Constant.h"
@implementation ExhibitionTableViewCell
@synthesize kimagev;
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    
   self.scrollView.minimumZoomScale=0.5;
    
    self.scrollView.maximumZoomScale=15.0;
    
    self.scrollView.contentSize=CGSizeMake(233, 146);
    
    self.scrollView.delegate=self;
    
    self.kimagev.layer.masksToBounds=YES;
    self.kimagev.layer.borderColor=[UIColor blackColor].CGColor;
    self.kimagev.layer.borderWidth=1.1;
    //self.kimagev.layer.cornerRadius=10;
    self.kimagev.layer.shadowColor=[UIColor redColor].CGColor;
   [self.kimagev setUserInteractionEnabled:YES];
    
}


- (void)handleDoubleTap:(UIGestureRecognizer *)gestureRecognizer {
    
    if(self.scrollView.zoomScale > self.scrollView.minimumZoomScale){
        [self.scrollView setZoomScale:self.scrollView.minimumZoomScale animated:YES];
            NSLog(@"zoom...");
    }

    else{
        [self.scrollView setZoomScale:self.scrollView.maximumZoomScale animated:YES];
    
}
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView

{
    return self.kimagev;
    
}

- (CGRect)zoomRectForScrollView:(UIScrollView *)scrollView withScale:(float)scale withCenter:(CGPoint)center {
    
    CGRect zoomRect;
    
    // The zoom rect is in the content view's coordinates.
    // At a zoom scale of 1.0, it would be the size of the
    // imageScrollView's bounds.
    // As the zoom scale decreases, so more content is visible,
    // the size of the rect grows.
    zoomRect.size.height = scrollView.frame.size.height / scale;
    zoomRect.size.width  = scrollView.frame.size.width  / scale;
    
    // choose an origin so as to get the right center.
    zoomRect.origin.x = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;
}

@end
