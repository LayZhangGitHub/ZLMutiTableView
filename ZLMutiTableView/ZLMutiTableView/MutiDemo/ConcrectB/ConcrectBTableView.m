//
//  ConcrectBTableView.m
//  ZLMutiTableView
//
//  Created by ZhangLei on 16/8/23.
//  Copyright © 2016年 LayZhang. All rights reserved.
//

#import "ConcrectBTableView.h"
#import "ConcrectB.h"

#import "ConcrectBTableViewLeftCell.h"
#import "ConcrectBTableViewContentCell.h"

static const CGFloat scrollViewLeftWitdh = 200.0f;
static const CGFloat scrollViewContentWidth = 1024.0f;

@implementation ConcrectBTableView

- (id)init {
    if (self = [super init]) {
        //        [self initData];
    }
    return self;
}

- (void)initData {
    self.contentArray = [[NSMutableArray alloc] init];
    
    ConcrectB *concrectB = [[ConcrectB alloc] init];
    [concrectB setAttribut0:@"0"];
    [concrectB setAttribut1:@"1"];
    [concrectB setAttribut2:@"2"];
    [concrectB setAttribut3:@"3"];
    [concrectB setAttribut4:@"4"];
    [concrectB setAttribut5:@"5"];
    [concrectB setAttribut6:@"6"];
    [concrectB setAttribut7:@"7"];
    
    [self.contentArray addObject:[concrectB copy]];
    [self.contentArray addObject:[concrectB copy]];
    [self.contentArray addObject:[concrectB copy]];
    [self.contentArray addObject:[concrectB copy]];
}

#pragma son Func
- (void)initContentColumNames {
    ConcrectBTableViewContentCell *cell = (ConcrectBTableViewContentCell *)[super getContentTableViewCell];
    [self.contentTopView addSubview:cell];
    
    [cell.attribute0    setText:@"字段0"];
    [cell.attribute1    setText:@"字段1"];
    [cell.attribute2    setText:@"字段2"];
    [cell.attribute3    setText:@"字段3"];
    [cell.attribute4    setText:@"字段4"];
}

- (void)initLeftColumNames {
    ConcrectBTableViewLeftCell *cell = (ConcrectBTableViewLeftCell *)[super getLeftTableViewCell];
    [self.leftTopView addSubview:cell];
    [cell.attribute5    setText:@"字段5"];
    [cell.attribute6    setText:@"字段6"];
    [cell.attribute7    setText:@"字段7"];
}

- (UITableViewCell *)updateContentTableViewCellWithIndex:(NSIndexPath *)indexPath {
    ConcrectBTableViewContentCell *cell = (ConcrectBTableViewContentCell *)[super getContentTableViewCell];
    
    ConcrectB *structB = [self.contentArray objectAtIndex:[indexPath row]];
    
    [cell.attribute0    setText:structB.attribut0];
    [cell.attribute1    setText:structB.attribut1];
    [cell.attribute2    setText:structB.attribut2];
    [cell.attribute3    setText:structB.attribut3];
    [cell.attribute4    setText:structB.attribut4];
    if (!cell.isAddListener) {
        [cell addGestureRecognizer:[self getRecognizer]];
        cell.isAddListener = true;
    }
    return cell;
}

- (UITableViewCell *)updateLeftTableViewCellWithIndex:(NSIndexPath *)indexPath {
    ConcrectBTableViewLeftCell *cell = (ConcrectBTableViewLeftCell *)[super getLeftTableViewCell];
    ConcrectB *structB = [self.contentArray objectAtIndex:[indexPath row]];
    
    [cell.attribute5    setText:structB.attribut5];
    [cell.attribute6    setText:structB.attribut6];
    [cell.attribute7    setText:structB.attribut7];
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
    ConcrectB *structB = [self.contentArray objectAtIndex:[indexPath row]];
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
