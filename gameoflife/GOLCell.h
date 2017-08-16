//
//  GOLCell.h
//  gameoflife
//
//  Created by 王彦睿 on 2017/8/14.
//  Copyright © 2017年 王彦睿. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GOLCellPosition.h"

typedef NS_ENUM(NSUInteger, GOLCellStatus) {
    GOLCellStatusDead = 0,
    GOLCellStatusLive = 1
};

@interface GOLCell : NSObject

@property (nonatomic, assign) GOLCellStatus status;

@property (nonatomic, assign) GOLCellStatus nextStatus;

@property (nonatomic, strong) GOLCellPosition *position;

- (void)determineNextStatusByLiveNumber:(int)live deadNumber:(int)dead;

- (NSArray <GOLCell *>*)neighorCells:(NSArray *)allCells maxRow:(int)maxRow maxColumn:(int)maxColumn;

- (void)determineNextStatusByNeighbors:(NSArray <GOLCell *>*)cells;

- (instancetype)init;

@end
