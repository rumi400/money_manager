import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:money_manager/utils/utils.dart';

class ImageSelector extends StatelessWidget {
  final Function(XFile?) onSelectImage;
  const ImageSelector({Key? key, required this.onSelectImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async
      {
        final ImagePicker picker = ImagePicker();
        final XFile? image = await picker.pickImage(source: ImageSource.gallery);
        onSelectImage(image);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration:  BoxDecoration(
          border: Border.all(color: MyAppColors.primaryColor, width: 2),
          borderRadius: BorderRadius.circular(5)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            const Icon(Icons.camera_alt),
            const SizedBox(width: 15,),
            Text("Select Photo", style: TextStyle(color: MyAppColors.primaryColor),)
          ],
        ),
      ),
    );
  }
}
