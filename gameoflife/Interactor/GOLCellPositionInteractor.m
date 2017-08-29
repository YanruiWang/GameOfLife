//
// Created by 王彦睿 on 2017/8/27.
// Copyright (c) 2017 王彦睿. All rights reserved.
//

#import "GOLCellPositionInteractor.h"


@implementation GOLCellPositionInteractor

+ (int)indexWithRow:(int)row column:(int)column maxRowIndex:(int)maxRowIndex maxColumnIndex:(int)maxColumnIndex {
    if (row < 0 || column < 0 || row > maxRowIndex || column > maxColumnIndex) {
        return -1;
    }
    return row * (maxColumnIndex + 1) + column;
}

@end