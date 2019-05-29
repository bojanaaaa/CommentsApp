//
//  EditPostViewController.m
//  CommentsApp
//
//  Created by Bojana Sladojevic on 27/05/2019.
//  Copyright © 2019 Bojana Sladojevic. All rights reserved.
//

#import "EditPostViewController.h"
#import "PostsManager.h"

@interface EditPostViewController ()

@end

@implementation EditPostViewController
@synthesize navigationBar,titleTextField,bodyTextView,scrollView,scrollViewBottomConstraint,post,bodyLabel,activityIndicator,editPostButton;
- (void)viewDidLoad {
    [super viewDidLoad];
    navigationBar.delegate=self;
    titleTextField.delegate=self;
    bodyTextView.delegate=self;
    scrollView.delegate=self;
    titleTextField.text=post.title;
    bodyTextView.text=post.body;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopIndicator:) name:@"postedited" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(somethingWentWrong:) name:@"somethingwentwrongwhileediting" object:nil];
    
    
    [self SetTextFieldBorder:titleTextField];
        titleTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Title" attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    
    [[self.bodyTextView layer] setBorderColor:[[UIColor grayColor] CGColor]];
    [[self.bodyTextView layer] setBorderWidth:2.3];
    [[self.bodyTextView layer] setCornerRadius:0];
    navigationBar.nameLabel.text=@"EDIT POST";
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    navigationBar.beckButton.hidden=NO;
    navigationBar.logOutButton.hidden=YES;
    navigationBar.nameLabel.hidden=NO;
    navigationBar.addPost.hidden=YES;
    navigationBar.photoSwitch.hidden=YES;
    navigationBar.editPost.hidden=YES;
    bodyLabel.hidden=YES;
    activityIndicator.hidden=YES;
}
- (void)backButtonDelegate:(id)sender{
    
     [self.navigationController popViewControllerAnimated:YES];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if(textField==titleTextField)
    {
        [bodyTextView becomeFirstResponder];
    }
    return YES;
}
-(void)textViewDidBeginEditing:(UITextView *)textView{
    
    bodyLabel.hidden=YES;
    
}
- (void)textViewDidEndEditing:(UITextView *) textView {
    if (![textView hasText]) {
        bodyLabel.hidden = NO;
    }
}

- (void) textViewDidChange:(UITextView *)textView {
    if(![textView hasText]) {
        bodyLabel.hidden = NO;
    }
    else {
        bodyLabel.hidden = YES;
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)editButton:(id)sender {
    
    [self editPostCall:post];
    
}
-(void) editPostCall:(Post *)post{
    
   
 
    if([titleTextField.text length]==0)
    {
        
        titleTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Title is reqired!" attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
        
    }
    if([bodyTextView.text length]==0)
    {
        
       bodyLabel.hidden=NO;
        
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Body text is reqired!"]];
        NSInteger i=[attrStr length];
        [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,i)];
        bodyLabel.attributedText = attrStr;
        
    }
    else {
        BOOL chack=YES;
        NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
        [def setBool:chack forKey:@"reload"];
        activityIndicator.hidden=NO;
        titleTextField.hidden=YES;
        bodyTextView.hidden=YES;
        editPostButton.hidden=YES;
        bodyLabel.hidden=YES;
        navigationBar.editPost.hidden=YES;
        post.title=titleTextField.text;
        post.body=bodyTextView.text;
    
        [self.activityIndicator startAnimating];
        [[PostsManager sharedManager]editPost:post];
    }
    
}
-(void)stopIndicator:(NSNotification *)notification {
    
  activityIndicator.hidesWhenStopped=YES;
  [self.activityIndicator stopAnimating];
    
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Notification"
                                 message:@"Post is edited!"
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    //Add Buttons
    
    UIAlertAction* okButton = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   
                                  [self.navigationController popViewControllerAnimated:YES];
                                   
                               }];
    
    [alert addAction:okButton];
    [self presentViewController:alert animated:YES completion:nil];
    
}
-(void)somethingWentWrong:(NSNotification *)notification{
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Notification"
                                 message:@"Post is not edited, due to poor intenet conection!"
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    //Add Buttons
    
    UIAlertAction* okButton = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   self->activityIndicator.hidesWhenStopped=YES;
                                   [self.activityIndicator stopAnimating];
                                   self->titleTextField.hidden=NO;
                                   self->bodyTextView.hidden=NO;
                                   self->editPostButton.hidden=NO;
                                   self->bodyLabel.hidden=YES;
                                   self->navigationBar.editPost.hidden=NO;
                                  // [self.navigationController popViewControllerAnimated:YES];
                               }];
    
    [alert addAction:okButton];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark Keyboard change methods

- (void)keyboardWillHide:(NSNotification *)notification {
    [UIView animateWithDuration:0.3 animations:^{
        self->scrollViewBottomConstraint.constant = 0;
    }];
}

- (void)keyboardFrameWillChange:(NSNotification *)notification {
    
    CGRect keyboardEndFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval animationDuration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] integerValue];
    
    [self.view layoutIfNeeded];
    
    CGRect keyboardFrameEnd = [self.view convertRect:keyboardEndFrame toView:nil];
    
    if (keyboardFrameEnd.size.height > 0) {
        scrollViewBottomConstraint.constant = keyboardFrameEnd.size.height + 20;
        [scrollView setContentOffset:CGPointMake(0, titleTextField.frame.origin.y)];
        
    }
    
    
    
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
}
@end
