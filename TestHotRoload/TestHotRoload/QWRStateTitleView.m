//
//  QWRStateTitleView.m
//  TestHotRoload
//
//  Created by 何鹏 on 2024/2/28.
//

#import "QWRStateTitleView.h"
#import <Masonry/Masonry.h>
@interface QWRStateTitleView ()

@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *rightName;

@end

@implementation QWRStateTitleView

-(instancetype)init{
    
    if (self = [super init]) {
        [self layout];
    }
    return self;
}


-(void)layout{
    
    _name = [[UILabel alloc] init];
    _name.font = [UIFont systemFontOfSize:14];
    _name.textColor = [UIColor whiteColor];
    _name.textAlignment = NSTextAlignmentRight;
    _name.text = @"啊大姐夫拉断阀12322224222224";
    [self addSubview:_name];
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self);
        make.centerY.equalTo(self);
        make.width.equalTo(@120);
    }];
    
    _rightName = [[UILabel alloc] init];
    _rightName.font = [UIFont systemFontOfSize:14];
    _rightName.textColor = [UIColor whiteColor];
    _rightName.textAlignment = NSTextAlignmentLeft;
    _rightName.text = @"asdfjladsfkjl";
    [self addSubview:_rightName];
    [_rightName mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.name.mas_right).equalTo(@10);
        make.centerY.equalTo(self);
        make.right.equalTo(self);
    }];
}



@end
