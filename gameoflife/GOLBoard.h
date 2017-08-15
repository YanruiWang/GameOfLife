//
//  GOLBoard.h
//  gameoflife
//
//  Created by 王彦睿 on 2017/8/14.
//  Copyright © 2017年 王彦睿. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GOLCell;

@interface GOLBoard : NSObject

@property (nonatomic, copy) NSArray <GOLCell *>*cells;

- (BOOL)isOneCell:(GOLCell *)oneCell neighborOfAnotherCell:(GOLCell *)anotherCell;

@end
