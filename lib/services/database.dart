import 'dart:async';
import 'package:time_tracker_flutter/app/home/models/job.dart';
import 'package:time_tracker_flutter/services/api_path.dart';
import 'package:time_tracker_flutter/services/firestore_service.dart';

abstract class Database {
  Future<void> createJob(Job job);
  Stream<List<Job>> jobsStream();
}

final _service = FirestoreService.instance;

class FirestoreDatabase implements Database {
  FirestoreDatabase({required this.uid}) : assert(uid != null);
  final String uid;

  Future<void> createJob(Job job) async => await _service.setData(
        path: APIPath.job(uid, 'job_abc'),
        data: job.toMap(),
      );

  Stream<List<Job>> jobsStream() => _service.collectionStream(
        path: APIPath.jobs(uid),
        builder: (data) => Job.fromMap(data),
      );
}
