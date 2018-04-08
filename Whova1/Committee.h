

#import <Foundation/Foundation.h>

@interface Committee : NSObject

@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *designation;
@property (nonatomic,strong) NSString *university;
@property (weak, nonatomic) NSString *img;

@end
