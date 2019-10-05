
// 首次编译必须导入基础运行库 /opt/iOSOpenDev/lib/libsubstrate.dylib

#include <substrate.h>
#import <UIKit/UIKit.h>

@interface SpringBoard : UIApplication
- (void)applicationDidFinishLaunching:(UIApplication *)arg1;
@end

%hook SpringBoard
- (void)applicationDidFinishLaunching:(UIApplication *)arg1{
    NSLog(@"测试Hook!");
    %orig;
}
%end