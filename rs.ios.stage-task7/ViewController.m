//
//  ViewController.m
//  rs.ios.stage-task7
//
//  Created by Liza Kryshkovskaya on 1.07.21.
//

#import "ViewController.h"
#import "UIButton+BackgroundColor.h"

// UIColor macro with hex values
#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
                green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
                 blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
                alpha: 1.0]

//RGB color macro with alpha
#define UIColorFromRGBWithAlpha(rgbValue, a) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

@interface ViewController ()

@end

@implementation ViewController

// цветовая схема приложения
int colorBlackCoral = 0x4C5C68;
int colorTurquoiseGreen = 0x91C7B1;
int colorVenetianRed = 0xC20114;
int colorLittleBoyBlue = 0x80A4ED;

- (void)createLogo {
    CGFloat width = self.view.frame.size.width;  // определяем ширину экрана
    // создаем лого и настраиваем его
    UILabel *logoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, width, 36)];
    [logoLabel setText:@"RSSchool"];
    logoLabel.font = [UIFont systemFontOfSize:36 weight:UIFontWeightBold]; // системный жирный шрифт размера 36
    logoLabel.textAlignment = NSTextAlignmentCenter; // выравниваем текст по центру
    logoLabel.numberOfLines = 1;
    [self.view addSubview:logoLabel]; // добавляем на вью
}

- (void)createLoginTextField {
    // создаем текстовое поле login
    UITextField *loginTextField = [[UITextField alloc] initWithFrame:CGRectMake(36, 196, 303, 34)];
    loginTextField.placeholder = @"Login";
    loginTextField.layer.borderWidth = 1.5;
    loginTextField.layer.borderColor = UIColorFromRGB(colorBlackCoral).CGColor; // цвет через hex значение, конвертируется в UIColor через macro
    loginTextField.layer.cornerRadius = 5.0;
    // добавляем левый внутренний отступ
    UIView *loginPaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 30)];
    loginTextField.leftView  = loginPaddingView;
    loginTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:loginTextField]; // добавляем на вью
}

-(void)createPasswordTextField {
    // создаем текстовое поле password
    UITextField *passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(36, 260, 303, 34)];
    passwordTextField.placeholder = @"Password";
    passwordTextField.layer.borderWidth = 1.5;
    passwordTextField.layer.borderColor = UIColorFromRGB(colorBlackCoral).CGColor; // цвет через hex значение, конвертируется в UIColor через macro
    passwordTextField.layer.cornerRadius = 5.0;
    // добавляем левый внутренний отступ
    UIView *passwordPaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 30)];
    passwordTextField.leftView  = passwordPaddingView;
    passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:passwordTextField]; // добавляем на вью
}

-(void)createAuthorizeButton {
    // создаем кнопку авторизации
    UIButton *authorizeButton = [[UIButton alloc] initWithFrame:CGRectMake(110, 320, 156, 42)];
    [authorizeButton setTitle:@"Authorize" forState: UIControlStateNormal];
    [authorizeButton setTitleColor: UIColorFromRGB(colorLittleBoyBlue) forState: UIControlStateNormal];
    authorizeButton.layer.borderColor = UIColorFromRGB(colorLittleBoyBlue).CGColor;
    authorizeButton.layer.borderWidth = 2.0;
    authorizeButton.layer.cornerRadius = 10.0; // скругляем
    authorizeButton.titleLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightSemibold]; // полужирный шрифт
    
    // вид кнопки для состояния highlighted
    [authorizeButton setTitleColor: UIColorFromRGBWithAlpha(colorLittleBoyBlue, 0.4) forState: UIControlStateHighlighted];
    authorizeButton.clipsToBounds = YES;
    [authorizeButton  setBackgroundColor:UIColorFromRGBWithAlpha(colorLittleBoyBlue, 0.2) forState:UIControlStateHighlighted];
    // вид кнопки для состояния disabled
    [authorizeButton setTitleColor: UIColorFromRGBWithAlpha(colorLittleBoyBlue, 0.5) forState: UIControlStateDisabled];
    if (!authorizeButton.enabled) {
        authorizeButton.layer.borderColor = UIColorFromRGBWithAlpha(colorLittleBoyBlue, 0.5).CGColor;
    } else {
        authorizeButton.layer.borderColor = UIColorFromRGBWithAlpha(colorLittleBoyBlue, 1.0).CGColor;
    }
    
    // в зависимости от версии оси отображаем системную картинку или png-шку, сделанную на ее основе
    if (@available(iOS 13.0, *)) {
        [authorizeButton setImage:[UIImage systemImageNamed:@"person"] forState:UIControlStateNormal];
        // вид кнопки для состояния highlighted
        [authorizeButton setImage:[UIImage systemImageNamed:@"person.fill"] forState: UIControlStateHighlighted];
        authorizeButton.imageView.tintColor = UIColorFromRGB(colorLittleBoyBlue);
        authorizeButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5.0); // добваляем 5px между иконкой и текстом кнопки
    } else {
        // Fallback on earlier versions
        [authorizeButton setImage:[UIImage imageNamed:@"person2x.png"] forState: UIControlStateNormal];
        // вид кнопки для состояния highlighted
        [authorizeButton setImage:[UIImage imageNamed:@"person-fill2x.png"] forState: UIControlStateHighlighted];
        authorizeButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 9.0); // добваляем 5px+4px между иконкой и текстом кнопки (+4px, так как в png картинке обрезаны отступы)
    }
    
    authorizeButton.contentEdgeInsets = UIEdgeInsetsMake(10.0, 20.0, 10.0, 20.0); // добавляем внутренние отступы
    [self.view addSubview:authorizeButton]; // добавляем на вью
}

-(void)createSecureView {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor]; // устанавливаем цвет бэкграунда
   
    [self createLogo];
    [self createLoginTextField];
    [self createPasswordTextField];
    [self createAuthorizeButton];
    [self createSecureView];
    
}

@end


