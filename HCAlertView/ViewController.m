//
//  ViewController.m
//  HCAlertView
//
//  Created by 何其灿 on 2018/9/13.
//  Copyright © 2018年 松小宝. All rights reserved.
//

#import "ViewController.h"
#import "HCAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, 50);
    [btn setTitle:@"显示AlertView - 4项" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(showAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(0, 300, [UIScreen mainScreen].bounds.size.width, 50);
    [btn2 setTitle:@"显示AlertView - 2项" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(showAction2:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(0, 400, [UIScreen mainScreen].bounds.size.width, 50);
    [btn3 setTitle:@"显示AlertView - 1项" forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(showAction3:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
}


-(void)showAction:(id)sender{
    [HCAlertView showAlertViewTitle:@"版本升级" message:@"有新版本升级，给我们一个评价吧，感谢您的支持！" selectItems:^(id<HCAlertItemProtocol> items) {
        [items addSelectItemWithTitle:@"去评价" titleColor:[UIColor blueColor]];
        [items addSelectItemWithTitle:@"下次吧" titleColor:[UIColor blueColor]];
        [items addSelectItemWithTitle:@"残忍拒绝" titleColor:[UIColor blueColor]];
        [items addSelectItemWithTitle:@"取消" titleColor:[UIColor grayColor]];
        
    } selectIndex:^(NSInteger selectIndex) {
        NSLog(@"选中：%ld",selectIndex);
    }];
    
}

-(void)showAction2:(id)sender{
    [HCAlertView showAlertViewTitle:@"版本升级" message:@"有新版本升级，给我们一个评价吧，感谢您的支持！" selectItems:^(id<HCAlertItemProtocol> items) {
        [items addSelectItemWithTitle:@"去评价" titleColor:[UIColor blueColor]];
        [items addSelectItemWithTitle:@"取消" titleColor:[UIColor grayColor]];
        
    } selectIndex:^(NSInteger selectIndex) {
        NSLog(@"选中：%ld",selectIndex);
    }];
    
}

-(void)showAction3:(id)sender{
    [HCAlertView showAlertViewTitle:@"版本升级" message:@"有新版本升级，给我们一个评价吧，感谢您的支持！" selectItems:^(id<HCAlertItemProtocol> items) {
        [items addSelectItemWithTitle:@"取消" titleColor:[UIColor grayColor]];
        
    } selectIndex:^(NSInteger selectIndex) {
        NSLog(@"选中：%ld",selectIndex);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
