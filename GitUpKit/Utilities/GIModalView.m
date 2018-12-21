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

#import "GIModalView.h"

#import "XLFacilityMacros.h"

@implementation GIModalView

- (void)presentContentView:(NSView*)view withCompletionHandler:(dispatch_block_t)handler {
  XLOG_DEBUG_CHECK(self.subviews.count == 0);

  NSRect bounds = self.bounds;
  NSRect frame = view.frame;
  view.frame = NSMakeRect(round((bounds.size.width - frame.size.width) / 2), round((bounds.size.height - frame.size.height) / 2), frame.size.width, frame.size.height);
  view.autoresizingMask = NSViewMinXMargin | NSViewMaxXMargin | NSViewMinYMargin | NSViewMaxYMargin;
  view.wantsLayer = YES;
  view.layer.borderWidth = 1.0;
  view.layer.borderColor = NSColor.separatorColor.CGColor;
  view.layer.cornerRadius = 5.0;

  view.layer.backgroundColor = NSColor.windowBackgroundColor.CGColor;
  // This is for dimming so deliberately does not adapt for dark mode.
  self.layer.backgroundColor = [[NSColor colorWithDeviceRed:0.0 green:0.0 blue:0.0 alpha:0.4] CGColor];
  [self addSubview:view];
  if (handler) {
    dispatch_async(dispatch_get_main_queue(), handler);
  }
}

- (void)dismissContentViewWithCompletionHandler:(dispatch_block_t)handler {
  XLOG_DEBUG_CHECK(self.subviews.count == 1);

  NSView* view = self.subviews.firstObject;
  [view removeFromSuperviewWithoutNeedingDisplay];
  view.wantsLayer = NO;
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
