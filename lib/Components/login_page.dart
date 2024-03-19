import 'package:aiinterview/Components/page_no_1.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin  {

  List<String> tabs = ["Login", "Register"];
  late TabController _tabController = TabController(length: 2, vsync: this);

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    var h=size.height;
    var w=size.width;
    return Scaffold(
      body: Container(
        height: h,
        width: w,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Colors.purple.shade50,
                Colors.purple.shade100,
                Colors.purple.shade200,
                Colors.purple.shade400,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight
          ),
        ),
        child: Center(
          child: SizedBox(
            height: h/2 +20,
            width: w-40,
            child: Container(
              decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(color: Colors.black54,spreadRadius: 1,blurRadius: 5,offset: Offset(4,4))
                ],
                gradient: LinearGradient(
                  colors: [
                    Colors.purple.shade50,
                    Colors.purple.shade100,
                    Colors.purple.shade200,
                    Colors.purple.shade400,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,

                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                    child: TabBar(
                      physics: NeverScrollableScrollPhysics(),
                      isScrollable: false,
                      dividerColor: Colors.blue,
                      controller: _tabController,
                      unselectedLabelColor: Colors.deepPurple[900],
                      indicatorColor: Colors.purple.shade400,
                      indicatorWeight: 3,
                      indicatorSize: TabBarIndicatorSize.label,
                      labelColor: Colors.black,
                      tabs: tabs.map((String tab) => Tab(text: tab)).toList(),
                      labelStyle: TextStyle(
                        fontSize: 20
                      ),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: _tabController,
                      children:[
                        LoginTab(),
                        RegisterPage(),
                      ]
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void showCustomSnackBar(BuildContext context, String string, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      content: Container(
        child: Text(string, style: TextStyle(
          color: color == Colors.red ? Colors.black : Colors.white,
          fontWeight: FontWeight.bold,
        ),
        ),
      ),
      behavior: SnackBarBehavior.values[1],
    ),
  );
}

class LoginTab extends StatefulWidget {
  LoginTab({super.key});
  @override
  State<LoginTab> createState() => _LoginTabState();
}
OutlineInputBorder colourchange(Color col){
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(
          color:col
      )
  );
}
class _LoginTabState extends State<LoginTab> {
  bool click=false;
  TextEditingController name=TextEditingController();
  TextEditingController password=TextEditingController();
  GlobalKey<FormState> key=GlobalKey();
  bool loggedIn=false;


  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn) {
      setState(() {
        loggedIn = true;
      });
    }
  }

  Future<void> login() async{
    try{
      final FirebaseAuth auth = FirebaseAuth.instance;
      await auth.signInWithEmailAndPassword(email: name.text, password: password.text);
      showCustomSnackBar(context, "Successfully Login", Colors.green);
      setState(() {
        loggedIn = true;
      });
      // final prefs = await SharedPreferences.getInstance();
      // prefs.setBool('isLoggedIn', true); // Store login status locally
      // Navigator.push(context, MaterialPageRoute(builder: (context) => FirstPage1(),));
    }
    catch(e){
      print(e);
      showCustomSnackBar(context,"Wrong Credentials",Colors.red);
    }
  }

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: key,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                validator: (val){
                  if (val == null || val.isEmpty) {
                    return 'Please Enter your userid';
                  }
                  return null;
                },
                controller: name,
                  decoration: InputDecoration(
                    focusColor: Colors.white,
                    hintText: "UserID",
                    border: colourchange(Colors.red),
                    focusedBorder: colourchange(Colors.purple)
                  ),
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: password,
                validator: (val){
                  if (val == null || val.isEmpty) {
                    return 'Please Enter your Password';
                  }
                  return null;
                },
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  focusedBorder: colourchange(Colors.purple)
                ),
              ),
            ),
            SizedBox(height: 30,),
            Center(
              child: InkWell(
                onTap: (){
                  if(key.currentState!.validate()){
                  //      code for forward
                    login();
                  }
                  setState(() {
                    click=!click;
                  });
                },
                child: Container(
                  height: 45,
                  width: 140,
                  decoration: BoxDecoration(
                      color: Colors.purple.shade400,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.purple.shade700),
                      boxShadow: [
                        !click?BoxShadow(
                            color: Colors.black45,
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(2,4)
                        ):BoxShadow(
                            color: Colors.black45,
                            blurRadius: 2,
                            offset: Offset(-2,-4)
                        ),
                      ]
                  ),
                  child: Center(child: Text("Login")),
                ),
              ),
            ),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool click=false;
  TextEditingController name=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  TextEditingController confirmpassword=TextEditingController();
  GlobalKey<FormState> key=GlobalKey();


  Future<void> Register() async{
    try{
      final FirebaseAuth auth = FirebaseAuth.instance;
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.text, password: password.text);
      showCustomSnackBar(context, "Registered Sucessfully", Colors.green);
      name.clear();
      email.clear();
      password.clear();
      confirmpassword.clear();
    }
    catch(e){
      print(e);
      showCustomSnackBar(context,e.toString(),Colors.orange);
    }
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: key,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                validator: (val){
                  if (val == null || val.isEmpty) {
                    return 'Please Enter your userid';
                  }
                  return null;
                },
                controller: name,
                decoration: InputDecoration(
                    focusColor: Colors.white,
                    hintText: "User-name",
                    border: colourchange(Colors.red),
                    focusedBorder: colourchange(Colors.purple)
                ),
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                validator: (val){
                  if (val == null || val.isEmpty) {
                    return 'Please Enter your Email';
                  }
                  return null;
                },
                controller: email,
                decoration: InputDecoration(
                    focusColor: Colors.white,
                    hintText: "Email",
                    border: colourchange(Colors.red),
                    focusedBorder: colourchange(Colors.purple)
                ),
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                validator: (val){
                  if (val == null || val.isEmpty) {
                    return 'Please Enter your Password';
                  }
                  return null;
                },
                controller: password,
                obscureText: true,
                decoration: InputDecoration(
                    focusColor: Colors.white,
                    hintText: "Password",
                    border: colourchange(Colors.red),
                    focusedBorder: colourchange(Colors.purple)
                ),
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                validator: (val){
                  if(password.text!=confirmpassword.text){
                    // showCustomSnackBar(context, "Password doesn;t match", Colors.redAccent);
                    return "Password doesn;t match";
                  }
                  if (val == null || val.isEmpty) {
                    return 'Confirm Password';
                  }
                  return null;
                },
                controller: confirmpassword,
                obscureText: true,
                decoration: InputDecoration(
                    focusColor: Colors.white,
                    hintText: "Confirm Password",
                    border: colourchange(Colors.red),
                    focusedBorder: colourchange(Colors.purple)
                ),
              ),
            ),
            SizedBox(height: 15,),
            Center(
              child: InkWell(
                onTap: (){
                  if(key.currentState!.validate() && password.text==confirmpassword.text){
                    Register();
                  }
                  setState(() {
                    click=!click;
                  });
                },
                child: Container(
                  height: 45,
                  width: 140,
                  decoration: BoxDecoration(
                      color: Colors.purple.shade300,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.purple.shade900),
                      boxShadow: [
                        !click?BoxShadow(
                            color: Colors.black45,
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(2,4)
                        ):BoxShadow(),
                      ]
                  ),
                  child: Center(child: Text("Register")),
                ),
              ),
            ),
            SizedBox(height: 15,),
          ],
        ),
      ),
    );
  }
}
