//
//  PostsViewController.h
//  CommentsApp
//
//  Created by Bojana Sladojevic on 13/05/2019.
//  Copyright © 2019 Bojana Sladojevic. All rights reserved.
//

#import "MainViewController.h"
#import "NavigationBar.h"


NS_ASSUME_NONNULL_BEGIN

@interface PostsViewController : MainViewController <UITableViewDelegate>



@property (strong, nonatomic) IBOutlet UITableView *tableView;




@end

NS_ASSUME_NONNULL_END
