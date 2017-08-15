//
//  ProductExceptSelf.h
//  gameoflife
//
//  Created by 王彦睿 on 2017/8/14.
//  Copyright © 2017年 王彦睿. All rights reserved.
//

#import <Foundation/Foundation.h>

int *productExceptSelf(int *nums, int size);

/**
 * 将数组中的 0 移至最后, 比如  [0, 1, 0, 3, 12] -> [1, 3, 12, 0, 0]
 * 移动步骤:
 * [0, 1, 0, 3, 12]
 * [1, 0, 0, 3, 12]
 * [1, 3, 0, 0, 12]
 * [1, 3, 12, 0, 0]
 *
 * 使用方式:
 * int *result = moveZeros(originArray, orginArraySize);
 */

int *moveZeros(int *nums, int size);


