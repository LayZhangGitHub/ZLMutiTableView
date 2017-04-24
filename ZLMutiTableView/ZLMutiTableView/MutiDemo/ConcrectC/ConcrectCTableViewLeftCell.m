//
//  ConcrectCTableViewLeftCell.m
//  ZLMutiTableView
//
//  Created by ZhangLei on 16/8/23.
//  Copyright © 2016年 LayZhang. All rights reserved.
//

#import "ConcrectCTableViewLeftCell.h"

@implementation ConcrectCTableViewLeftCell

@synthesize attribute5;
@synthesize attribute6;
@synthesize attribute7;

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
