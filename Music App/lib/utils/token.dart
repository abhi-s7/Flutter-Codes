import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Token {
  /*
  This token is sended by Firebase to Authenicate so inorder to use the login first time
  we must store the token in the Device itself
  3 options
  1. SharedPreference
  2. SQLite
  3. Secure Storage - this is better option of all as it encrypts it so that no one can read this token 
  From the file manager 
  */
  static FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  static generateToken(String token) async {
    await _secureStorage.write(key: "tokennum", value: token);
    //inside data/app/storage
  }

  //token internally converted into future
  static Future<String> readToken() async {
    String token = await _secureStorage.read(key: "tokennum");
    //this decrypts the token 
    return token;
  }
}
