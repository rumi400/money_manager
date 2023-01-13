import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/widgets/widgets.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children:  [
            SizedBox(
              height: 310,
              child: Stack(
                //alignment: Alignment.bottomCenter,
                children:[
                  MyAppBar(
                    centerTitle: true,
                    leading: IconButton(
                      onPressed: (){},
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                    title: const Text("Profile"),
                    actions: [
                      OutlinedButton(
                        style:  ButtonStyle(
                            maximumSize: const MaterialStatePropertyAll(Size(50,40)),
                            minimumSize:const MaterialStatePropertyAll(Size(50,40)),
                            foregroundColor:const MaterialStatePropertyAll(Colors.white),
                            backgroundColor: MaterialStatePropertyAll(Colors.teal.shade700),
                            surfaceTintColor:const MaterialStatePropertyAll(Colors.white)
                        ),
                        onPressed: (){},
                        child: const Icon(CupertinoIcons.bell),)
                    ],
                  ),
                  const Align(
                    alignment: Alignment.bottomCenter,
                    child: Profile(
                      image: AssetImage("assets/images/profile.jpg"),
                      username: "Abdullah",
                      email: "rumi124@gmail.com",
                    ),
                  )
                ]
              ),
            ),

            const SizedBox(height: 10,),
            MyListTile(
              leading: const Icon(Icons.diamond),
              title: const Text("Invite Friends"),
              onPressed: (){},
            ),
            MyListTile(
              leading: const Icon(Icons.person),
              title: const Text("Account Info"),
              onPressed: (){},
            ),
            MyListTile(
              leading: const Icon(Icons.people),
              title: const Text("Personal Profile"),
              onPressed: (){},
            ),
            MyListTile(
              leading: const Icon(Icons.mail),
              title: const Text("Message Center"),
              onPressed: (){},
            ),
            MyListTile(
              leading: const Icon(Icons.security),
              title: const Text("Login & Security"),
              onPressed: (){},
            ),
            MyListTile(
              leading: const Icon(Icons.lock),
              title: const Text("Data Privacy"),
              onPressed: (){},
            ),
            const SizedBox(height: 10,),

          ],
        ),
      ),
    );
  }
}
