//
//  CommentsViewController.h
//  CommentsApp
//
//  Created by Bojana Sladojevic on 10/05/2019.
//  Copyright © 2019 Bojana Sladojevic. All rights reserved.
//

#import "MainViewController.h"
#import "NavigationBar.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommentsViewController : MainViewController <NavigationBarDelegate>
@property (strong, nonatomic) IBOutlet NavigationBar *navigationBar;

@end

NS_ASSUME_NONNULL_END
