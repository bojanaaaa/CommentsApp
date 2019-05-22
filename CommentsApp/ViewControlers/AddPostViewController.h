//
//  AddPostViewController.h
//  CommentsApp
//
//  Created by Bojana Sladojevic on 21/05/2019.
//  Copyright © 2019 Bojana Sladojevic. All rights reserved.
//

#import "MainViewController.h"
#import "NavigationBar.h"
NS_ASSUME_NONNULL_BEGIN

@interface AddPostViewController : MainViewController <NavigationBarDelegate,UITextFieldDelegate,UITextViewDelegate,UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet NavigationBar *navigationBar;
@property (strong, nonatomic) IBOutlet UITextField *titleTextField;
@property (strong, nonatomic) IBOutlet UITextView *bodyTextView;
@property (strong, nonatomic) IBOutlet UILabel *bodyLabel;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *scrollViewBottom;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;


@property (strong, nonatomic) IBOutlet UIButton *addPostButton;

- (IBAction)addPostButton:(id)sender;

@end

NS_ASSUME_NONNULL_END
