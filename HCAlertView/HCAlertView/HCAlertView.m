//
//  HCAlertView.m
//  HCAlertView
//
//  Created by 何其灿 on 2018/9/13.
//  Copyright © 2018年 松小宝. All rights reserved.
//

#import "HCAlertView.h"

#define key_Window [UIApplication sharedApplication].keyWindow
#define key_HCSelectItem_Title @"key_HCSelectItem_Title"
#define key_HCSelectItem_TitleColor @"key_HCSelectItem_TitleColor"

#define kColorWithHex(c) [UIColor colorWithRed:((c>>16)&0xFF)/255.0f green:((c>>8)&0xFF)/255.0f blue:(c&0xFF)/255.0f alpha:1.0f]

#define Screen_HC_Width [UIScreen mainScreen].bounds.size.width
#define Screen_HC_Height [UIScreen mainScreen].bounds.size.height
#define kAlertView_offsetX 45   //alertView侧边偏移量
#define kAlertView_MAX_Height 460   //alertView最大高度
#define kAlertView_content_offsetX 20 //内部文字边距
#define kSelect_item_height 45 //选项高度


#pragma mark - ********** HCAlertSelectItems
@interface HCAlertSelectItems ()

@end

@implementation HCAlertSelectItems

-(void)addSelectItemWithTitle:(NSString *)title titleColor:(UIColor *)color{
    if (title && [title isKindOfClass:[NSString class]] && title.length>0) {
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:title,key_HCSelectItem_Title, color , key_HCSelectItem_TitleColor,  nil];
        [self.itemsArray addObject:dict];
    }
}

@synthesize itemsArray = _itemsArray;
-(NSMutableArray *)itemsArray{
    if (!_itemsArray) {
        _itemsArray = [[NSMutableArray alloc] init];
    }
    return _itemsArray;
}

@end



#pragma mark - **********  HCAlertView

@interface HCAlertView ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) HCAlertSelectItems *items;
@property (copy ,nonatomic) void (^selectedBlock)(NSInteger selectIndex);
@property (strong,nonatomic) UIView *alertView;
@property (strong,nonatomic) UILabel *titleLabel;
@property (strong,nonatomic) UILabel *messageLabel;
@property (strong,nonatomic) NSString *title;
@property (strong,nonatomic) NSString *message;
@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) UIView *seperaterLine;

@end

@implementation HCAlertView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.frame = key_Window.bounds;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        
//        //手势
//        UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionGesture:)];
//        [self addGestureRecognizer:ges];
    }
    return self;
}

-(void)actionGesture:(UIGestureRecognizer *)ges{
    [self hiddenSelf];
}

//隐藏
-(void)hiddenSelf{
    [self removeFromSuperview];
}

//显示
+(void)showAlertViewTitle:(NSString *)title message:(NSString *)message selectItems:(HCSelectItems)itemsBlock selectIndex:(HCSelectBlock)selectIndex{
    HCAlertView *alertView = [[HCAlertView alloc] initWithFrame:CGRectZero];
    [alertView showAlertViewTitle:title message:message selectItems:itemsBlock selectIndex:selectIndex];
}

-(void)showAlertViewTitle:(NSString *)title message:(NSString *)message selectItems:(HCSelectItems)itemsBlock selectIndex:(HCSelectBlock)selectIndex{
    self.selectedBlock = selectIndex;
    itemsBlock(self.items);
    
    self.title = title;
    self.message = message;
    
    [key_Window addSubview:self];
    
    [self addSubview:self.alertView];
    [self layoutHCAlertView];
}


/**
 布局AlertView
 */
-(void)layoutHCAlertView{
    //title
    self.titleLabel.text = self.title;
    CGFloat normalWidth = self.alertView.frame.size.width-kAlertView_content_offsetX*2;
    CGRect rectTitle = [self.title boundingRectWithSize:CGSizeMake(normalWidth, MAXFLOAT)
                                                options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                             attributes:@{NSFontAttributeName:self.titleLabel.font}
                                                context:nil];
    self.titleLabel.frame = CGRectMake(kAlertView_content_offsetX, kAlertView_content_offsetX, rectTitle.size.width, rectTitle.size.height);
    self.titleLabel.center = CGPointMake(self.alertView.frame.size.width/2, self.titleLabel.center.y);
    [self.alertView addSubview:self.titleLabel];
    
    //messageLabel
    self.messageLabel.text = self.message;
    CGRect rectMessage = [self.message boundingRectWithSize:CGSizeMake(normalWidth, MAXFLOAT)
                                                    options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                 attributes:@{NSFontAttributeName:self.messageLabel.font}
                                                    context:nil];
    self.messageLabel.textAlignment = rectMessage.size.width>normalWidth ? NSTextAlignmentLeft: NSTextAlignmentCenter;
    self.messageLabel.frame = CGRectMake(kAlertView_content_offsetX, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + kAlertView_content_offsetX, rectMessage.size.width, rectMessage.size.height);
    [self.alertView addSubview:self.messageLabel];
    
    //tableView
    CGFloat tableHeight = self.items.itemsArray.count * kSelect_item_height;
    if (self.items.itemsArray.count <= 2) {
        tableHeight = kSelect_item_height;
    }
    self.tableView.frame = CGRectMake(0, self.messageLabel.frame.origin.y+self.messageLabel.frame.size.height + kAlertView_content_offsetX, self.alertView.frame.size.width, tableHeight);
    [self.alertView addSubview:self.tableView];
    
    
    
    //alertView frame
    CGFloat alertViewHeight = self.titleLabel.frame.origin.y + rectTitle.size.height + rectMessage.size.height + tableHeight + kAlertView_content_offsetX *2;
    self.alertView.frame = CGRectMake(kAlertView_offsetX, 0, Screen_HC_Width - kAlertView_offsetX*2, alertViewHeight> kAlertView_MAX_Height ? kAlertView_MAX_Height : alertViewHeight);
    self.alertView.center = key_Window.center;
    
    
    
    NSMutableArray *arr = self.items.itemsArray;
    for (NSDictionary *hcItem in arr) {
        NSLog(@"items: %@" , [hcItem objectForKey:key_HCSelectItem_Title]);
    }
    
    self.selectedBlock(2);
}

