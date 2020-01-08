//
//  CPMyCreditsListTableViewCell.m
//  CrowdPower4iPhone
//
//  Created by 秦旭 on 2018/1/29.
//  Copyright © 2018年 ingtube. All rights reserved.
//

#import "CPUIKitCommonTableViewCell.h"
#import <YYCategories/YYCategories.h>
#import <Masonry/Masonry.h>
#import "NSDate+Utils.h"

@interface CPUIKitCommonTableViewCell ()
@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UILabel* dateLabel;
@property (nonatomic, strong) UILabel* creditsLabel;
@property (nonatomic, strong) UILabel* subtitleLabel;
@property (nonatomic, strong) UILabel* remainLabel;
@property (nonatomic, strong) UIView* separatorLine;
@property (nonatomic, strong) UIStackView* rightContainerView;
@end

@implementation CPUIKitCommonTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit{
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.dateLabel];
    [self.contentView addSubview:self.rightContainerView];
    [self.rightContainerView addArrangedSubview:self.creditsLabel];
    [self.rightContainerView addArrangedSubview:self.remainLabel];
    [self.contentView addSubview:self.subtitleLabel];
    [self.contentView addSubview:self.separatorLine];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(22.0f);
        make.leading.mas_equalTo(18.0f);
        make.trailing.lessThanOrEqualTo(self.creditsLabel.mas_leading).offset(-44.0f);
    }];
    
    [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.titleLabel);
        make.trailing.lessThanOrEqualTo(self.creditsLabel.mas_leading).offset(-44.0f);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(12.0f);
    }];
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.titleLabel);
        make.top.equalTo(self.subtitleLabel.mas_bottom).offset(10.0f);
        make.bottom.mas_equalTo(-22.0f);
    }];
    
    [self.rightContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.trailing.mas_equalTo(-18.0f);
    }];
    
    [self.separatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(0.5f);
    }];
}

- (void)setData:(id<CPUIKitCommonTableViewCellDataProtocol>)data{
    if (data) {
        self.titleLabel.text = data.pointDetail;
        self.creditsLabel.text = data.pointString;
        self.dateLabel.text = [NSDate formateDateToHumanReadable:data.createTime type:NSDateFormateType2];
        self.subtitleLabel.text = data.subtitle;
        self.remainLabel.text = data.remain;
        if (data.subtitle.length <= 0) {
            [self.dateLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.leading.equalTo(self.titleLabel);
                make.top.equalTo(self.titleLabel.mas_bottom).offset(10.0f);
                make.bottom.mas_equalTo(-22.0f);
            }];
        }else{
            [self.dateLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.leading.equalTo(self.titleLabel);
                make.top.equalTo(self.subtitleLabel.mas_bottom).offset(10.0f);
                make.bottom.mas_equalTo(-22.0f);
            }];
        }
    }
}

- (void)prepareForReuse{
    [super prepareForReuse];
    self.titleLabel.text = nil;
    self.creditsLabel.text = nil;
    self.dateLabel.text = nil;
    self.subtitleLabel.text = nil;
    self.remainLabel.text = nil;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.font = [UIFont systemFontOfSize:16.0f weight:UIFontWeightMedium];
        _titleLabel.textColor = [UIColor colorWithRGB:0x3e3d3e];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UILabel *)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _dateLabel.font = [UIFont systemFontOfSize:14.0f weight:UIFontWeightRegular];
        _dateLabel.textColor = [UIColor colorWithRGB:0x949494];
    }
    return _dateLabel;
}

- (UILabel *)creditsLabel{
    if (!_creditsLabel) {
        _creditsLabel = [[UILabel alloc] init];
        _creditsLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _creditsLabel.font = [UIFont systemFontOfSize:18.0f weight:UIFontWeightSemibold];
        _creditsLabel.textColor = [UIColor colorWithRGB:0x000000];
        [_creditsLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        [_creditsLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    }
    return _creditsLabel;
}

- (UIView *)separatorLine{
    if (!_separatorLine) {
        _separatorLine = [[UIView alloc] init];
        _separatorLine.translatesAutoresizingMaskIntoConstraints = NO;
        _separatorLine.backgroundColor = [UIColor colorWithRGB:0xe0e0e0];
    }
    return _separatorLine;
}

- (UILabel *)subtitleLabel{
    if (!_subtitleLabel) {
        _subtitleLabel = [[UILabel alloc] init];
        _subtitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _subtitleLabel.textColor = [UIColor colorWithRGB:0x949494];
        _subtitleLabel.font = [UIFont systemFontOfSize:14.0f];
        _subtitleLabel.numberOfLines = 0;
    }
    return _subtitleLabel;
}

- (UILabel *)remainLabel{
    if (!_remainLabel) {
        _remainLabel = [[UILabel alloc] init];
        _remainLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _remainLabel.font = [UIFont systemFontOfSize:12.0f];
        _remainLabel.textColor = [UIColor colorWithRGB:0x939393];
    }
    return _remainLabel;
}

- (UIStackView *)rightContainerView{
    if (!_rightContainerView) {
        _rightContainerView = [[UIStackView alloc] init];
        _rightContainerView.translatesAutoresizingMaskIntoConstraints = NO;
        _rightContainerView.alignment = UIStackViewAlignmentTrailing;
        _rightContainerView.distribution = UIStackViewDistributionFill;
        _rightContainerView.spacing = 10.0f;
        _rightContainerView.axis = UILayoutConstraintAxisVertical;
    }
    return _rightContainerView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
