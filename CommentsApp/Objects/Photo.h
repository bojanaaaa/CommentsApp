//
//  Photo.h
//  CommentsApp
//
//  Created by Bojana Sladojevic on 13/05/2019.
//  Copyright © 2019 Bojana Sladojevic. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Photo : NSObject

@property (strong,nonatomic) NSString *title,*url;
@property (strong,nonatomic) NSNumber *albumID,*photoID;

@end

NS_ASSUME_NONNULL_END
