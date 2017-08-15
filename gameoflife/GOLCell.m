//
//  GOLCell.m
//  gameoflife
//
//  Created by 王彦睿 on 2017/8/14.
//  Copyright © 2017年 王彦睿. All rights reserved.
//

#import "GOLCell.h"

@implementation GOLCell

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

- (NSArray <GOLCell *>*)neighorCells:(NSArray *)allCells {
    NSMutableArray <GOLCell *>*cells = [NSMutableArray array];
    int row = self.position.row;
    int column = self.position.column;
    for (GOLCell *cell in allCells) {
        if ([cell.position isNeighborOfAnotherPosition:self.position] && !(cell.position.row == row && cell.position.column == column)) {
            [cells addObject:cell];
        }
    }
    return [cells copy];
}

- (instancetype)init {
    if (self = [super init]) {
        _position = [[GOLCellPosition alloc] init];
        _status = GOLCellStatusDead;
    }
    return self;
}

@end
