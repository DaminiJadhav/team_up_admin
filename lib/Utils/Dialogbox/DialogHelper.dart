
import 'package:flutter/material.dart';
import 'package:teamupadmin/Utils/Dialogbox/ErrorDialog.dart';
import 'package:teamupadmin/Utils/Dialogbox/SuccessDialog.dart';

class DialogBoxHelper{
  static Success(context,title,message) => showDialog(context : context,builder :(context)=>SuccessDialog(title,message));
  static Error(context,title,message) => showDialog(context : context,builder :(context)=>ErrorDialog(title,message));

}