//
//  WKLineLayout.m
//  自定义collectionView
//
//  Created by 阿拉斯加的狗 on 16/9/5.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKLineLayout.h"

@implementation WKLineLayout

- (instancetype)init {

    if (self = [super init]) {
        
        
        
    }

    return self;
}

/**
 *   准备布局
 */
- (void)prepareLayout {

    [super prepareLayout];
    
    self.itemSize = CGSizeMake(200, 200);
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;

    //设置起始的内边距
    CGFloat inset = (self.collectionView.frame.size.width - self.itemSize.width) * 0.5;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
    
}

/**
 *   用来刷新重新布局
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {

    return YES;

}


/**
 *   用来布局cell的frame
 */

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {

    NSArray *attrsArray = [super layoutAttributesForElementsInRect:rect];
    
    //获取到collectionView的中心点的X
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    for (UICollectionViewLayoutAttributes *attr in attrsArray) {
        
        CGFloat delta = ABS(attr.center.x - centerX);
        
        CGFloat scale = 1 - delta / self.collectionView.frame.size.width;
        
        attr.transform = CGAffineTransformMakeScale(scale, scale);
    }

    return attrsArray;
}

/**
 *   用来布局cell最终的落点
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {

    CGRect rect = CGRectMake(proposedContentOffset.x, 0, self.collectionView.frame.size.width, self.collectionView.frame.size.height);
    
    //获取到cell的frame
    NSArray *attrsArray = [super layoutAttributesForElementsInRect:rect];

    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    //计算cellectionView中心点最小的值
     CGFloat minDetla = CGFLOAT_MAX;
    for (UICollectionViewLayoutAttributes *attr in attrsArray) {
     
        if (ABS(minDetla) > ABS(centerX - attr.center.x)) {
            
            minDetla = attr.center.x - centerX;
        }
        
    }
        proposedContentOffset.x += minDetla;
    
    return proposedContentOffset;
    
}


@end
