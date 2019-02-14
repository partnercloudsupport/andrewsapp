// import 'dart:async';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../model/timesheet.dart';
// import '../common/uidata.dart';

// import '../resources/repository.dart';
// import 'package:rxdart/rxdart.dart';

// class TimesheetBloc {
//   final _repository = Repository();
//   final _title = BehaviorSubject<String>();
//   final _timesheetMessage = BehaviorSubject<String>();
//   final _showProgress = BehaviorSubject<bool>();

//   Observable<String> get name => _title.stream.transform(_validateName);

//   Observable<String> get timesheetMessage =>
//       _timesheetMessage.stream.transform(_validateMessage);

//   Observable<bool> get showProgress => _showProgress.stream;

//   Function(String) get changeName => _title.sink.add;

//   Function(String) get changeTimesheetMessage => _timesheetMessage.sink.add;

//   final _validateMessage = StreamTransformer<String, String>.fromHandlers(
//       handleData: (timesheetMessage, sink) {
//     if (timesheetMessage.length > 10) {
//       sink.add(timesheetMessage);
//     } else {
//       sink.addError(StringConstant.timesheetValidateMessage);
//     }
//   });

//   final _validateName = StreamTransformer<String, String>.fromHandlers(
//       handleData: (String name, sink) {
//     if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(name)) {
//       sink.addError(StringConstant.nameValidateMessage);
//     } else {
//       sink.add(name);
//     }
//   });

//   void submit(String email) {
//     _showProgress.sink.add(true);
//     _repository
//         .uploadTimesheet(email, _title.value, _timesheetMessage.value)
//         .then((value) {
//       _showProgress.sink.add(false);
//     });
//   }

//   // void extractText(var image) {
//   //   _repository.extractText(image).then((text) {
//   //     _timesheetMessage.sink.add(text);
//   //   });
//   // }

//   Stream<DocumentSnapshot> myTimesheetsList(String email) {
//     return _repository.myTimesheetList(email);
//   }

//   Stream<QuerySnapshot> othersTimesheetList() {
//     return _repository.othersTimesheetList();
//   }

//   //dispose all open sink
//   void dispose() async {
//     await _timesheetMessage.drain();
//     _timesheetMessage.close();
//     await _title.drain();
//     _title.close();
//     await _showProgress.drain();
//     _showProgress.close();
//   }

//   //Convert map to timesheet list
//   List mapToList({DocumentSnapshot doc, List<DocumentSnapshot> docList}) {
//     if (docList != null) {
//       List<Timesheet> timesheetList = [];
//       docList.forEach((document) {
//         String email = document.data[StringConstant.emailField];
//         Map<String, String> timesheets =
//             document.data[StringConstant.timesheetField] != null
//                 ? document.data[StringConstant.timesheetField]
//                     .cast<String, String>()
//                 : null;
//         if (timesheets != null) {
//           timesheets.forEach((userId, status) {
//             Timesheet otherTimesheet = Timesheet(userId, status);
//             timesheetList.add(otherTimesheet);
//           });
//         }
//       });
//       return timesheetList;
//     } else {
//       Map<String, String> timesheets =
//           doc.data[StringConstant.timesheetField] != null
//               ? doc.data[StringConstant.timesheetField].cast<String, String>()
//               : null;
//       List<Timesheet> timesheetList = [];
//       if (timesheets != null) {
//         timesheets.forEach((userId, status) {
//           Timesheet timesheet = Timesheet(userId, status);
//           timesheetList.add(timesheet);
//         });
//       }
//       return timesheetList;
//     }
//   }

//   //Remove item from the timesheet list
//   void removeTimesheet(String title, String email) {
//     return _repository.removeTimesheet(title, email);
//   }
// }
