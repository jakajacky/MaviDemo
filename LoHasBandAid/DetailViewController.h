//
//  DetailViewController.h
//  LoHasBandAid
//
//  Created by zhangxiaoqiang on 2017/3/29.
//  Copyright © 2017年 LoHas-Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) NSDate *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

