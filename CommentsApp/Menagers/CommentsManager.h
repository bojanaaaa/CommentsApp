//
//  CommentsManager.h
//  CommentsApp
//
//  Created by Bojana Sladojevic on 13/05/2019.
//  Copyright © 2019 Bojana Sladojevic. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommentsManager : NSObject

+ (CommentsManager *)sharedManager;

@property (strong,nonatomic) NSMutableArray *commentsArray;
-(void) initManager;
-(NSMutableArray* )formCommentsArray:(NSString*) postID;


@end

NS_ASSUME_NONNULL_END
