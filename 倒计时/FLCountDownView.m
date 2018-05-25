//
//  CZCountDownView.m
//  countDownDemo
//
//  Created by 孔凡列 on 15/12/9.
//  Copyright © 2015年 czebd. All rights reserved.
//
#define YHFont(a) [UIFont systemFontOfSize:(a)];
#import "FLCountDownView.h"
// label数量
#define labelCount 3
#define separateLabelCount 2
#define padding 5
@interface FLCountDownView (){
    // 定时器
    NSTimer *timer;
}
@property (nonatomic,strong)NSMutableArray *timeLabelArrM;
@property (nonatomic,strong)NSMutableArray *separateLabelArrM;
// day
//@property (nonatomic,strong)UILabel *dayLabel;
// hour
@property (nonatomic,strong)UILabel *hourLabel;
// minues
@property (nonatomic,strong)UILabel *minuesLabel;
// seconds
@property (nonatomic,strong)UILabel *secondsLabel;
@end

@implementation FLCountDownView
// 创建单例
+ (instancetype)fl_shareCountDown{
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[FLCountDownView alloc] init];
    });
    return instance;
}

+ (instancetype)fl_countDown{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
    //    [self addSubview:self.dayLabel];
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.hourLabel];
        [self addSubview:self.minuesLabel];
        [self addSubview:self.secondsLabel];
        
        
    //    self.dayLabel.font = YHFont(15);
        self.hourLabel.font = YHFont(10);
        self.hourLabel.textColor = [UIColor blueColor];
        self.minuesLabel.font = YHFont(10);
        self.minuesLabel.textColor = [UIColor blueColor];
        self.secondsLabel.font = YHFont(10);
        self.secondsLabel.textColor = [UIColor blueColor];
        
        self.hourLabel.text = @"00";
        self.minuesLabel.text = @"00";
        self.secondsLabel.text = @"00";
        for (NSInteger index = 0; index < separateLabelCount; index ++) {
            UILabel *separateLabel = [[UILabel alloc] init];
            separateLabel.text = @":";
            separateLabel.font = YHFont(10);
            separateLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:separateLabel];
            [self.separateLabelArrM addObject:separateLabel];
        }
        
        _outTimeLB = [[UILabel alloc] init];
        _outTimeLB.textAlignment = NSTextAlignmentCenter;
        //超时
        _outTimeLB.backgroundColor = [UIColor whiteColor];
        _outTimeLB.textColor = [UIColor redColor];
        _outTimeLB.font = YHFont(12);
        _outTimeLB.textAlignment = NSTextAlignmentCenter;
        _outTimeLB.text = @"钓鱼超时";
        _outTimeLB.hidden = YES;
        [self addSubview:self.outTimeLB];

    }
    return self;
}

- (void)setBackgroundImageName:(NSString *)backgroundImageName{
    _backgroundImageName = backgroundImageName;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:backgroundImageName]];
    imageView.frame = self.bounds;
    [self addSubview:imageView];
//    [self bringSubviewToFront:imageView];
}

// 拿到外界传来的时间戳
- (void)setTimestamp:(NSInteger)timestamp{
    _timestamp = timestamp;
    if (_timestamp != 0) {
        if (timer) {
            [timer invalidate];
            timer = nil;
        }
        else{
            self.hourLabel.text = @"00";
            self.minuesLabel.text = @"00";
            self.secondsLabel.text = @"00";

            timer =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timer:) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        }
    }
}
//移除 倒计时
- (void)timerRemove{
    self.hourLabel.text = @"00";
    self.minuesLabel.text = @"00";
    self.secondsLabel.text = @"00";
    [timer invalidate];
    timer = nil;
}
-(void)timer:(NSTimer*)timerr{
    _timestamp--;
    [self getDetailTimeWithTimestamp:_timestamp];
    if (_timestamp == 0) {
        [timer invalidate];
        timer = nil;
        self.hourLabel.text = @"00";
        self.minuesLabel.text = @"00";
        self.secondsLabel.text = @"00";

        // 执行block回调
        self.timerStopBlock();
    }
}

