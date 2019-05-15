//
//  LogInViewController.m
//  CommentsApp
//
//  Created by Bojana Sladojevic on 10/05/2019.
//  Copyright © 2019 Bojana Sladojevic. All rights reserved.
//

#import "LogInViewController.h"
#import "User.h"
#import "SignUpViewController.h"
#import "PostsViewController.h"
#import "CommentsViewController.h"
#import "UserManager.h"
#import "Konstante.h"
@interface LogInViewController ()

@end

@implementation LogInViewController{
    
    NSString *email, *password;
    
    BOOL rememberMe;
    User *user;
    
}
@synthesize commentsAppLabel,emailTextField,passwordTextField,rememberMeLabel,somethingWentWrongLabel,checkImage,signUpLabel,commentsAppTop,scrollView,scrollViewBottom;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    scrollView.delegate=self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    if (IS_IPHONE_5)
        commentsAppTop.constant=50;
  
      
    if (IS_IPHONE_6)
        commentsAppTop.constant=70;
        
    emailTextField.delegate = self;
    [self SetTextFieldBorder:emailTextField];
    
    passwordTextField.delegate = self;
    [self SetTextFieldBorder:passwordTextField];
    
    emailTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"E-mail" attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    
    passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    email=[NSString new];
    password=[NSString new];
    email=@"nekoje";
    password=@"nekoje";
   
    
    /*if ( IS_IPHONE_5)
    {
        emailTop.constant=10;
    }*/
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    
    if (IS_IPHONE_5)
    {commentsAppTop.constant=225;
        NSLog(@"radim");
    }
    
    
    if (IS_IPHONE_6)
        commentsAppTop.constant=225;
    rememberMe=[self rememberMe];
    
    if (rememberMe)
    {
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
       emailTextField.text = [defaults objectForKey:@"username"];
        passwordTextField.text = [defaults objectForKey:@"password"];
        
        rememberMeLabel.textColor=[UIColor blackColor];
        checkImage.image = [UIImage imageNamed: @"check_active"];
        
        user.email=emailTextField.text;
        user.password=passwordTextField.text;
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        CommentsViewController *cartController = [sb instantiateViewControllerWithIdentifier:@"CommentsViewController"];
        
        //cartController.user = user;
        
       // [self.navigationController pushViewController:cartController animated:YES];
    }
    else {
        
        rememberMeLabel.textColor=[UIColor grayColor];
        checkImage.image = [UIImage imageNamed: @"check_unactive"];
    }
    
    
}/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)textFieldDidStartEditing:(id)sender {
    
    emailTextField.placeholder=nil;
}
- (IBAction)emailEditingDidEnd:(id)sender {
    
    emailTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"E-mail" attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
}
- (IBAction)passwordTextFieldDidStartEditing:(id)sender {
    
    passwordTextField.placeholder=nil;
}
- (IBAction)passwordEditingEnd:(id)sender {
    passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
}

-(BOOL)rememberMe
{
    NSUserDefaults *def= [NSUserDefaults standardUserDefaults];
    rememberMe=[def boolForKey:@"rememberMe"];
    
    return rememberMe;
}

- (IBAction)rememberMeButton:(id)sender {
    
    rememberMe=!rememberMe;
    
    if (rememberMe)
    {
        
        rememberMeLabel.textColor=[UIColor blackColor];
        checkImage.image = [UIImage imageNamed: @"check_active"];
        
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        [defaults setObject:emailTextField.text forKey:@"username"];
        [defaults setObject:passwordTextField.text forKey:@"password"];
        [defaults synchronize];
        
    }
    
    else
    {   rememberMeLabel.textColor=[UIColor grayColor];
        
        checkImage.image = [UIImage imageNamed: @"check_unactive"];
    }
    
    NSUserDefaults *def= [NSUserDefaults standardUserDefaults];
    [def setBool:rememberMe forKey:@"rememberMe"];
    
    [def synchronize];
}

- (IBAction)logInButton:(id)sender {
    
    User *user;
    
    if ( [emailTextField.text length]==0 )
        
        emailTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"E-mail is reqired!" attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
    
    if ( [passwordTextField.text length]==0 )
        passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password is reqired!" attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];

    
   /* if ([emailTextField.text isEqualToString: email]){
    if ( [passwordTextField.text isEqualToString: password] )
        
    {
        
        user.email=emailTextField.text;
        user.password=passwordTextField.text;
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        PostsViewController *cartController = [sb instantiateViewControllerWithIdentifier:@"PostsViewController"];
        //cartController.user = user;
        
        
        [self.navigationController pushViewController:cartController animated:YES];
        
    }
        
    else  {
        
        passwordTextField.text=@"";
        passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Incorect" attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];}
    }*/
    
    if((user=[[UserManager sharedManager]returnUser:emailTextField.text])){
        
        if(user.password==passwordTextField.text)
        {
            emailTextField.text=@"";
            passwordTextField.text=@"";
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            PostsViewController *cartController = [sb instantiateViewControllerWithIdentifier:@"PostsViewController"];
            //cartController.user = user;
            NSLog(@"user %@",user.email);
            passwordTextField.text=@"";
            emailTextField.text=@"";
            
            [self.navigationController pushViewController:cartController animated:YES];
        }
        else
            somethingWentWrongLabel.text=@"Password is incorect!";
    }
    else
    {   emailTextField.text=@"";
        emailTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"E-mail" attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
        passwordTextField.text=@"";
        passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
        somethingWentWrongLabel.text=@"No existing acount,please SIGN UP!";
    }
    
}

- (IBAction)signUpButton:(id)sender {
    
 
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
     SignUpViewController *cartController = [sb instantiateViewControllerWithIdentifier:@"SignUpViewController"];
    
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
        scrollViewBottom.constant = keyboardFrameEnd.size.height + 10;
        [scrollView setContentOffset:CGPointMake(0, emailTextField.frame.origin.y)];
        
    }
    
    
    
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
}
@end
