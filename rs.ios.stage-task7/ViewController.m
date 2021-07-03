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

@interface ViewController () <UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic) UILabel *logoLabel;
@property (nonatomic) UITextField *loginTextField;
@property (nonatomic) UITextField *passwordTextField;
@property (nonatomic) UIButton *authorizeButton;
@property (nonatomic) UIView *secureView;
@property (nonatomic) UIButton *firstSecureButton;
@property (nonatomic) UIButton *secondSecureButton;
@property (nonatomic) UIButton *thirdSecureButton;
@property (nonatomic) UILabel *resultSecureField;

@end

// MARK: - Keyboard category
@interface ViewController (KeyboardHandling)
- (void)subscribeOnKeyboardEvents;
//- (void)updateTopContraintWith:(CGFloat) constant andBottom:(CGFloat) bottomConstant;
- (void)hideWhenTappedAround;
@end

@implementation ViewController

// цветовая схема приложения
int colorBlackCoral = 0x4C5C68;
int colorTurquoiseGreen = 0x91C7B1;
int colorVenetianRed = 0xC20114;
int colorLittleBoyBlue = 0x80A4ED;

- (UILabel *)createLogo {
    
    CGFloat width = self.view.frame.size.width;  // определяем ширину экрана
    // создаем лого и настраиваем его
    UILabel * logoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, width, 36)];
    [logoLabel setText:@"RSSchool"];
    logoLabel.font = [UIFont systemFontOfSize:36 weight:UIFontWeightBold]; // системный жирный шрифт размера 36
    logoLabel.textAlignment = NSTextAlignmentCenter; // выравниваем текст по центру
    logoLabel.numberOfLines = 1;
    return logoLabel;
}

- (UITextField *)createLoginTextField {
    // создаем текстовое поле login
    UITextField * loginTextField = [[UITextField alloc] initWithFrame:CGRectMake(36, 160+36, 303, 34)];
    loginTextField.placeholder = @"Login";
    loginTextField.layer.borderWidth = 1.5;
    loginTextField.layer.borderColor = UIColorFromRGB(colorBlackCoral).CGColor; // цвет через hex значение, конвертируется в UIColor через macro
    loginTextField.layer.cornerRadius = 5.0;
    // добавляем левый внутренний отступ
    UIView *loginPaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 30)];
    loginTextField.leftView  = loginPaddingView;
    loginTextField.leftViewMode = UITextFieldViewModeAlways;
    // клавиатура с маленькой буквы:
    loginTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;

    return loginTextField;
}

-(UITextField *)createPasswordTextField {
    // создаем текстовое поле password
    UITextField * passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(36, 260, 303, 34)];
    passwordTextField.placeholder = @"Password";
    passwordTextField.layer.borderWidth = 1.5;
    passwordTextField.layer.borderColor = UIColorFromRGB(colorBlackCoral).CGColor; // цвет через hex значение, конвертируется в UIColor через macro
    passwordTextField.layer.cornerRadius = 5.0;
    // добавляем левый внутренний отступ
    UIView *passwordPaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 30)];
    passwordTextField.leftView  = passwordPaddingView;
    passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    // клавиатура с маленькой буквы:
    passwordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    return passwordTextField;
}

-(UIButton *)createAuthorizeButton {
    // создаем кнопку авторизации
    UIButton * authorizeButton = [[UIButton alloc] initWithFrame:CGRectMake(110, 350, 156, 42)];
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
    
    // добавляем ивент
    [authorizeButton addTarget:self
                             action:@selector(authorizeButtonTapped:)
                   forControlEvents:UIControlEventTouchUpInside];
    return authorizeButton;
}

- (void)customizaDisplay:(UIButton *)button {
    button.layer.borderWidth = 2;
    button.layer.borderColor = UIColorFromRGB(colorLittleBoyBlue).CGColor;
    button.layer.cornerRadius = 25;
    [button setTitleColor: UIColorFromRGB(colorLittleBoyBlue) forState: UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:24 weight:UIFontWeightSemibold];
    // вид кнопки для состояния highlighted
    button.clipsToBounds = YES;
    [button setBackgroundColor:UIColorFromRGBWithAlpha(colorLittleBoyBlue, 0.2) forState:UIControlStateHighlighted];
}

-(UILabel *)createResultSecureField {
    // создаем результирющее поле
    UILabel *resultSecureField = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 236, 45)];
    [resultSecureField setText:@"_"];
    resultSecureField.textAlignment = NSTextAlignmentCenter;
    resultSecureField.font = [UIFont systemFontOfSize:18 weight:UIFontWeightSemibold];
    
    //    secureView.layer.borderWidth = 2;
    //    secureView.layer.borderColor = UIColorFromRGB(colorTurquoiseGreen).CGColor;
    //    secureView.layer.borderColor = UIColorFromRGB(colorVenetianRed).CGColor;

    return resultSecureField;
}
-(UIView *)createSecureView {
    // создаем поле secure
    UIView * secureView = [[UIView alloc] initWithFrame:CGRectMake(69, 67+350+42, 236, 110)];
    secureView.layer.cornerRadius = 10.0;
    secureView.hidden = YES; // прячем вью до поры до времени
    return secureView;
}


