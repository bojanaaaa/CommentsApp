//
//  Album.h
//  CommentsApp
//
//  Created by Bojana Sladojevic on 13/05/2019.
//  Copyright © 2019 Bojana Sladojevic. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Album : NSObject

@property (strong,nonatomic) NSString *title;
@property (strong,nonatomic) NSNumber *userID,*albumID;

@end

NS_ASSUME_NONNULL_END

