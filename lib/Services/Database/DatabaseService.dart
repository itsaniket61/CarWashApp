abstract class DatabaseService {
  // Add a new Record to the database
  Future<Map<String,dynamic>> addAppointment(Map<String, dynamic> data);

  // Read record from the database
  Stream<List<Map<String, dynamic>>> getAppointment();

  // Read selective record from the database
  Stream<Map<String, dynamic>> getOneAppointment(String id);

  // Update record from the database
  Future<Map<String,dynamic>> updateAppointment(String id, Map<String, dynamic> updatedData);

  // Delete record from the database
  Future<bool> deleteAppointment(String id);
}
