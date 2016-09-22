//
//  ViewController.m
//  ScrollBar and Thread demo
//
//  Created by Dishant Kapadiya on 8/29/16.
//  Copyright © 2016 Dishant Kapadiya. All rights reserved.
//

#import "ViewController.h"
#import "ScrollAndThreadDemoViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[ScrollAndThreadDemoViewController class]]) {
        ScrollAndThreadDemoViewController *nextView = (ScrollAndThreadDemoViewController *)segue.destinationViewController;
        nextView.title = segue.identifier;
        nextView.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://images.apple.com/v/iphone-5s/gallery/a/images/download/%@.jpg", segue.identifier]];
    }
}

@end