#pragma mark - tableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.items.itemsArray.count<=2 ? 1 : self.items.itemsArray.count ;
}
//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HCAlertViewCellStr"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HCAlertViewCellStr"];
    }
    
    if (self.items.itemsArray.count == 2) {
        [self addCellButtonWhenSizeTwo:cell IndexPath:indexPath];
    }else{
        NSDictionary *hcItem = [self.items.itemsArray objectAtIndex:indexPath.row];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.text = [hcItem objectForKey:key_HCSelectItem_Title];
        cell.textLabel.textColor = [hcItem objectForKey:key_HCSelectItem_TitleColor];
    }
    
    
    //line
    UIView *lineView=[[UIView alloc]init];
    self.seperaterLine=lineView;
    self.seperaterLine.frame = CGRectMake(0, 0, cell.frame.size.width, 1);
    self.seperaterLine.backgroundColor = kColorWithHex(0xd2d5d9);
    [cell.contentView addSubview:self.seperaterLine];
    
    return cell;
}

//当选项只有两项的时候，只显示一行cell，两个按钮
-(void)addCellButtonWhenSizeTwo:(UITableViewCell *)cell IndexPath:(NSIndexPath *)indexPath{
    NSDictionary *firstItem = [self.items.itemsArray objectAtIndex:0];
    UIButton *firstBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    firstBtn.frame = CGRectMake(0, 0, cell.contentView.frame.size.width/2, cell.contentView.frame.size.height);
    firstBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [firstBtn setTitleColor:[firstItem objectForKey:key_HCSelectItem_TitleColor] forState:UIControlStateNormal];
    [firstBtn setTitle:[firstItem objectForKey:key_HCSelectItem_Title] forState:UIControlStateNormal];
    firstBtn.tag = 0;
    [firstBtn addTarget:self action:@selector(selectActionWhenTwoItem:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:firstBtn];
    
    
    NSDictionary *secondItem = [self.items.itemsArray objectAtIndex:1];
    UIButton *secondBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    secondBtn.frame = CGRectMake(firstBtn.frame.size.width, 0, cell.contentView.frame.size.width/2, cell.contentView.frame.size.height);
    secondBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [secondBtn setTitleColor:[secondItem objectForKey:key_HCSelectItem_TitleColor] forState:UIControlStateNormal];
    [secondBtn setTitle:[secondItem objectForKey:key_HCSelectItem_Title] forState:UIControlStateNormal];
    secondBtn.tag = 1;
    [secondBtn addTarget:self action:@selector(selectActionWhenTwoItem:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:secondBtn];
    
    UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, secondBtn.frame.size.height)];
    lineV.backgroundColor = kColorWithHex(0xd2d5d9);
    [secondBtn addSubview:lineV];
}

//选中
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.selectedBlock(indexPath.row);
    [self hiddenSelf];
}

-(void)selectActionWhenTwoItem:(UIButton *)sender{
    self.selectedBlock(sender.tag);
    [self hiddenSelf];
}

-(HCAlertSelectItems *)items{
    if (!_items) {
        _items = [[HCAlertSelectItems alloc] init];
    }
    return _items;
}

@synthesize alertView = _alertView;
- (UIView *)alertView{
    if (!_alertView) {
        _alertView = [[UIView alloc] initWithFrame:CGRectMake(kAlertView_offsetX, 0, Screen_HC_Width - kAlertView_offsetX*2, kAlertView_MAX_Height/2)];
        _alertView.center = key_Window.center;
        _alertView.backgroundColor = [UIColor whiteColor];
        _alertView.layer.masksToBounds = YES;
        _alertView.layer.cornerRadius = 5;
    }
    return _alertView;
}

@synthesize titleLabel = _titleLabel;
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

@synthesize messageLabel = _messageLabel;
-(UILabel *)messageLabel{
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.textColor = [UIColor grayColor];
        _messageLabel.font = [UIFont systemFontOfSize:15];
        _messageLabel.textAlignment = NSTextAlignmentLeft;
        _messageLabel.numberOfLines = 0;
    }
    return _messageLabel;
}

@synthesize tableView = _tableView;
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _tableView.separatorColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
    }
    return _tableView;
}

@synthesize seperaterLine = _seperaterLine;
-(UIView *)seperaterLine{
    if (!_seperaterLine) {
        _seperaterLine = [[UIView alloc] initWithFrame:CGRectZero];
        _seperaterLine.backgroundColor = kColorWithHex(0xd2d5d9);
    }
    return _seperaterLine;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
