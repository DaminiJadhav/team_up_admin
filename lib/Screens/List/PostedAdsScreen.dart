import 'package:flutter/material.dart';
import 'package:teamupadmin/Screens/PostAdsScreen.dart';
class PostedAds extends StatefulWidget {
  @override
  _PostedAdsState createState() => _PostedAdsState();
}

class _PostedAdsState extends State<PostedAds> {
  String _imageUrl = "https://scontent.fpnq7-2.fna.fbcdn.net/v/t1.0-9/121732294_778416379557290_5841228350588989246_o.jpg?_nc_cat=104&_nc_sid=8bfeb9&_nc_ohc=anNZVN9g2v4AX8FQM5B&_nc_ht=scontent.fpnq7-2.fna&oh=ce2bb0fd069fa2551f6aa20f95641b9b&oe=5FAF203C";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ad's"),
      ),
      body: Container(
        child: ListView(
          children: [
            MainDesign(context, 'Big Billion Day sale', 'Flipkart Pvt Ltd Pune',"It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).",'gajanan@sdaemon.com','8099060708',_imageUrl),
            MainDesign(context, 'Big Billion Day sale', 'Flipkart Pvt Ltd Pune',"It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).",'gajanan@sdaemon.com','8099060708',_imageUrl),

          ],
        )
      ),
    );
  }
}
Widget MainDesign(BuildContext context,String adsHeading,String organizationName,String Content,String emailId,String mobileNumber,String imageUrl){
  return Card(
    clipBehavior: Clip.antiAlias,
    elevation: 20,
    child: Column(
      children: [
        Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                child: Icon(Icons.ac_unit),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                  child: Text(
                    adsHeading,
                    overflow: TextOverflow.ellipsis,
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left:40.0),
              child: Flexible(
                child: Text(organizationName,style: TextStyle(
                  fontSize: 16.0
                ),
                  overflow: TextOverflow.ellipsis,),
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 25.0,
            clipBehavior: Clip.antiAlias,
            shadowColor: Theme.of(context).primaryColor,
            child: GestureDetector(
              onTap: (){

              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 250.0,
                child: const DecoratedBox(
                  decoration: const BoxDecoration(
                      color: Colors.grey,
                      image: DecorationImage(
                          fit: BoxFit.contain,
                          image: NetworkImage("https://scontent.fpnq7-2.fna.fbcdn.net/v/t1.0-9/121732294_778416379557290_5841228350588989246_o.jpg?_nc_cat=104&_nc_sid=8bfeb9&_nc_ohc=anNZVN9g2v4AX8FQM5B&_nc_ht=scontent.fpnq7-2.fna&oh=ce2bb0fd069fa2551f6aa20f95641b9b&oe=5FAF203C")
                          //AssetImage('assets/Icons/select_image.png')
                      )
                  ),),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                  flex:1,child: Text(Content,maxLines: 4,)),
            ],
          ),
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.only(
              left: 8.0, right: 8.0, bottom: 16.0),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.email),
                    ),
                    GestureDetector(
                        onTap: () {
                          // print('Email Id click');
                        },
                        child: Text(emailId))
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.call),
                    ),
                    GestureDetector(
                        onTap: () {
                          // print('Mobile Number Click');
                        },
                        child: Text(mobileNumber))
                  ],
                ),
              ),
            ],
          ),
        ),


      ],
    ),
  );
}
