
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices{

  FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> signUp(String Useremail, String UserPassword ) async {
    try{
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: Useremail,
          password: UserPassword
      );

    }
    catch(e){
      print("Error $e");
    }
  }
  Future<void> signIn(String UserMail, String Userpassword) async{
    try{
      await auth.signInWithEmailAndPassword(
          email: UserMail, password: Userpassword);
    }
    catch(e){
      print("Error in sign $e");
    }
  }
  Future<void> signOut () async{
    await auth.signOut();
  }
  User? getCurrentUSer () {
    return auth.currentUser;
  }

}