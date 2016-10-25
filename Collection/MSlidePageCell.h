//
//  MSlidePageCell.h
//  Collection
//
//  Created by Dry on 16/10/21.
//  Copyright © 2016年 Dry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSlidePageCell : UICollectionViewCell

@property (nonatomic, strong)UILabel *titleLabel;

/*
 当前选中的cell的indexPath
 */
@property (nonatomic, strong) NSIndexPath *indexPath;

/*
 设置cell里的title。
 */
- (void)setTitle:(NSString *)title curentIndexPath:(NSIndexPath *)curentIndexPath;

@end
