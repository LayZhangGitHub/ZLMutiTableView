//
//  ConcrectBTableViewContentCell.m
//  ZLMutiTableView
//
//  Created by ZhangLei on 16/8/23.
//  Copyright © 2016年 Allone. All rights reserved.
//

#import "ConcrectBTableViewContentCell.h"

@implementation ConcrectBTableViewContentCell

@synthesize attribute0;
@synthesize attribute1;
@synthesize attribute2;
@synthesize attribute3;
@synthesize attribute4;

@synthesize isAddListener;

- (void)awakeFromNib {
    [super awakeFromNib];
    self.isAddListener = false;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
