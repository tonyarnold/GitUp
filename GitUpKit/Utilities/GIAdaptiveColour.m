// Douglas Hill, December 2018

#import "GIAdaptiveColour.h"
#import "GIAppKit.h"
#import "GCMacros.h"

@implementation GIAdaptiveColour

- (instancetype)initWithLightColour:(NSColor *)lightColour darkColour:(NSColor *)darkColour {
  if ((self = [super init])) {
    _lightColour = lightColour;
    _darkColour = darkColour;
  }
  return self;
}

- (NSColor *)currentColour {
  return NSAppearance.currentAppearance.gi_isLight ? _lightColour : _darkColour;
}

- (CGColorRef)currentCGColor {
  return self.currentColour.CGColor;
}

@end
