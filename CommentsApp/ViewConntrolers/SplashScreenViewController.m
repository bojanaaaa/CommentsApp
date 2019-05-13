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
    //[[UserManager sharedManager]initUserManager];
    // Do any additional setup after loading the view.
    [self initPostsManager];

   
}
-(void)initPostsManager{
    [[PostsManager sharedManager]initManager];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initPhotoManager) name:@"finishedLoadingPosts" object:nil];

}
-(void)initPhotoManager{
    [[PhotoManager sharedManager]initManager];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initAlbumManager) name:@"finishedLoadingPhotos" object:nil];

}
-(void)initAlbumManager{
    [[AlbumManager sharedManager]initManager];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initCommentsManager) name:@"finishedLoadingAlbums" object:nil];

}
-(void)initCommentsManager{
    [[CommentsManager sharedManager]initManager];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(next:) name:@"finishedLoadingComments" object:nil];

}

-(void)setLabel{
    [commentsAppLabel setTransform:CGAffineTransformMakeRotation(M_PI / 2)];
    
}
    
- (void)next: (NSNotification *)notification  {
    
    AppDelegate *applicationDelegate;
    applicationDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    
    
    //pozivamo funkciju app delegate koja ce da prikaze nas pocetni ekran
    //ako ti se ne prikaze ova funkcija, moras je dodati u .h fajl
    [applicationDelegate openAppHome];
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
/*- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
