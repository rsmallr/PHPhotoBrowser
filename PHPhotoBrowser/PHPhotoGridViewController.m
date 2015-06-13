//
//  PHPhotoGridViewController.m
//  PHPhotoBrowser
//
//  Created by Peni on 2015/6/13.
//  Copyright (c) 2015 Peni. All rights reserved.
//

#import "PHPhotoGridViewController.h"
#import "Game.h"
#import "UIImageView+AFNetworking.h"
#import "PHPhotoDetailViewController.h"
#import "UIAlertView+AFNetworking.h"

@interface PHPhotoGridCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImageView;

@end

@implementation PHPhotoGridCell

@end


@interface PHPhotoGridViewController ()

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;
@property (readwrite, nonatomic, strong) NSArray *games;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSIndexPath *selectedItemIndexPath;

@end

@implementation PHPhotoGridViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.loadingIndicator startAnimating];
    self.collectionView.alpha = 0.0f;
    
    __weak __typeof(self) tempSelf = self;
    NSURLSessionTask *task = [Game browseGamesWithBlock:^(NSArray *games, NSError *error) {
        if (!error) {
            tempSelf.games = games;
            [tempSelf.loadingIndicator stopAnimating];
            [tempSelf.collectionView reloadData];
            [UIView animateWithDuration:0.3
                             animations:^{
                                 self.collectionView.alpha = 1.0f;
                             }];
        }
    }];
    
    [UIAlertView showAlertViewForTaskWithErrorOnCompletion:task delegate:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"gotoPhotoDetailView"]) {
        PHPhotoDetailViewController *vc = segue.destinationViewController;
        vc.game = self.games[self.selectedItemIndexPath.item];
    }
}

#pragma mark - UICollectionView data source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.games.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PHPhotoGridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PHPhotoGridCell"
                                                                      forIndexPath:indexPath];
    Game *game = self.games[indexPath.item];
    [cell.thumbnailImageView setImageWithURL:game.thumbnailURL placeholderImage:[UIImage imageNamed:@"default-placeholder"]];
    
    return cell;
}

#pragma mark - UICollectionView delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedItemIndexPath = indexPath;
    [self performSegueWithIdentifier:@"gotoPhotoDetailView" sender:self];
}

@end
