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

@interface SignUpViewController ()

@end

@implementation SignUpViewController{
    NSMutableArray *users;
    NSString *temp;
}
@synthesize emailTextField,passwordTextField,confirmedPasswordTextField,somethingWentWrongLabel,logInLabel;
- (void)viewDidLoad {
    [super viewDidLoad];
    emailTextField.delegate=self;
    passwordTextField.delegate=self;
    confirmedPasswordTextField.delegate=self;
    
    emailTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"E-mail" attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    
    passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    
    confirmedPasswordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Confirm password" attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    
    // Do any additional setup after loading the view.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


- (IBAction)signUpButton:(id)sender {
    
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
            passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName:[UIColor blueColor]}];
            return;
        }
        
    }
    
    
    if ([passwordTextField.text length]==0){
        
        passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password is reqired!" attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
        
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

- (IBAction)logInButton:(id)sender {
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LogInViewController *cartController = [sb instantiateViewControllerWithIdentifier:@"LogInViewController"];
    
    [self.navigationController pushViewController:cartController animated:YES];
    
}
@end
