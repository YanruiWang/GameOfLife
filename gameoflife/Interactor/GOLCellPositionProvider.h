//
// Created by 王彦睿 on 2017/8/27.
// Copyright (c) 2017 王彦睿. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GOLCellPositionProvider <NSObject>

+ (int)indexWithRow:(int)row column:(int)column maxRowIndex:(int)maxRowIndex maxColumnIndex:(int)maxColumnIndex;

@end