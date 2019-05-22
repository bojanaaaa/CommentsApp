//
//  SignUpViewController.m
//  CommentsApp
//
//  Created by Bojana Sladojevic on 10/05/2019.
//  Copyright © 2019 Bojana Sladojevic. All rights reserved.
//

#import "SignUpViewController.h"
#import "LogInViewController.h"
#import "PostsViewController.h"
#import "UserManager.h"
#import "User.h"
#import "Konstante.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController{
    NSMutableArray *users;
    NSString *temp;
}
@synthesize emailTextField,passwordTextField,confirmedPasswordTextField,somethingWentWrongLabel,logInLabel,scrollView,scrollViewBottom,commentsAppTop;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    emailTextField.delegate=self;
    passwordTextField.delegate=self;
    confirmedPasswordTextField.delegate=self;
    scrollView.delegate=self;
    
    [self SetTextFieldBorder:emailTextField];
    [self SetTextFieldBorder:passwordTextField];
    [self SetTextFieldBorder:confirmedPasswordTextField];
    if (IS_IPHONE_5)
    {commentsAppTop.constant=100;
      
    }
    
    
    if (IS_IPHONE_6)
        commentsAppTop.constant=100;
    
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    emailTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"E-mail" attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    
    
    passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    
    confirmedPasswordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Confirm password" attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    
    //NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Password must contain a minimum of 6 characters"]];
    //NSInteger i=[attrStr length];
   // [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0,i)];
    //somethingWentWrongLabel.attributedText = attrStr;
    
    // Do any additional setup after loading the view.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

- (IBAction)emailEditingDidBegin:(id)sender {
    emailTextField.placeholder=nil;
    emailTextField.text=temp;
}
- (IBAction)passwordEditingDidBegin:(id)sender {
    passwordTextField.placeholder=nil;
}
- (IBAction)confirmationEditingDidBegin:(id)sender {
    confirmedPasswordTextField.placeholder=nil;
}
- (IBAction)emailEditingDidEnd:(id)sender {
    emailTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"E-mail" attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];

}
- (IBAction)passwordEditingDidEnd:(id)sender {
      passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
}
- (IBAction)confirmationEditingDidEnd:(id)sender {
       confirmedPasswordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Confirm password" attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if(textField==emailTextField)
    {
        [passwordTextField becomeFirstResponder];
    }
    
    if(textField==passwordTextField)
    {
        [confirmedPasswordTextField becomeFirstResponder];
    }
    else
    {
        [self signUp];
        
    }
    
    return YES;
}

-(void)signUp{
    
    if([emailTextField.text length]==0){
        
        emailTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"E-mail is reqired!" attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
        
    }
    else {
        NSLog(@"exists %i",[[UserManager sharedManager]checkForEmail:emailTextField.text]);
        if([[UserManager sharedManager]checkForEmail:emailTextField.text])
            
        {
            temp=[NSString new];
            temp=emailTextField.text;
            emailTextField.text=@"";
            emailTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"E-mail already exists!" attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
            
            passwordTextField.text=@"";
            passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
            confirmedPasswordTextField.text=@"";
            confirmedPasswordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Confirm password" attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
            return;
        }
        
    }
    
    if ([passwordTextField.text length]==0){
        
        passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password is reqired!" attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
        
    }
    else if ([passwordTextField.text length]<6){
        
        passwordTextField.text=@"";
        confirmedPasswordTextField.text=@"";
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Password must contain a minimum of 6 characters"]];
        NSInteger i=[attrStr length];
        [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,i)];
        somethingWentWrongLabel.attributedText = attrStr;
        passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
        confirmedPasswordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Confirm password" attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
        
    }
    else if([confirmedPasswordTextField.text isEqualToString:passwordTextField.text])
    {
        [[UserManager sharedManager]setUser:emailTextField.text and:passwordTextField.text];
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LogInViewController *cartController = [sb instantiateViewControllerWithIdentifier:@"LogInViewController"];
        [self.navigationController pushViewController:cartController animated:YES];
    }
    else {
        
        confirmedPasswordTextField.text=@"";
        confirmedPasswordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Not matching!" attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
        
        //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(next:) name:@"finished" object:nil];
    }
    
    
}


- (IBAction)signUpButton:(id)sender {
    
    [self signUp];
}

- (IBAction)logInButton:(id)sender {
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LogInViewController *cartController = [sb instantiateViewControllerWithIdentifier:@"LogInViewController"];
    
    [self.navigationController pushViewController:cartController animated:YES];
    
}

#pragma mark Keyboard change methods

- (void)keyboardWillHide:(NSNotification *)notification {
    [UIView animateWithDuration:0.3 animations:^{
        self->scrollViewBottom.constant = 0;
    }];
}

- (void)keyboardFrameWillChange:(NSNotification *)notification {
    
    CGRect keyboardEndFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval animationDuration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] integerValue];
    
    [self.view layoutIfNeeded];
    
    CGRect keyboardFrameEnd = [self.view convertRect:keyboardEndFrame toView:nil];
    
    if (keyboardFrameEnd.size.height > 0) {
        scrollViewBottom.constant = keyboardFrameEnd.size.height + 20;
        [scrollView setContentOffset:CGPointMake(0, emailTextField.frame.origin.y)];
        
    }
    
    
    
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
}

@end
