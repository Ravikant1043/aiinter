import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool shado=false;
  bool shado1=false;
  Widget build(BuildContext context) {
    double hi=MediaQuery.of(context).size.height;
    double wi=MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
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
        child:Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: hi*0.30,
                  width: double.infinity,
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Colors.purple.shade50,
                        Colors.purple.shade100,
                        Colors.purple.shade200,
                        Colors.purple.shade400,
                      ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,

                      ),
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(24),
                      ),

                    ),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: hi*0.14,),
                        Text("UserName", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                        SizedBox(height: 12,),
                        Text("email", style: TextStyle(fontWeight: FontWeight.bold),),
                        SizedBox(height: 20,),
                        InkWell(
                          onTap: (){
                            setState(() {
                              shado=!shado;
                            });
                          },
                          child: Container(
                            height: hi*0.05,
                            width: wi*.4,
                            decoration: BoxDecoration(
                              color: Colors.purple.shade400,
                              boxShadow: [
                                shado?BoxShadow(
                                    color: Colors.black26,
                                    spreadRadius: 3,
                                    blurRadius: 5,
                                    offset: Offset(4,4)
                                ):BoxShadow()
                              ],
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.black, width: 3),
                            ),
                            child: Center(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Logout', style: TextStyle(color: Colors.white),),
                                  Icon(Icons.logout, color: Colors.white,),
                                ],),
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        InkWell(
                          onTap: (){
                            shado1=!shado1;
                            setState(() {

                            });
                          },
                          child: Container(
                            height: hi*0.05,
                            width: wi*.4,
                            decoration: BoxDecoration(
                              color: Colors.purple.shade400,
                              boxShadow: [
                                shado1?BoxShadow(
                                    color: Colors.black26,
                                    spreadRadius: 3,
                                    blurRadius: 5,
                                    offset: Offset(4,4)
                                ):BoxShadow()
                              ],
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.black, width: 3),
                            ),
                            child:Center(child: Text("About App", style: TextStyle(color: Colors.white),)),
                          ),
                        )
                      ],
                    ),
                  ),
                ),

              ],
            ),
            Positioned(
              left: wi/3.4,
              top: hi*0.18,
              child:  Center(
                child:CircleAvatar(
                  radius: wi*0.22,
                ),
              ),),

          ],
        ),
      ),
    );
  }
}
