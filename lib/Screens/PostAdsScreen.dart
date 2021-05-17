import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PostAds extends StatefulWidget {
  @override
  _PostAdsState createState() => _PostAdsState();
}
class _PostAdsState extends State<PostAds> {
  bool _hasPoster = false;
  bool _hasContent = false;
  File _image;
  bool isImageLoad;

  @override
  void initState() {
    // TODO: implement initState
    isImageLoad=false;
    super.initState();

  }

  Future _imgFromCamera() async {
    File image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
      isImageLoad = true;
    });
  }

  Future _imgFromGallery() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      isImageLoad = true;
    });
  }
  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Gallary'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Post Ad's"),
      ),
      body: Container(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top:16.0,bottom: 16.0),
              child: Center(child: Text("Post Your Ad",style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0
              ),)),
            ),
            Padding(
              padding: const EdgeInsets.only(left:16.0,right:16.0,top: 16.0),
              child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Ad Heading',
                    labelText: 'Heading',
                    hintStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: new BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left:16.0,right:16.0,top: 8.0,bottom: 16.0),
              child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Organization Name',
                    labelText: 'Organization',
                    hintStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: new BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left:16.0,right: 16.0),
              child: Row(
                children: [
                  Expanded(
                      flex:2,
                      child: Text('Does this Ad has poster ?',style: TextStyle(
                    fontSize: 18.0
                  ),)),
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Text('No',style: TextStyle(
                          fontSize: 18.0
                        ),),
                        CupertinoSwitch(
                          value: _hasPoster,
                          onChanged: (value) {
                            setState(() {
                              _hasPoster = value;
                            });
                          },
                        ),
                        Text('Yes',style: TextStyle(
                          fontSize: 18.0
                        ),)
                      ],
                    ),
                  )


                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Visibility(
                visible: _hasPoster,
                child: GestureDetector(
                  onTap: (){
                    _showPicker(context);
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 250.0,
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                                image: isImageLoad ? FileImage(_image) : AssetImage('assets/icons/select_image.png'),
                                fit:BoxFit.contain
                            )
                        ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:16.0,right: 16.0),
              child: Row(
                children: [
                  Expanded(
                      flex:2,
                      child: Text('Does this Ad has Content ?',style: TextStyle(
                          fontSize: 18.0
                      ),)),
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Text('No',style: TextStyle(
                            fontSize: 18.0
                        ),),
                        CupertinoSwitch(
                          value: _hasContent,
                          onChanged: (value) {
                            setState(() {
                              _hasContent = value;
                            });
                          },
                        ),
                        Text('Yes',style: TextStyle(
                            fontSize: 18.0
                        ),)
                      ],
                    ),
                  ),

                ],
              ),
            ),
            Visibility(
              visible: _hasContent,
              child: Padding(
                padding: const EdgeInsets.only(left:16.0,right:16.0,top: 16.0),
                child: TextField(
                  maxLines: 5,
                    decoration: InputDecoration(
                      hintText: 'Ad Content',
                      labelText: 'Content',
                      hintStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: new BorderSide(
                          color: Colors.black,
                          width: 2.0,
                        ),
                      ),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:16.0,right:16.0,top: 16.0),
              child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Organization Email Id',
                    labelText: 'Email Id',
                    hintStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: new BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left:16.0,right:16.0,top: 8.0,bottom: 16.0),
              child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Organization Contact Number',
                    labelText: 'Contact No.',
                    hintStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: new BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left:16.0,right:16.0,top: 8.0,bottom: 16.0),
              child: GestureDetector(
                onTap: () {
                },
                child: Container(
                  height: 50.0,
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Center(
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20.0),
                    ),
                  ),
                ),
              ),
            )


          ],
        ),
      ),
    );
  }
}
