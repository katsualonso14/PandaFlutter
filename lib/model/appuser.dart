//ユーザの定義
class AppUser {
  String _displayName;
  String _comment;

  AppUser(this._displayName,this._comment);

  String get displayName => _displayName;
  String get comment => _comment;
}
