//
//  SingleCommentViewController.m
//  CommentsApp
//
//  Created by Bojana Sladojevic on 10/05/2019.
//  Copyright © 2019 Bojana Sladojevic. All rights reserved.
//

#import "SingleCommentViewController.h"
#import "CommentsViewController.h"
#import "PostsViewController.h"
#import "Post.h"
#import "Comment.h"
#import "Album.h"
#import "Photo.h"
#import "CommentsManager.h"
#import "PhotoManager.h"
#import "AlbumManager.h"
#import "PostsManager.h"
#import "TableViewCell.h"
#import "NavigationBar.h"
#import "LogInViewController.h"
#import "UserManager.h"
#import "Konstante.h"

@interface SingleCommentViewController ()

@end

@implementation SingleCommentViewController{
    UIColor *thumbOnColor;
    UIColor *thumbOffColor;
    BOOL willIShowImage;
}
@synthesize bodyLabel,nameLabel,emailLabel,imageNameLabel,imageView,comment,navigationBar,mainPost,index,myCurrentUser,namaLabelConstraint;


- (void)viewDidLoad {
    [super viewDidLoad];

    navigationBar.delegate=self;
    bodyLabel.text=comment.body;
    emailLabel.text=comment.email;
    nameLabel.text=comment.name;
    
    
    
    NSMutableArray *photos=[PhotoManager sharedManager].photoArray;
    Photo *photo=[Photo new];
    photo=photos[index];
    imageNameLabel.text=photo.title;
    
    
    NSString *imgString=photo.url;
    NSData *data= [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:imgString]];
    imageView.image= [UIImage imageWithData:data];
    
    willIShowImage=[[UserManager sharedManager]chackUsersImageDefults:myCurrentUser];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willIShowImage) name:@"show" object:nil];
    // Do any additional setup after loading the view.
    if(willIShowImage)
        imageView.hidden=NO;
    else imageView.hidden=YES;
     NSLog(@"ufunkciji %d",willIShowImage);
    
}
/*- (void)willIShowImage{
    NSLog(@"ufunkciji %d",willIShowImage);

    if(willIShowImage)
        imageView.hidden=NO;
    else imageView.hidden=YES;
    
}*/
- (void)viewWillAppear:(BOOL)animated{
    
    if([myCurrentUser.imageDefults isEqualToString:@"YES"])
        [navigationBar.photoSwitch setOn:YES animated:YES];
    else [navigationBar.photoSwitch setOn:NO animated:NO];
    
    navigationBar.beckButton.hidden=NO;
    navigationBar.logOutButton.hidden=YES;
    navigationBar.nameLabel.text=@"COMMENT";
    navigationBar.addPost.hidden=YES;
    if (IS_IPHONE_5)
    {
        namaLabelConstraint.constant=10;
    }
    
    
   
}

- (void)backButtonDelegate:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)photoSwitchDelegate:(id)sender{
    if(navigationBar.photoSwitch.isOn)
    {imageView.hidden=NO;
        [[UserManager sharedManager]changeUsersImageDefults:myCurrentUser with:NO];}
    
    else
    {imageView.hidden=YES;
        [[UserManager sharedManager]changeUsersImageDefults:myCurrentUser with:YES];}
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
