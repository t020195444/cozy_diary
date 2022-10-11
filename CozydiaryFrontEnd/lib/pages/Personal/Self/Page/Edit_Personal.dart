import 'dart:io';
import 'package:flutter/material.dart';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../Data/dataResourse.dart';
import '../../userHeaderWidget.dart';

class Edit_PersonalPage extends StatefulWidget {
  const Edit_PersonalPage({
    Key? key,
  }) : super(key: key);

  @override
  State<Edit_PersonalPage> createState() => _Edit_PersonalPageState();
}

class _Edit_PersonalPageState extends State<Edit_PersonalPage> {
  late TextEditingController _nameController;
  late TextEditingController _IntroducionController;
  final GlobalKey<FormState> _nameFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _introductionFormKey = GlobalKey<FormState>();
  final _imagePicker = ImagePicker();
  late String? Oldname;
  late DateTime OldbirthDay;
  late String? birthDayText;
  late String? OldIntroduction;
  final birthday = PersonalValue_Map["birthDay"]!.split("-");
  late File? OldImage;
  late dynamic previewImage;
  @override
  void initState() {
    OldImage = UserHeaderImage;
    previewImage = UserHeaderImage != null
        ? FileImage(UserHeaderImage!)
        : NetworkImage(Image_List[3]);
    ;
    _nameController =
        TextEditingController(text: PersonalValue_Map["UserName"]);
    _IntroducionController =
        TextEditingController(text: PersonalValue_Map["Introduction"]);
    Oldname = PersonalValue_Map["UserName"];
    birthDayText = PersonalValue_Map["birthDay"];
    OldIntroduction = PersonalValue_Map["Introduction"];
    OldbirthDay = DateTime(
        int.parse(birthday[0]), int.parse(birthday[1]), int.parse(birthday[2]));
    super.initState();
  }

  Future<void> _openImagePicker() async {
    final XFile? pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      final image = File(pickedImage.path);
      OldImage = image;
      setState(() => previewImage = FileImage(image));
    } else {
      return;
    }
  }

  Widget nameTextField() {
    return TextFormField(
      autofocus: true,
      maxLength: 20,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onSaved: (String? value) => setState(() => Oldname = value!),
      controller: _nameController,
      style: TextStyle(color: Colors.black),
      textInputAction: TextInputAction.done,
      validator: (value) {
        if (value!.isEmpty) {
          return "請輸入姓名";
        }
        return null;
      },
    );
  }

  Widget nameTitle() {
    return ListTile(
        title: Text(
          Oldname!,
          style: TextStyle(color: Color.fromARGB(130, 0, 0, 0)),
        ),
        dense: true,
        trailing: Icon(
          Icons.keyboard_arrow_right_outlined,
          color: Colors.black,
        ),
        leading: Text(
          "姓名",
          style: TextStyle(color: Colors.black),
        ),
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Color.fromARGB(105, 0, 0, 0), width: 1),
            borderRadius: BorderRadius.circular(15)),
        tileColor: Colors.white,
        onTap: () {
          _nameController =
              TextEditingController(text: PersonalValue_Map["UserName"]);
          showFlexibleBottomSheet(
              context: context,
              builder: _buildNameBottomSheet,
              minHeight: 0,
              initHeight: 0.9,
              maxHeight: 0.9,
              isSafeArea: false);
        });
  }

  Widget _buildNameBottomSheet(
    BuildContext context,
    ScrollController scrollController,
    double bottomSheetOffset,
  ) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "取消",
            style: TextStyle(color: Colors.black),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              final isValid = _nameFormKey.currentState!.validate();
              if (isValid) {
                _nameFormKey.currentState!.save();
                Navigator.pop(context);
              }
            },
            child: Text(
              "確認",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
                child: Form(key: _nameFormKey, child: nameTextField()),
              ),
            ],
          )),
    );
  }

  Widget BirthDayTitle() {
    return ListTile(
        title: Text(
          birthDayText!,
          style: TextStyle(color: Color.fromARGB(130, 0, 0, 0)),
        ),
        dense: true,
        trailing: const Icon(
          Icons.keyboard_arrow_right_outlined,
          color: Colors.black,
        ),
        leading: const Text(
          "生日",
          style: TextStyle(color: Colors.black),
        ),
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Color.fromARGB(105, 0, 0, 0), width: 1),
            borderRadius: BorderRadius.circular(15)),
        tileColor: Colors.white,
        onTap: () async {
          DateTime? newDate = await showDatePicker(
              context: context,
              initialDate: OldbirthDay,
              firstDate: DateTime(DateTime.now().year - 100),
              lastDate: DateTime.now());

          if (newDate == null) return;
          setState(
              () => birthDayText = DateFormat("yyyy-MM-dd").format(newDate));
          OldbirthDay = newDate;
        });
  }

  Widget IntroductionTitle() {
    return Form(
      key: _introductionFormKey,
      child: TextFormField(
        validator: (value) {
          if (value!.length > 301) {
            return "字數需低於300個字";
          }
          return null;
        },
        onSaved: (String? value) {
          OldIntroduction = value!;
        },
        maxLines: 10,
        controller: _IntroducionController,
        maxLength: 300,
        decoration: InputDecoration(
            hintText: "打點什麼介紹自己吧~",
            hintStyle: TextStyle(color: Colors.black38),
            label: Text("簡介"),
            labelStyle: TextStyle(color: Colors.black, fontSize: 16),
            floatingLabelBehavior: FloatingLabelBehavior.always),
        style: TextStyle(color: Colors.black, fontSize: 14),
        textInputAction: TextInputAction.done,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          // leading: IconButton(
          //   icon: const Icon(Icons.chevron_left_outlined),
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          // ),
          actions: [
            TextButton(
              onPressed: () {
                final isValid = _introductionFormKey.currentState!.validate();
                if (isValid) {
                  _introductionFormKey.currentState!.save();
                  setState(() {
                    PersonalValue_Map.update(
                        "birthDay",
                        (value) =>
                            DateFormat('yyyy-MM-dd').format(OldbirthDay));
                    PersonalValue_Map["UserName"] = Oldname!;
                    PersonalValue_Map["Introduction"] = OldIntroduction!;
                    UserHeaderImage = OldImage;
                  });

                  Navigator.pop(context);
                }
              },
              child: Text(
                "確認",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
          title: const Text(
            '編輯個人資料',
            style: TextStyle(color: Colors.black54),
          ),
        ),
        body: ListView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                UserHeader(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  top: 0,
                  image: previewImage,
                ),
                TextButton(
                    onPressed: () {
                      _openImagePicker();
                    },
                    child: Text(
                      "點擊更換頭貼",
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ))
              ],
            ),
            // Divider(
            //   color: Color.fromARGB(132, 0, 0, 0),
            //   indent: MediaQuery.of(context).size.width * 0.05,
            //   endIndent: MediaQuery.of(context).size.width * 0.05,
            // ),
            Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                child: nameTitle()),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: BirthDayTitle(),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: IntroductionTitle(),
            )
          ],
        ));
  }
}
