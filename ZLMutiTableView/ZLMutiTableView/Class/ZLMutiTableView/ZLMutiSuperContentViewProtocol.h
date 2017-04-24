//
//  ZLMutiSuperContentViewProtocol.h
//  ZLMutiTableView
//
//  Created by ZhangLei on 16/8/23.
//  Copyright © 2016年 LayZhang. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 可滑动 tableview的Protocol
 */
@protocol ZLMutiSuperContentViewProtocol <NSObject>

@required
- (void)initContentColumNames;
- (void)initLeftColumNames;
- (UITableViewCell *) updateContentTableViewCellWithIndex:(NSIndexPath *)indexPath;
- (UITableViewCell *) updateLeftTableViewCellWithIndex:(NSIndexPath *)indexPath;

- (CGFloat)getLeftColumWidth;
- (CGFloat)getContentColumWidth;
- (CGFloat)getScrollContentWidth;

@end
