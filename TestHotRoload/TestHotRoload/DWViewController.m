//
//  DWViewController.m
//  DWDebugHR
//
//  Created by 丁巍 on 2021/4/20.
//

#import "DWViewController.h"
#import "UIView+Extension.h"
#import <Masonry/Masonry.h>
//#import "MonitorFileChangeHelp.h"
#import "QWRStateTitleView.h"
#import "TestView.h"
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
    
    UIView *head = [[UIView alloc] init];
    head.backgroundColor = [UIColor blueColor];
    [self.view addSubview:head];
    [head mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.right.equalTo(self.view);
        make.height.equalTo(@(64+22));
    }];
    
    self.view.backgroundColor = [UIColor blackColor];//
    
    UIImageView *avater = [[UIImageView alloc] init];
    avater.backgroundColor = [UIColor redColor];
    avater.layer.cornerRadius = 20;
    avater.layer.masksToBounds = YES;
    [self.view addSubview:avater];
    [avater mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).equalTo(@(64+22+13));//
        make.width.height.equalTo(@(40));
    }];
    
    UILabel *title = [[UILabel alloc] init];
//    title. M 24
    title.textColor = [UIColor whiteColor];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"奶茶妹 送你的礼物";
    [self.view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view).equalTo(@(15));//
        make.right.equalTo(self.view).equalTo(@(-15));//
        make.top.equalTo(avater.mas_bottom).equalTo(@8);
    }];
    
    
    UILabel *price = [[UILabel alloc] init];
    NSLog(@"%f",price.x);
//    title. R 14
    price.textColor = [UIColor whiteColor];
    price.font = [UIFont systemFontOfSize:24];
    price.textAlignment = NSTextAlignmentCenter;
    price.text = @"+28.12";
    [self.view addSubview:price];
    [price mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view).equalTo(@(15));//
        make.right.equalTo(self.view).equalTo(@(-15));//
        make.top.equalTo(title.mas_bottom).equalTo(@8);
    }];
    
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor whiteColor];//#3A3B3E
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(price.mas_bottom).equalTo(@40);
        make.height.equalTo(@0.5);
    }];
    
//    UIView *stateView = [[UIView alloc] init];
//    stateView.backgroundColor =[UIColor redColor];
//    [self.view addSubview:stateView];
//    [stateView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.view).equalTo(@(15));//
//        make.right.equalTo(self.view).equalTo(@(-15));//
//        make.top.equalTo(line.mas_bottom).equalTo(@(15));//
//        make.height.equalTo(@23);
//    }];
//
//    UILabel *leftTitle = [[UILabel alloc] init];
////    title. R 12
//    leftTitle.textColor = [UIColor whiteColor];//#8C8D8E
//    leftTitle.font = [UIFont systemFontOfSize:12];
//    leftTitle.textAlignment = NSTextAlignmentRight;
//    leftTitle.text = @"当前状态";
//    [stateView addSubview:leftTitle];
//    [leftTitle mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(stateView);//
//        make.width.equalTo(@70);//Size
//        make.top.bottom.equalTo(stateView);
//    }];
//
//
//    UILabel *rightTitle = [[UILabel alloc] init];
////    title. R 12
//    rightTitle.textColor = [UIColor whiteColor];
//    rightTitle.font = [UIFont systemFontOfSize:12];
//    rightTitle.textAlignment = NSTextAlignmentLeft;
//    rightTitle.text = @"已存入零钱";
//    [stateView addSubview:rightTitle];
//    [rightTitle mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(leftTitle.mas_right).equalTo(@25);//
//        make.right.equalTo(stateView);//Size
//        make.top.bottom.equalTo(stateView);
//    }];
//
    
    QWRStateTitleView *stateTitle = [[QWRStateTitleView alloc] init];
    stateTitle.backgroundColor = [UIColor blackColor];
    [self.view addSubview:stateTitle];
    [stateTitle mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self.view).equalTo(@(15));//
        make.right.equalTo(self.view).equalTo(@(-15));//
        make.top.equalTo(line.mas_bottom).equalTo(@(15));//
        make.height.equalTo(@23);
    }];
    
    TestView *testView = [[TestView alloc] init];
    testView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:testView];
    [testView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self.view).equalTo(@(15));//
        make.right.equalTo(self.view).equalTo(@(-15));//
        make.top.equalTo(stateTitle.mas_bottom).equalTo(@(15));//
        make.height.equalTo(@100);
    }];
}


#pragma mark - 热重载

- (void)injected {
    NSLog(@"inject");
    //修改UI的代码直接写在这里
}

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




