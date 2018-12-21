//  Copyright (C) 2015-2018 Pierre-Olivier Latour <info@pol-online.net>
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.

#if !__has_feature(objc_arc)
#error This file requires ARC
#endif

#import <QuartzCore/QuartzCore.h>
#import <sys/sysctl.h>

#import "GCMacros.h"
#import "GIModalView.h"

#import "XLFacilityMacros.h"

@interface GIModalView ()

@property (nonatomic, readonly) NSBox *box;

@end

@implementation GIModalView

@synthesize box = _box;
- (NSBox *)box {
  if (_box == nil) {
    _box = [[NSBox alloc] init];

    _box.boxType = NSBoxCustom;
    _box.autoresizingMask = NSViewMinXMargin | NSViewMaxXMargin | NSViewMinYMargin | NSViewMaxYMargin;
    _box.contentViewMargins = NSZeroSize;
    _box.borderWidth = 1.0;
    _box.cornerRadius = 5.0;
    _box.borderColor = NSColor.separatorColor;
    _box.fillColor = NSColor.windowBackgroundColor;
  }

  return _box;
}

- (void)presentContentView:(NSView*)view withCompletionHandler:(dispatch_block_t)handler {
  XLOG_DEBUG_CHECK(self.subviews.count == 0);

  let bounds = self.bounds;
  let modalSize = view.bounds.size;
  // The box always positions the content view inset by 1 point on each side, presumably for the border because contentViewMargins is defined as being to the border, not the edge of the box.
  // Therefore take this padding into account so the size of the content view does not drift each time it is shown.
  self.box.frame = NSInsetRect(NSMakeRect(round((bounds.size.width - modalSize.width) / 2), round((bounds.size.height - modalSize.height) / 2), modalSize.width, modalSize.height), -1, -1);
  self.box.contentView = view;

  // If this fails it means the border is not being considered correctly and the content view size will drift each time it is shown.
  XLOG_DEBUG_CHECK(NSEqualSizes(view.bounds.size, modalSize));

  // This is for dimming so deliberately does not adapt for dark mode.
  self.layer.backgroundColor = [[NSColor colorWithDeviceRed:0.0 green:0.0 blue:0.0 alpha:0.4] CGColor];

  [self addSubview:self.box];

  if (handler) {
    dispatch_async(dispatch_get_main_queue(), handler);
  }
}

- (void)dismissContentViewWithCompletionHandler:(dispatch_block_t)handler {
  XLOG_DEBUG_CHECK(self.subviews.count == 1);

  [self.box removeFromSuperviewWithoutNeedingDisplay];
  self.box.contentView = nil;

  self.layer.backgroundColor = nil;

  if (handler) {
    dispatch_async(dispatch_get_main_queue(), handler);
  }
}

// Prevent events bubbling to ancestor views - TODO: Is there a better way?
- (void)mouseDown:(NSEvent*)event {
}
- (void)rightMouseDown:(NSEvent*)event {
}
- (void)otherMouseDown:(NSEvent*)event {
}
- (void)mouseUp:(NSEvent*)event {
}
- (void)rightMouseUp:(NSEvent*)event {
}
- (void)otherMouseUp:(NSEvent*)event {
}
- (void)mouseMoved:(NSEvent*)event {
}
- (void)mouseDragged:(NSEvent*)event {
}
- (void)scrollWheel:(NSEvent*)event {
}
- (void)rightMouseDragged:(NSEvent*)event {
}
- (void)otherMouseDragged:(NSEvent*)event {
}
- (void)mouseEntered:(NSEvent*)event {
}
- (void)mouseExited:(NSEvent*)event {
}

@end
