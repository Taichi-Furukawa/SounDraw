//
//  MyButton.m
//  SounDrow
//
//  Created by 古川 泰地 on 2013/01/18.
//  Copyright (c) 2013年 古川 泰地. All rights reserved.
//

#import "MyButton.h"

@implementation MyButton

@synthesize btnColor,soundBuff,animationArr,animation,number;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
/*
-(void)chengeColor:(UIColor*)Color{
    [self setBackgroundColor:Color];
    
}
*/
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
