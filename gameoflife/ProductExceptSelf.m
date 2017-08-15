//
//  ProductExceptSelf.m
//  gameoflife
//
//  Created by 王彦睿 on 2017/8/14.
//  Copyright © 2017年 王彦睿. All rights reserved.
//

#import "ProductExceptSelf.h"

static void swap(int *x, int *y);

int *moveZerosInternal(int *nums, int size, int *position);

int *productExceptSelf(int *nums, int size) {
    int *result = (int *)malloc(sizeof(int) * size);
    result[0] = 1;
    
    for (int i = 1; i < size; i++) {
        result[i] = result[i - 1] * nums[i - 1];
    }
    int right = 1;
    for (int i = size - 1; i >= 0; i--) {
        result[i] *= right;
        right *= nums[i];
    }
    return result;
}

int *moveZeros(int *nums, int size) {
    int position = 0;
    return moveZerosInternal(nums, size, &position);
}

int *moveZerosInternal(int *nums, int size, int *position) {
    int *result = nums;
    for (int i = *position; i < size; i++) {
        if (!*(nums + i)) {
            for (int j = i + 1; j < size; j++) {
                if (*(nums + j)) {
                    swap(nums + i, nums + j);
                    break;
                }
            }
            *position = i + 1;
            break;
        }
    }
    if (*position != size - 1) {
        moveZerosInternal(result, size, position);
    }
    
    return result;
}

void swap(int *x, int *y) {
    int temp;
    temp = *x;
    *x = *y;
    *y = temp;
}
