//
//  NavigationBar.m
//  CommentsApp
//
//  Created by Bojana Sladojevic on 10/05/2019.
//  Copyright © 2019 Bojana Sladojevic. All rights reserved.
//

#import "NavigationBar.h"

@implementation NavigationBar
@synthesize contentView;

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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
