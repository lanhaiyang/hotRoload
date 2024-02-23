//
//  DWViewController.m
//  DWDebugHR
//
//  Created by 丁巍 on 2021/4/20.
//

#import "DWViewController.h"
#import "UIView+Extension.h"
#import <Masonry/Masonry.h>
#define SPACING  16.0

@interface DWViewController ()

@property (nonatomic, strong) UILabel *demoLabel;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel  *titleLabel;

@property (nonatomic, strong) UILabel  *descLabel;
@property (nonatomic, strong) UILabel *name;

@end

@implementation DWViewController


-(instancetype)init{
    if(self=[super init]){
        
        NSLog(@"xx");
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSLog(@"xx2");
//    [self.view addSubview:self.demoLabel];
//    [self.view addSubview:self.contentView];
//    [self.contentView addSubview:self.iconImageView];
//    [self.contentView addSubview:self.titleLabel];
//    [self.contentView addSubview:self.descLabel];
//
//    self.name = [[UILabel alloc] init];
//    self.name.frame = CGRectMake(CGRectGetMinX(self.titleLabel.frame), CGRectGetMaxY(self.descLabel.frame) + 5, self.contentView.width * 0.6, 20);
//    self.name.font = [UIFont systemFontOfSize:14];
//    self.name.textColor = [UIColor blackColor];
//    self.contentView.backgroundColor = [UIColor redColor];
//    [self.contentView addSubview:self.name];
//    NSLog(@"xx3");
//    self.descLabel.text      = @"1234344何鹏天龙教天龙八部之夜叉，身着红衣的艳美女子。常化名姬无双。擅长轻功，邪气逼人，龙王麾下的第一战将。后与东方未明在森林相遇，随后经历洛阳河洛大侠江天雄宴会，天意城事件，最终在地宫彼此互诉情谊，在天王线结局，与东方未明西域隐居成为一对神仙眷侣123";
    
    
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor redColor];
    label.text = @"你长大了吗22222123222223";
//    label.textColor = [UIColor blackColor];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).equalTo(@25);
        make.right.equalTo(self.view).equalTo(@-15);
        make.top.equalTo(self.view).equalTo(@(80));
    }];
    
    
}


#pragma mark - 热重载

- (void)DWHotReload {
    [self viewDidLoad];
//    self.iconImageView.image = [UIImage imageNamed:@"yc"];
//    self.titleLabel.text     = @"夜叉1213";
//    self.descLabel.text      = @"1223333何鹏天龙教天龙八部之夜叉，身着红衣的艳美女子。常化名姬无双。擅长轻功，邪气逼人，龙王麾下的第一战将。后与东方未明在森林相遇，随后经历洛阳河洛大侠江天雄宴会，天意城事件，最终在地宫彼此互诉情谊，在天王线结局，与东方未明西域隐居成为一对神仙眷侣123";
//
//    self.name.text = @"1";
}


#pragma mark - 懒加载

- (UILabel *)demoLabel{
    if (!_demoLabel) {
        _demoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, self.view.width, 56)];
        _demoLabel.font          = [UIFont boldSystemFontOfSize:26];
        _demoLabel.text          = @"热重载demo";
        _demoLabel.textAlignment = NSTextAlignmentCenter;
        _demoLabel.textColor     = [UIColor blackColor];
    }
    return _demoLabel;
}

- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.demoLabel.frame) + 50, self.view.width, 200)];
    }
    return _contentView;
}

- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        CGFloat height = 64;
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SPACING,10, height, height)];
        _iconImageView.image = [UIImage imageNamed:@"icon"];
    }
    return _iconImageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame)+SPACING, CGRectGetMinY(self.iconImageView.frame), self.contentView.width * 0.6, self.iconImageView.height*0.5-4)];
        _titleLabel.font      = [UIFont systemFontOfSize:18];
        _titleLabel.text      = @"陈公公";
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}

- (UILabel *)descLabel{
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.titleLabel.frame), CGRectGetMaxY(self.titleLabel.frame) + 5, self.contentView.width * 0.6, 100)];
        _descLabel.font      = [UIFont systemFontOfSize:16];
        _descLabel.textColor = [UIColor blackColor];
        _descLabel.text      = @"2343333333陈崇英，东厂头目，手段阴狠，武功造诣不明。是当今朝中最令忠臣义士切齿痛恨的一人。借囚禁忠臣的机会，打算诱出与朝廷作对的江湖人，并将他们一网打尽。";
        _descLabel.numberOfLines = 0;
    }
    return _descLabel;
}


@end
