//
//  PostsManager.h
//  CommentsApp
//
//  Created by Bojana Sladojevic on 13/05/2019.
//  Copyright © 2019 Bojana Sladojevic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface PostsManager : NSObject
+ (PostsManager *)sharedManager;

@property (strong,nonatomic) NSMutableArray *postsArray;
-(void) initManager;
-(void) addPost:(Post *) newPost;


@end

NS_ASSUME_NONNULL_END
