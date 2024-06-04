import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:friendszone_app/resources/auth_methods.dart';
import 'package:friendszone_app/responsive/web_screen_layout.dart';
import 'package:friendszone_app/responsive/responsive_layout_screen.dart';
import 'package:friendszone_app/responsive/mobile_screen_layout.dart';
import 'package:friendszone_app/screens/signup_screen.dart';
import 'package:friendszone_app/utils/colors.dart';
import 'package:friendszone_app/utils/utils.dart';
import 'package:friendszone_app/widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();

  }

  void loginUser() async{
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
      email: _emailController.text, 
      password: _passwordController.text);

      if(res == "success"){
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const ResponsiveLayout(
              mobileScreenLayout: MobileScreenLayout(),
              webScreenLayout: WebScreenLayout(),
            ),
          ),
        );
      } else{
        
        showSnackBar(res, context);
      }
      setState(() {
      _isLoading = false;
    });
  }

void NavigateToSignup() {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => const SignupScreen(),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea( 
       child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Flexible(child: Container(), flex: 2),
          SvgPicture.asset(
            'assets/Text_Logo.svg', 
            color: primaryColor,
             height: 64),
             const SizedBox(height: 64),
             TextFieldInput(hintText: 'Enter your email', textInputType: 
             TextInputType.emailAddress, 
             textEditingController: _emailController,),
             const SizedBox(height: 22),
             TextFieldInput(hintText: 'Enter your Password', textInputType: 
             TextInputType.text, 
             textEditingController: _passwordController,
             isPass: true,
             ),
             const SizedBox(height: 22),
             InkWell(
              onTap: loginUser,
               child: Container(
                child: _isLoading ? const Center(child: CircularProgressIndicator(),) : const Text('Log in'),
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const ShapeDecoration(shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4),
                  )
                ),
                color: blueColor
                ),
               ),
             ),
             SizedBox(height: 12),
            Flexible(child: Container(), flex: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text("Don't have an account?"),
                  padding: const EdgeInsets.symmetric(
                    vertical: 8
                  ),
                ),
                GestureDetector(
                  onTap: NavigateToSignup,
                  child: Container(
                    child: const Text("Sign Up", style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),),
                    padding: const EdgeInsets.symmetric(
                      vertical: 8
                    ),
                  ),
                )
              ],
            )
          ],
          
        ),
       ), 
      )
    );
  }
}