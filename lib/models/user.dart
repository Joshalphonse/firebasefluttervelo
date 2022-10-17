class User {
  static const String Avatar1 =
      'https://static.wixstatic.com/media/7bdcd4_0d1e566d72e74985b799ccc17431ac3b~mv2.png';
  static const String Avatar2 =
      'https://static.wixstatic.com/media/7bdcd4_8ff1899c57f9423dac4da464c275b29f~mv2.png';
  static const String Avatar3 =
      'https://static.wixstatic.com/media/7bdcd4_1a68ac8c267b4f4db1554b67b8c780b0~mv2.png';
  static const String Avatar4 =
      'https://static.wixstatic.com/media/7bdcd4_4ac7dc7e305147f6aed9641c4713a2f8~mv2.png';
  static const String Avatar5 =
      'https://static.wixstatic.com/media/7bdcd4_4b3388196a6648bcbbfc32baee4ef5f0~mv2.png';
  String firstName = '';
  String lastName = '';
  String email = '';
  String phone = '';
  Map avatars = {
    Avatar1: false,
    Avatar2: false,
    Avatar3: false,
    Avatar4: false,
    Avatar5: false
  };
    bool newsletter = false;
  String programmingLangs = '';
  String interests = '';
  save() {
    print('saving user using a web service');
  }
}
enum ProfileAvatars { avatar1, avatar2, avatar3, avatar4, avatar5 }
