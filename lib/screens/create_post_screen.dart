import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_archfolio/config/palette.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostScreen extends StatefulWidget {
  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  File _image;
  final picker = ImagePicker();

  TextEditingController _titleController;
  TextEditingController _descriptionController;
  final _formKey = GlobalKey<FormState>();
  static List<String> contentList = [null];

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool _addText = false;
    bool _addImage = false;
    List<String> list = [
      'Lorem  aliqua. Ut enim ad minim veniamconsectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum',
      "My Name is",
      "Gabriel"
    ];

    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Palette.cardTheme,
        title: Text(
          'create post',
          key: const Key('createScreenText'),
          style: const TextStyle(
            color: Palette.mainColorTheme,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.9,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              TextFormField(
                style: TextStyle(fontWeight: FontWeight.bold),
                cursorColor: Palette.mainColorTheme,
                controller: _titleController,
                decoration: InputDecoration(
                  hoverColor: Palette.mainColorTheme,
                  hintText: "Title",
                  fillColor: Palette.scaffold,
                  filled: true,
                ),
                validator: (v) {
                  if (v.trim().isEmpty) return 'Please enter something';
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                cursorColor: Palette.mainColorTheme,
                decoration: InputDecoration(
                  hoverColor: Palette.mainColorTheme,
                  hintText: "Description",
                  fillColor: Palette.scaffold,
                  filled: true,
                ),
                controller: _descriptionController,
                validator: (v) {
                  if (v.trim().isEmpty) return 'Please enter something';
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Add content',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
              ..._getcontent(),
              Container(
                child: Center(
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Palette.mainColorTheme)),
                    onPressed: () {
                      print('hey');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Create Post',
                        style: const TextStyle(
                          color: Palette.mainTextColorTheme,
                          fontSize: 18.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // i can try and make this with text + image, just try to make the contenttextfields but for images.
  List<Widget> _getcontent() {
    List<Widget> contentTextFields = [];
    for (int i = 0; i < contentList.length; i++) {
      contentTextFields.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            Expanded(child: ContentTextFields(i)),
            SizedBox(
              width: 10,
            ),
            _addRemoveButton(i == contentList.length - 1, i),
          ],
        ),
      ));
    }
    return contentTextFields;
  }

  Widget _addRemoveButton(bool add, int index) {
    return InkWell(
      onTap: () {
        if (add) {
          contentList.insert(0, null);
        } else
          contentList.removeAt(index);
        setState(() {});
      },
      child: add
          ? PopupMenuButton(
              key: const Key('addContentButton'),
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: (add) ? Palette.mainColorTheme : Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  (add) ? Icons.add : Icons.remove,
                  color: Colors.white,
                ),
              ),
              onSelected: (value) {
                if (value) {
                  contentList.insert(0, null);
                  setState(() {});
                  print('text');
                } else
                  getImage();
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  key: const Key('addTextPopup'),
                  value: true,
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                        child: Icon(Icons.text_fields),
                      ),
                      Text('Text')
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: false,
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                        child: Icon(Icons.image),
                      ),
                      Text('Image')
                    ],
                  ),
                ),
              ],
            )
          : InkWell(
              key: const Key('removeContentButton'),
              onTap: () {
                contentList.removeAt(index);
                setState(() {});
              },
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  Icons.remove,
                  color: Colors.white,
                ),
              ),
            ),
    );
  }
}

class ContentTextFields extends StatefulWidget {
  final int index;
  ContentTextFields(this.index);
  @override
  _ContentTextFieldsState createState() => _ContentTextFieldsState();
}

class _ContentTextFieldsState extends State<ContentTextFields> {
  TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _nameController.text =
          _CreatePostScreenState.contentList[widget.index] ?? '';
    });

    return TextFormField(
      key: Key('contentTextField'),
      controller: _nameController,
      onChanged: (v) => _CreatePostScreenState.contentList[widget.index] = v,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
      ),
      autofocus: false,
      minLines: 1,
      maxLines: null,
      keyboardType: TextInputType.text,
      validator: (v) {
        if (v.trim().isEmpty) return 'Please enter something';
        return null;
      },
    );
  }
}
