//
//  GOLBoard.m
//  gameoflife
//
//  Created by 王彦睿 on 2017/8/14.
//  Copyright © 2017年 王彦睿. All rights reserved.
//

#import "GOLBoard.h"
#import "GOLCellPosition.h"
#import "GOLCell.h"

@implementation GOLBoard

- (BOOL)isOneCell:(GOLCell *)oneCell neighborOfAnotherCell:(GOLCell *)anotherCell {
    return [oneCell.position isNeighborOfAnotherPosition:anotherCell.position];
}

@end
