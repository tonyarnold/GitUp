// Douglas Hill, December 2018

#import <AppKit/AppKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GIAdaptiveColour : NSObject

- (instancetype)initWithLightColour:(NSColor*)lightColour darkColour:(NSColor*)darkColour;

/// The colour used with a light appearance (Aqua).
@property (nonatomic, readonly) NSColor* lightColour;

/// The colour used with a dark appearance (DarkAqua).
@property (nonatomic, readonly) NSColor* darkColour;

/// The colour for the current appearance.
@property (nonatomic, readonly) NSColor* currentColour;

/// The Core Graphics colour for the current appearance.
@property (nonatomic, readonly) CGColorRef currentCGColor NS_RETURNS_INNER_POINTER;

@end

NS_ASSUME_NONNULL_END
