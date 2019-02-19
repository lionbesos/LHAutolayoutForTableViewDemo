//
//  ViewController.m
//  LWAutolayoutForTableViewDemo
//
//  Created by weiyuxiang on 2019/2/19.
//  Copyright © 2019 weiyuxiang. All rights reserved.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>
#import <ReactiveObjC/ReactiveObjC.h>


#import "ABLaborActivityDetailViewCell.h"
#import <YYKit/YYKit.h>
#import "UILabel+Extension.h"

// 屏幕宽
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
// 屏幕高
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
// 适配iPhone X以上 导航栏高度
#define  SCREEN_NavHeight  (iPhoneX ? 88.f : 64.f)
#define iPhoneX ((SCREEN_HEIGHT == 812.f || SCREEN_HEIGHT == 896.f ) ? YES : NO)
#define stronggSelf  @strongify(self)
#define weakifyySelf @weakify(self)
#define Bold_Font @"PingFangSC-Semibold"   //加粗
// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
/** 背景白色 */
#define BackgroundWhite_Color UIColorFromRGB(0xf4f4f4)

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    CGFloat _tableViewHeight;//接收cell的高度
    BOOL _isEnd;//刷新开关
}
/** 头部视图*/
@property (nonatomic, strong) UIView *headView;

@property (nonatomic, strong) UITableView *tableView;


@end

static NSString * const Identifier = @"ABLaborActivityDetailViewCell";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    _tableViewHeight = 0;//给初始高度
    _isEnd = NO;//给初始状态
    self.view.backgroundColor = BackgroundWhite_Color;
//    self.navigationBar.titleLabel.text = @"活动详情";
//    self.navigationBar.rightImageName = @"find_share";
    self.title = @"活动详情";
}

#pragma mark - delegate&action


#pragma mark - tableview delegate,datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ABLaborActivityDetailViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    cell.index = indexPath.row;
    weakifyySelf;
    [cell.subject subscribeNext:^(NSNumber *x) {
        stronggSelf;
        //接收cell值并累加
        _tableViewHeight = _tableViewHeight + [x floatValue];
        if (indexPath.row == 4 && _isEnd == NO) {
            _isEnd = YES;
            self.tableView.size = CGSizeMake(SCREEN_WIDTH - 30, _tableViewHeight + 43.5);
            [self.tableView reloadData];
        }
    }];
    return cell;
}




#pragma mark - lazy load

- (UIView *)headView{
    if(!_headView){
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
        UILabel *title = [UILabel labelWithText:@"卖特斯拉，拿大奖" atColor:[UIColor blackColor] atTextSize:16 atTextFontForType:Bold_Font];
        [_headView addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(12);
            make.centerX.equalTo(self.headView);
        }];
    }
    return _headView;
}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(15, SCREEN_NavHeight + 15, SCREEN_WIDTH - 30, SCREEN_HEIGHT - SCREEN_NavHeight - 15)];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //row高自适应
        _tableView.rowHeight = UITableViewAutomaticDimension;
        //给一个预估值，当计算不出时会默认使用此高度
        _tableView.estimatedRowHeight = 100;
        [_tableView registerClass:[ABLaborActivityDetailViewCell class] forCellReuseIdentifier:Identifier];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.scrollEnabled = NO;
        _tableView.tableHeaderView = self.headView;
        _tableView.clipsToBounds = YES;
        _tableView.layer.cornerRadius = 5;
    }
    return _tableView;
}


@end
