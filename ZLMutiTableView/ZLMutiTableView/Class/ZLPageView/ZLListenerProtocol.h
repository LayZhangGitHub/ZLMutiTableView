//
//  ZLListenerProtocol.h
//  ZLMutiTableView
//
//  Created by ZhangLei on 16/8/22.
//  Copyright © 2016年 LayZhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ZLListenerProtocol <NSObject>

- (void)addListener;
- (void)removeListener;

@end
