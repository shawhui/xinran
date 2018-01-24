//
//  DOPDropDownMenuRowCell.m
//  DOPdemo
//
//  Created by ZOMAKE on 2017/10/9.
//  Copyright © 2017年 tanyang. All rights reserved.
//

#import "MoreDropDownMenuRowCell.h"
#import "NSArray+ZMAdd.h"
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#define kTableViewCellHeight 43
#define kTableViewHeight 300
#define kButtomImageViewHeight 21

#define kTextColor          [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1]
#define kDetailTextColor    [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1]
#define kSeparatorColor     [UIColor colorWithRed:219/255.0 green:219/255.0 blue:219/255.0 alpha:1]
#define kCellBgColor        [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1]
#define kTextSelectColor    [UIColor colorWithRed:246/255.0 green:79/255.0 blue:0/255.0 alpha:1]

#define KSelectBorderColor      [UIColor colorWithRed:253/255.0 green:206/255.0 blue:41/255.0 alpha:1]
#define KUnSelectBorderColor    [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1]
#define KButtonColor            [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1]

#define KImageHeight 40.f
#define KImageMargin 20.f
#define KImageCount  3.f
#define WEAKSELF  __weak  typeof(self) weakSelf = self
#define BLOCKSELF __block typeof(self) weakSelf = self


@interface MoreDropDownMenuRowCell()

/** 记录最后一个数量 */
@property (nonatomic, assign) NSInteger lastCount;
/** 底部视图 */
@property (nonatomic, strong) UIView *bottomV;
/** 存储数据 */
@property (nonatomic, strong) NSArray *dataArray;
/** 最后一个按钮 */
@property (nonatomic, strong) UIButton *lastBTN;

@end

@implementation MoreDropDownMenuRowCell
{
    CGFloat imageCount;
    CGFloat imageSpace;
    CGFloat imageWidth;
    CGFloat imageHeight;
}

- (UIView *)bottomV
{
    if (!_bottomV) {
        _bottomV = [[UIView alloc]init];
        [self.contentView addSubview:_bottomV];
        [_bottomV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    return _bottomV;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style  reuseIdentifier:reuseIdentifier];
    
    if (self) {
        imageCount  = 3.0;
        imageSpace  = 20.0;
        imageWidth  = (SCREEN_WIDTH - imageSpace * 2 - (imageCount - 1) * imageSpace)/imageCount;
        imageHeight = 40.0;
    }
    
    return self;
    
}

//复用以前的button，有就复用，没有就创建，多了就删
- (void)setUI:(NSArray *)dataArray{
    self.dataArray = dataArray;
    WEAKSELF;
    NSInteger count = dataArray.count;
    //增加
    for (NSInteger i = 1; i <= count ; i++) {
        UIButton *btn = [self viewWithTag:i*10];
        if (btn == nil) {
            //没有button 这放数据
            btn = [self cellView:dataArray[i-1] tag:i*10];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                if (weakSelf.lastBTN == nil) {
                    make.left.mas_equalTo(weakSelf.bottomV.mas_left).offset(KImageMargin);
                    make.top.mas_equalTo(weakSelf.bottomV.mas_top).with.offset(KImageMargin);
                }else{
                    //左边
                    if (i % 3 == 1) {
                        make.left.mas_equalTo(weakSelf.bottomV.mas_left).offset(KImageMargin);
                        NSUInteger line = ceil((i)/3.f) - 1;
                        make.top.mas_equalTo(line * (KImageHeight * FIT_WIDTH + KImageMargin) + KImageMargin);
                    }else if(i % 3 == 2){
                        make.left.mas_equalTo(imageWidth + 2 * imageSpace);
                        NSUInteger line = ceil((i)/3.f) - 1;
                        make.top.mas_equalTo(line * (KImageHeight * FIT_WIDTH + KImageMargin) + KImageMargin);
                    }else if (i % 3 == 0){
                        make.right.mas_equalTo(weakSelf.bottomV.mas_right).offset(- KImageMargin);
                        NSUInteger line = ceil((i)/3.f) - 1;
                        make.top.mas_equalTo(line * (KImageHeight * FIT_WIDTH + KImageMargin) +KImageMargin);
                    }
                }
            }];
        }else{
            //已有button 这放数据
            [self setUI:[self viewWithTag:i*10+1] data:dataArray[i-1]];
        }
        self.lastBTN = btn;
    }
    //删除
    for (NSInteger j = count; j < _lastCount; j++) {
        UIButton *btn = [self viewWithTag:j*10];
        [btn removeFromSuperview];
        btn = nil;
    }
    _lastCount = count;
}

