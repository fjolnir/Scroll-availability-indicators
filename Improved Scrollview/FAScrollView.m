#import "FAScrollView.h"
#import "FAScrollIndicationView.h"

@interface NSScrollView (Dumped)
- (void)_handleBoundsChangeForSubview:(NSView *)subview;

@end

// A little Ivar faking mechanism
static NSMutableDictionary *_fakeIvars;
#define I(x) [[_fakeIvars objectForKey:[NSNumber numberWithInt:(int)self]] objectForKey:x]
#define SetI(x, y) [[_fakeIvars objectForKey:[NSNumber numberWithInt:(int)self]] setObject:y forKey:x]


@interface FAScrollView ()
- (void)_initScrollIndications;
@end

@implementation FAScrollView
+ (void)initialize {
  static dispatch_once_t ivarsInitialized;
  dispatch_once(&ivarsInitialized, ^{
    _fakeIvars = [[NSMutableDictionary alloc] init];
  });
}

- (id)initWithCoder:(NSCoder *)coder {
  if(!(self = [super initWithCoder:coder])) return nil;
  
  [self _initScrollIndications];
  
  return self;
}

- (id)initWithFrame:(NSRect)frameRect {
  if(!(self = [super initWithFrame:frameRect])) return nil;
  
  [self _initScrollIndications];
  
  return self;
}

- (void)dealloc {
  [_fakeIvars removeObjectForKey:[NSNumber numberWithInt:(int)self]];
  
  [super dealloc];
}

- (void)_initScrollIndications {
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

- (void)resizeSubviewsWithOldSize:(NSSize)oldSize {
  [super resizeSubviewsWithOldSize:oldSize];
  
  [I(@"topIndicator") resizeWithOldSuperviewSize:oldSize];
  [I(@"leftIndicator") resizeWithOldSuperviewSize:oldSize];
  [I(@"bottomIndicator") resizeWithOldSuperviewSize:oldSize];
  [I(@"rightIndicator") resizeWithOldSuperviewSize:oldSize];
}

// Handle scrolling/resizing and display the scroll availability indicators as needed
- (void)_handleBoundsChangeForSubview:(NSView *)subview {
  [super _handleBoundsChangeForSubview:subview];
  
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
@end
