//
//  SingleCommentViewController.h
//  CommentsApp
//
//  Created by Bojana Sladojevic on 10/05/2019.
//  Copyright © 2019 Bojana Sladojevic. All rights reserved.
//

#import "MainViewController.h"
#import "NavigationBar.h"
#import "Comment.h"
#import "Post.h"
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface SingleCommentViewController : MainViewController <NavigationBarDelegate>
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *emailLabel;
@property (strong, nonatomic) IBOutlet UILabel *bodyLabel;
@property (strong, nonatomic) IBOutlet UILabel *imageNameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong,nonatomic) Comment *comment;
@property (strong, nonatomic) IBOutlet NavigationBar *navigationBar;
@property (strong, nonatomic) IBOutlet Post  *mainPost;
@property(strong,nonatomic) User *myCurrentUser;
@property NSInteger index;

@end

NS_ASSUME_NONNULL_END
