//ユーザの定義
class AppUser {
  late String name;
  late String uid;
  late String imagePath;
  late String lastMessage;
  late String? email;

  // AppUser(String name, String uid, String imagePath, String lastMessage,
  //     String email, String password) {
  //   this.name = name;
  //   this.uid = uid;
  //   this.imagePath = imagePath;
  //   this.lastMessage = lastMessage;
  //   this.email = email;
  //   this.password = password;
  // }

  AppUser(
      {required this.name,
      required this.uid,
      required this.imagePath,
      required this.lastMessage,
      required this.email});
}
