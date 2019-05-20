//
//  UserManager.h
//  CommentsApp
//
//  Created by Bojana Sladojevic on 13/05/2019.
//  Copyright © 2019 Bojana Sladojevic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserManager : NSObject
+ (UserManager *)sharedManager;

@property(strong,nonatomic) NSMutableArray *users;
-(void)initUserManager;
-(void)setUser:(NSString *)email and:(NSString *)password;
-(BOOL)checkForEmail:(NSString*)email;
-(User *)returnUser:(NSString*)email;
-(void)changeUsersImageDefults:(User *)user with:(BOOL)setBool;
-(BOOL)chackUsersImageDefults:(User *)user;


@end

NS_ASSUME_NONNULL_END
