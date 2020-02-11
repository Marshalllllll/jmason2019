import 'package:firebase_database/firebase_database.dart';

class Toilet{
  String _key;
  dynamic useFlag;
  List <num> useFlagList;
  Toilet(this.useFlag);

  Toilet.fromsnapshot(DataSnapshot snapshot):
    _key = snapshot.key,
    useFlag = snapshot.value;
    toJson(){
      return{
        "useFlag": useFlag
      };
    }
}