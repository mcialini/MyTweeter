//
//  ColorPickerController.m
//  MyTweeter
//
//  Created by Cialini, Matthew, John on 2/25/14.
//  Copyright (c) 2014 Cialini, Matthew, John. All rights reserved.
//

#import "ColorPickerController.h"
#import "MyTabBarController.h"


@implementation ColorPickerController

@synthesize hueSlider;
@synthesize saturationSlider;
@synthesize brightnessSlider;
@synthesize hsb;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hueSlider.value = 1.0;
        self.saturationSlider.value = 0.1;
        self.brightnessSlider.value = 1.0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIColor *myColor = [UIColor colorWithHue:self.hueSlider.value saturation:self.saturationSlider.value brightness:self.brightnessSlider.value alpha:1.0];
    [self.view setBackgroundColor:myColor];
}



- (void)viewWillAppear:(BOOL)animated {
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeHue:(id)sender {
    self.hsb = [UIColor colorWithHue:self.hueSlider.value saturation:self.saturationSlider.value brightness:self.brightnessSlider.value alpha:1.0];
    [self.view setBackgroundColor:self.hsb];
    MyTabBarController *tabBar = (MyTabBarController *)self.tabBarController;
    tabBar.bgColor = hsb;
}
- (IBAction)changeSaturation:(id)sender {
    self.hsb = [UIColor colorWithHue:self.hueSlider.value saturation:self.saturationSlider.value brightness:self.brightnessSlider.value alpha:1.0];
    [self.view setBackgroundColor:self.hsb];
    MyTabBarController *tabBar = (MyTabBarController *)self.tabBarController;
    tabBar.bgColor = hsb;

}
- (IBAction)changeBrightness:(id)sender {
    self.hsb = [UIColor colorWithHue:self.hueSlider.value saturation:self.saturationSlider.value brightness:self.brightnessSlider.value alpha:1.0];
    [self.view setBackgroundColor:self.hsb];
    MyTabBarController *tabBar = (MyTabBarController *)self.tabBarController;
    tabBar.bgColor = hsb;

}

@end
