//
//  ConcrectB.m
//  ZLMutiTableView
//
//  Created by ZhangLei on 16/8/23.
//  Copyright © 2016年 Allone. All rights reserved.
//

#import "ConcrectB.h"

@implementation ConcrectB
- (id)copyWithZone:(NSZone *)zone {
    ConcrectB *concrect = [[[self class] allocWithZone:zone] init];
    
    concrect.attribut0 = [self.attribut0 copy];
    concrect.attribut1 = [self.attribut1 copy];
    concrect.attribut2 = [self.attribut2 copy];
    concrect.attribut3 = [self.attribut3 copy];
    concrect.attribut4 = [self.attribut4 copy];
    concrect.attribut5 = [self.attribut5 copy];
    concrect.attribut6 = [self.attribut6 copy];
    concrect.attribut7 = [self.attribut7 copy];
    
    return concrect;
}
@end
