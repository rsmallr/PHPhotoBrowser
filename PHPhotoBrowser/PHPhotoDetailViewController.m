//
//  PHPhotoDetailViewController.m
//  PHPhotoBrowser
//
//  Created by Peni on 2015/6/13.
//  Copyright (c) 2015 Peni. All rights reserved.
//

#import "PHPhotoDetailViewController.h"

@interface PHPhotoDetailViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionLabel;

@end

@implementation PHPhotoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = self.game.gameName;
    self.descriptionLabel.text = self.game.gameDescription;
}

@end
