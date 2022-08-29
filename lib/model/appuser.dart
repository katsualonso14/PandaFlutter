//ユーザの定義
class AppUser {
  late String name;
  late String uid;
  late String imagePath;
  late String lastMessage;
  late String? email;

  AppUser(
      {required this.name,
      required this.uid,
      required this.imagePath,
      required this.lastMessage,
      required this.email});
}
