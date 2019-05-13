//
//  SplashScreenViewController.h
//  CommentsApp
//
//  Created by Bojana Sladojevic on 10/05/2019.
//  Copyright © 2019 Bojana Sladojevic. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"
#import "AFNetworking.h"


NS_ASSUME_NONNULL_BEGIN

@interface SplashScreenViewController : MainViewController

@property (strong, nonatomic) IBOutlet UILabel *commentsAppLabel;

@end

NS_ASSUME_NONNULL_END
