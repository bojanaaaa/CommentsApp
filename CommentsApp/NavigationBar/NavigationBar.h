//
//  NavigationBar.h
//  CommentsApp
//
//  Created by Bojana Sladojevic on 13/05/2019.
//  Copyright © 2019 Bojana Sladojevic. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class NavigationBar;
@protocol NavigationBarDelegate <NSObject>
@optional
- (IBAction)backButtonDelegate:(id)sender;
- (IBAction)logOutButtonDelegate:(id)sender;
- (IBAction)photoSwitchDelegate:(id)sender;

@end

@interface NavigationBar : UIView
@property(strong,nonatomic) id <NavigationBarDelegate> delegate;

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

- (IBAction)photoSwitch:(id)sender;
- (IBAction)backButton:(id)sender;
- (IBAction)logOutButton:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *logOutButton;
@property (strong, nonatomic) IBOutlet UIButton *beckButton;
@property (strong, nonatomic) IBOutlet UISwitch *photoSwitch;



@end

NS_ASSUME_NONNULL_END
