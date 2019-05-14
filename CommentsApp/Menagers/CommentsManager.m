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
@implementation CommentsManager
@synthesize commentsArray;


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
          
          [self parsData:array];
          
      } failure:^(NSURLSessionTask *operation, NSError *error) {
          NSLog(@"Error: %@", error);
          
      }];
    
    
}

-(void)parsData:(NSArray *)array
{
    for(NSDictionary *commD in array)
    {
        
        Comment *a=[Comment new];
        
        a.body=[commD objectForKey:@"body"];
        a.email=[commD objectForKey:@"title"];
        a.postID=[commD objectForKey:@"postId"];
        a.name=[commD objectForKey:@"name"];
        a.commentID=[commD objectForKey:@"id"];
        
        [commentsArray addObject:a];
        
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"finishedLoadingComments" object:nil];
}
-(NSMutableArray* )formCommentsArray:(NSNumber*)postID {
    
    NSMutableArray *newCommentsArray=[NSMutableArray new];
    
    for (Comment *comment in commentsArray)
    {
        NSLog(@"%@ %@",[comment.postID class],[postID class]);
        if(comment.postID == postID)
        {
            NSLog(@"naso");
            [newCommentsArray addObject:comment];
            
        }
    }
    
    NSLog(@"comments number %li", (long)[newCommentsArray count]);
    
    return newCommentsArray;
    
}

@end
