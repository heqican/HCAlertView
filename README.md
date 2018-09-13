· -松小宝-

# HCAlertView
自定义UIAlertView

使用方法：
#import "HCAlertView.h"

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
