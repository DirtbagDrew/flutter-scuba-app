class FacebookProfile {
  String firstName;
  String lastName;
  String email;
  String id;

  FacebookProfile(Map<String, dynamic> decodedJson) {
    firstName = decodedJson['first_name'];
    lastName = decodedJson['last_name'];
    email = decodedJson['email'];
    id = decodedJson['id'];
  }
}
