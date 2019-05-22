//
//  NavigationBar.m
//  CommentsApp
//
//  Created by Bojana Sladojevic on 13/05/2019.
//  Copyright © 2019 Bojana Sladojevic. All rights reserved.
//

#import "NavigationBar.h"

@implementation NavigationBar

@synthesize contentView,delegate;


-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self customInit];
    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        [self customInit];
    }
    
    return self;
}

-(void)customInit {
    
    [[NSBundle mainBundle] loadNibNamed:@"View" owner:self options:nil];
    
    [self addSubview:self.contentView];
    self.contentView.frame=self.bounds;
}



- (IBAction)photoSwitch:(id)sender {
    
    if([self.delegate respondsToSelector:@selector(photoSwitchDelegate:)])
    {
        [self.delegate photoSwitchDelegate:self];
    }
    
    
}

- (IBAction)backButton:(id)sender {
    
    if([self.delegate respondsToSelector:@selector(backButtonDelegate:)])
    {
        [self.delegate backButtonDelegate:self];
    }
    
    
}


- (IBAction)logOutButton:(id)sender {
    if ([self.delegate respondsToSelector:@selector(logOutButtonDelegate:)]) {
        
        [self.delegate logOutButtonDelegate:self];
    }
}

- (IBAction)addPost:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(addPostDelegate:)]) {
        
        [self.delegate addPostDelegate:self];
    }

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
