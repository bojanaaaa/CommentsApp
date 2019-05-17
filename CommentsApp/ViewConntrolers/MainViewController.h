//
//  MainViewController.h
//  CommentsApp
//
//  Created by Bojana Sladojevic on 10/05/2019.
//  Copyright © 2019 Bojana Sladojevic. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MainViewController : UIViewController <UITextFieldDelegate>

- (void)SetTextFieldBorder :(UITextField *)textField;
-(void)initPostsManager;
-(void)initPhotoManager;
-(void)initCommentsManager;
-(void)initAlbumManager;
@end

NS_ASSUME_NONNULL_END
