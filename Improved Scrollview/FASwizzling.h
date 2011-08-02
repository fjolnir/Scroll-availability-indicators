//
//  FASwizzling.h
//  Improved Scrollview
//
//  Created by Fjölnir Ásgeirsson on 8/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#ifndef Improved_Scrollview_FASwizzling_h
#define Improved_Scrollview_FASwizzling_h

#import <objc/objc.h>
#import <objc/runtime.h>

void SwizzleInstanceMethods(Class theClass, SEL originalSelector, SEL newSelector);

#endif
