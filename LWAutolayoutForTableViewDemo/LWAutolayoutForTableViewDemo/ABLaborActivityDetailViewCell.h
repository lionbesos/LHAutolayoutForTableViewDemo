//
//  ABLaborActivityDetailViewCell.h
//  AgentBear
//
//  Created by 芦苇Mac_mini on 2019/1/29.
//  Copyright © 2019年 LW. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <ReactiveObjC/ReactiveObjC.h>
NS_ASSUME_NONNULL_BEGIN

@interface ABLaborActivityDetailViewCell : UITableViewCell

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) RACSubject *subject;

@end

NS_ASSUME_NONNULL_END
