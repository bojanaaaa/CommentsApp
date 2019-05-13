//
//  PostsViewController.h
//  CommentsApp
//
//  Created by Bojana Sladojevic on 13/05/2019.
//  Copyright © 2019 Bojana Sladojevic. All rights reserved.
//

#import "MainViewController.h"
#import "NavigationBar.h"
#import "PostsViewController.h"
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface PostsViewController : MainViewController
<UITableViewDelegate,UITableViewDataSource,NavigationBarDelegate>




@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet NavigationBar *navigationBar;

@property (strong, nonatomic) User *user;
@property(strong, nonatomic) NSMutableArray *postsArray;


@end

NS_ASSUME_NONNULL_END
