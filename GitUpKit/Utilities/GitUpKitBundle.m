// Douglas Hill, December 2018

#import "GitUpKitBundle.h"
#import "GIBranch.h"

NS_ASSUME_NONNULL_BEGIN

NSBundle* GitUpKitBundle(void) {
  // There’s nothing special about this class. Any hardcoded class in the bundle will do.
  return [NSBundle bundleForClass:[GIBranch class]];
}

NS_ASSUME_NONNULL_END
