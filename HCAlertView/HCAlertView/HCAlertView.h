//
//  HCAlertView.h
//  HCAlertView
//
//  Created by 何其灿 on 2018/9/13.
//  Copyright © 2018年 松小宝. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - **********  HCAlertSelectItems
@protocol HCAlertItemProtocol <NSObject>

/**
 添加选项按钮

 @param title 选项标题
 */
@required
-(void)addSelectItemWithTitle:(NSString *)title titleColor:(UIColor *)color;
@end

@interface HCAlertSelectItems : NSObject<HCAlertItemProtocol>
@property (strong,nonatomic) NSMutableArray *itemsArray;
@end



#pragma mark - **********  HCAlertView

typedef void(^HCSelectItems)(id<HCAlertItemProtocol>items);
typedef void(^HCSelectBlock)(NSInteger selectIndex);

@interface HCAlertView : UIView


/**
 显示AlertView

 @param title 标题
 @param message 描述信息
 @param itemsBlock 添加选择项
 @param selectIndex 选中项，选中后回调选中index
 
 调用方式如下：
     [HCAlertView showAlertViewTitle:@"版本升级" message:@"有新版本升级，给我们一个评价吧，感谢您的支持！" selectItems:^(id<HCAlertItemProtocol> items) {
         [items addSelectItemWithTitle:@"去评价" titleColor:[UIColor blueColor]];
         [items addSelectItemWithTitle:@"取消" titleColor:[UIColor grayColor]];
 
     } selectIndex:^(NSInteger selectIndex) {
        NSLog(@"选中：%ld",selectIndex);
     }];
 
 */
+(void)showAlertViewTitle:(NSString *)title message:(NSString *)message selectItems:(HCSelectItems)itemsBlock selectIndex:(HCSelectBlock)selectIndex;

@end
