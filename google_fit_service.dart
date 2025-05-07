import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/fitness/v1.dart' as fitness;
import 'package:googleapis_auth/googleapis_auth.dart';
import 'package:http/http.dart' as http;

class GoogleFitService {
  static const List<String> SCOPES = [fitness.FitnessApi.fitnessActivityReadScope];

  Future<AuthClient?> getAuthenticatedClient() async {
    final GoogleSignInAccount? account = await GoogleSignIn(scopes: SCOPES).signIn();
    if (account == null) return null;

    final GoogleSignInAuthentication auth = await account.authentication;
    final AccessCredentials credentials = AccessCredentials(
      AccessToken("Bearer", auth.accessToken!, DateTime.now().add(Duration(hours: 1))),
      null,
      SCOPES,
    );

    return authenticatedClient(http.Client(), credentials);
  }

  Future<int?> getHeartRate(fitness.FitnessApi fitnessApi, DateTime startTime, DateTime endTime) async {
    try {
      var response = await fitnessApi.users.dataset.aggregate(
        "me" as fitness.AggregateRequest,
        fitness.AggregateRequest(
          aggregateBy: [fitness.AggregateBy(dataTypeName: "com.google.heart_rate.bpm")],
          bucketByTime: fitness.BucketByTime(durationMillis: "60000"),  // Convert to String
          startTimeMillis: startTime.millisecondsSinceEpoch.toString(),  // Convert to String
          endTimeMillis: endTime.millisecondsSinceEpoch.toString(),  // Convert to String
        ) as String,
      );

      if (response.bucket != null && response.bucket!.isNotEmpty) {
        for (var bucket in response.bucket!) {
          if (bucket.dataset != null && bucket.dataset!.isNotEmpty) {
            for (var dataset in bucket.dataset!) {
              if (dataset.point != null && dataset.point!.isNotEmpty) {
                for (var point in dataset.point!) {
                  if (point.value != null && point.value!.isNotEmpty) {
                    return point.value!.first.fpVal?.toInt();
                  }
                }
              }
            }
          }
        }
      }
    } catch (e) {
      print("Error fetching heart rate: $e");
    }
    return null;
  }

  Future<int?> getStepCount(fitness.FitnessApi fitnessApi, DateTime startTime, DateTime endTime) async {
    try {
      var response = await fitnessApi.users.dataset.aggregate(
        "me" as fitness.AggregateRequest,
        fitness.AggregateRequest(
          aggregateBy: [fitness.AggregateBy(dataTypeName: "com.google.step_count.delta")],
          bucketByTime: fitness.BucketByTime(durationMillis: "60000"),  // Convert to String
          startTimeMillis: startTime.millisecondsSinceEpoch.toString(),  // Convert to String
          endTimeMillis: endTime.millisecondsSinceEpoch.toString(),  // Convert to String
        ) as String,
      );

      if (response.bucket != null && response.bucket!.isNotEmpty) {
        for (var bucket in response.bucket!) {
          if (bucket.dataset != null && bucket.dataset!.isNotEmpty) {
            for (var dataset in bucket.dataset!) {
              if (dataset.point != null && dataset.point!.isNotEmpty) {
                for (var point in dataset.point!) {
                  if (point.value != null && point.value!.isNotEmpty) {
                    return point.value!.first.intVal;
                  }
                }
              }
            }
          }
        }
      }
    } catch (e) {
      print("Error fetching step count: $e");
    }
    return null;
  }
}
