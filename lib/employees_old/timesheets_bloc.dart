// import 'dart:async';

// import 'employee_view_model.dart';
// import 'dart:async';
// // import 'post_view_model.dart';
// import 'package:taskist/model/timesheet.dart';
// import 'package:taskist/logic/viewmodel/timesheet_view_model/timesheet_view_model.dart';

// //

// class TimesheetBloc {
//   final PostViewModel postViewModel = PostViewModel();

//   final postController = StreamController<List<Post>>();
//   final fabController = StreamController<bool>();
//   final fabVisibleController = StreamController<bool>();
//   Sink<bool> get fabSink => fabController.sink;
//   Stream<List<Post>> get postItems => postController.stream;
//   Stream<bool> get fabVisible => fabVisibleController.stream;

//   PostBloc() {
//     postController.add(postViewModel.getPosts());
//     fabController.stream.listen(onScroll);
//   }

//   onScroll(bool visible) {
//     fabVisibleController.add(visible);
//   }

//   void dispose() {
//     postController?.close();
//     fabController?.close();
//     fabVisibleController?.close();
//   }
// }
// // class TimesheetBloc {
// //   // final EmployeeViewModel employeeViewModel = EmployeeViewModel();
// //   final employeeController = StreamController<List<Employee>>();
// //   Stream<List<Employee>> get employeeItems => employeeController.stream;

// //   TimesheetBloc() {
// //     // employeeController.add(employeeViewModel.getEmployees());
// //   }
// // }
