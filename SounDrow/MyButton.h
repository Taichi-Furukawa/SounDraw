//
//  MyButton.h
//  SounDrow
//
//  Created by 古川 泰地 on 2013/01/18.
//  Copyright (c) 2013年 古川 泰地. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <OpenAL/al.h>
#import <OpenAL/alc.h>

@interface MyButton : UIButton{
    UIColor *btnColor;
    ALuint soundBuff;
    UIImageView *animation;
    NSMutableArray *animationArr;
    int number;
}
@property(nonatomic,retain)UIColor* btnColor;
@property(nonatomic,retain)UIImageView *animation;
@property(nonatomic,retain)NSMutableArray *animationArr;
@property(nonatomic)ALuint soundBuff;
@property(nonatomic)int number;
@end
