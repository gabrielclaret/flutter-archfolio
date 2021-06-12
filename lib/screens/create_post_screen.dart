import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_archfolio/config/palette.dart';
import 'package:flutter_archfolio/config/settings.dart';
import 'package:flutter_archfolio/model/user_model.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostScreen extends StatefulWidget {
  final User user;
  const CreatePostScreen({Key key, this.user}) : super(key: key);
  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  File _image;
  File _thumbnail;
  final picker = ImagePicker();
  final thumbPicker = ImagePicker();

  TextEditingController _titleController;
  TextEditingController _descriptionController;
  final _formKey = GlobalKey<FormState>();
  static List<dynamic> contentList = ['text'];

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

  Future getThumb() async {
    final pickedThumb = await thumbPicker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedThumb != null) {
        _thumbnail = File(pickedThumb.path);
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
                inputFormatters: [
                  LengthLimitingTextInputFormatter(20),
                ],
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
                inputFormatters: [
                  LengthLimitingTextInputFormatter(150),
                ],
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
                'Thumbnail',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
              _thumbnail == null
                  ? Container(
                      child: Center(
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Palette.mainColorTheme)),
                          onPressed: getThumb,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Add Thumbnail',
                              style: const TextStyle(
                                color: Palette.mainTextColorTheme,
                                fontSize: 18.0,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: getThumb,
                      child: Center(
                        child: CircleAvatar(
                          radius: 80.0,
                          backgroundColor: Colors.grey[200],
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(0.0),
                            child: Container(
                              height: double.infinity,
                              width: double.infinity,
                              decoration: new BoxDecoration(
                                color: const Color(0xff7c94b6),
                                image: new DecorationImage(
                                  image: FileImage(_thumbnail),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: new BorderRadius.all(
                                    const Radius.circular(0.0)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
              Text(
                'Add content',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
              ..._getContent(),
              Container(
                child: Center(
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Palette.mainColorTheme)),
                    onPressed: () async {
                      await _createPost(
                          contentList.reversed.toList(),
                          widget.user.id,
                          _titleController,
                          _descriptionController,
                          _thumbnail);
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

  List<Widget> _getContent() {
    List<Widget> contentFields = [];
    List<Widget> newContentFields = [];

    for (int i = 0; i < contentList.length; i++) {
      if (contentList[i].runtimeType.toString() == 'String') {
        contentFields.add(Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            children: [
              Expanded(child: ContentTextFields(i)),
              SizedBox(
                width: 10,
              ),
              _addRemoveButton(i == 0, i),
            ],
          ),
        ));
      } else {
        contentFields.add(Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            children: [
              Expanded(child: Text('hello its me mario')),
              SizedBox(
                width: 10,
              ),
              _addRemoveButton(i == 0, i),
            ],
          ),
        ));
      }
    }
    newContentFields = contentFields.reversed.toList();
    return newContentFields;
  }

  Widget _addRemoveButton(bool add, int index) {
    return InkWell(
      onTap: () {},
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
              onSelected: (value) async {
                print(value);
                if (value) {
                  contentList.insert(index, 'text');
                  setState(() {});
                } else {
                  await getImage();
                  contentList.insert(index, _image);
                }
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

_createPost(
    List<dynamic> contentList,
    int authorId,
    TextEditingController titleController,
    TextEditingController descriptionController,
    File thumbnail) async {
  var dio = Dio();
  dio.options.baseUrl = Uri.http(Settings.apiUrl, 'archfolio/v1').toString();

  var body_text = new Map<String, dynamic>();
  body_text['author'] = authorId;
  body_text['title'] = titleController.text;
  body_text['description'] = descriptionController.text;
  body_text['tags'] = ['cool', 'notags'];
  print(body_text);

  var formData = new FormData.fromMap({
    'text': json.encode(body_text),
    'file': await MultipartFile.fromFile(thumbnail.path, filename: 'thumbnail')
  });

  Response responsePost = await dio.post('/posts', data: formData);
  int postId = responsePost.data['id'];
  int dispositionOrder = 0;
  for (var content in contentList) {
    if (content.runtimeType.toString() == 'String') {
      var body_text = new Map<String, dynamic>();
      body_text['content'] = content;
      body_text['disposition_order'] = dispositionOrder;
      var formData = new FormData.fromMap({
        'text': json.encode(body_text),
      });
      Response response =
          await dio.post('/posts/$postId/metadatas', data: formData);
    } else {
      var body_text = new Map<String, dynamic>();
      body_text['disposition_order'] = dispositionOrder;
      var formData = new FormData.fromMap({
        'text': json.encode(body_text),
        'file': await MultipartFile.fromFile(content.path,
            filename: 'metadata$dispositionOrder')
      });
      Response response =
          await dio.post('/posts/$postId/metadatas', data: formData);
    }
    dispositionOrder += 1;
  }

  // var formData = FormData.fromMap({
  //   'text': json.encode(body_text),
  //   'file': await MultipartFile.fromFile(pfp.path, filename: 'pfp$userId')
  // });

  // Response response = await dio.patch('/users/$userId', data: formData);
  // return User.fromJson(jsonDecode(response.toString()));
}
