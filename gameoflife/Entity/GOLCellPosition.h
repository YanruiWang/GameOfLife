//
//  GOLCellPosition.h
//  gameoflife
//
//  Created by 王彦睿 on 2017/8/14.
//  Copyright © 2017年 王彦睿. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GOLCellPosition : NSObject

@property (nonatomic, assign) int row;

@property (nonatomic, assign) int column;

+ (int)indexWithRow:(int)row column:(int)column maxRowIndex:(int)maxRowIndex maxColumnIndex:(int)maxColumnIndex;

@end
