//
//  TimeCell.m
//  倒计时
//
//  Created by 任大超 on 2018/5/24.
//  Copyright © 2018年 dudu. All rights reserved.
//

#import "TimeCell.h"
#import "FLCountDownView.h"

@interface TimeCell ()
@property (nonatomic, weak)FLCountDownView *countDown;
@end

@implementation TimeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUI];
    }
    return self;
}
- (void)setUI
{
    
    
    FLCountDownView *countDown      = [FLCountDownView fl_countDown];
    _countDown = countDown;
    countDown.backgroundColor = [UIColor grayColor];
    countDown.frame = CGRectMake(20, 0, 200, 50);
    countDown.timerStopBlock        = ^{
        NSLog(@"1号时间停止");
       
    };
    [self addSubview:countDown];
    
   
    
    
}

- (void)setTimeNumber:(NSInteger)timeNumber
{
    _timeNumber = timeNumber;
    _countDown.timestamp = _timeNumber;
}








- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
