//
//  AlbumManager.h
//  CommentsApp
//
//  Created by Bojana Sladojevic on 13/05/2019.
//  Copyright © 2019 Bojana Sladojevic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Album.h"
#import "AFNetworking.h"

NS_ASSUME_NONNULL_BEGIN

@interface AlbumManager : NSObject
+ (AlbumManager *)sharedManager;

@property (strong,nonatomic) NSMutableArray *albumArray;
-(void) initManager;
@end

NS_ASSUME_NONNULL_END
