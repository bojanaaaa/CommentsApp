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
    [[NSNotificationCenter defaultCenter] postNotificationName:@"newPostsArray" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"finishedLoadingPosts" object:nil];
}
-(void)addPost:(Post*)newPost{
  
    NSURL *url = [NSURL URLWithString:@"https://jsonplaceholder.typicode.com/posts"];
    
    // create a POST request
    SGHTTPRequest *req = [SGHTTPRequest postRequestWithURL:url];
    
    
    // set the POST fields
    req.parameters = @{@"id": newPost.postID,
                       @"userId": newPost.userID,
                       @"title": newPost.title,
                       @"body": newPost.body
                       };
    
    // optional success handler
    req.onSuccess = ^(SGHTTPRequest *_req) {
        NSLog(@"response:%@", _req.responseString);
       

        //NSDictionary *postinstring = [[NSDictionary alloc] initWithDictionary:]
        
        NSString *string = (NSString *)_req.parameters;
        NSLog(@"%@",string);//   NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
     
        
         Post *a=[Post new];
        a.userID=[_req.parameters objectForKey:@"userID"];
        a.postID=[_req.parameters objectForKey:@"id"];
        a.title=[_req.parameters objectForKey:@"title"];
        a.body=[_req.parameters objectForKey:@"body"];
        NSLog(@"%@",a.title);
        [self->postsArray addObject:a];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"newarraypost" object:nil];
        
        
    };
    
    // optional failure handler
    req.onFailure = ^(SGHTTPRequest *_req) {
        NSLog(@"error:%@", _req.error);
        NSLog(@"status code:%ld", (long)_req.statusCode);
        
    };
    // start the request in the background
    [req start];
    
   
    
    
    
    /*NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://jsonplaceholder.typicode.com/posts"]];
    
    [request setHTTPMethod:@"POST"];
    NSString *userUpdate =[NSString stringWithFormat:@"userId=%@&Id=%@&title=%@&body=%@&",newPost.userID,  newPost.postID,newPost.title,newPost.body];
    NSLog(@"the data Details is =%@", userUpdate);
    NSData *data1 = [userUpdate dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data1];
    NSError *err;
    NSURLResponse *response;
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    
    NSString *resSrt = [[NSString alloc]initWithData:responseData encoding:NSASCIIStringEncoding];
    
    NSLog(@"got response==%@", resSrt);
    if(resSrt)
    {
        NSLog(@"got response");
       Post *post=
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"newarraypost" object:nil];
    }
    else
    {
        NSLog(@"faield to connect");
    }*/

    
}


@end
