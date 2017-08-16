//
//  GOLCell.m
//  gameoflife
//
//  Created by 王彦睿 on 2017/8/14.
//  Copyright © 2017年 王彦睿. All rights reserved.
//

#import "GOLCell.h"

@implementation GOLCell

+ (NSArray <GOLCell *>*)generateRandomCells:(NSArray <GOLCell *>*)cells {
    for (GOLCell *cell in cells) {
        NSNumber *number = @(arc4random_uniform(30));
        int cellStatus = number.intValue;
        if (cellStatus == 0) {
            cell.status = GOLCellStatusLive;
        } else {
            cell.status = GOLCellStatusDead;
        }
    }
    return cells;
}

- (void)determineNextStatusByLiveNumber:(int)live deadNumber:(int)dead {
    if (self.status == GOLCellStatusLive) {
        if (live < 2) {
            self.nextStatus = GOLCellStatusDead;
        } else if (live == 2 || live == 3) {
            self.nextStatus = GOLCellStatusLive;
        } else if (live > 3) {
            self.nextStatus = GOLCellStatusDead;
        }
    } else if (self.status == GOLCellStatusDead && live == 3) {
        self.nextStatus = GOLCellStatusLive;
    }
}

- (void)determineNextStatusByNeighbors:(NSArray <GOLCell *>*)cells {
    int live = 0;
    int dead = 0;
    for (GOLCell *cell in cells) {
        if (cell.status == GOLCellStatusLive) {
            live++;
        } else {
            dead++;
        }
    }
    [self determineNextStatusByLiveNumber:live deadNumber:dead];
}

- (NSArray <GOLCell *>*)neighborCells:(NSArray *)allCells maxRow:(int)maxRow maxColumn:(int)maxColumn {
    NSMutableArray <GOLCell *>*cells = [NSMutableArray array];
    for (NSNumber *index in [self neighorCellIndiesWithMaxRowIndex:maxRow - 1 maxColumnIndex:maxColumn - 1]) {
        if (index.intValue >= 0) [cells addObject:allCells[index.intValue]]; // 超出范围的 index.intValue = -1
    }
    return [cells copy];
}

- (NSArray <NSNumber *>*)neighorCellIndiesWithMaxRowIndex:(int)maxRowIndex maxColumnIndex:(int)maxColumnIndex {
    NSArray <NSNumber *>*result;
    int row = self.position.row;
    int column = self.position.column;
    int nextRow = row + 1;
    int previousRow = row - 1;
    int nextColumn = column + 1;
    int previousColumn = column - 1;
    result = @[@([GOLCellPosition indexWithRow:previousRow column:previousColumn maxRowIndex:maxRowIndex maxColumnIndex:maxColumnIndex]), // 左上
               @([GOLCellPosition indexWithRow:previousRow column:column maxRowIndex:maxRowIndex maxColumnIndex:maxColumnIndex]), // 中上
               @([GOLCellPosition indexWithRow:previousRow column:nextColumn maxRowIndex:maxRowIndex maxColumnIndex:maxColumnIndex]), // 右上
               @([GOLCellPosition indexWithRow:nextRow column:previousColumn maxRowIndex:maxRowIndex maxColumnIndex:maxColumnIndex]), // 左下
               @([GOLCellPosition indexWithRow:nextRow column:column maxRowIndex:maxRowIndex maxColumnIndex:maxColumnIndex]), // 中下
               @([GOLCellPosition indexWithRow:nextRow column:nextColumn maxRowIndex:maxRowIndex maxColumnIndex:maxColumnIndex]), // 右下
               @([GOLCellPosition indexWithRow:row column:previousColumn maxRowIndex:maxRowIndex maxColumnIndex:maxColumnIndex]), // 左
               @([GOLCellPosition indexWithRow:row column:nextColumn maxRowIndex:maxRowIndex maxColumnIndex:maxColumnIndex])]; // 右

    return result;
}

- (instancetype)init {
    if (self = [super init]) {
        _position = [[GOLCellPosition alloc] init];
        _status = GOLCellStatusDead;
    }
    return self;
}

@end
