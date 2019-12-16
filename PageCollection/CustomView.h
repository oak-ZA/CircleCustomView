//
//  CustomView.h
//  PageCollection
//
//  Created by 张奥 on 2019/12/16.
//  Copyright © 2019 张奥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomView : UIView
-(instancetype)initWithType:(NSInteger)type;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) NSInteger totalPage;
@end
