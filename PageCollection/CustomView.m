//
//  CustomView.m
//  PageCollection
//
//  Created by 张奥 on 2019/12/16.
//  Copyright © 2019 张奥. All rights reserved.
//

#import "CustomView.h"
#import "JHCollectionViewFlowLayout.h"
#define SCREEN_Width [UIScreen mainScreen].bounds.size.width
#define SCREEN_Height [UIScreen mainScreen].bounds.size.height
@interface CustomView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, assign) NSInteger type;
@end
@implementation CustomView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithType:(NSInteger)type{
    self = [super init];
    if (self) {
        self.type = type;
        if (23 % 10 == 0) {
            //除尽
            self.totalPage = 23 / 10;
        }else{
            //未除尽
            self.totalPage = 23 / 10 + 1;
        }
        [self createCollectionView];
    }
    return self;
}

-(void)createCollectionView{
    
    JHCollectionViewFlowLayout *layout = [JHCollectionViewFlowLayout new];
    layout.row = 2;
    layout.column = 5;
    layout.rowSpacing = 0;
    layout.columnSpacing = 0;
    layout.size = CGSizeMake(SCREEN_Width/5, 270/2);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 270) collectionViewLayout:layout];
    self.collectionView = collectionView;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.pagingEnabled = YES;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.backgroundColor = [UIColor blackColor];
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([self class])];
    [self addSubview:collectionView];
    
}

#pragma mark -- UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 23;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([self class]) forIndexPath:indexPath];
    if (self.type == 0) {
        cell.backgroundColor = [UIColor blueColor];
    }else{
        cell.backgroundColor = [UIColor greenColor];
    }
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"%@==============scrollView_____X++++%f",self,scrollView.contentOffset.x);
}

@end
