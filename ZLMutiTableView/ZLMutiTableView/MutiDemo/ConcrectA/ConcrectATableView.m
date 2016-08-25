//
//  ConcrectATableView.m
//  ZLMutiTableView
//
//  Created by ZhangLei on 16/8/23.
//  Copyright © 2016年 Allone. All rights reserved.
//

#import "ConcrectATableView.h"
#import "ConcrectA.h"

#import "ConcrectATableViewLeftCell.h"
#import "ConcrectATableViewContentCell.h"

static const CGFloat scrollViewLeftWitdh = 200.0f;
static const CGFloat scrollViewContentWidth = 1024.0f;

@implementation ConcrectATableView

- (id)init {
    if (self = [super init]) {
        //        [self initData];
    }
    return self;
}

- (void)initData {
    self.contentArray = [[NSMutableArray alloc] init];
    
    ConcrectA *concrectA = [[ConcrectA alloc] init];
    [concrectA setAttribut0:@"0"];
    [concrectA setAttribut1:@"1"];
    [concrectA setAttribut2:@"2"];
    [concrectA setAttribut3:@"3"];
    [concrectA setAttribut4:@"4"];
    [concrectA setAttribut5:@"5"];
    [concrectA setAttribut6:@"6"];
    [concrectA setAttribut7:@"7"];
    
    [self.contentArray addObject:[concrectA copy]];
    [self.contentArray addObject:[concrectA copy]];
    [self.contentArray addObject:[concrectA copy]];
    [self.contentArray addObject:[concrectA copy]];
}

#pragma son Func
- (void)initContentColumNames {
    ConcrectATableViewContentCell *cell = (ConcrectATableViewContentCell *)[super getContentTableViewCell];
    [self.contentTopView addSubview:cell];
    
    [cell.attribute0    setText:@"AttributeName0"];
    [cell.attribute1    setText:@"AttributeName1"];
    [cell.attribute2    setText:@"AttributeName2"];
    [cell.attribute3    setText:@"AttributeName3"];
    [cell.attribute4    setText:@"AttributeName4"];
}

- (void)initLeftColumNames {
    ConcrectATableViewLeftCell *cell = (ConcrectATableViewLeftCell *)[super getLeftTableViewCell];
    [self.leftTopView addSubview:cell];
    [cell.attribute5    setText:@"AttributeName5"];
    [cell.attribute6    setText:@"AttributeName6"];
    [cell.attribute7    setText:@"AttributeName7"];
}

- (UITableViewCell *)updateContentTableViewCellWithIndex:(NSIndexPath *)indexPath {
    ConcrectATableViewContentCell *cell = (ConcrectATableViewContentCell *)[super getContentTableViewCell];
    
    ConcrectA *structA = [self.contentArray objectAtIndex:[indexPath row]];
    
    [cell.attribute0    setText:structA.attribut0];
    [cell.attribute1    setText:structA.attribut1];
    [cell.attribute2    setText:structA.attribut2];
    [cell.attribute3    setText:structA.attribut3];
    [cell.attribute4    setText:structA.attribut4];
    if (!cell.isAddListener) {
        [cell addGestureRecognizer:[self getRecognizer]];
        cell.isAddListener = true;
    }
    return cell;
}

- (UITableViewCell *)updateLeftTableViewCellWithIndex:(NSIndexPath *)indexPath {
    ConcrectATableViewLeftCell *cell = (ConcrectATableViewLeftCell *)[super getLeftTableViewCell];
    ConcrectA *structA = [self.contentArray objectAtIndex:[indexPath row]];
    
    [cell.attribute5    setText:structA.attribut5];
    [cell.attribute6    setText:structA.attribut6];
    [cell.attribute7    setText:structA.attribut7];
    
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
    ConcrectA *structA = [self.contentArray objectAtIndex:[indexPath row]];
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
