//
//  CommentsViewController.h
//  CommentsApp
//
//  Created by Bojana Sladojevic on 10/05/2019.
//  Copyright © 2019 Bojana Sladojevic. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "NavigationBar.h"
#import "Comment.h"
#import "Post.h"
#import "User.h"
NS_ASSUME_NONNULL_BEGIN

@interface CommentsViewController : MainViewController <UITableViewDelegate,UITableViewDataSource,NavigationBarDelegate>

@property (strong, nonatomic) IBOutlet NavigationBar *navigationBar;
@property(strong,nonatomic) Comment *comment;
@property(strong,nonatomic) NSMutableArray *commentsArray;
@property(strong,nonatomic) Post *post;
@property(strong,nonatomic) User *myCurrentUser;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *bodyLabel;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;

@end

NS_ASSUME_NONNULL_END