- (void)getDetailTimeWithTimestamp:(NSInteger)timestamp{
    NSInteger ms = timestamp;
    NSInteger ss = 1;
    NSInteger mi = ss * 60;
    NSInteger hh = mi * 60;
    NSInteger dd = hh * 24;
    
    // 剩余的
    NSInteger day = ms / dd;// 天
    NSInteger hour = (ms - day * dd) / hh;// 时
    NSInteger minute = (ms - day * dd - hour * hh) / mi;// 分
    NSInteger second = (ms - day * dd - hour * hh - minute * mi) / ss;// 秒
//    NSLog(@"%zd日:%zd时:%zd分:%zd秒",day,hour,minute,second);
    
   // self.dayLabel.text = [NSString stringWithFormat:@"%zd天",day];
    self.hourLabel.text = [NSString stringWithFormat:@"%zd",hour];
    self.minuesLabel.text = [NSString stringWithFormat:@"%zd",minute];
    self.secondsLabel.text = [NSString stringWithFormat:@"%zd",second];
    if (hour< 10) {
        self.hourLabel.text = [NSString stringWithFormat:@"0%zd",hour];
    }
    if (minute<10) {
        self.minuesLabel.text = [NSString stringWithFormat:@"0%zd",minute];
    }
    if (second<10) {
         self.secondsLabel.text = [NSString stringWithFormat:@"0%zd",second];
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    // 获得view的宽、高
    CGFloat viewW = self.frame.size.width;
    CGFloat viewH = self.frame.size.height;
    // 单个label的宽高
    CGFloat labelW = viewW / labelCount;
    CGFloat labelH = viewH;
    
       // self.dayLabel.frame = CGRectMake(0, 0, labelW, labelH);
    self.hourLabel.frame = CGRectMake(0, 0, labelW, labelH);
    self.minuesLabel.frame = CGRectMake( labelW , 0, labelW, labelH);
    self.secondsLabel.frame = CGRectMake(2 * labelW, 0, labelW, labelH);
    
    
    for (NSInteger index = 0; index < self.separateLabelArrM.count ; index ++) {
        UILabel *separateLabel = self.separateLabelArrM[index];
        separateLabel.frame = CGRectMake((labelW - 1) * (index + 1), 0, 5, labelH);
    }
    //超时
    self.outTimeLB.frame = CGRectMake(0, 0, viewW, viewH);

}


#pragma mark - setter & getter

- (NSMutableArray *)timeLabelArrM{
    if (_timeLabelArrM == nil) {
        _timeLabelArrM = [[NSMutableArray alloc] init];
    }
    return _timeLabelArrM;
}

- (NSMutableArray *)separateLabelArrM{
    if (_separateLabelArrM == nil) {
        _separateLabelArrM = [[NSMutableArray alloc] init];
    }
    return _separateLabelArrM;
}

//- (UILabel *)dayLabel{
//    if (_dayLabel == nil) {
//        _dayLabel = [[UILabel alloc] init];
//        _dayLabel.textAlignment = NSTextAlignmentCenter;
////        _dayLabel.backgroundColor = [UIColor grayColor];
//    }
//    return _dayLabel;
//}

- (UILabel *)hourLabel{
    if (_hourLabel == nil) {
        _hourLabel = [[UILabel alloc] init];
        _hourLabel.textAlignment = NSTextAlignmentCenter;
//        _hourLabel.backgroundColor = [UIColor redColor];
    }
    return _hourLabel;
}

- (UILabel *)minuesLabel{
    if (_minuesLabel == nil) {
        _minuesLabel = [[UILabel alloc] init];
        _minuesLabel.textAlignment = NSTextAlignmentCenter;
//        _minuesLabel.backgroundColor = [UIColor orangeColor];
    }
    return _minuesLabel;
}

- (UILabel *)secondsLabel{
    if (_secondsLabel == nil) {
        _secondsLabel = [[UILabel alloc] init];
        _secondsLabel.textAlignment = NSTextAlignmentCenter;
//        _secondsLabel.backgroundColor = [UIColor yellowColor];
    }
    return _secondsLabel;
}


@end
