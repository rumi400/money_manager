import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class WalletView extends StatelessWidget {
  const WalletView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.90,
            child: Stack(
              children: [
                MyAppBar(
                  centerTitle: true,
                  title:const Text("Income"),

                  leading:  IconButton(
                      splashRadius: 20,
                      onPressed: (){},
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.white,)
                  ),
                  actions:  const [
                    AppBarActionButton(
                        icon: Icon(Icons.notifications_outlined, color: Colors.white,)
                    )
                  ],
                ),
                Positioned(

                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: WalletCard(
                    width: MediaQuery.of(context).size.width,
                    height:MediaQuery.of(context).size.height * 0.65,

                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
