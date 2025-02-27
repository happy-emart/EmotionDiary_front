import 'package:flutter/material.dart';
import 'package:animated_login/animated_login.dart';
import 'package:async/async.dart';
import 'dialog_builders.dart';
import 'login_functions.dart' as logIn;

const seedColor = Color.fromARGB(49, 118, 118, 118);
/// Main function.
void main() {
  runApp(const MainApp());
}

/// Example app widget.
class MainApp extends StatelessWidget {
  /// Main app widget.
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated Login',
      theme: ThemeData(
          colorSchemeSeed: seedColor,
          fontFamily: 'bookk',
          ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (BuildContext context) => const LoginScreen(),
        '/forgotPass': (BuildContext context) => const ForgotPasswordScreen(),
      },
    );
  }
}

/// Example login screen
class LoginScreen extends StatefulWidget {
  /// Simulates the multilanguage, you will implement your own logic.
  /// According to the current language, you can display a text message
  /// with the help of [LoginTexts] class.
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  /// Example selected language, default is English.
  // LanguageOption language = _languageOptions[1];

  /// Current auth mode, default is [AuthMode.login].
  AuthMode currentMode = AuthMode.login;

  CancelableOperation? _operation;

  @override
  Widget build(BuildContext context) {
    return AnimatedLogin(
      onLogin: (LoginData data) async =>
          _authOperation(logIn.LoginFunctions(context).onLogin(data)),
      onSignup: (SignUpData data) async =>
          _authOperation(logIn.LoginFunctions(context).onSignup(data)),
      // onForgotPassword: _onForgotPassword,
      // logo: Image.asset('assets/images/fire2.gif'),
      // backgroundImage: 'assets/images/loginbackground.jpg',
      signUpMode: SignUpModes.both,
      // socialLogins: _socialLogins(context),
      loginDesktopTheme: _desktopTheme,
      loginMobileTheme: _mobileTheme,
      loginTexts: _loginTexts,
      passwordValidator: ValidatorModel(
          customValidator: (password) {
            return null;
          },
      ),
      // passwordValidator: ValidatorModel(
      //     checkUpperCase: false, checkNumber: true,
      //     // checkUpperCase: false, checkNumber: false, checkLowerCase: false, checkSpace: false, length: 1,
      //     validatorCallback: (String? password) => "비밀번호는 문자와 숫자를 모두 포함하고, 6자 이상이어야 합니다"),
      // nameValidator: ValidatorModel(
      //     checkUpperCase: false, checkNumber: false, checkLowerCase: false, checkSpace: false,
      //     validatorCallback: (String? name) => "옳지 않은 이름 양식입니다."),
      nameValidator: ValidatorModel(
          customValidator: (name) {
            return null;
          },
          validatorCallback: (String? name) => "옳지 않은 이름 양식입니다."),
      // emailValidator: ValidatorModel(
      //     validatorCallback: (String? email) => '옳지 않은 이메일 양식입니다'),
      emailValidator: ValidatorModel(
          customValidator: (password) {
            return null;
          },
      ),
      // changeLanguageCallback: (LanguageOption? _language) {
      //   if (_language != null) {
      //     DialogBuilder(context).showResultDialog(
      //         'Successfully changed the language to: ${_language.value}.');
      //     if (mounted) setState(() => language = _language);
      //   }
      // },
      // changeLangDefaultOnPressed: () async => _operation?.cancel(),
      // languageOptions: _languageOptions,
      // selectedLanguage: language,
      initialMode: currentMode,
      onAuthModeChange: (AuthMode newMode) async {
        currentMode = newMode;
        await _operation?.cancel();
      },
    );
  }

  Future<String?> _authOperation(Future<String?> func) async {
    await _operation?.cancel();
    _operation = CancelableOperation.fromFuture(func);
    final String? res = await _operation?.valueOrCancellation();
    // if (_operation?.isCompleted == true) {
    //   DialogBuilder(context).showResultDialog(res ?? '$res.');
    // }
    return res;
  }

  // Future<String?> _onForgotPassword(String email) async {
  //   await _operation?.cancel();
  //   return await LoginFunctions(context).onForgotPassword(email);
  // }

  // static List<LanguageOption> get _languageOptions => const <LanguageOption>[
  //       LanguageOption(
  //         value: 'Turkish',
  //         code: 'TR',
  //         iconPath: 'assets/images/apple.png',
  //       ),
  //       LanguageOption(
  //         value: 'English',
  //         code: 'EN',
  //         iconPath: 'assets/images/apple.png',
  //       ),
  //     ];

