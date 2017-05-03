//
//  ViewController.m
//  ZLMutiTableView
//
//  Created by ZhangLei on 16/8/19.
//  Copyright © 2016年 LayZhang. All rights reserved.
//

#import "ViewController.h"
#import "ZLPageView.h"
#import "ZLSinglePageView.h"

#import "ConcrectATableView.h"
#import "ConcrectBTableView.h"
#import "ConcrectCTableView.h"
#import "ZLPageViewProtocol.h"

@interface ViewController ()<ZLPageViewDataSourceProtocol> {
    ZLPageView *pageView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    pageView = [[ZLPageView alloc] initWithFrame:CGRectMake(0, 50,
                                                                        self.view.bounds.size.width,
                                                                        400)];
    
    [pageView setSourceDelegate:self];
    [self.view addSubview:pageView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [pageView setCurrentPage:0];
}


- (CGFloat)topTapTitleHeightAtPageView:(ZLPageView *)pageView {
    return 40.0f;
}

- (NSArray *)arrayOfCustomPageViewAtPageView:(ZLPageView *)pageView {
    
    ZLSinglePageView *pageA = [[ConcrectATableView alloc] init];
    ZLSinglePageView *pageB = [[ConcrectBTableView alloc] init];
    ZLSinglePageView *pageC = [[ConcrectCTableView alloc] init];
    [pageB setBackgroundColor:[UIColor redColor]];
    return @[pageA, pageB, pageC];
}
- (CGFloat)topTapTitleHeight {
    return 40.0f;
}

- (NSArray *)arrayOfPageView {
    ZLSinglePageView *pageA = [[ConcrectATableView alloc] init];
    ZLSinglePageView *pageB = [[ConcrectBTableView alloc] init];
    ZLSinglePageView *pageC = [[ConcrectCTableView alloc] init];
    [pageB setBackgroundColor:[UIColor redColor]];
    return @[pageA, pageB, pageC];
}

- (NSArray *)arrayOfTitleButton {
    UIButton *btnA = [[UIButton alloc] init];
    UIButton *btnB = [[UIButton alloc] init];
    UIButton *btnC = [[UIButton alloc] init];
    [btnA setTitle:@"A" forState:UIControlStateNormal];
    [btnB setTitle:@"B" forState:UIControlStateNormal];
    [btnC setTitle:@"C" forState:UIControlStateNormal];
    return @[btnA, btnB, btnC];
}

- (Boolean)scrollEnable {
    return true;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
