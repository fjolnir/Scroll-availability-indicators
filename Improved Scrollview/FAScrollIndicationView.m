//
//  FAScrollIndicationView.m
//  Improved Scrollview
//
//  Created by Fjölnir Ásgeirsson on 8/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FAScrollIndicationView.h"

@implementation FAScrollIndicationView
@synthesize edge=_edge;

+ (NSSize)indicatorSize {
  static NSSize size = { 3.0, 6.0 };
  return size;
}

- (id)initWithFrame:(NSRect)frame edge:(NSRectEdge)anEdge
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
  if(!(self = [super initWithFrame:frame])) return nil;
  
  self.edge = anEdge;
  self.alphaValue =0.3;
  self.wantsLayer = YES;
  
  _gradient = [[NSGradient alloc] initWithStartingColor:[NSColor colorWithCalibratedWhite:0.0 alpha:0.13]
                                            endingColor:[NSColor colorWithCalibratedWhite:0.0 alpha:0.0]];
  
  return self;
}

- (void)dealloc {
  [_gradient release];
  
  [super dealloc];
}

- (void)setEdge:(NSRectEdge)edge {
  NSUInteger mask = 0;
  switch(edge) {
    case NSMinYEdge:
      mask = NSViewMaxYMargin|NSViewWidthSizable;
      break;
    case NSMaxYEdge:
      mask = NSViewMinYMargin|NSViewWidthSizable;
      break;
    case NSMinXEdge:
      mask = NSViewMaxXMargin|NSViewHeightSizable;
      break;
    case NSMaxXEdge:
      mask = NSViewMinXMargin|NSViewHeightSizable;
      default:
      break;
  }
  self.autoresizingMask = mask;
  _edge = edge;
}

- (void)drawRect:(NSRect)dirtyRect
{
  switch(_edge) {
    case NSMinYEdge:
      [_gradient drawInRect:self.bounds angle:270.0];
      break;
    case NSMaxYEdge:
      [_gradient drawInRect:self.bounds angle:90.0];
      break;
    case NSMinXEdge:
      [_gradient drawInRect:self.bounds angle:0.0];
      break;
    case NSMaxXEdge:
       [_gradient drawInRect:self.bounds angle:180.0];
      default:
      break;
  }
}

#pragma mark -
#pragma mark Event handling
// We don't want any mouse events
- (NSView *)hitTest:(NSPoint)aPoint {
  return nil;
}
- (BOOL)mouse:(NSPoint)aPoint inRect:(NSRect)aRect {
  return NO;
}
@end
