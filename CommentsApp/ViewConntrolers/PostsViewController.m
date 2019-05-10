//
//  PostsViewController.m
//  CommentsApp
//
//  Created by Bojana Sladojevic on 10/05/2019.
//  Copyright © 2019 Bojana Sladojevic. All rights reserved.
//

#import "PostsViewController.h"

@interface PostsViewController ()

@end

@implementation PostsViewController
@synthesize navigationBar;

- (void)viewDidLoad {
    [super viewDidLoad];
    navigationBar.delegate=self;    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    
    navigationBar.backButton.hidden=YES;
    navigationBar.logOutButton.hidden=NO;
    navigationBar.label.text=@"Posts";
    
    NSLog(@"view will appear");
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
