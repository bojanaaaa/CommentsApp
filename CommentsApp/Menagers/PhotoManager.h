//
//  PhotoManager.h
//  CommentsApp
//
//  Created by Bojana Sladojevic on 13/05/2019.
//  Copyright © 2019 Bojana Sladojevic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Photo.h"
NS_ASSUME_NONNULL_BEGIN

@interface PhotoManager : NSObject
+ (PhotoManager *)sharedManager;

@property (strong,nonatomic) NSMutableArray *photoArray;
-(void) initManager;

@end

NS_ASSUME_NONNULL_END
