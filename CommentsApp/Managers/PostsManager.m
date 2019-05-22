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
    [[NSNotificationCenter defaultCenter] postNotificationName:@"newPostsArray" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"finishedLoadingPosts" object:nil];
}
-(void)addPost:(Post*)newPost{
 
    NSDictionary *param = @{@"userId":newPost.userID,
                            
                            @"id":newPost.postID,
                            
                            @"title":newPost.title,
                            
                            @"body":newPost.body
                            
                            };
    
    NSLog(@"param:%@",param);
    
  
    
    
    NSString *finalurl=[NSString stringWithFormat:@"https://jsonplaceholder.typicode.com/posts/"];
    NSURL *nsurl=[NSURL URLWithString:finalurl];
    NSMutableURLRequest *nsrequest=[NSMutableURLRequest requestWithURL:nsurl];
    NSData *data = [NSJSONSerialization dataWithJSONObject:param options:0 error:nil];
    
    [nsrequest setHTTPBody:data];
    
    //Here YOUR URL
    /*NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://jsonplaceholder.typicode.com/posts"]];
    
    
    //create the Method "GET" or "POST"
    [request setHTTPMethod:@"POST"];
    
    //Pass The String to server(YOU SHOULD GIVE YOUR PARAMETERS INSTEAD OF MY PARAMETERS)
    NSString *userUpdate =[NSString stringWithFormat:@"userId=%@&id=%@&title=%@&  body=%@&",newPost.userID,newPost.postID,newPost.title,newPost.body];
    
    
    
    //Check The Value what we passed
    NSLog(@"the data Details is =%@", userUpdate);
    
    //Convert the String to Data
    NSData *data1 = [userUpdate dataUsingEncoding:NSUTF8StringEncoding];
    
    //Apply the data to the body
    [request setHTTPBody:data1];
    
    //Create the response and Error
    NSError *err;
    NSURLResponse *response;
    
    NSData *responseData = [NSJSONSerialization dataWithJSONObject:param options:0 error:nil];
    NSString *resSrt = [[NSString alloc]initWithData:responseData encoding:NSASCIIStringEncoding];
    
    //This is for Response
    NSLog(@"got response==%@", resSrt);
    if(resSrt)
    {
        NSLog(@"got response");
    
    }
    else
    {
        NSLog(@"faield to connect");
    }
    */
     [[NSNotificationCenter defaultCenter] postNotificationName:@"newarray" object:nil];
}


@end
