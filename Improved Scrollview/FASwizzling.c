#import "FASwizzling.h"

void SwizzleInstanceMethods(Class theClass, SEL originalSelector, SEL newSelector) {
  Method originalMethod = class_getInstanceMethod(theClass, originalSelector);
  Method newMethod = class_getInstanceMethod(theClass, newSelector);
  
  if(class_addMethod(theClass, originalSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod)))
    class_replaceMethod(theClass, newSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
  else
    method_exchangeImplementations(originalMethod, newMethod);
}