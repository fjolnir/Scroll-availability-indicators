#import <AppKit/AppKit.h>

@interface NSScrollView (FAScrollIndications)
- (id)_fa_initWithCoder:(NSCoder *)coder;
- (id)_fa_initWithFrame:(NSRect)frameRect;
- (void)_fa_dealloc;

- (void)_initScrollIndications;
- (void)_fa_resizeSubviewsWithOldSize:(NSSize)oldSize;
- (void)_fa__handleBoundsChangeForSubview:(NSView *)subview;
@end

@interface NSScrollView (Dumped)
- (void)_handleBoundsChangeForSubview:(NSView *)subview;
@end