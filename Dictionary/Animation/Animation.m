//
//  Animation.m
//  Dictionary
//
//  Created by Son Lui on 2013/07/23.
//  Copyright (c) 2013年 SONLUI. All rights reserved.
//

#import "Animation.h"

@implementation Animation

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self = [[[NSBundle mainBundle] loadNibNamed:@"Animation" owner:self options:nil]lastObject];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
