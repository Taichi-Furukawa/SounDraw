//
//  ViewController.h
//  SounDrow
//
//  Created by 古川 泰地 on 2013/01/10.
//  Copyright (c) 2013年 古川 泰地. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import <OpenAL/al.h>
#import <OpenAL/alc.h>
#import "MyButton.h"

@interface ViewController : UIViewController{
    
    UIColor* nomal_Color;
    NSMutableArray *colorArr;
    NSMutableArray *btnArrX;
    NSTimer* cycle;
    UIScreen *sc;
    CGPoint startLocation;
    
}

@property(nonatomic,retain)UIColor* nomal_Color;
@property(nonatomic,retain)UIColor* action_Color;
@property(nonatomic,retain)NSMutableArray *colorArr;
@property(nonatomic,retain)NSMutableArray *btnArrX;
@property(nonatomic,retain)NSTimer* cycle;



@end
