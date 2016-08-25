//
//  ZLPageTitleButton.m
//  ZLMutiTableView
//
//  Created by ZhangLei on 16/8/22.
//  Copyright © 2016年 Allone. All rights reserved.
//

#import "ZLPageTitleButton.h"

@interface ZLPageTitleButton(){
    ZLTitleButtonStyle _zlStyle;
}

- (void)setZLStyle:(ZLTitleButtonStyle)style;

@end

@implementation ZLPageTitleButton

- (id)initWithStyle:(ZLTitleButtonStyle)style {
    if (self = [super init]) {
        [self setZLStyle:style];
    }
    return self;
}

- (id)init {
    if (self = [super init]) {
        [self initComponent];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initComponent];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initComponent];
    }
    return self;
}

- (void)initComponent {
    [self setTitle:@"123" forState:UIControlStateNormal];
    [self setBackgroundColor:[UIColor grayColor]];
}

- (void)setZLStyle:(ZLTitleButtonStyle)zlStyle {
    _zlStyle = zlStyle;
    
    switch (zlStyle) {
        case ZLTitleButtonStyleRed:
            [self styleRed];
            break;
        case ZLTitleButtonStyleGray:
            [self styleGray];
            break;
        default:
            break;
    }
}

- (void)styleRed {
    
}

- (void)styleGray {
}

@end
