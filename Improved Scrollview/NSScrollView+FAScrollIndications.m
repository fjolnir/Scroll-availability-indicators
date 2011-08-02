#import "NSScrollView+FAScrollIndications.h"
#import "FAScrollIndicationView.h"

// A little Ivar faking mechanism
static NSMutableDictionary *_fakeIvars;
#define I(x) [[_fakeIvars objectForKey:[NSNumber numberWithInt:(int)self]] objectForKey:x]
#define SetI(x, y) [[_fakeIvars objectForKey:[NSNumber numberWithInt:(int)self]] setObject:y forKey:x]


@interface NSScrollView ()
- (void)_initScrollIndications;
@end


// _fa_ prefixed methods are methods that will have their implementations exchanged for their counterparts in NSScrollview
@implementation NSScrollView (FAScrollIndications)
- (id)_fa_initWithCoder:(NSCoder *)coder {
  if(!(self = [self _fa_initWithCoder:coder])) return nil;
  
  [self _initScrollIndications];
  
  return self;
}

- (id)_fa_initWithFrame:(NSRect)frameRect {
  if(!(self = [self _fa_initWithFrame:frameRect])) return nil;
  
  [self _initScrollIndications];
  
  return self;
}

- (void)_fa_dealloc {
  [_fakeIvars removeObjectForKey:[NSNumber numberWithInt:(int)self]];
  
  [self _fa_dealloc];
}

#pragma mark -
- (void)_initScrollIndications {
  static dispatch_once_t ivarsInitialized;
  dispatch_once(&ivarsInitialized, ^{
    _fakeIvars = [[NSMutableDictionary alloc] init];
  });
  [_fakeIvars setObject:[NSMutableDictionary dictionary] forKey:[NSNumber numberWithInt:(int)self]];
  
  NSSize size = self.bounds.size;
  
  NSSize indicationSize = [FAScrollIndicationView indicatorSize];
  
  FAScrollIndicationView *top = [[FAScrollIndicationView alloc] initWithFrame:NSMakeRect(0, 0, size.width, indicationSize.height) 
                                                                          edge:NSMinYEdge];

  FAScrollIndicationView *left = [[FAScrollIndicationView alloc] initWithFrame:NSMakeRect(0, 0, indicationSize.width, size.height) 
                                                                          edge:NSMinXEdge];
  FAScrollIndicationView *bottom = [[FAScrollIndicationView alloc] initWithFrame:NSMakeRect(0, size.height - indicationSize.height, size.width, indicationSize.height) 
                                                                          edge:NSMaxYEdge];
  FAScrollIndicationView *right = [[FAScrollIndicationView alloc] initWithFrame:NSMakeRect(size.width - indicationSize.width, 0, indicationSize.width, size.height) 
                                                                            edge:NSMaxXEdge];
  top.layer.opacity = 0.0;
  left.layer.opacity = 0.0;
  bottom.layer.opacity = 0.0;
  right.layer.opacity = 0.0;
  
  [self addSubview:top positioned:NSWindowBelow relativeTo:self.verticalScroller];
  [self addSubview:left positioned:NSWindowBelow relativeTo:self.horizontalScroller];
  [self addSubview:bottom positioned:NSWindowBelow relativeTo:self.horizontalScroller];
  [self addSubview:right positioned:NSWindowBelow relativeTo:self.verticalScroller];
  
  SetI(@"topIndicator",    top);
  SetI(@"leftIndicator",   left);
  SetI(@"bottomIndicator", bottom);
  SetI(@"rightIndicator",  right);
  
  
  [top release];
  [left release];
  [bottom release];
  [right release];
}

- (void)_updateScrollIndications {
  NSSize ownSize = self.bounds.size;
  NSClipView *clipView = self.contentView;
  NSView *docView = (NSView *)[clipView documentView];
  
  NSRect clipBounds = clipView.bounds;
  NSRect docBounds = docView.bounds;
  
  if(clipBounds.origin.y > 0)
    ((NSView *)I(@"topIndicator")).layer.opacity = 1.0;
  else
    ((NSView *)I(@"topIndicator")).layer.opacity = 0.0;
  
  if(docBounds.size.height - clipBounds.origin.y > ownSize.height)
    ((NSView *)I(@"bottomIndicator")).layer.opacity = 1.0;
  else
    ((NSView *)I(@"bottomIndicator")).layer.opacity = 0.0;
  
  if(clipBounds.origin.x > 0)
    ((NSView *)I(@"leftIndicator")).layer.opacity = 1.0;
  else
    ((NSView *)I(@"leftIndicator")).layer.opacity = 0.0;
  
  if(docBounds.size.width - clipBounds.origin.x > ownSize.width)
    ((NSView *)I(@"rightIndicator")).layer.opacity = 1.0;
  else
    ((NSView *)I(@"rightIndicator")).layer.opacity = 0.0;
}

#pragma mark -
- (void)_fa_resizeSubviewsWithOldSize:(NSSize)oldSize {
  [self _fa_resizeSubviewsWithOldSize:oldSize];
  
  [I(@"topIndicator") resizeWithOldSuperviewSize:oldSize];
  [I(@"leftIndicator") resizeWithOldSuperviewSize:oldSize];
  [I(@"bottomIndicator") resizeWithOldSuperviewSize:oldSize];
  [I(@"rightIndicator") resizeWithOldSuperviewSize:oldSize];
}

// Handle scrolling/resizing and display the scroll availability indicators as needed
- (void)_fa__handleBoundsChangeForSubview:(NSView *)subview {
  [self _fa__handleBoundsChangeForSubview:subview];

  [self _updateScrollIndications];
}
@end
