//
//  AddPostViewController.m
//  CommentsApp
//
//  Created by Bojana Sladojevic on 21/05/2019.
//  Copyright © 2019 Bojana Sladojevic. All rights reserved.
//

#import "AddPostViewController.h"
#import "PostsViewController.h"
#import "Post.h"
#import "PostsManager.h"
#import <QuartzCore/QuartzCore.h>
@interface AddPostViewController ()

@end

@implementation AddPostViewController{
    Post *newPost;
}
@synthesize navigationBar,bodyTextView,titleTextField,bodyLabel,scrollView,scrollViewBottom,activityIndicator,addPostButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    newPost=[Post new];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopIndicator:) name:@"newarraypost" object:nil];
    
    
    navigationBar.delegate=self;
    titleTextField.delegate=self;
    bodyTextView.delegate=self;
   // [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(limitTextField) name:UITextFieldTextDidChangeNotification object:nil];
    titleTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Title" attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    [self SetTextFieldBorder:titleTextField];
    
   // bodyTextView.text=@"Body";
   // bodyTextView.textColor= [UIColor lightGrayColor];
    
    [[self.bodyTextView layer] setBorderColor:[[UIColor grayColor] CGColor]];
    [[self.bodyTextView layer] setBorderWidth:2.3];
    [[self.bodyTextView layer] setCornerRadius:0];
    // Do any additional setup after loading the view.
}
/*-(void)limitTextField
{
    titleTextField.text = [titleTextField.text substringToIndex:60];
}*/
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Prevent crashing undo bug – see note below.
    if(range.length + range.location > titleTextField.text.length)
    {
        return NO;
    }
    
    NSUInteger newLength = [titleTextField.text length] + [string length] - range.length;
    return newLength <= 60;
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

- (void)viewWillAppear:(BOOL)animated{
    
    bodyLabel.hidden=NO;
    navigationBar.beckButton.hidden=NO;
    navigationBar.logOutButton.hidden=YES;
    navigationBar.nameLabel.text=@"ADD POST";
    navigationBar.photoSwitch.hidden=YES;
    navigationBar.addPost.hidden=YES;
    activityIndicator.hidden=YES;
}



- (void)backButtonDelegate:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if(textField==titleTextField)
    {
        [bodyTextView becomeFirstResponder];
    }
    else
    {
        [self addPostCall:newPost];
    }
    
    return YES;
}


-(void) addPostCall:(Post *)newPost{
    
    NSArray *postsArray=[PostsManager sharedManager].postsArray;
    newPost.postID=@([postsArray count]+1);
    newPost.userID=@(1);
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
    newPost.title=titleTextField.text;
    newPost.body=bodyTextView.text;
    activityIndicator.hidden=NO;
    titleTextField.hidden=YES;
    bodyTextView.hidden=YES;
    addPostButton.hidden=YES;
    bodyLabel.hidden=YES;
        
        BOOL chack=YES;
        NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
        [def setBool:chack forKey:@"writenewpost"];
       /* NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
        [def setBool:chack forKey:@"writenewpost"];
        [def setObject:newPost.postID forKey:@"id"];
        [def setObject:newPost.userID forKey:@"userId"];
        [def setObject:newPost.title forKey:@"title"];
        [def setObject:newPost.body forKey:@"body"];
        [def synchronize];*/
        
    [self.activityIndicator startAnimating];
    [[PostsManager sharedManager]addPost:newPost];
       /*UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        PostsViewController *cartController = [sb instantiateViewControllerWithIdentifier:@"PostsViewController"];
        [self.navigationController pushViewController:cartController animated:YES];*/
       
    }
    
}
-(void)stopIndicator:(NSNotification *)notification {
    
    activityIndicator.hidesWhenStopped=YES;
    [self.activityIndicator stopAnimating];
    
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Notification"
                                 message:@"Post is created!"
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    //Add Buttons
    
    UIAlertAction* okButton = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
     
     UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
     PostsViewController *cartController = [sb instantiateViewControllerWithIdentifier:@"PostsViewController"];
     [self.navigationController pushViewController:cartController animated:YES];
     
                               }];
    
    [alert addAction:okButton];
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (IBAction)addPostButton:(id)sender {
    
    [self addPostCall:newPost];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
        [scrollView setContentOffset:CGPointMake(0, titleTextField.frame.origin.y)];
        
    }
    
    
    
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
}
@end
