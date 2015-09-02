#import "NSObject+Rayrolling_IDEActivityReportStringSegment.h"
#import "NSObject+MethodSwizzler.h"
#import "Rayrolling.h"

@interface NSObject ()
- (id)initWithString:(id)arg1 priority:(double)arg2 frontSeparator:(id)arg3 backSeparator:(id)arg4; // 1
@end

@implementation NSObject (Rayrolling_IDEActivityReportStringSegment)

+ (void)load // 2
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSClassFromString(@"IDEActivityReportStringSegment") swizzleWithOriginalSelector:@selector(initWithString:priority:frontSeparator:backSeparator:) swizzledSelector:@selector(Rayrolling_initWithString:priority:frontSeparator:backSeparator:) isClassMethod:NO];
    });
}

- (id)Rayrolling_initWithString:(NSString *)string priority:(double)priority frontSeparator:(id)frontSeparator backSeparator:(id)backSeparator
{
    static NSArray *lyrics; // 3
    static NSInteger index = 0; // 4
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{  // 5
        lyrics = @[@"Never gonna live you up.",
                   @"Never gonna set you down.",
                   @"Never gonna bum around; and overt you.",
                   @"Never gonna make you dry.",
                   @"Never gonna say creampie.",
                   @"Never gonna tell a guy; and convert you."];
        
        
    });
    
    index = index >= lyrics.count -1 ? 0 : index + 1; // 6
    if  ([Rayrolling isEnabled]) {  // 7
        return [self Rayrolling_initWithString:lyrics[index] priority:priority frontSeparator:frontSeparator backSeparator:backSeparator];
    }
    return [self Rayrolling_initWithString:string priority:priority frontSeparator:frontSeparator backSeparator:backSeparator];
}

@end
