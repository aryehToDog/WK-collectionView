//
//  ViewController.m
//  自定义collectionView
//
//  Created by 阿拉斯加的狗 on 16/9/5.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "ViewController.h"
#import "WKLineLayout.h"
#import "WKCollectionCell.h"
#import "WKCircleLayout.h"

@interface ViewController () <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong)NSMutableArray *images;
@property (nonatomic,strong)UICollectionView *collectionView;
@end

@implementation ViewController


static  NSString *const ID = @"cell";


- (NSMutableArray *)images {
    
    if (!_images) {
        _images = [NSMutableArray array];
        
        for (int i = 0; i < 20; i ++) {
            [_images addObject:[NSString stringWithFormat:@"%zd",i + 1]];
        }
    }

    return _images;

}

- (void)viewDidLoad {
    [super viewDidLoad];

    //自定义布局
    WKCircleLayout *flowLaout = [[WKCircleLayout alloc]init];

    CGRect rect = CGRectMake(0, 150, [UIScreen mainScreen].bounds.size.width, 300);
    
    
    //创建collectionView
    UICollectionView *collectView = [[UICollectionView alloc]initWithFrame:rect collectionViewLayout:flowLaout];
//    collectView.backgroundColor = [UIColor grayColor];
    collectView.dataSource = self;
    collectView.delegate = self;
    [collectView registerNib:[UINib nibWithNibName:NSStringFromClass([WKCollectionCell class]) bundle:nil] forCellWithReuseIdentifier:ID];
    self.collectionView = collectView;
    [self.view addSubview:collectView];
  
    
}

//点击屏幕进行切换布局模式
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    if ([self.collectionView.collectionViewLayout isKindOfClass:[WKCircleLayout class]]) {
        
        [self.collectionView setCollectionViewLayout:[[WKLineLayout alloc]init] animated:YES];
        
    }else {
    
        [self.collectionView setCollectionViewLayout:[[WKCircleLayout alloc]init] animated:YES];
    }

}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {


    return self.images.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    WKCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];

    cell.imageName = self.images[indexPath.item];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    //点中删除某一行
    [self.images removeObjectAtIndex:indexPath.item];
    
    [collectionView deleteItemsAtIndexPaths:@[indexPath]];
}


@end
