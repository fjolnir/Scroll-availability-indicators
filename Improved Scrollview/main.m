//
//  main.m
//  Improved Scrollview
//
//  Created by Fjölnir Ásgeirsson on 8/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FASwizzling.h"
#import "NSScrollView+FAScrollIndications.h"

int main(int argc, char *argv[])
{
  SwizzleInstanceMethods([NSScrollView class], @selector(initWithFrame:), @selector(_fa_initWithFrame:));
  SwizzleInstanceMethods([NSScrollView class], @selector(initWithCoder:), @selector(_fa_initWithCoder:));
  SwizzleInstanceMethods([NSScrollView class], @selector(dealloc), @selector(_fa_dealloc));
  SwizzleInstanceMethods([NSScrollView class], @selector(resizeSubviewsWithOldSize:), @selector(_fa_resizeSubviewsWithOldSize:));
  SwizzleInstanceMethods([NSScrollView class], @selector(_handleBoundsChangeForSubview:), @selector(_fa__handleBoundsChangeForSubview:));

  
  return NSApplicationMain(argc, (const char **)argv);
}
