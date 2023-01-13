import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final int? index;
  final String? username;
  final String? email;
  final AssetImage? image;
  
  const Profile({Key? key, this.index, this.username, this.email, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width*0.50,
      decoration: const BoxDecoration(
        color: Colors.transparent
      ),
      child: Column(
        children: [
          Stack(

            children:   [
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.grey,
                child:CircleAvatar(
                    radius: 38,
                  backgroundImage: image,
                ),
              ),

            ],
          ),
          const SizedBox(height: 5,),
          Text(username!,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
          const SizedBox(height: 5,),
          Text(email!,style: TextStyle(fontSize: 12,color: Colors.teal.shade700),)
        ],
      ),
    );
  }
}
