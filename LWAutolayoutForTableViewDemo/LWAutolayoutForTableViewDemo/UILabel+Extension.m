//
//  UILabel+Extension.m
//  text
//
//  Created by 枫 on 15/9/10.
//  Copyright (c) 2015年 XQBoy. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)

/** 自定义文字大小与颜色  字体类型*/
+ (instancetype)labelWithText:(NSString *)text atColor:(UIColor *)color atTextSize:(CGFloat)size atTextFontForType:(NSString *)type{
    UILabel *label = [[self alloc] init];
    [label setText:text];
    [label setTextColor:color];
//    if ([type isEqualToString:Title_Font]) {
//        [label setFont:[UIFont fontWithName:Title_Font size:size]];
//    }else if ([type isEqualToString:UserName_Font]){
//        [label setFont:[UIFont fontWithName:UserName_Font size:size]];
//    }else{
//        [label setFont:[UIFont fontWithName:type size:size]];
//    }
    [label setFont:[UIFont fontWithName:type size:size]];
    return label;
}

/** 自定义文字大小与颜色 */
+ (instancetype)labelWithText:(NSString *)text atColor:(UIColor *)color atTextSize:(CGFloat)size{
    UILabel *label = [[self alloc] init];
    [label setText:text];
    [label setTextColor:color];
    [label setFont:[UIFont systemFontOfSize:size]];
    return label;
}

@end
