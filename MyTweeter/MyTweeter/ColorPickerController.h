//
//  ColorPickerController.h
//  MyTweeter
//
//  Created by Cialini, Matthew, John on 2/25/14.
//  Copyright (c) 2014 Cialini, Matthew, John. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorPickerController : UIViewController

@property (strong, nonatomic) IBOutlet UISlider *hueSlider;
@property (strong, nonatomic) IBOutlet UISlider *saturationSlider;
@property (strong, nonatomic) IBOutlet UISlider *brightnessSlider;
@property (strong, nonatomic) UIColor *hsb;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;

- (void)viewWillAppear:(BOOL)animated;

- (IBAction)changeHue:(id)sender;
- (IBAction)changeSaturation:(id)sender;
- (IBAction)changeBrightness:(id)sender;

@end