  /// You can adjust the colors, text styles, button styles, borders
  /// according to your design preferences for *DESKTOP* view.
  /// You can also set some additional display options such as [showLabelTexts].
  LoginViewTheme get _desktopTheme => _mobileTheme.copyWith(
        // To set the color of button text, use foreground color.
        actionButtonStyle: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.white),
        ),
        dialogTheme: const AnimatedDialogTheme(
          languageDialogTheme: LanguageDialogTheme(
              optionMargin: EdgeInsets.symmetric(horizontal: 80)),
        ),
        loadingSocialButtonColor: const Color(0xFF130101),
        loadingButtonColor: Colors.white,
        privacyPolicyStyle: const TextStyle(fontFamily: "bookk", color: Color(0xFF130101)),
        privacyPolicyLinkStyle: const TextStyle(fontFamily: "bookk", 
            color: Color(0xFF130101), decoration: TextDecoration.underline),
      );

  /// You can adjust the colors, text styles, button styles, borders
  /// according to your design preferences for *MOBILE* view.
  /// You can also set some additional display options such as [showLabelTexts].
  LoginViewTheme get _mobileTheme => LoginViewTheme(
        logoPadding: const EdgeInsets.all(20.0),
        logoSize: const Size(180, 180),
        welcomeTitleStyle: const TextStyle(
          fontFamily: "bookk",
          fontSize: 40,
        ),
        welcomeDescriptionStyle: const TextStyle(
          fontFamily: "bookk",
          fontSize: 25,
        ),
        changeActionTextStyle: const TextStyle(
          fontFamily: "bookk",
          fontSize: 20,
        ),
        useEmailStyle: const TextStyle(
          fontFamily: "bookk",
          fontSize: 18,
        ),
        actionButtonStyle: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(const Color(0xFF130101)),
          textStyle: MaterialStateProperty.all<TextStyle>(
            const TextStyle(
              fontFamily: "bookk",
              fontSize: 25,
            )
          )
        ),
        textFormStyle: const TextStyle(
          color: Colors.black87,
        ),
        showLabelTexts: false,
        backgroundColor: Colors.transparent, // const Color(0xFF6666FF),
        formFieldBackgroundColor: Colors.white,
        formWidthRatio: 60,
        // actionButtonStyle: ButtonStyle(
        //   foregroundColor: MaterialStateProperty.all(Color(0xFF130101)),
        // ),
        animatedComponentOrder: const <AnimatedComponent>[
          // AnimatedComponent(
          //   component: LoginComponents.logo,
          //   animationType: AnimationType.right,
          // ),
          AnimatedComponent(component: LoginComponents.title),
          AnimatedComponent(component: LoginComponents.description),
          AnimatedComponent(component: LoginComponents.formTitle),
          AnimatedComponent(component: LoginComponents.socialLogins),
          AnimatedComponent(component: LoginComponents.useEmail),
          AnimatedComponent(component: LoginComponents.form),
          AnimatedComponent(component: LoginComponents.notHaveAnAccount),
          // AnimatedComponent(component: LoginComponents.forgotPassword),
          // AnimatedComponent(component: LoginComponents.policyCheckbox),
          AnimatedComponent(component: LoginComponents.changeActionButton),
          AnimatedComponent(component: LoginComponents.actionButton),
        ],
        privacyPolicyStyle: const TextStyle(fontFamily: "bookk", color: Colors.white70),
        privacyPolicyLinkStyle: const TextStyle(fontFamily: "bookk", 
            color: Colors.white, decoration: TextDecoration.underline),
      );

  LoginTexts get _loginTexts => LoginTexts(
        nameHint: _username,
        login: _login,
        signUp: _signup,
        welcomeBack: "DAIRY",
        welcomeBackDescription: "하루에 한 번, 나만의 휴식",
        welcome: "DAIRY",
        welcomeDescription: "하루에 한 번, 나만의 휴식",
        signupEmailHint: '이메일을 입력해주세요',
        signupPasswordHint: '비밀번호를 입력해주세요',
        loginEmailHint: '이메일을 입력해주세요',
        loginPasswordHint: '비밀번호를 입력해주세요',
        confirmPasswordHint: '비밀번호를 다시 입력해주세요',
        notHaveAnAccount: '계정이 없으신가요?',
        alreadyHaveAnAccount: '계정이 있으신가요?',
        loginUseEmail: "카카오 또는 이메일로 로그인",
        signUpUseEmail: "카카오 또는 이메일로 가입",
      );

  /// You can adjust the texts in the screen according to the current language
  /// With the help of [LoginTexts], you can create a multilanguage scren.
  String get _username => '이름을 입력해주세요';

  String get _login => '로그인';

  String get _signup => '가입하기';

  /// Social login options, you should provide callback function and icon path.
  /// Icon paths should be the full path in the assets
  /// Don't forget to also add the icon folder to the "pubspec.yaml" file.
  
  // List<SocialLogin> _socialLogins(BuildContext context) => <SocialLogin>[
  //       SocialLogin(
  //           callback: () async => _socialCallback('Kakao'),
            // iconPath: 'assets/images/kakao4.png'),
        // SocialLogin(
        //     callback: () async => _socialCallback('Facebook'),
        //     iconPath: 'assets/images/apple.png'),
        // SocialLogin(
        //     callback: () async => _socialCallback('LinkedIn'),
        //     iconPath: 'assets/images/apple.png'),
      // ];

  // Future<String?> _socialCallback(String type) async {
  //   await _operation?.cancel();
  //   _operation = CancelableOperation.fromFuture(
  //       logIn.LoginFunctions(context).socialLogin(type));
  //   final String? res = await _operation?.valueOrCancellation();
  //   // if (_operation?.isCompleted == true && res == null) {
  //   //   DialogBuilder(context)
  //   //       .showResultDialog('Successfully logged in with $type.');
  //   // }
  //   return res;
  // }
}

/// Example forgot password screen
class ForgotPasswordScreen extends StatelessWidget {
  /// Example forgot password screen that user is navigated to
  /// after clicked on "Forgot Password?" text.
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('FORGOT PASSWORD'),
      ),
    );
  }
}

class ColorService {
  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}