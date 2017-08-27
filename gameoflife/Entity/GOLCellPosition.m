//
//  GOLCellPosition.m
//  gameoflife
//
//  Created by 王彦睿 on 2017/8/14.
//  Copyright © 2017年 王彦睿. All rights reserved.
//

#import "GOLCellPosition.h"

@implementation GOLCellPosition

- (BOOL)isNeighborOfAnotherPosition:(GOLCellPosition *)position {
    // [position.row - 1, position.row + 1] && [position.column - 1, position.column + 1]
    return position.row >= self.row  - 1 && position.row <= self.row + 1 && position.column >= self.column - 1 && position.column <= self.column + 1;
}

- (int)convertToIndexWithMaxColumn:(int)maxColumn {
    return self.row * maxColumn + self.column;
}

+ (int)indexWithRow:(int)row column:(int)column maxRowIndex:(int)maxRowIndex maxColumnIndex:(int)maxColumnIndex {
    if (row < 0 || column < 0 || row > maxRowIndex || column > maxColumnIndex) {
        return -1;
    }
    return row * (maxColumnIndex + 1) + column;
}

@end
