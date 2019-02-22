import 'dart:async';
// import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './model/employee.dart';

// class Counter {
//   Counter({this.id, this.value});
//   int id;
//   int value;
// }

abstract class Database {
  Future<void> createEmployee(String name);
  Future<void> setEmployee(Employee employee);
  Future<void> deleteEmployee(Employee employee);
  Stream<List<Employee>> employeesStream();
}

// Realtime Database
// class AppDatabase implements Database {
//   // Future<void> createCounter() async {
//   //   int now = DateTime.now().millisecondsSinceEpoch;
//   //   Counter counter = Counter(id: now, value: 0);
//   //   await setCounter(counter);
//   }

// Future<void> setCounter(Counter counter) async {
//   DatabaseReference databaseReference = _databaseReference(counter);
//   await databaseReference.set(counter.value);
// }

// Future<void> deleteCounter(Counter counter) async {
//   DatabaseReference databaseReference = _databaseReference(counter);
//   await databaseReference.remove();
// }

// DatabaseReference _databaseReference(Counter counter) {
//   var path = '$rootPath/${counter.id}';
//   return FirebaseDatabase.instance.reference().child(path);
// }

//   Stream<List<Counter>> countersStream() {
//     return _DatabaseStream<List<Counter>>(
//       apiPath: rootPath,
//       parser: _DatabaseCountersParser(),
//     ).stream;
//   }

//   static final String rootPath = 'counters';
// }

// class _DatabaseStream<T> {
//   Stream<T> stream;
//   _DatabaseStream({String apiPath, DatabaseNodeParser<T> parser}) {
// FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
// DatabaseReference databaseReference =
//     firebaseDatabase.reference().child(apiPath);
// var eventStream = databaseReference.onValue;
// stream = eventStream.map((event) => parser.parse(event));
//   }
// }

// abstract class DatabaseNodeParser<T> {
//   T parse(Event event);
// }

// class _DatabaseCountersParser implements DatabaseNodeParser<List<Counter>> {
//   List<Counter> parse(Event event) {
//     Map<dynamic, dynamic> values = event.snapshot.value;
//     if (values != null) {
//       Iterable<String> keys = values.keys.cast<String>();

//       var counters = keys
//           .map((key) => Counter(id: int.parse(key), value: values[key]))
//           .toList();
//       counters.sort((lhs, rhs) => rhs.id.compareTo(lhs.id));
//       return counters;
//     } else {
//       return [];
//     }
//   }
// }

// Cloud Firestore
class AppFirestore implements Database {
  static final String rootPath = 'employees';

  DocumentReference _documentReference(Employee employee) {
    return Firestore.instance.collection(rootPath).document('${employee.id}');
  }

  Future<void> createEmployee(String name) async {
    Employee employee = Employee(name: name, id: name);
    await setEmployee(employee);
  }

  Future<void> setEmployee(Employee employee) async {
    _documentReference(employee).setData({
      'name': employee.name,
    });
  }

  Future<void> deleteEmployee(Employee employee) async {
    _documentReference(employee).delete();
  }

  Stream<List<Employee>> employeesStream() {
    return _FirestoreStream<List<Employee>>(
      apiPath: rootPath,
      parser: FirestoreEmployeesParser(),
    ).stream;
  }
}

abstract class FirestoreNodeParser<T> {
  T parse(QuerySnapshot querySnapshot);
}

class FirestoreEmployeesParser extends FirestoreNodeParser<List<Employee>> {
  List<Employee> parse(QuerySnapshot querySnapshot) {
    var employees = querySnapshot.documents.map((documentSnapshot) {
      return Employee(
        id: documentSnapshot.documentID,
        name: documentSnapshot['name'],
      );
    }).toList();
    employees.sort((lhs, rhs) => rhs.id.compareTo(lhs.id));
    return employees;
  }
}

class _FirestoreStream<T> {
  _FirestoreStream({String apiPath, FirestoreNodeParser<T> parser}) {
    CollectionReference collectionReference =
        Firestore.instance.collection(apiPath);
    Stream<QuerySnapshot> snapshots = collectionReference.snapshots();
    stream = snapshots.map((snapshot) => parser.parse(snapshot));
  }

  Stream<T> stream;
}
