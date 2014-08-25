//
//  BNRHypnosisView.m
//  BNR-iOS-Hypnosister
//
//  Created by Kelvin Lee on 6/15/14.
//  Copyright (c) 2014 Kelvin. All rights reserved.
//

#import "BNRHypnosisView.h"

@interface BNRHypnosisView ()

// class extension, private property. Only used by BNRHypnosisView
@property (strong, nonatomic) UIColor *circleColor;

@end

@implementation BNRHypnosisView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        // all BNRHypnosisView start with clear background color
        self.backgroundColor = [UIColor clearColor];
        self.circleColor = [UIColor lightGrayColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGRect bounds = self.bounds;
    
    // figure out the center of the bounds rectangle
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    
    // The circle will be the largest that will fit in the view
//    float radius = (MIN(bounds.size.width, bounds.size.height) / 2.0);
    
    // the largest circle will circumscribe the view
    float maxRadius = hypot(bounds.size.width, bounds.size.height) / 2.0;
    
    // draw the circle
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    // add arc to the path at center, with radius of radius,
    // from 0 to 2 * PI radians (a circle)
//    [path addArcWithCenter:center radius:radius startAngle:0.0 endAngle:M_PI * 2.0 clockwise:YES];
    
    for (float currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20) {
        [path moveToPoint:CGPointMake(center.x + currentRadius, center.y)];
        
        [path addArcWithCenter:center radius:currentRadius
                    startAngle:0.0
                      endAngle:M_PI * 2.0
                     clockwise:YES];
    }
    
    // configure line width to 10 points
    path.lineWidth = 10;
    
    // configure the drawing color to light gray
//    [[UIColor lightGrayColor] setStroke];
    [self.circleColor setStroke];
    
    // draw the line
    [path stroke];
    
    NSLog(@"%f", center.x / 5);
    NSLog(@"%f", center.x * 3);
    
    // path for gradient, triangle
    UIBezierPath *gradientPath = [[UIBezierPath alloc] init];
    [gradientPath moveToPoint:CGPointMake(center.x, (center.y / 5))];
    [gradientPath addLineToPoint:CGPointMake((center.x / 2), center.y)];
    [gradientPath addLineToPoint:CGPointMake((center.x * 1.5), center.y)];
    [gradientPath addLineToPoint:CGPointMake(center.x, (center.y / 5))];
    gradientPath.lineWidth = 1;
    [[UIColor blackColor] setStroke];
    [gradientPath stroke];
    
    
    // save the current graphics context
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextSaveGState(currentContext);
    
    // clipping path for gradient
    [gradientPath addClip];
    
    // gold challenge
    // draw gradient
    CGFloat locations[2] = { 0.0, 1.0 };
    CGFloat components[8] = { 1.0, 0.0, 0.0, 1.0,
                            1.0, 1.0, 0.0, 1.0 };
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorspace, components, locations, 2);
    CGPoint startPoint;
    startPoint.x = center.x;
    startPoint.y = (center.y / 5);
    CGPoint endPoint;
    endPoint.x = center.x;
    endPoint.y = center.y;
    CGContextDrawLinearGradient(currentContext, gradient, startPoint, endPoint, 0);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);
    
    // restore the current graphics context after gradient
    CGContextRestoreGState(currentContext);
    
    // save the current graphics context
    // set the shadow for the logo
    CGContextSaveGState(currentContext);
    CGContextSetShadow(currentContext, CGSizeMake(4, 7), 3);
    
    // display the logo with shadow on top of the circles
    UIImage *logoImage = [UIImage imageNamed:@"logo.png"];
    CGRect logoRect = CGRectMake((bounds.size.width / 5), (bounds.size.height / 5), (logoImage.size.width / 2), (logoImage.size.height / 2));
    [logoImage drawInRect:logoRect];
    
    // restore the context after displaying logo
    CGContextRestoreGState(currentContext);
}

// when finger touches screen
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@ was touched", self);
    
    // get 3 random numbers between 0 and 1
    float red = (arc4random() % 100) / 100.0;
    float green = (arc4random() % 100) / 100.0;
    float blue = (arc4random() % 100) / 100.0;
    
    UIColor *randomColor = [UIColor colorWithRed:red
                                           green:green
                                            blue:blue
                                           alpha:1.0];
    self.circleColor = randomColor;
}

- (void)setCircleColor:(UIColor *)circleColor
{
    _circleColor = circleColor;
    [self setNeedsDisplay];
}

@end
