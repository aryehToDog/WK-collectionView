//
//  WKCollectionCell.m
//  自定义collectionView
//
//  Created by 阿拉斯加的狗 on 16/9/5.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKCollectionCell.h"

@interface WKCollectionCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation WKCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    //设置图片的边框
    self.imageView.layer.borderColor = ([UIColor whiteColor].CGColor);
    self.imageView.layer.borderWidth = 5;
    
}

- (void)setImageName:(NSString *)imageName {

    _imageName = [imageName copy];

    self.imageView.image = [UIImage imageNamed:imageName];
    
}

@end
