import 'package:flutter/material.dart';

class OrganizationDetails extends StatefulWidget {
  @override
  _OrganizationDetailsState createState() => _OrganizationDetailsState();
}

class _OrganizationDetailsState extends State<OrganizationDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Organization Details'),
      ),
      body: Container(
        child: ListView(
          children: [
            bodyContaint(context,'Sdaemon Infotech Pvt.Ltd','Software','https://www.sdaemon.com','8099060708','support@sdaemon.com','2020-10-10','2020-10-21'),

          ],
        ),
      ),
    );
  }
}
Widget bodyContaint(BuildContext context,String organizationName,String type,String webSite,String mobileNumber,String emailId,String contractFrom,String contractTo){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      child:Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: CircleAvatar(
                radius: 70.0,
                child: Icon(Icons.business,size: 90.0,),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(organizationName,style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0
            ),),
          ),
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left:8.0,right: 8.0,top: 4.0),
            child: Row(
              children: [
                Icon(Icons.business),
                Text('Organization Type: ',style: TextStyle(
                    fontSize: 18.0
                ),),
                Text(type,style: TextStyle(
                    fontSize: 18.0
                ),)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:8.0,right: 8.0,top: 8.0),
            child: Row(
              children: [
                Icon(Icons.language),
                Text('Website: ',style: TextStyle(
                    fontSize: 18.0
                ),),
                Text(webSite,style: TextStyle(
                    fontSize: 18.0
                ),)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:8.0,right: 8.0,top: 8.0),
            child: Row(
              children: [
                Icon(Icons.email),
                Text('Email Id : ',style: TextStyle(
                    fontSize: 18.0
                ),),

                GestureDetector(
                  onTap: (){},
                  child: Text(emailId,style: TextStyle(
                      fontSize: 18.0
                  ),),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:8.0,right: 8.0,top: 8.0),
            child: Row(
              children: [
                Icon(Icons.call),
                Text('Mobile Number: ',style: TextStyle(
                    fontSize: 18.0
                ),),

                GestureDetector(
                  onTap: (){},
                  child: Text(mobileNumber,style: TextStyle(
                      fontSize: 18.0
                  ),),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Divider(),
          SizedBox(
            height: 10.0,
          ),
          Text('Contract Details',style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0
          ),),
          Padding(
            padding: const EdgeInsets.only(left:8.0,right: 8.0,top: 16.0),
            child: Row(
              children: [
                Text('Form : ',style: TextStyle(
                    fontSize: 18.0
                ),),
                Text(contractFrom,style: TextStyle(
                    fontSize: 18.0
                ),)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:8.0,right: 8.0,top: 8.0),
            child: Row(
              children: [
                Text('To: ',style: TextStyle(
                    fontSize: 18.0
                ),),
                Text(contractTo,style: TextStyle(
                    fontSize: 18.0
                ),)
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Divider(),
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left:8.0,right: 8.0,top: 16.0,bottom: 16.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                    },
                    child: Container(
                      height: 40.0,
                      margin: EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.close,color: Colors.white,),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            'Suspend Contract',
                            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20.0),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ) ,
    ),
  );
}

