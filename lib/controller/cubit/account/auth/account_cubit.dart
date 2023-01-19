import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../model/user_model.dart';
import 'account_states.dart';

class AccountCubit extends Cubit<AccountStates> {
  AccountCubit() : super(CoinsInitial());

  static AccountCubit get(context) => BlocProvider.of<AccountCubit>(context);

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  GoogleSignIn? googleSignIn = GoogleSignIn();
  ImagePicker imagePicker = ImagePicker();

  UserModel registerUser = UserModel();
  XFile? userImage;

  signInByGoogle() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await googleSignIn!.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );
      var user = await auth.signInWithCredential(authCredential);
      emit(RegisterSuccessEmail());
      try {
        registerUser.id = user.user!.uid;
        registerUser.name = googleSignInAccount.displayName;
        registerUser.email = googleSignInAccount.email;
        registerUser.photo = googleSignInAccount.photoUrl;
        await firebaseFirestore
            .collection('users')
            .doc(registerUser.id)
            .set(registerUser.toJson());

        emit(SaveDataToFireStoreEmail());
      } catch (e2) {
        emit(ErrorDataToFireStoreEmail());
      }
    } catch (e) {
      emit(RegisterFailedEmail());
    }
  }

  registerByEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(RegisterSuccessEmail());
      try {
        registerUser.name = name;
        registerUser.email = email;
        registerUser.password = password;
        registerUser.id = credential.user!.uid;
        /*await firebaseStorage
            .ref()
            .child("photos/")
            .child("${registerUser.id}.png")
            .putFile(File(userImage!.path));
        registerUser.photo = await firebaseStorage
            .ref()
            .child("photos/")
            .child("${registerUser.id}.png")
            .getDownloadURL();*/
        await firebaseFirestore
            .collection('users')
            .doc(registerUser.id)
            .set(registerUser.toJson());
        emit(SaveDataToFireStoreEmail());
      } catch (e2) {
        emit(ErrorDataToFireStoreEmail());
      }
    } catch (e) {
      emit(RegisterFailedEmail());
    }
  }

  login({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      DocumentSnapshot<Map<String, dynamic>> snapshot = await firebaseFirestore
          .collection('users')
          .doc(credential.user!.uid)
          .get();
      registerUser = UserModel.fromJson(snapshot.data());
      emit(LoginSuccessfully());
    } catch (e) {
      emit(FailedToLogin());
    }
    /* getUsers();
    emit(UsersSecured());*/
  }

  images({required String source}) async {
    emit(LoadingImageState());
    if (source == "cam") {
      userImage = await imagePicker.pickImage(source: ImageSource.camera);
      try {
        await firebaseStorage
            .ref()
            .child("photos/")
            .child("${registerUser.id}.png")
            .putFile(File(userImage!.path));
        registerUser.photo = await firebaseStorage
            .ref()
            .child("photos/")
            .child("${registerUser.id}.png")
            .getDownloadURL();
        await firebaseFirestore.collection('users').doc(registerUser.id).set(registerUser.toJson());
        emit(SuccessfullyStoredImage());
      } catch (e) {
        print('error : $e');
        emit(FailedToStoreImage());
      }

      return userImage!.readAsBytes();
    } else {
      userImage = await imagePicker.pickImage(source: ImageSource.gallery);
      try {
        await firebaseStorage
            .ref()
            .child("photos/")
            .child("${registerUser.id}.png")
            .putFile(File(userImage!.path));
        registerUser.photo = await firebaseStorage
            .ref()
            .child("photos/")
            .child("${registerUser.id}.png")
            .getDownloadURL();
        await firebaseFirestore.collection('users').doc(registerUser.id).set(registerUser.toJson());
        emit(SuccessfullyStoredImage());
      } catch (e) {
        print('error : $e');
        emit(FailedToStoreImage());
      }
      return userImage!.readAsBytes();
    }
  }

  logOut()async{
    await auth.signOut();
    emit(SignOutState());
  }


}
