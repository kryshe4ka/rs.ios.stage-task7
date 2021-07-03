//
//  UIButton+BackgroundColor.h
//  rs.ios.stage-task7
//
//  Created by Liza Kryshkovskaya on 3.07.21.
//

#import <UIKit/UIKit.h>

// добавляем категорию для класса UIButton с методом setBackgroundColor:forState:
@interface UIButton(BackgroundColor)
- (void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state;
@end
