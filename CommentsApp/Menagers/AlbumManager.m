//
//  AlbumManager.m
//  CommentsApp
//
//  Created by Bojana Sladojevic on 13/05/2019.
//  Copyright © 2019 Bojana Sladojevic. All rights reserved.
//

#import "AlbumManager.h"
#import "AFNetworking.h"

@implementation AlbumManager


@synthesize albumArray;


+ (AlbumManager *)sharedManager {
    static dispatch_once_t pred;
    static AlbumManager *_sharedManager = nil;
    
    dispatch_once(&pred, ^{
        _sharedManager = [[self alloc] init];
    });
    return _sharedManager;
}

-(void) initManager

{
    albumArray=[NSMutableArray new];
    [self getData];
    
    
}

-(void)getData
{
    NSLog(@"albums: tu sam ");
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"https://jsonplaceholder.typicode.com/albums"
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
        
        Album *a=[Album new];
        
        a.userID=[commD objectForKey:@"userId"];
        a.albumID=[commD objectForKey:@"id"];
        a.title=[commD objectForKey:@"title"];
       
        
        [albumArray addObject:a];
        
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"finishedLoadingAlbums" object:nil];
}
@end
