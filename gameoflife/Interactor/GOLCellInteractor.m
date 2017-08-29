//
//  GOLCellInteractor.m
//  gameoflife
//
//  Created by 王彦睿 on 2017/8/27.
//  Copyright © 2017年 王彦睿. All rights reserved.
//

#import "GOLCellInteractor.h"

@interface GOLCellInteractor ()

@property (nonatomic, strong) NSArray <GOLCell *>* cells;

@end

@implementation GOLCellInteractor

- (instancetype)initWithCells:(NSArray <GOLCell *>*)cells {
    self = [super init];
    if (self) {
        _cells = cells;
    }
    return self;
}

+ (void)generateRandomCells:(NSArray <GOLCell *>*)cells {
    for (GOLCell *cell in cells) {
        NSNumber *number = @(arc4random_uniform(30));
        int cellStatus = number.intValue;
        if (cellStatus == 0) {
            cell.status = GOLCellStatusLive;
        } else {
            cell.status = GOLCellStatusDead;
        }
    }
}

- (void)determineNextStatusForCell:(GOLCell *)cell ByLiveNumber:(int)live deadNumber:(int)dead {
    if (cell.status == GOLCellStatusLive) {
        if (live < 2) {
            cell.nextStatus = GOLCellStatusDead;
        } else if (live == 2 || live == 3) {
            cell.nextStatus = GOLCellStatusLive;
        } else if (live > 3) {
            cell.nextStatus = GOLCellStatusDead;
        }
    } else if (cell.status == GOLCellStatusDead && live == 3) {
        cell.nextStatus = GOLCellStatusLive;
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

- (NSArray <GOLCell *>*)neighborsForCell:(GOLCell *)cell maxRow:(int)maxRow maxColumn:(int)maxColumn {
    NSMutableArray <GOLCell *>*cells = [NSMutableArray array];
    for (NSNumber *index in [self neighborIndiesForCell:cell WithMaxRowIndex:maxRow maxColumnIndex:maxColumn]) {
        if (index.intValue >= 0) [cells addObject:_cells[index.intValue]]; // 超出范围的 index.intValue = -1
    }
    return [cells copy];
}

- (NSArray <NSNumber *>*)neighborIndiesForCell:(GOLCell *)cell WithMaxRowIndex:(int)maxRowIndex maxColumnIndex:(int)maxColumnIndex {
    NSArray <NSNumber *>*result;
    int row = cell.position.row;
    int column = cell.position.column;
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

- (void)nextGenerationForCells:(NSArray <GOLCell *>*)cells withMaxRowCount:(int)maxRowCount maxColumnCount:(int)maxColumnCount {
    for (GOLCell *singleCell in cells) {
        NSArray *neighbors = [singleCell neighborCells:cells maxRow:maxRowCount maxColumn:maxColumnCount];
        [singleCell determineNextStatusByNeighbors:neighbors];
    }
}

@end
