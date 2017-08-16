//
//  ViewController.m
//  gameoflife
//
//  Created by 王彦睿 on 2017/8/14.
//  Copyright © 2017年 王彦睿. All rights reserved.
//

#import "ViewController.h"
#import "ProductExceptSelf.h"
#import "GOLCollectionViewCell.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray <NSNumber *>*status;

@property (nonatomic, strong) NSMutableArray <GOLCell *>*cells;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) UIButton *start;

@property (nonatomic, assign) BOOL gameRunning;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSTimeInterval date1 = [NSDate date].timeIntervalSince1970;
//    int r[] = {1,2,3,4};
//    int *s = productExceptSelf(r, 4);
//    NSTimeInterval date2 = [NSDate date].timeIntervalSince1970;
//    NSLog(@"%f", date2 - date1);
//    for (int i = 0; i < 4; i++) {
//        NSLog(@"array index %d : %d", i, *(s + i));
//    }
//    int r[] = {0, 1, 0, 3, 12, 34, 0, 0, 77};
//    int *s = moveZeros(r, 9);
//    for (int i = 0; i < 9; i++) {
//        NSLog(@"array index %d : %d", i, *(s + i));
//    }
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.alwaysBounceVertical = NO;
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[GOLCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    self.status = [NSMutableArray array];
    self.cells = [NSMutableArray array];
    for (int i = 0; i < 400; i++) {
//        NSNumber *number = @(arc4random_uniform(30));
//        [self.status addObject:number];
//        int cellStatus = number.intValue;
        GOLCell *cell = [[GOLCell alloc] init];
//        if (cellStatus == 0) {
//            cell.status = GOLCellStatusLive;
//        } else {
//            cell.status = GOLCellStatusDead;
//        }
        cell.position.row = i / 20;
        cell.position.column = i - (i / 20) * 20;
        [self.cells addObject:cell];
    }
    self.gameRunning = NO;
    self.start = [[UIButton alloc] init];
    [self.start setTitle:@"start" forState:UIControlStateNormal];
    [self.start addTarget:self action:@selector(startGame) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.start];
    
    
//
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[[self.collectionView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor], [self.collectionView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor], [self.collectionView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20], [self.collectionView.heightAnchor constraintEqualToAnchor:self.collectionView.widthAnchor]]];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.start.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[[self.start.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor], [self.start.topAnchor constraintEqualToAnchor:self.collectionView.bottomAnchor constant:40]]];
    [self.start setTintColor:[UIColor blueColor]];
    [self.start setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
}

- (void)startGame {
    if (self.gameRunning) {
        [self.timer invalidate];
        [self.start setTitle:@"start" forState:UIControlStateNormal];
    } else {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(nextGeneration) userInfo:nil repeats:YES];
        [self.start setTitle:@"stop" forState:UIControlStateNormal];
    }
    self.gameRunning = !self.gameRunning;
}


- (void)nextGeneration {
    for (GOLCell *cell in self.cells) {
        NSArray *neighors = [cell neighorCells:self.cells];
        [cell determineNextStatusByNeighbors:neighors];
    }
    [self.collectionView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 400;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GOLCollectionViewCell *cell = (GOLCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    GOLCell *cellModel = self.cells[indexPath.item];
    cellModel.status = cellModel.nextStatus;
    if (cellModel.status == GOLCellStatusLive) {
        cell.backgroundColor = [UIColor blackColor];
    } else {
        cell.backgroundColor = [UIColor whiteColor];
    }
    cell.layer.borderWidth = 1;
    cell.layer.borderColor = [[UIColor grayColor] CGColor];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((int)collectionView.frame.size.width / 20, (int)collectionView.frame.size.width / 20);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    GOLCell *cellModel = self.cells[indexPath.item];
    if (cellModel.status == GOLCellStatusDead) {
        cellModel.status = GOLCellStatusLive;
        GOLCollectionViewCell *cell = (GOLCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        cell.backgroundColor = [UIColor blackColor];
        cell.cell.status = GOLCellStatusLive;
    } else {
        cellModel.status = GOLCellStatusDead;
        GOLCollectionViewCell *cell = (GOLCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        cell.cell.status = GOLCellStatusLive;
        cell.backgroundColor = [UIColor whiteColor];
    }
    cellModel.nextStatus = cellModel.status;
    [collectionView reloadData];
}


@end
