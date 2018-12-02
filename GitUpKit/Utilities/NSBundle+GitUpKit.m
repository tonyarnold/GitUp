// Douglas Hill, December 2018

#import "NSBundle+GitUpKit.h"
#import "GIBranch.h"

NS_ASSUME_NONNULL_BEGIN

@implementation NSBundle (GitUpKit)

- (NSBundle *)gitUpKitBundle {
  // There’s nothing special about this class. Any hardcoded class in the bundle will do.
  return [NSBundle bundleForClass:[GIBranch class]];
}

@end

NS_ASSUME_NONNULL_END