- (UIButton *)cellView:(NSString *)data tag:(NSInteger)tag{
    UIButton *bottomView = [[UIButton alloc]init];
    [bottomView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    bottomView.titleLabel.font = [UIFont systemFontOfSize:13];
    bottomView.tag = tag;
    [bottomView addTarget:self action:@selector(tapProduct:) forControlEvents:UIControlEventTouchUpInside];
    bottomView.layer.borderColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1].CGColor;
    bottomView.layer.borderWidth = 0.5;
    bottomView.layer.cornerRadius = 2;
    if (tag == 10) {
        [self setupButtonStyle:bottomView isAdd:YES];
    }
    [self.bottomV addSubview:bottomView];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake((kScreenWidth - 2 * KImageMargin - 2 * KImageMargin)/KImageCount, KImageHeight * FIT_WIDTH));
    }];
    
    
    [self setUI:bottomView data:data];
    return bottomView;
    
}

- (void)setUI:(UIButton *)button data:(NSString *)data{
    if (data.length) {
        [button setTitle:data forState:UIControlStateNormal];
    }
    
}
#pragma mark - 点击产品
- (void)tapProduct:(UIButton *)sender{
    NSLog(@"sender.tag = %ld",sender.tag);
    [self setupButtonStyle:[self viewWithTag:10] isAdd:NO];
    if (self.selectButton) {
        [self setupButtonStyle:self.selectButton isAdd:NO];
    }
    [self setupButtonStyle:sender isAdd:YES];
    self.selectButton = sender;
    
    NSString *tag = [self.dataArray safeObjectAtIndex:sender.tag/10-1];
    
    if (self.clickTagBlock) {
        self.clickTagBlock(tag);
    }
}

#pragma mark - 添加或者删除样式
- (void)setupButtonStyle:(UIButton *)btn isAdd:(BOOL)isAdd{
    if (isAdd) {
        btn.layer.borderColor = KSelectBorderColor.CGColor;
        btn.backgroundColor  = KSelectBorderColor;
    }else{
        btn.layer.borderColor = KUnSelectBorderColor.CGColor;
        btn.backgroundColor = [UIColor whiteColor];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end


@implementation MoreDropDownMenuRowCollectionCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.layer.masksToBounds = YES;
        self.contentView.layer.borderColor = KUnSelectBorderColor.CGColor;
        self.contentView.layer.borderWidth = 0.5;
        self.contentView.layer.cornerRadius = 2;
    }
    return self;
}

- (UIButton *)button{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.titleLabel.font = [UIFont systemFontOfSize:13];
        _button.backgroundColor = [UIColor clearColor];
        _button.userInteractionEnabled = NO;
        
        [_button setTitleColor:KButtonColor forState:UIControlStateNormal];
        [self.contentView addSubview:_button];
        [_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
    }
    return _button;
}

- (void)setupUI:(NSString *)text{
    if (!text.length) return;
    //self.contentView.backgroundColor = [UIColor redColor];
    [self.button setTitle:text forState:UIControlStateNormal];
}

- (void)setSelectCell:(BOOL)selectCell{
    if (selectCell) {
        self.contentView.layer.borderColor = KSelectBorderColor.CGColor;
        self.contentView.backgroundColor = KSelectBorderColor;
    }else{
        self.contentView.layer.borderColor = KUnSelectBorderColor.CGColor;
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
}

@end
