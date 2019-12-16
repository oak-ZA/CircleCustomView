//
//  ViewController.m
//  PageCollection
//
//  Created by 张奥 on 2019/12/16.
//  Copyright © 2019 张奥. All rights reserved.
//

#import "ViewController.h"
#import "CustomView.h"
#define SCREEN_Width [UIScreen mainScreen].bounds.size.width
#define SCREEN_Height [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)UIPageControl *pageControl;
@property (nonatomic, assign)int scrollerW;
@property (nonatomic, assign)long currentPage;
@property (nonatomic, assign)long markPage;
@property (nonatomic, strong) NSMutableArray *customViews;
@property (nonatomic, copy) NSArray *datas;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.scrollerW = SCREEN_Width;
    self.customViews = [NSMutableArray array];
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.pageControl];
    
    [self configData:@[@"1",@"2"]];
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsVerticalScrollIndicator = YES;
        _scrollView.showsHorizontalScrollIndicator = YES;
        _scrollView.pagingEnabled = YES;
        _scrollView.backgroundColor = [UIColor yellowColor];
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
        _scrollView.frame = CGRectMake(0, (SCREEN_Height - 270)/2, self.scrollerW, 270);
    }
    return _scrollView;
}
-(UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.frame = CGRectMake((SCREEN_Width - 12)/2, CGRectGetMaxY(_scrollView.frame)-10, 12, 6);
        _pageControl.backgroundColor = [UIColor redColor];
        _pageControl.hidden = YES;
    }
    return _pageControl;
}

-(void)configData:(NSArray *)datas{
    self.datas = datas;
    _scrollView.contentSize = CGSizeMake(self.scrollerW*3, 270);
    _pageControl.numberOfPages = 3;
    
    for (int i=0; i<3; i++) {
        
        CustomView *customView = [[CustomView alloc] initWithType:i];
        customView.tag = 1000+i;
        [_scrollView addSubview:customView];
        [self.customViews addObject:customView];
        
    }
    
    _scrollView.contentOffset = CGPointMake(self.scrollerW, 0);
    _pageControl.currentPage = 0;
    self.markPage = 0;
    self.currentPage = 0;
    
    [self setPageViewIsRight:YES];
}

-(void)setPageViewIsRight:(BOOL)isRight{
    
    CustomView *leftCustomView ;
    CustomView *middleCustomView;
    CustomView *rightCustomView;
    
    if (self.pageControl.currentPage == self.datas.count - 1) {
        leftCustomView = self.customViews[self.pageControl.currentPage - 1];
        
        middleCustomView = self.customViews[self.pageControl.currentPage];
        
        rightCustomView = self.customViews.firstObject;
        
    }else if (self.pageControl.currentPage == 0){
        leftCustomView = self.customViews.lastObject;
        
        middleCustomView = self.customViews.firstObject;
        
        rightCustomView = self.customViews[1];
    }else{
        leftCustomView = self.customViews[self.pageControl.currentPage - 1];
        
        middleCustomView = self.customViews[self.pageControl.currentPage];
        
        rightCustomView = self.customViews[self.pageControl.currentPage + 1];
    }
    leftCustomView.frame = CGRectMake(0, 0, self.scrollerW, 270);
    
    middleCustomView.frame = CGRectMake(self.scrollerW, 0, self.scrollerW, 270);
    rightCustomView.frame = CGRectMake(2*self.scrollerW, 0, self.scrollerW, 270);
    
    if (isRight) {
       leftCustomView.collectionView.contentOffset = CGPointMake((leftCustomView.totalPage - 1)*self.scrollerW, 0);
        middleCustomView.collectionView.contentOffset = CGPointMake(0, 0);
        rightCustomView.collectionView.contentOffset = CGPointMake(0, 0);
    }else{
        leftCustomView.collectionView.contentOffset = CGPointMake((leftCustomView.totalPage - 1)*self.scrollerW, 0);
        middleCustomView.collectionView.contentOffset = CGPointMake((leftCustomView.totalPage - 1)*self.scrollerW, 0);
        rightCustomView.collectionView.contentOffset = CGPointMake(0, 0);
    }
    self.scrollView.contentOffset = CGPointMake(self.scrollerW, 0);
    
    self.markPage = self.currentPage;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x > self.scrollerW) {
        //右滑
        [self setPageIndex:YES];
        [self setPageViewIsRight:YES];
    }else{
        //左滑
        [self setPageIndex:NO];
        [self setPageViewIsRight:NO];
    }
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
}

//左右滑动
-(void)setPageIndex:(BOOL)isRight{
    
    if (isRight) {
        if (self.currentPage == self.datas.count - 1) {
            self.pageControl.currentPage = 0;
        }else{
            self.pageControl.currentPage = self.currentPage + 1;
        }
    }else{
        if (self.currentPage == 0) {
            self.pageControl.currentPage = self.datas.count - 1;
        }else{
            self.pageControl.currentPage = self.currentPage - 1;
        }
    }
    self.currentPage = self.pageControl.currentPage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
