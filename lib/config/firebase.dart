// Firebase auth and cloud_firestore config values

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

final FirebaseFirestore store = FirebaseFirestore.instance;
final FirebaseAuth auth = FirebaseAuth.instance;
// Local environment variables (use this only when using firebase emulator)
// String authHost = "http://localhost:9099";
// String storeHost = defaultTargetPlatform == TargetPlatform.android
//     ? '10.0.2.2:8080'
//     : 'localhost:8080';
