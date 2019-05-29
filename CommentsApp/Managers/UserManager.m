//
//  UserManager.m
//  CommentsApp
//
//  Created by Bojana Sladojevic on 13/05/2019.
//  Copyright © 2019 Bojana Sladojevic. All rights reserved.
//

#import "UserManager.h"
#import "User.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>
#import "AFNetworking.h"
@implementation UserManager{
    
    NSManagedObjectContext *context;
    NSPersistentStoreCoordinator *coordinator;
    NSUserDefaults *defaults;
    
}
@synthesize users;

+ (UserManager *)sharedManager {
    static dispatch_once_t pred;
    static UserManager *_sharedManager = nil;
    
    dispatch_once(&pred, ^{
        _sharedManager = [[self alloc] init];
    });
    return _sharedManager;
}

-(void)initUserManager{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    context = app.managedObjectContext;
    coordinator = app.persistentStoreCoordinator;
    
}
-(void)setUser:(NSString *)email and:(NSString *)password{
    
    NSManagedObject *object=[NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
    [object setValue:email forKey:@"email"];
    [object setValue:password forKey:@"password"];
    NSString *str=@"YES";
    [object setValue:str forKey:@"imageDefults"];
    /*NSString *str=@"YES";
    [object setValue:str forKey:@"switchBOOL"];*/
    
    [context save:nil];
    
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"User"];
    request.returnsObjectsAsFaults=false;
    
    NSError *error=nil;
    NSArray *results= [context executeFetchRequest:request error:&error];
    
    for ( User *user in results)
    {
        NSLog(@"email %@",user.email);
    }
}

-(BOOL)checkForEmail:(NSString*)email{
    
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"User"];
    request.returnsObjectsAsFaults=false;
    
    NSPredicate *predicate= [NSPredicate predicateWithFormat:@"email == %@",email];
    [request setPredicate:predicate];
    
    NSError *error=nil;
    NSArray *results= [context executeFetchRequest:request error:&error];
    
    NSLog(@"%li", (long)[results count]);
    if([results count]==0)
        return false;
    
    return true;
    
}

-(void)changeUsersImageDefults:(User *)user with:(BOOL)setBool{
    
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"User"];
    request.returnsObjectsAsFaults=false;
    
    NSPredicate *predicate= [NSPredicate predicateWithFormat:@"email == %@",user.email];
    [request setPredicate:predicate];
    
    NSError *error=nil;
    NSArray *results= [context executeFetchRequest:request error:&error];
    NSManagedObject *object= [results objectAtIndex:0];
    
        if (setBool) {
            [object setValue:@"NO" forKey:@"imageDefults"];
        }
        else [object setValue:@"YES" forKey:@"imageDefults"];
    
}
-(BOOL)chackUsersImageDefults:(User *)user{
   
    BOOL chack;
    if([user.imageDefults isEqualToString:@"YES"])
    {
        chack=YES;
    }
    else chack=NO;
    NSLog(@"%@",user.email);
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"show" object:nil];
    return chack;
}

-(User *)returnUser:(NSString*)email{
    
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"User"];
    request.returnsObjectsAsFaults=false;
    
    NSPredicate *predicate= [NSPredicate predicateWithFormat:@"email == %@",email];
    [request setPredicate:predicate];
    
    NSError *error=nil;
    NSArray *results= [context executeFetchRequest:request error:&error];
    
    User *user=[results firstObject];
    
    return user;
    
}




@end
