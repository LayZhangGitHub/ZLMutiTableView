//
//  ConcrectCTableView.m
//  ZLMutiTableView
//
//  Created by ZhangLei on 16/8/23.
//  Copyright © 2016年 Allone. All rights reserved.
//

#import "ConcrectCTableView.h"
#import "ConcrectC.h"

#import "ConcrectCTableViewLeftCell.h"
#import "ConcrectCTableViewContentCell.h"

static const CGFloat scrollViewLeftWitdh = 200.0f;
static const CGFloat scrollViewContentWidth = 1024.0f;

@implementation ConcrectCTableView

- (id)init {
    if (self = [super init]) {
        //        [self initData];
    }
    return self;
}

- (void)initData {
    self.contentArray = [[NSMutableArray alloc] init];
    
    ConcrectC *concrectC = [[ConcrectC alloc] init];
    [concrectC setAttribut0:@"0"];
    [concrectC setAttribut1:@"1"];
    [concrectC setAttribut2:@"2"];
    [concrectC setAttribut3:@"3"];
    [concrectC setAttribut4:@"4"];
    [concrectC setAttribut5:@"5"];
    [concrectC setAttribut6:@"6"];
    [concrectC setAttribut7:@"7"];
    
    [self.contentArray addObject:[concrectC copy]];
    [self.contentArray addObject:[concrectC copy]];
    [self.contentArray addObject:[concrectC copy]];
    [self.contentArray addObject:[concrectC copy]];
}

#pragma son Func
- (void)initContentColumNames {
    ConcrectCTableViewContentCell *cell = (ConcrectCTableViewContentCell *)[super getContentTableViewCell];
    [self.contentTopView addSubview:cell];
    
    [cell.attribute0    setText:@"AttributeName0"];
    [cell.attribute1    setText:@"AttributeName1"];
    [cell.attribute2    setText:@"AttributeName2"];
    [cell.attribute3    setText:@"AttributeName3"];
    [cell.attribute4    setText:@"AttributeName4"];
}

- (void)initLeftColumNames {
    ConcrectCTableViewLeftCell *cell = (ConcrectCTableViewLeftCell *)[super getLeftTableViewCell];
    [self.leftTopView addSubview:cell];
    [cell.attribute5    setText:@"AttributeName5"];
    [cell.attribute6    setText:@"AttributeName6"];
    [cell.attribute7    setText:@"AttributeName7"];
}

- (UITableViewCell *)updateContentTableViewCellWithIndex:(NSIndexPath *)indexPath {
    ConcrectCTableViewContentCell *cell = (ConcrectCTableViewContentCell *)[super getContentTableViewCell];
    
    ConcrectC *structC = [self.contentArray objectAtIndex:[indexPath row]];
    
    [cell.attribute0    setText:structC.attribut0];
    [cell.attribute1    setText:structC.attribut1];
    [cell.attribute2    setText:structC.attribut2];
    [cell.attribute3    setText:structC.attribut3];
    [cell.attribute4    setText:structC.attribut4];
    if (!cell.isAddListener) {
        [cell addGestureRecognizer:[self getRecognizer]];
        cell.isAddListener = true;
    }
    return cell;
}

- (UITableViewCell *)updateLeftTableViewCellWithIndex:(NSIndexPath *)indexPath {
    ConcrectCTableViewLeftCell *cell = (ConcrectCTableViewLeftCell *)[super getLeftTableViewCell];
    ConcrectC *structC = [self.contentArray objectAtIndex:[indexPath row]];
    
    [cell.attribute5    setText:structC.attribut5];
    [cell.attribute6    setText:structC.attribut6];
    [cell.attribute7    setText:structC.attribut7];
    if (!cell.isAddListener) {
        [cell addGestureRecognizer:[self getRecognizer]];
        cell.isAddListener = true;
    }
    return cell;
}

- (CGFloat)getLeftColumWidth {
    return scrollViewLeftWitdh;
}

- (CGFloat)getContentColumWidth {
    return CGRectGetWidth(self.frame) - scrollViewLeftWitdh;
}

- (CGFloat)getScrollContentWidth {
    return scrollViewContentWidth;
}

#pragma gesture
- (UITapGestureRecognizer *)getRecognizer {
    UITapGestureRecognizer *recongnizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(showView:)];
    return recongnizer;
}

#pragma action
- (void)showView:(UIGestureRecognizer *)gesture {
    NSIndexPath * indexPath = [super getIndexPathOfGesture:gesture];
    if(indexPath == nil) return;
    ConcrectC *structC = [self.contentArray objectAtIndex:[indexPath row]];
    NSLog(@"did click");
}

#pragma Listener
- (void)addListener {
}

- (void)removeListener {
}

- (void)priceWarningChange:(NSNotification *)notify {
    // 注意需要排序
    dispatch_async(dispatch_get_main_queue(), ^{
        [self removeListener];
        [self initData];
        [self.contentTableView reloadData];
        [self.leftTableView reloadData];
        [self addListener];
    });
}

#pragma override
- (void)reloadPageData {
    [super reloadPageData];
}

- (void)pageUnSelect {
    [super pageUnSelect];
}

- (void)pageSelect {
    [super pageSelect];
}


@end

