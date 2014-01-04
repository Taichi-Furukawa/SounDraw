//
//  ViewController.m
//  SounDrow
//
//  Created by 古川 泰地 on 2013/01/10.
//  Copyright (c) 2013年 古川 泰地. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController
@synthesize cycle,btnArrX,colorArr,nomal_Color,action_Color;

int BUTTON_y=0;
int BUTTON_x=0;
BOOL hit;
MyButton* rect;
BOOL tapend;
BOOL firstContact;
int firstPosition=0;
int btnCount=0;
UIImageView *anime;
- (void)viewDidLoad
{
    [super viewDidLoad];
    btnArrX = [NSMutableArray array];
    colorArr = [NSMutableArray array];
    anime = [UIImageView new];
    CGRect inRect;
    sc = [UIScreen mainScreen];
    CGRect rect = sc.bounds;
    if (rect.size.height==568.0) {
        inRect=CGRectMake(31,31,24,24);
        firstPosition=9;
        BUTTON_x=10;
        BUTTON_y=18;
    }else if(rect.size.height==480.0){
        inRect=CGRectMake(31,31,24,24);
        firstPosition=9;
        BUTTON_x=10;
        BUTTON_y=15;
    }else if(rect.size.height==1024.0){
        inRect=CGRectMake(32,32,24,24);
        firstPosition=4;
        BUTTON_x=24;
        BUTTON_y=32;
    }
    MyButton *box=[[MyButton alloc]init];
    box.number=0;
    NSMutableArray *Yarray[BUTTON_x];
    
    for (int i=0; i<BUTTON_x; i++) {
        Yarray[i]=[NSMutableArray array];
    }
    
    ALuint  _buffers[BUTTON_x];
    ALuint  _sources[BUTTON_x];
    
    // OpneALデバイスを開く
    ALCdevice*  device;
    device = alcOpenDevice(NULL);
    
    // OpenALコンテキストを作成して、カレントにする
    ALCcontext* alContext;
    alContext = alcCreateContext(device, NULL);
    alcMakeContextCurrent(alContext);
    
    // バッファとソースを作成する
    alGenBuffers(BUTTON_x, _buffers);
    alGenSources(BUTTON_x, _sources);
    
    for (int i = 0; i < BUTTON_x; i++) {
        // サウンドファイルパスを取得する
        NSString*   fileName = nil;
        NSString*   path;
        if (BUTTON_x==10) {
        switch (i) {
            case 0: fileName = @"5.1"; break;
            case 1: fileName = @"5.2"; break;
            case 2: fileName = @"5.3"; break;
            case 3: fileName = @"5.4"; break;
            case 4: fileName = @"5.5"; break;
            case 5: fileName = @"6.1"; break;
            case 6: fileName = @"6.2"; break;
            case 7: fileName = @"6.3"; break;
            case 8: fileName = @"6.4"; break;
            case 9: fileName = @"6.5"; break;
        }
        }
        if(BUTTON_x==24){
            switch (i) {
                case 0: fileName = @"3.2"; break;
                case 1: fileName = @"3.3"; break;
                case 2: fileName = @"3.4"; break;
                case 3: fileName = @"3.5"; break;
                case 4: fileName = @"4.1"; break;
                case 5: fileName = @"4.2"; break;
                case 6: fileName = @"4.3"; break;
                case 7: fileName = @"4.4"; break;
                case 8: fileName = @"4.5"; break;
                case 9: fileName = @"5.1"; break;
                case 10: fileName = @"5.2"; break;
                case 11: fileName = @"5.3"; break;
                case 12: fileName = @"5.4"; break;
                case 13: fileName = @"5.5"; break;
                case 14: fileName = @"6.1"; break;
                case 15: fileName = @"6.2"; break;
                case 16: fileName = @"6.3"; break;
                case 17: fileName = @"6.4"; break;
                case 18: fileName = @"6.5"; break;
                case 19: fileName = @"7.1"; break;
                case 20: fileName = @"7.2"; break;
                case 21: fileName = @"7.3"; break;
                case 22: fileName = @"7.4"; break;
                case 23: fileName = @"7.5"; break;
                
            }
            
        }
        path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"m4a"];
        
        // オーディオデータを取得する
        void*   audioData;
        ALsizei dataSize;
        ALenum  dataFormat;
        ALsizei sampleRate;
        audioData = GetOpenALAudioData((__bridge CFURLRef)[NSURL fileURLWithPath:path], &dataSize, &dataFormat, &sampleRate);
        
        // データをバッファに設定する
        alBufferData(_buffers[i], dataFormat, audioData, dataSize, sampleRate);
        
        // バッファをソースに設定する
        alSourcei(_sources[i], AL_BUFFER, _buffers[i]);
    }
    
    NSMutableArray *array=[NSMutableArray array];
    UIImage *image =[[UIImage alloc]init];
    for (int i=0; i<20; i++) {
        image=[self imageWithColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0-(0.05*i)]];
        [array addObject:image];
    }
    
    [self colorCreate];
    
    UIView *uv = [UIView new];
    uv.frame = CGRectMake(0,0,rect.size.width,rect.size.height);
    uv.backgroundColor = [UIColor blackColor];
    [self.view addSubview:uv];
    int count=0;
    for (int u=0;u<BUTTON_x;u++) {
        for(int i=0;i<BUTTON_y;i++){
            UIImageView *image=[UIImageView new];
            image.animationRepeatCount=1;
            image.animationDuration=1.5;
            image.userInteractionEnabled=YES;
            image.animationImages=array;
            
            CGRect boxRect = CGRectMake((inRect.origin.x*u)+firstPosition, (inRect.origin.y*i)+firstPosition,inRect.size.width,inRect.size.height);
            box=[MyButton buttonWithType:UIButtonTypeCustom];
            box.frame = boxRect;
            box.selected=NO;
            [box setBackgroundColor:nomal_Color];
            box.enabled=NO;
            box.btnColor=[colorArr objectAtIndex:u];
            box.soundBuff=_sources[u];
            box.animation=image;
            box.animation.frame=boxRect;
            [Yarray[u] addObject:box];
           
            [self.view addSubview:box];
            [self.view addSubview:box.animation];
            count++;
        }
        [btnArrX addObject:Yarray[u]];
    }
    
    
    cycle=[NSTimer scheduledTimerWithTimeInterval:0.15f
                                        target:self
                                      selector:@selector(tone:)
                                      userInfo:NULL
                                       repeats:YES];
}
-(void)colorCreate{
    nomal_Color = RGB(25, 25, 25);
    UIColor *enaColor=[UIColor new];
    for (int i=0; i<BUTTON_x; i++) {
        enaColor = RGB(255, (225/BUTTON_x)*i, 0);
        [colorArr addObject:enaColor];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    startLocation = [[touches anyObject] locationInView:self.view];
    hit=[self hitcheck:startLocation];
    tapend=YES;
    if(hit==YES){
        if (rect.selected==NO) {
            firstContact=NO;
        }else if(rect.selected==YES){
            firstContact=YES;
        }
        tapend=NO;
    }
    if (firstContact==NO) {
        [self ClickYes:rect];
    }else if(firstContact==YES){
        [self ClickNo:rect];
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint pt = [[touches anyObject] locationInView:self.view];
    hit=[self hitcheck :pt];
    if (hit==YES) {
        while (tapend==YES) {
            if (rect.selected==NO) {
                firstContact=NO;
            }else if(rect.selected==YES){
                firstContact=YES;
            }
            tapend=NO;
        }
    }
    if (firstContact==NO) {
        [self ClickYes:rect];
    }else if(firstContact==YES){
        [self ClickNo:rect];
    }
    
}

- (void)ClickNo:(MyButton*)sender{
    sender.selected=NO;
    [sender setBackgroundColor:nomal_Color];
    [sender.animation stopAnimating];
}

-(void)ClickYes:(MyButton*)sender{
    sender.selected=YES;
    [sender setBackgroundColor:sender.btnColor];
}


-(BOOL)hitcheck:(CGPoint)pt{
    NSMutableArray* arr=[NSMutableArray array];
    rect=[[MyButton alloc]init];
    for (arr in btnArrX) {
        for (rect in arr) {
            if ((pt.x>rect.frame.origin.x-(firstPosition/2) && pt.x<rect.frame.origin.x + rect.frame.size.width+(firstPosition/2))&&(pt.y>rect.frame.origin.y-(firstPosition/2)&& pt.y<rect.frame.origin.y + rect.frame.size.height+(firstPosition/2))) {
                return YES;
        }
     }
    }
    return NO;
}

-(void)tone:(NSTimer*)timer{
    NSMutableArray *timearr=[NSMutableArray array];
    MyButton *timebtn=[[MyButton alloc]init];
    int gain=0;
    for (timearr in btnArrX) {
        timebtn = [timearr objectAtIndex:btnCount];
        if (timebtn.selected==YES){
            gain++;
        }
    }
    for (timearr in btnArrX) {
        timebtn = [timearr objectAtIndex:btnCount];
        if (timebtn.selected==YES){
            
            timebtn.animation.frame=timebtn.frame;
            
             
            alSourcef(timebtn.soundBuff, AL_GAIN,1.0/gain);
            [timebtn.animation startAnimating];
            alSourcePlay(timebtn.soundBuff);
            
        }
    }
    btnCount++;
    if (btnCount==BUTTON_y) {
        btnCount=0;
    }
}

-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    NSMutableArray* reArr=[NSMutableArray array];
    MyButton *reSet=[[MyButton alloc]init];
    for (reArr in btnArrX) {
        for (reSet in reArr) {
            if (reSet.selected==YES) {
                reSet.selected=NO;
                [reSet.animation stopAnimating];
                [reSet.animation startAnimating];
                [reSet setBackgroundColor:nomal_Color];
            }
        }
    }
}

void* GetOpenALAudioData(
                         CFURLRef fileURL, ALsizei* dataSize, ALenum* dataFormat, ALsizei *sampleRate)
{
    OSStatus    err;
    UInt32      size;
    
    // オーディオファイルを開く
    ExtAudioFileRef audioFile;
    err = ExtAudioFileOpenURL(fileURL, &audioFile);
    
    
    // オーディオデータフォーマットを取得する
    AudioStreamBasicDescription fileFormat;
    size = sizeof(fileFormat);
    err = ExtAudioFileGetProperty(
                                  audioFile, kExtAudioFileProperty_FileDataFormat, &size, &fileFormat);
    
    
    // アウトプットフォーマットを設定する
    AudioStreamBasicDescription outputFormat;
    outputFormat.mSampleRate = fileFormat.mSampleRate;
    outputFormat.mChannelsPerFrame = fileFormat.mChannelsPerFrame;
    outputFormat.mFormatID = kAudioFormatLinearPCM;
    outputFormat.mBytesPerPacket = 2 * outputFormat.mChannelsPerFrame;
    outputFormat.mFramesPerPacket = 1;
    outputFormat.mBytesPerFrame = 2 * outputFormat.mChannelsPerFrame;
    outputFormat.mBitsPerChannel = 16;
    outputFormat.mFormatFlags = kAudioFormatFlagsNativeEndian | kAudioFormatFlagIsPacked | kAudioFormatFlagIsSignedInteger;
    err = ExtAudioFileSetProperty(
                                  audioFile, kExtAudioFileProperty_ClientDataFormat, sizeof(outputFormat), &outputFormat);
    
    
    // フレーム数を取得する
    SInt64  fileLengthFrames = 0;
    size = sizeof(fileLengthFrames);
    err = ExtAudioFileGetProperty(
                                  audioFile, kExtAudioFileProperty_FileLengthFrames, &size, &fileLengthFrames);
    
    
    // バッファを用意する
    UInt32          bufferSize;
    void*           data;
    AudioBufferList dataBuffer;
    bufferSize = fileLengthFrames * outputFormat.mBytesPerFrame;;
    data = malloc(bufferSize);
    dataBuffer.mNumberBuffers = 1;
    dataBuffer.mBuffers[0].mDataByteSize = bufferSize;
    dataBuffer.mBuffers[0].mNumberChannels = outputFormat.mChannelsPerFrame;
    dataBuffer.mBuffers[0].mData = data;
    
    // バッファにデータを読み込む
    err = ExtAudioFileRead(audioFile, (UInt32*)&fileLengthFrames, &dataBuffer);
    if (err) {
        free(data);
        goto Exit;
    }
    
    // 出力値を設定する
    *dataSize = (ALsizei)bufferSize;
    *dataFormat = (outputFormat.mChannelsPerFrame > 1) ? AL_FORMAT_STEREO16 : AL_FORMAT_MONO16;
    *sampleRate = (ALsizei)outputFormat.mSampleRate;
    
Exit:
    // オーディオファイルを破棄する
    if (audioFile) {
        ExtAudioFileDispose(audioFile);
    }
    
    return data;
}

//指定したUIColorでCGRectの大きさを塗り潰したUIImageを返す
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}

- (BOOL)canBecomeFirstResponder {
   // NSLog(@"canBecomeFirstResponder()");
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
