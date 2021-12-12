class User{
  String id;
  String name;

  User.fromJson(Map<String,dynamic> map):name = map['shop_name'],id = map
  ['shop_id'];
}