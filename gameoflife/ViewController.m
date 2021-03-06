//
//  ViewController.m
//  gameoflife
//
//  Created by 王彦睿 on 2017/8/14.
//  Copyright © 2017年 王彦睿. All rights reserved.
//

#import "ViewController.h"
#import "GOLCollectionViewCell.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray <GOLCell *>*cells;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) UIButton *start;

@property (nonatomic, assign) BOOL gameRunning;

@property (nonatomic, assign) int rowCount;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _rowCount = 20;
    [self initUI];
}

- (void)initUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.alwaysBounceVertical = NO;
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[GOLCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    self.cells = [NSMutableArray array];
    for (int i = 0; i < _rowCount * _rowCount; i++) {
        GOLCell *cell = [[GOLCell alloc] init];
        cell.position.row = i / _rowCount;
        cell.position.column = i - (i / _rowCount) * _rowCount;
        [self.cells addObject:cell];
    }
    self.gameRunning = NO;
    self.start = [[UIButton alloc] init];
    [self.start setTitle:@"start" forState:UIControlStateNormal];
    [self.start addTarget:self action:@selector(startGame) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.start];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self initLayout];
}

- (void)dealloc {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)initLayout {
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[[self.collectionView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
            [self.collectionView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
            [self.collectionView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20],
            [self.collectionView.heightAnchor constraintEqualToAnchor:self.collectionView.widthAnchor]]];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;

    self.start.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[[self.start.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
            [self.start.topAnchor constraintEqualToAnchor:self.collectionView.bottomAnchor constant:40]]];
    [self.start setTintColor:[UIColor blueColor]];
    [self.start setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
}

- (void)startGame {
    if (self.gameRunning) {
        [self.timer invalidate];
        [self.start setTitle:@"start" forState:UIControlStateNormal];
    } else {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(nextGeneration) userInfo:nil repeats:YES];
        [self.start setTitle:@"stop" forState:UIControlStateNormal];
    }
    self.gameRunning = !self.gameRunning;
}


- (void)nextGeneration {
    for (GOLCell *cell in self.cells) {
        NSArray *neighbors = [cell neighborCells:self.cells maxRow:_rowCount maxColumn:_rowCount];
        [cell determineNextStatusByNeighbors:neighbors];
    }
    [self.collectionView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _rowCount;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _rowCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GOLCollectionViewCell *cell = (GOLCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    GOLCell *cellModel = self.cells[indexPath.section * _rowCount + indexPath.item];
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
    return CGSizeMake((int)collectionView.frame.size.width / _rowCount, (int)collectionView.frame.size.width / _rowCount);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    GOLCell *cellModel = self.cells[indexPath.section * _rowCount + indexPath.item];
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
