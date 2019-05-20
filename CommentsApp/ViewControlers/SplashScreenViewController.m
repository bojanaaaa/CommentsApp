//
//  SplashScreenViewController.m
//  CommentsApp
//
//  Created by Bojana Sladojevic on 10/05/2019.
//  Copyright © 2019 Bojana Sladojevic. All rights reserved.
//

#import "SplashScreenViewController.h"
#import "LogInViewController.h"
#import "PostsManager.h"
#import "CommentsManager.h"
#import "PhotoManager.h"
#import "AlbumManager.h"
#import "AFNetworking.h"
#import "UserManager.h"


@interface SplashScreenViewController ()

@end

@implementation SplashScreenViewController
@synthesize commentsAppLabel;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLabel];
    [[UserManager sharedManager]initUserManager];
    //[[UserManager sharedManager]initUserManager];
    // Do any additional setup after loading the view.
    [self initPostsManager];
    
    }
-(void)setLabel{
    [commentsAppLabel setTransform:CGAffineTransformMakeRotation(M_PI / 2)];
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
/*- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
