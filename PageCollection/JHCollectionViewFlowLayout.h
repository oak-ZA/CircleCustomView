//
//  JHCollectionViewFlowLayout.h
//  PageCollection
//
//  Created by 张奥 on 2019/12/16.
//  Copyright © 2019 张奥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHCollectionViewFlowLayout : UICollectionViewFlowLayout
///一页展示行数
@property (nonatomic, assign) NSInteger row;
///一页展示列数
@property (nonatomic, assign) NSInteger column;
///行间距
@property (nonatomic, assign) CGFloat rowSpacing;
///列间距
@property (nonatomic, assign) CGFloat columnSpacing;
///item大小
@property (nonatomic, assign) CGSize size;
///一页的宽度
@property (nonatomic, assign) CGFloat pageWidth;
@end
