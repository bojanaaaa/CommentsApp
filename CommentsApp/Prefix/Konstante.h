//
//  Konstante.h
//  CommentsApp
//
//  Created by Bojana Sladojevic on 11/05/2019.
//  Copyright © 2019 Bojana Sladojevic. All rights reserved.
//

#ifndef Konstante_h
#define Konstante_h


#define NSSTRING_IS_NOT_NULL(string)        (string != (id)[NSNull null] && [string length] != 0 && ![string isEqualToString:@""])
#define ACTIVE_STORYBOARD               (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) ? @"Main" : @"Main"
#define INIT_VC_FROM_STORYBOARD(name)   [[UIStoryboard storyboardWithName:ACTIVE_STORYBOARD bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:name];
#define COLOR(r,g,b,a)                  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define UIColorFromHEX(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define IS_OS_5_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0)
#define IS_OS_6_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
#define IS_OS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IS_OS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IS_OS_9_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define IS_OS_10_OR_LATER   ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
#define IS_OS_11_OR_LATER   ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0)
#define IS_OS_12_OR_LATER   ([[[UIDevice currentDevice] systemVersion] floatValue] >= 12.0)

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
#define IS_IPHONE_X_OR_HIGHER (IS_IPHONE && SCREEN_MAX_LENGTH >= 812.0)


#endif /* Konstante_h */
