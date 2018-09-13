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

+(void)showAlertViewTitle:(NSString *)title message:(NSString *)message selectItems:(HCSelectItems)itemsBlock selectIndex:(HCSelectBlock)selectIndex;

@end
