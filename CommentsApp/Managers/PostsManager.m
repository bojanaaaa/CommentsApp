//
//  PostsManager.m
//  CommentsApp
//
//  Created by Bojana Sladojevic on 13/05/2019.
//  Copyright © 2019 Bojana Sladojevic. All rights reserved.
//

#import "PostsManager.h"
#import "AFNetworking.h"
#import "Post.h"
@implementation PostsManager

@synthesize postsArray;



+ (PostsManager *)sharedManager {
    static dispatch_once_t pred;
    static PostsManager *_sharedManager = nil;
    
    dispatch_once(&pred, ^{
        _sharedManager = [[self alloc] init];
    });
    return _sharedManager;
}

-(void) initManager

{
    postsArray=[NSMutableArray new];
    [self getData];
    
    
}

-(void)getData
{
    NSLog(@"posts: tu sam ");
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"https://jsonplaceholder.typicode.com/posts"
      parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
          NSArray *array = (NSArray *)responseObject;
          
          [self parsData:array];
          
      } failure:^(NSURLSessionTask *operation, NSError *error) {
          NSLog(@"Error: %@", error);
          
      }];
    
    
}

-(void)parsData:(NSArray *)array
{
    for(NSDictionary *commD in array)
    {
        
        Post *a=[Post new];
        
        a.body=[commD objectForKey:@"body"];
        a.title=[commD objectForKey:@"title"];
        a.postID=[commD objectForKey:@"id"];
        a.userID=[commD objectForKey:@"userId"];
        
        [postsArray addObject:a];
        
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"finishedLoadingPosts" object:nil];
}
-(void)addPost:(Post*)newPost{
    
     
     [[NSNotificationCenter defaultCenter] postNotificationName:@"newarray" object:nil];
}


@end
