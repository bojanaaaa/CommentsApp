//
//  Comment.h
//  CommentsApp
//
//  Created by Bojana Sladojevic on 13/05/2019.
//  Copyright © 2019 Bojana Sladojevic. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Comment : NSObject
@property (strong,nonatomic) NSString *name,*email,*body;

@property (strong,nonatomic) NSNumber *postID,*commentID;


@end

NS_ASSUME_NONNULL_END
