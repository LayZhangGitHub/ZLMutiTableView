//
//  ZLPageTitleButton.h
//  ZLMutiTableView
//
//  Created by ZhangLei on 16/8/22.
//  Copyright © 2016年 LayZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ZLTitleButtonStyle) {
    ZLTitleButtonStyleGray  = 0,
    ZLTitleButtonStyleRed   = 1,
};

@interface ZLPageTitleButton : UIButton

- (id)initWithStyle:(ZLTitleButtonStyle)style;

@end
