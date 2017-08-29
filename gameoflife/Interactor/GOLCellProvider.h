//
//  GOLCellProvider.h
//  gameoflife
//
//  Created by 王彦睿 on 2017/8/27.
//  Copyright © 2017年 王彦睿. All rights reserved.
//

#import "GOLCell.h"

@protocol GOLCellProvider <NSObject>

+ (void)generateRandomCells:(NSArray <GOLCell *> *)cells;

- (void)determineNextStatusByLiveNumber:(int)live deadNumber:(int)dead;

- (NSArray <GOLCell *>*)neighborCells:(NSArray *)allCells maxRow:(int)maxRow maxColumn:(int)maxColumn;

- (void)determineNextStatusByNeighbors:(NSArray <GOLCell *>*)cells;

@end


