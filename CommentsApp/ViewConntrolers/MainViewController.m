//
//  MainViewController.m
//  CommentsApp
//
//  Created by Bojana Sladojevic on 10/05/2019.
//  Copyright © 2019 Bojana Sladojevic. All rights reserved.
//

#import "MainViewController.h"
#import "User.h"

@interface MainViewController ()

@end

@implementation MainViewController{
    UIActivityIndicatorView *loadingIndicator;
    UIView *menuOverlayView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}
- (void)showLoadingUseFullScreen:(bool)fullscreen {
    if (!loadingIndicator) {
        loadingIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];

        
        loadingIndicator.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.7];
        [self.view addSubview:loadingIndicator];
    }
    [loadingIndicator startAnimating];
    loadingIndicator.hidden = false;
    [self.view bringSubviewToFront:loadingIndicator];
}

- (void)hideLoading {
    if (loadingIndicator) {
        [loadingIndicator stopAnimating];
        loadingIndicator.hidden = true;
        [self.view sendSubviewToBack:loadingIndicator];
    }
}
-(void)SetTextFieldBorder :(UITextField *)textField{
    
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 2;
    border.borderColor = [UIColor grayColor].CGColor;
    border.frame = CGRectMake(0, textField.frame.size.height - borderWidth, textField.frame.size.width, textField.frame.size.height);
    border.borderWidth = borderWidth;
    [textField.layer addSublayer:border];
    textField.layer.masksToBounds = YES;
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
