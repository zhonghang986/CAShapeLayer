//
//  ViewController.m
//  倒计时
//
//  Created by 任大超 on 2018/5/24.
//  Copyright © 2018年 dudu. All rights reserved.
//

#import "ViewController.h"
#import "TimeCell.h"
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[TimeCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//    });
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TimeCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[TimeCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.timeNumber = [self.dataArr[indexPath.row] integerValue];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.f;
}
- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray arrayWithObjects:@"50", @"50", @"50",@"50", @"50", @"50"@"50", @"50", @"50"@"50", @"50", @"50",@"50", @"50", @"50",@"50", @"50", @"50",@"50", @"50", @"50",nil];
    }
    return _dataArr;
}












@end
