//
//  DetailViewController.m
//  LoHasBandAid
//
//  Created by zhangxiaoqiang on 2017/3/29.
//  Copyright © 2017年 LoHas-Tech. All rights reserved.
//

#import "DetailViewController.h"
#import "LoginManager.h"
#import "LoginApi.h"
@interface DetailViewController ()

@property (nonatomic, strong) LoginApi *api;

@end

@implementation DetailViewController

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 暂时模拟退出帐号
- (IBAction)logoutCurrentUser:(id)sender {
    
    User *user = [LoginManager defaultManager].currentUser;
    user.isLatestLogin = NO;
    
    [self.api saveCurrentUser:user];
    
    UIViewController *masterVC = self.splitViewController.viewControllers.firstObject;
    [masterVC viewWillAppear:YES];
    
}



#pragma mark - Managing the detail item
- (void)setDetailItem:(NSDate *)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

#pragma mark - private properties
- (LoginApi *)api {
    if (!_api) {
        _api = [LoginApi biz];
    }
    return _api;
}

@end
