//
//  PhotoManager.m
//  CommentsApp
//
//  Created by Bojana Sladojevic on 13/05/2019.
//  Copyright © 2019 Bojana Sladojevic. All rights reserved.
//

#import "PhotoManager.h"
#import "AFNetworking.h"

@implementation PhotoManager

@synthesize photoArray;


+ (PhotoManager *)sharedManager {
    static dispatch_once_t pred;
    static PhotoManager *_sharedManager = nil;
    
    dispatch_once(&pred, ^{
        _sharedManager = [[self alloc] init];
    });
    return _sharedManager;
}

-(void) initManager

{
    photoArray=[NSMutableArray new];
    
    [self getData];
    
    
}

-(void)getData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"https://jsonplaceholder.typicode.com/photos"
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
        Photo *a=[Photo new];
        
        a.albumID=[commD objectForKey:@"albumId"];
        a.photoID=[commD objectForKey:@"id"];
        a.title=[commD objectForKey:@"title"];
        a.url=[commD objectForKey:@"url"];
        
        
        [photoArray addObject:a];
        
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"finishedLoadingPhotos" object:nil];
    
}
-(Photo *)getPhoto:(NSNumber*)commentID{
    
    Photo *image=[Photo new];
    
    for(Photo *photo in photoArray)
        if(image.photoID == commentID)
        {
            NSLog(@"naso");
            image=photo;
            return image;
            
        }
    
    return image;
    
}
@end
