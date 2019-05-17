//
//  CommentsManager.m
//  CommentsApp
//
//  Created by Bojana Sladojevic on 13/05/2019.
//  Copyright © 2019 Bojana Sladojevic. All rights reserved.
//

#import "CommentsManager.h"
#import "AFNetworking.h"
#import "Comment.h"
#import "MainViewController.h"
@implementation CommentsManager
@synthesize commentsArray,postcommentsArray;


+ (CommentsManager *)sharedManager {
    static dispatch_once_t pred;
    static CommentsManager *_sharedManager = nil;
    
    dispatch_once(&pred, ^{
        _sharedManager = [[self alloc] init];
    });
    return _sharedManager;
}

-(void) initManager

{
    commentsArray=[NSMutableArray new];
    
    [self getData];
}

-(void)getData
{
    NSLog(@"comments: tu sam ");
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"https://jsonplaceholder.typicode.com/comments"
      parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
          NSArray *array = (NSArray *)responseObject;
          
          [self parsData:array and:self->commentsArray];
          
      } failure:^(NSURLSessionTask *operation, NSError *error) {
          NSLog(@"Error: %@", error);
          
      }];
    
    
}

-(void)parsData:(NSArray *)array and:(NSMutableArray*)mutable
{
    for(NSDictionary *commD in array)
    {
        
        Comment *a=[Comment new];
        
        a.body=[commD objectForKey:@"body"];
        a.email=[commD objectForKey:@"email"];
        a.postID=[commD objectForKey:@"postId"];
        a.name=[commD objectForKey:@"name"];
        a.commentID=[commD objectForKey:@"id"];
        
        [mutable addObject:a];
        
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"finishedLoadingComments" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"newarray" object:nil];
    
}



-(void)formCommentsArray:(NSNumber*)postID
{
    postcommentsArray=[NSMutableArray new];
    NSString *str=@"https://jsonplaceholder.typicode.com/comments?postId=";
    NSString *str2=[postID stringValue];
    str=[str stringByAppendingString:str2];
    
    
    NSLog(@"comments: tu sam ");
    

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:str
      parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
          NSArray *array = (NSArray *)responseObject;
          
          [self parsData:array and:self->postcommentsArray];
          
          NSLog(@"ovde sam %li",(long)[self->postcommentsArray count]);
      } failure:^(NSURLSessionTask *operation, NSError *error) {
          NSLog(@"Error: %@", error);
          
      }];
    
    NSLog(@"ovde sam %li",(long)[postcommentsArray count]);
  
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(next:) name:@"finishedLoadingComments" object:nil];
    /*for (Comment *comment in commentsArray)
    {
        NSLog(@"%@ %@",[comment.postID class],[postID class]);
        if(comment.postID == postID)
        {
            NSLog(@"naso");
            [newCommentsArray addObject:comment];
        }
    }
    NSLog(@"comments number %li", (long)[newCommentsArray count]);*/
}


@end