// <------- VIEW DID LOAD ---------->
// <------- VIEW DID LOAD ---------->
// <------- VIEW DID LOAD ---------->

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor]; // устанавливаем цвет бэкграунда
    self.logoLabel = [self createLogo];
    [self.view addSubview:self.logoLabel]; // добавляем на вью
    
    self.loginTextField = [self createLoginTextField];
    [self.view addSubview:self.loginTextField]; // добавляем на вью

    self.passwordTextField = [self createPasswordTextField];
    [self.view addSubview:self.passwordTextField];

    self.authorizeButton = [self createAuthorizeButton];
    [self.view addSubview:self.authorizeButton];

    self.secureView = [self createSecureView];
    [self.view addSubview:self.secureView];
    
    self.resultSecureField = [self createResultSecureField];
    [self.secureView addSubview:self.resultSecureField]; // добавляем на secure вью
    
    // создаем secure кнопки 1, 2, 3
    self.firstSecureButton = [[UIButton alloc] initWithFrame:CGRectMake(23, 45, 50, 50)];
    [self.firstSecureButton setTitle:@"1" forState:UIControlStateNormal];
    
    self.secondSecureButton = [[UIButton alloc] initWithFrame:CGRectMake(93, 45, 50, 50)];
    [self.secondSecureButton setTitle:@"2" forState:UIControlStateNormal];
    
    self.thirdSecureButton = [[UIButton alloc] initWithFrame:CGRectMake(163, 45, 50, 50)];
    [self.thirdSecureButton setTitle:@"3" forState:UIControlStateNormal];
    NSArray *buttonArray = [[NSArray alloc] initWithObjects:self.firstSecureButton,self.secondSecureButton,self.thirdSecureButton,nil];
    for (UIButton *button in buttonArray) {
        [self customizaDisplay:button]; // настраиваем отображение кнопки
        [self.secureView addSubview:button]; // добавляем кнопку на вью
    }
    
    // Subscrube on keyboard events
    [self subscribeOnKeyboardEvents];
    [self hideWhenTappedAround];
    
    // назначем наш вью-контроллер делегатом
    self.loginTextField.delegate = self;
    self.passwordTextField.delegate = self;
}

- (void)authorizeButtonTapped:(UIButton *)sender {
    NSString * login = self.loginTextField.text;
    NSString * password = self.passwordTextField.text;

    if ([login isEqualToString:@"login"]) {
        NSLog(@"верный логин");
    } else {
        NSLog(@"логин не верный  %@", self.loginTextField.text);
    }


}

// MARK: - Delegates

// TextField
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [self.passwordTextField becomeFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSMutableCharacterSet *latinSet = [[NSMutableCharacterSet alloc] init];
    [latinSet addCharactersInRange:NSMakeRange('A', 'Z'-'A'+1)]; // Add uppercase
    [latinSet addCharactersInRange:NSMakeRange('a', 'z'-'a'+1)]; // Add lowercase
    NSArray * components = [string componentsSeparatedByCharactersInSet:latinSet];
    // чтобы работало удаление символов:
    if ([string length] == 0)
            return YES;
    
    if ([components count] > 1) {
        return YES;
    } else {
        return NO;
    }
}

//// TextView
//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
//    return ![text containsString:@"a"];
//}

@end


// MARK: - Keyboard category

@implementation ViewController (KeyboardHandling)

- (void)subscribeOnKeyboardEvents {
    // Keyboard will show
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(keybaordWillShow:)
                                               name:UIKeyboardWillShowNotification
                                             object:nil];
    // Keyboard will hide
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(keybaordWillHide:)
                                               name:UIKeyboardWillHideNotification
                                             object:nil];
}

- (void)hideWhenTappedAround {
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                               action:@selector(hide)];
    [self.view addGestureRecognizer:gesture];
}

- (void)hide {
    [self.view endEditing:true];
}

- (void)keybaordWillShow:(NSNotification *)notification {
    CGRect rect = [(NSValue *)notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];

    //[self updateTopContraintWith:15.0 andBottom:rect.size.height - self.view.safeAreaInsets.bottom + 15.0];
}

- (void)keybaordWillHide:(NSNotification *)notification {
    //[self updateTopContraintWith:200.0 andBottom:0.0];
}

//- (void)updateTopContraintWith:(CGFloat) constant andBottom:(CGFloat) bottomConstant {
//    // Change your constraint constants
//    self.topContraint.constant = constant;
//    self.bottomContraint.constant = bottomConstant;
//    [UIView animateWithDuration:0.2 animations:^{
//        [self.view layoutIfNeeded];
//    }];
//}

@end
