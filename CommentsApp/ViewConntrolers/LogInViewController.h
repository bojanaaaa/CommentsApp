//
//  LogInViewController.h
//  CommentsApp
//
//  Created by Bojana Sladojevic on 10/05/2019.
//  Copyright © 2019 Bojana Sladojevic. All rights reserved.
//

#import "MainViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LogInViewController : MainViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UILabel *commentsAppLabel;

@property (strong, nonatomic) IBOutlet UITextField *emailTextField;

@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;

@property (strong, nonatomic) IBOutlet UILabel *somethingWentWrongLabel;

@property (strong, nonatomic) IBOutlet UIImageView *checkImage;

@property (strong, nonatomic) IBOutlet UILabel *rememberMeLabel;

@property (strong, nonatomic) IBOutlet UILabel *signUpLabel;

- (IBAction)rememberMeButton:(id)sender;

- (IBAction)logInButton:(id)sender;

- (IBAction)signUpButton:(id)sender;


@end

NS_ASSUME_NONNULL_END
