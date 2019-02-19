//
//  ABLaborActivityDetailViewCell.m
//  AgentBear
//
//  Created by 芦苇Mac_mini on 2019/1/29.
//  Copyright © 2019年 LW. All rights reserved.
//

#import "ABLaborActivityDetailViewCell.h"
#import <Masonry/Masonry.h>
#import "UILabel+Extension.h"
#import <YYKit/YYKit.h>

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

@interface ABLaborActivityDetailViewCell()
{
    BOOL _isLayout;//状态开关
}

/** 标题*/
@property (nonatomic, strong) UILabel *titleLabel;
/** 内容*/
@property (nonatomic, strong) UILabel *detailLabel;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation ABLaborActivityDetailViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style
                   reuseIdentifier:reuseIdentifier]){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setLayout];
    }
    return self;
}

#pragma mark - set

- (void)setIndex:(NSInteger)index{
    self.titleLabel.text = self.dataArray[index][@"title"];
    self.detailLabel.text = self.dataArray[index][@"detail"];
//    通过index和数组给cell内容赋值时，让开关为YES，走几次由数组决定，每一次都会走layoutIfNeeded方法。
    _isLayout = YES;
    //调用layoutSubviews方法
    [self layoutIfNeeded];
}

#pragma mark - setlayout

- (void)setLayout{
    
    //一开始创建的是控件，先走一遍setLayout，默认使信号为NO，第二遍开始走setIndex
    _isLayout = NO;
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(18);
        make.left.offset(18);
        make.width.offset(67);
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(18);
        make.left.equalTo(self.titleLabel.mas_right).offset(0);
        make.right.offset(-17);
    }];
    
    UIImageView *line = [[UIImageView alloc] init];
    line.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(0);
        make.top.equalTo(self.detailLabel.mas_bottom).offset(15);
        make.left.equalTo(self.titleLabel);
        make.right.equalTo(self.detailLabel);
        make.height.offset(1);
    }];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    //每次信号为YES，都会通过RAC传出cell的高度。
    if (_isLayout == YES) {
        [self.subject sendNext:@(self.size.height)];
        NSLog(@"CELL高=%f",self.size.height);
    }
    
}

#pragma mark - lazy load

- (UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [UILabel labelWithText:@"" atColor:[UIColor blackColor] atTextSize:13];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)detailLabel{
    if(!_detailLabel){
        _detailLabel = [UILabel labelWithText:@"" atColor:[UIColor blackColor] atTextSize:13];
        _detailLabel.numberOfLines = 0;
        _detailLabel.preferredMaxLayoutWidth = SCREEN_WIDTH - 31-33 - 67;
        _detailLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_detailLabel];
    }
    return _detailLabel;
}

- (NSArray *)dataArray{
    if(!_dataArray){
        _dataArray = [NSArray arrayWithObjects:@{@"title":@"挑战时间：",@"detail":@"2018-10-2018:00至2018-11-2018:00"},@{@"title":@"挑战商品：",@"detail":@"售卖特斯拉model 3车型最多的公会"},@{@"title":@"奖金数额：",@"detail":@"￥1000000"},@{@"title":@"奖励发放：",@"detail":@"会获胜后，公会内各成员根据对于销售额的贡献率去分配奖金——由平台人工手动发放奖励"},@{@"title":@"规则说明：",@"detail":@"只有公会的会长有权决定是否参加，并在挑战时间内以真实有效的数据为参考即可获得成功，一旦发现公会有甩单的行为，严惩不贷，取消参赛资格！，取消参赛资格！，取消参赛资格！，取消参赛资格！，取消参赛资格！，取消参赛资格！，取消参赛资格！，取消参赛资格！，取消参赛资格！，取消参赛资格！"}, nil];
    }
    return _dataArray;
}

- (RACSubject *)subject{
    if (!_subject) {
        _subject = [RACSubject subject];
    }
    return _subject;
}

@end
