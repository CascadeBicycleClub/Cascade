//
//  DescriptionsViewController.m
//  Cascade-iOS-App
//
//  Created by iGuest on 3/28/15.
//  Copyright (c) 2015 Cascade. All rights reserved.
//

#import "DescriptionsViewController.h"

@interface DescriptionsViewController ()

@end

@implementation DescriptionsViewController
@synthesize routedb;

- (void)viewDidLoad {
    CGFloat selfViewWidth = self.view.frame.size.width;
    CGFloat selfViewHeight = self.view.frame.size.height;
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    //self.navigationController.navigationBar.backItem.title = @"Custom text";
    
    self.dm = [[DataManager alloc] init];
    UIImage *backgroundImage = [self.dm loadImage:[self.routedb valueForKey:@"title"]];
    //self.view.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    //[self.view setBackgroundColor:[UIColor colorWithPatternImage:backgroundImage]];
    
    
    //CGRect croprect = CGRectMake(0, 0 , backgroundImage.size.width, backgroundImage.size.width * 2.5);
    CGRect croprect = CGRectMake(backgroundImage.size.width/6, 0 , backgroundImage.size.height/2, backgroundImage.size.height);
     //Draw new image in current graphics context
    CGImageRef imageRef = CGImageCreateWithImageInRect([backgroundImage CGImage], croprect);
    UIImage *croppedImage = [UIImage imageWithCGImage:imageRef];
    
    /*
    UIGraphicsBeginImageContext(self.view.frame.size);
    [backgroundImage drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    */
    
    UIImageView * backgroundView  =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, selfViewWidth, selfViewHeight)];
    [backgroundView setImage:croppedImage];
    [self.view addSubview:backgroundView];
    //[self.view insertSubview:backgroundView belowSubview:self.routeTitleLabel];
    
    UILabel *routeTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, backgroundView.frame.size.height * 0.4, backgroundView.frame.size.width, backgroundView.frame.size.width/5)];
    routeTitleLabel.backgroundColor = [UIColor clearColor];
    routeTitleLabel.textColor = [UIColor whiteColor];
    [routeTitleLabel setTextAlignment:NSTextAlignmentCenter];
    routeTitleLabel.font = [UIFont boldSystemFontOfSize:23.0f];
    routeTitleLabel.numberOfLines = 2;
    routeTitleLabel.lineBreakMode = 0;
    
    UIImageView *descriptImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, backgroundView.frame.size.height * 0.6, backgroundView.frame.size.width, backgroundView.frame.size.height*0.4)];
    descriptImage.backgroundColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:0.5];
    [self.view addSubview:descriptImage];
    
    UILabel *routeDescriptLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, descriptImage.frame.size.width, descriptImage.frame.size.height)];
    routeDescriptLabel.backgroundColor = [UIColor clearColor];
    //routeDescriptLabel.backgroundColor
    [descriptImage addSubview:routeDescriptLabel];
    
    if (self.routedb) {
        routeTitleLabel.text = [self.routedb valueForKey:@"title"];
        [backgroundView addSubview:routeTitleLabel];
    }
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
