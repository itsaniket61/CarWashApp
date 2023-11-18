import 'package:car_wash_app/Constants/FirestoreConstants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:car_wash_app/Services/Database/DatabaseService.dart';

class FirestoreService implements DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<Map<String,dynamic>> addAppointment(Map<String, dynamic> data) async{
    try{
      await _firestore.collection(FirestoreConstants.APPOINTMENT_COLLECTION_NAME).doc().set(data);
      return data;
    }on FirebaseException catch(ex){
      throw("Error during inserting appointment ${ex.message??""}");
    }
  }

  @override
  Future<bool> deleteAppointment(String id) async{
    try{
      await _firestore.collection(FirestoreConstants.APPOINTMENT_COLLECTION_NAME).doc(id).delete();
      return true;
    }on FirebaseException catch(ex){
      throw("Error during deletion appointment ${ex.message??""}");
    }
  }

  @override
  Stream<List<Map<String, dynamic>>> getAppointment() {
    try{
      return _firestore.collection(FirestoreConstants.APPOINTMENT_COLLECTION_NAME).snapshots().map(
            (snapshot) => snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList(),
      );
    }on FirebaseException catch(ex){
      throw("Error during reading appointment ${ex.message??""}");
    }
  }

  @override
  Stream<Map<String, dynamic>> getOneAppointment(String id) {
    try{
      return _firestore.collection(FirestoreConstants.APPOINTMENT_COLLECTION_NAME).doc(id).snapshots().map(
            (snapshot) => snapshot.data() as Map<String,dynamic>
      );
    }on FirebaseException catch(ex){
      throw("Error during reading appointment ${ex.message??""}");
    }
  }

  @override
  Future<Map<String,dynamic>> updateAppointment(String id, Map<String, dynamic> updatedData) async{
    try{
      await _firestore.collection(FirestoreConstants.APPOINTMENT_COLLECTION_NAME).doc(id).update(updatedData);
      return updatedData;
    }on FirebaseException catch(ex){
      throw("Error during updating appointment ${ex.message??""}");
    }
  }
}