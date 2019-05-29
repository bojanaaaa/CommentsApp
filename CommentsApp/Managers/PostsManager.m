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
#import "SGHTTPRequest.h"
#import "AFNetworking.h"

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
    [[NSNotificationCenter defaultCenter] postNotificationName:@"newPostsArray" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"finishedLoadingPosts" object:nil];
}
-(void)addPost:(Post*)newPost{


    NSURL *url = [NSURL URLWithString:@"https://jsonplaceholder.typicode.com/posts"];
    SGHTTPRequest *req = [SGHTTPRequest postRequestWithURL:url];
    req.parameters = @{@"id": newPost.postID,
                       @"userId": newPost.userID,
                       @"title": newPost.title,
                       @"body": newPost.body
                       };

    req.onSuccess = ^(SGHTTPRequest *_req) {
        NSLog(@"response:%@", _req.responseString);

         Post *a=[Post new];
        a.userID= @([[_req.parameters objectForKey:@"userID"] intValue]);
       // a.userID=[_req.parameters objectForKey:@"userID"];
        a.postID=[_req.parameters objectForKey:@"id"];
        a.title=[_req.parameters objectForKey:@"title"];
        a.body=[_req.parameters objectForKey:@"body"];
        NSLog(@"%@",a.title);
        [self->postsArray addObject:a];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"newarraypost" object:nil];
    
    };
    
    req.onFailure = ^(SGHTTPRequest *_req) {
        NSLog(@"error:%@", _req.error);
        NSLog(@"status code:%ld", (long)_req.statusCode);
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"somethingwentwrong" object:nil];
        
    };
    
    [req start];
}
- (void)editPost:(Post *)post{
   
    NSString *urlstr= [NSString stringWithFormat:@"https://jsonplaceholder.typicode.com/posts/%i", [post.postID intValue]];
    NSLog(@"tu");
    NSURL *url = [NSURL URLWithString:urlstr];
    SGHTTPRequest *req = [SGHTTPRequest patchRequestWithURL:url];
    NSLog(@"post: %@,%@,%i,%i",post.title,post.body,[post.userID intValue],[post.postID intValue]);
    req.parameters = @{@"id": post.postID,
                       @"userId": post.userID,
                       @"title": post.title,
                       @"body": post.body
                       };
    NSLog(@"tu");

    req.onSuccess = ^(SGHTTPRequest *_req) {
        NSLog(@"response:%@", _req.responseString);
        
        Post *a=[Post new];
        //NSNumberFormatter *format=[NSNumberFormatter new];
        //format.numberStyle=NSNumberFormatterDecimalStyle;
        //a.userID= @([[_req.parameters objectForKey:@"userID"] intValue]);
        a.userID=[_req.parameters objectForKey:@"userID"];
        a.postID=[_req.parameters objectForKey:@"id"];
        a.title=[_req.parameters objectForKey:@"title"];
        a.body=[_req.parameters objectForKey:@"body"];
        int i=[post.postID intValue]-1;
        NSLog(@"%i",i);
        [self->postsArray replaceObjectAtIndex:i withObject:a];
        Post *p=self->postsArray[i];
        NSLog(@"tijelo %@",p.body);
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"postedited" object:nil];
        
    };
    
    req.onFailure = ^(SGHTTPRequest *_req) {
        NSLog(@"error:%@", _req.error);
        NSLog(@"status code:%ld", (long)_req.statusCode);
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"somethingwentwrongwhileediting" object:nil];
        
    };
    
    [req start];
    
    
    
}
- (void) deletePost:(Post *)post{
    NSString *urlstr= [NSString stringWithFormat:@"https://jsonplaceholder.typicode.com/posts/%i", [post.postID intValue]];
    NSLog(@"tu");
    NSURL *url = [NSURL URLWithString:urlstr];
    SGHTTPRequest *req = [SGHTTPRequest deleteRequestWithURL:url];
    
    req.onSuccess = ^(SGHTTPRequest *_req) {
        NSLog(@"response:%@", _req.responseString);
        
        [self->postsArray removeObject:post];
        NSLog(@"%lu",(unsigned long)[self->postsArray count]);
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"postisdeleted" object:nil];
        
    };
    
    // optional failure handler
    req.onFailure = ^(SGHTTPRequest *_req) {
        NSLog(@"error:%@", _req.error);
        NSLog(@"status code:%ld", (long)_req.statusCode);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"postisnotdeleted" object:nil];
    };
    
    [req start];
    
}

@end
