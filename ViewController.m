//
//  ViewController.m
//  motionDemo
//
//  Created by liushuai on 2017/9/8.
//  Copyright © 2017年 liushuai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIAccelerometerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (assign) CGFloat time;
@property (assign) NSInteger count;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.timeLabel.text = @"0.00";
    self.time = 0;
    self.count = 0;
    
    UIAccelerometer *accelerometer = [UIAccelerometer sharedAccelerometer];
    accelerometer.delegate = self;
    accelerometer.updateInterval =  1.0f/60.0f;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (IBAction)startAction:(id)sender {

    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(updateTimeLabel) userInfo:nil repeats:YES];
//    UIButton *btn = (UIButton *)sender;
//    [btn setEnabled:NO];
}
- (IBAction)stopAction:(id)sender {
    [self.timer setFireDate:[NSDate distantFuture]];
    self.timer = nil;
}
- (IBAction)clearAction:(id)sender {
    self.timeLabel.text = @"0.00";
}

- (void)updateTimeLabel {
    
    self.time += 0.01;
    self.timeLabel.text = [NSString stringWithFormat:@"%.2f",self.time];
}

//- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
//    if (motion == UIEventSubtypeMotionShake) {
//        self.count ++;
//        self.countLabel.text = [NSString stringWithFormat:@"%ld 次",self.count];
//    }
//}

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration{
    
    // 三轴摇晃的G力超过２则 列入计次
    if (fabsf(acceleration.x)>2.0 || fabsf(acceleration.y)>2.0|| fabsf(acceleration.z)>2.0){
        self.count++;
        self.countLabel.text = [NSString stringWithFormat:@"%ld 次",self.count/5];
        NSLog(@"摇晃");
    }
}

@end
