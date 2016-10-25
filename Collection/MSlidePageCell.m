//
//  MSlidePageCell.m
//  Collection
//
//  Created by Dry on 16/10/21.
//  Copyright © 2016年 Dry. All rights reserved.
//

#import "MSlidePageCell.h"


@implementation MSlidePageCell

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLabel.frame = CGRectMake(0, 5, self.contentView.frame.size.width, self.contentView.frame.size.height-10);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        /*cell上创建显示title的label*/
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

- (void)setTitle:(NSString *)title curentIndexPath:(NSIndexPath *)curentIndexPath {
    
    float size = 14.0;
    if (curentIndexPath.row == self.indexPath.row)
    {
        size = 15.0;
        self.titleLabel.textColor = [UIColor redColor];
    }
    else
    {
        self.titleLabel.textColor = [UIColor blackColor];
    }
    self.titleLabel.font = [UIFont systemFontOfSize:size];

    self.titleLabel.text = title;
}

@end
