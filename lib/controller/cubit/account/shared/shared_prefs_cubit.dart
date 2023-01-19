import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_currency/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'shared_prefs_states.dart';

class SharedPCubit extends Cubit<SharedPStates>{

  SharedPCubit(): super(InitialSharedPState());

  static SharedPCubit get(context) => BlocProvider.of<SharedPCubit>(context);

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool? isLoggedIn = false;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  UserModel? userModel;

  storeInSharedPrefs({bool? logState}) async{
    final SharedPreferences prefs = await _prefs;
    if(logState == true){
      prefs.setBool('loggedIn', true);
      isLoggedIn = true;
      emit(SetIsLoggedInValueTrueState());
    }else {
      prefs.setBool('loggedIn', false);
      isLoggedIn = false;
      emit(SetIsLoggedInValueFalseState());
    }
  }

  setUserDataInPrefs({String? email, String? name, String? photo, String? id})async{
    final SharedPreferences prefs = await _prefs;
    prefs.setString('email', email!);
    prefs.setString('name', name!);
    prefs.setString('photo', photo!);
    prefs.setString('id', id!);
    emit(SetUserDataInPrefs());
  }

  getUserDataInPrefs()async{
    final SharedPreferences prefs = await _prefs;
    var response = await firebaseFirestore.collection('users').doc(prefs.getString('id')).get();
    //print('-----------------------------------------${response.data()}');
    userModel = UserModel.fromJson(response.data());
    emit(GetUserDataInPrefs());
  }

  getFromSharedPrefs()async{
    final SharedPreferences prefs = await _prefs;
    isLoggedIn = prefs.getBool('loggedIn');
    emit(SetIsLoggedInValueState());
    if(prefs.getBool('loggedIn')! == true){
      emit(LoggedInState());
    }
    else {
      emit(SignedOutState());
    }
  }
}