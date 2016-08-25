//
//  ViewController.m
//  ZLMutiTableView
//
//  Created by ZhangLei on 16/8/19.
//  Copyright © 2016年 Allone. All rights reserved.
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
    [pageA setPageTitle:@"pageA"];
    [pageB setPageTitle:@"pageB"];
    [pageC setPageTitle:@"pageC"];
    [pageB setBackgroundColor:[UIColor redColor]];
    return @[pageA, pageB, pageC];
}

- (Boolean)scrollEnable {
    return false;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
