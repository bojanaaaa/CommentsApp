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

@interface SingleCommentViewController ()

@end

@implementation SingleCommentViewController
@synthesize bodyLabel,nameLabel,emailLabel,imageNameLabel,imageView,comment,navigationBar,mainPost,index;


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
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    
    navigationBar.beckButton.hidden=NO;
    navigationBar.logOutButton.hidden=YES;
    navigationBar.nameLabel.text=@"COMMENT";
   
}

- (void)backButtonDelegate:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)photoSwitchDelegate:(id)sender{
    
    if(imageView.hidden==YES)
        imageView.hidden=NO;
    
    if(imageView.hidden==NO)
        imageView.hidden=YES;
    
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
