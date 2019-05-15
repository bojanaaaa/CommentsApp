//
//  SignUpViewController.h
//  CommentsApp
//
//  Created by Bojana Sladojevic on 10/05/2019.
//  Copyright © 2019 Bojana Sladojevic. All rights reserved.
//

#import "MainViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SignUpViewController : MainViewController<UITextFieldDelegate,UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *commentsAppLabel;

@property (strong, nonatomic) IBOutlet UITextField *emailTextField;

@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;

@property (strong, nonatomic) IBOutlet UITextField *confirmedPasswordTextField;

@property (strong, nonatomic) IBOutlet UILabel *somethingWentWrongLabel;

@property (strong, nonatomic) IBOutlet UILabel *logInLabel;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewBottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentsAppTop;
- (IBAction)signUpButton:(id)sender;


- (IBAction)logInButton:(id)sender;



@end

NS_ASSUME_NONNULL_END
