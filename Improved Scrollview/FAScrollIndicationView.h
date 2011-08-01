//
//  FAScrollIndicationView.h
//  Improved Scrollview
//
//  Created by Fjölnir Ásgeirsson on 8/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface FAScrollIndicationView : NSView {
  NSRectEdge _edge;
  NSGradient *_gradient;
}
@property(nonatomic, assign) NSRectEdge edge;
// Width represents the width on vertical indicators, height represents the height on horizontal ones
+ (NSSize)indicatorSize;

- (id)initWithFrame:(NSRect)frame edge:(NSRectEdge)anEdge;
@end
