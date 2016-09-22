//
//  ScrollAndThreadDemoViewController.m
//  ScrollBar and Thread demo
//
//  Created by Dishant Kapadiya on 8/29/16.
//  Copyright © 2016 Dishant Kapadiya. All rights reserved.
//

#import "ScrollAndThreadDemoViewController.h"

@interface ScrollAndThreadDemoViewController() <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityMoniter;

@end

@implementation ScrollAndThreadDemoViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.scrollView addSubview:self.imageView];
}

-(void)setImageURL:(NSURL *)imageURL
{
    _imageURL = imageURL;
    //self.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.imageURL]];
    [self startDownloadingImage];
}

-(void)startDownloadingImage
{
    self.image = nil;
    
    if(self.imageURL)
    {
        [self.activityMoniter startAnimating];
        NSURLRequest *request = [NSURLRequest requestWithURL:self.imageURL];
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if(!error) {
                if([request.URL isEqual:self.imageURL]){
                    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
                    dispatch_async(dispatch_get_main_queue(), ^{self.image = image;});
                }
            }
        }];
        [task resume];
    }
}

-(void)setImage:(UIImage *)image
{
    self.imageView.image = image;
    self.scrollView.contentSize = self.image ? self.image.size : CGSizeZero;
    [self.imageView sizeToFit];
    [self.activityMoniter stopAnimating];
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

-(void)setScrollView:(UIScrollView *)scrollView
{
    _scrollView = scrollView;
    _scrollView.minimumZoomScale = 0.2;
    _scrollView.maximumZoomScale = 2;
    _scrollView.delegate = self;
    
    self.scrollView.contentSize = self.image ? self.image.size : CGSizeZero;
}

-(UIImageView *)imageView
{
    if (!_imageView) _imageView = [[UIImageView alloc] init];
    return _imageView;
}

-(UIImage *)image
{
    return [self.imageView image];
}

@end
