//
//  YHTSignView.m
//  CloudContract_SDK
//
//  Created by 吴清正 on 16/5/24.
//  Copyright © 2016年 dazheng_wu. All rights reserved.
//

#import "YHTSignView.h"
#import "YHTConstants.h"
@interface YHTSignView()

@property (nonatomic, strong)YHTSign *sign;

@property (nonatomic, strong)UIImageView *signImageView;

@property (nonatomic, strong)UIButton *deleteBtn;

@end

@implementation YHTSignView

+ (instancetype)instanceWithSign:(YHTSign *)sign delegate:(id<YHTSignViewDelegate>)delegate{
    YHTSignView *view = [[YHTSignView alloc] init];
    view.sign = sign;
    view.delegate = delegate;
    [view addSubview:view.signImageView];
    [view addSubview:view.deleteBtn];

    return view;
}

#pragma mark - GET/SET
- (void)setSign:(YHTSign *)sign {
    _sign = sign;
    self.signImageView.image = _sign.signImage;
    self.deleteBtn.hidden = _sign.isUsed;
}

- (UIImageView *)signImageView{
    if (!_signImageView) {
        _signImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _kIOS_SCREEN_WIDTH-120, 100)];
    }
    return _signImageView;
}

- (UIButton *)deleteBtn{
    if (!_deleteBtn) {
        _deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(_kIOS_SCREEN_WIDTH-120, 0, 120, 100)];
        [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteBtn setTitleColor:_kMAIN_COLOR forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}

- (void)delete:(id)sender{
    if (self.delegate) {
        [self.delegate deleteSign:self.sign];
    }
}
@end
