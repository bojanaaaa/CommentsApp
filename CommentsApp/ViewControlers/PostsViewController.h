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
<UITableViewDelegate,UITableViewDataSource,NavigationBarDelegate,UISearchBarDelegate>


@property (strong, nonatomic) IBOutlet UILabel *noPosts;

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet NavigationBar *navigationBar;

@property (strong, nonatomic) User *user,*myCurrentUser;

@property(strong, nonatomic) NSMutableArray *postsArray;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tableViewBottom;


@end

NS_ASSUME_NONNULL_END
