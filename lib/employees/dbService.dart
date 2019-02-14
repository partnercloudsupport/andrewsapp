import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskist/model/employee.dart';
import 'package:taskist/model/timesheet.dart';
import 'package:firestore_helpers/firestore_helpers.dart';

class DatabaseService
{
    final empCollection = Firestore.instance.collection("employees");
    final timeSheetCollection = Firestore.instance.collection("timesheets");

    // Future<void> createLocation(Employee emp) async
    // {
    //     empCollection.document().setData(EmployeeSerializer().toMap(emp));
    // }

Stream<List<Employee>> getEmployees({List<QueryConstraint> constraints}) {
  try {
    Query query = buildQuery(collection: empCollection, constraints: constraints);
    return getDataFromQuery(
        query: query, 
           mapper: (doc) => EmployeeSerializer().fromMap(doc.data),

        // mapper: (eventDoc) {
        //  mapper: (doc) => EmployeeSerializer().fromMap(doc.data),
        //   event.id = eventDoc.documentID;
        //   return event;
        // }, 
        // clientSidefilters: (event) => event.startTime > DateTime.now()  // only future events
        // orderComparer: (event1, event2) => event1.name.compareTo(event2.name) 
      );
  } on Exception catch (ex) {
    print(ex);
  }
  return null;
}

// getEvents(constraints: [new QueryConstraint(field: "creatorId", isEqualTo: _currentUser.id)]);
Stream<List<Timesheet>> getTimesheets({List<QueryConstraint> constraints}) {
  try {
    Query query = buildQuery(collection: timeSheetCollection, constraints: constraints);
  
     return getDataFromQuery(
        query: query, 
        
        mapper: (eventDoc) {
          var sheet = TimesheetSerializer().fromMap(eventDoc.data);
          sheet.id = eventDoc.documentID;
          return sheet;
        }, 
         orderComparer: (sheet1, sheet2) => sheet1.startTimestamp .compareTo(sheet2.startTimestamp),
        //  clientSidefilters: (Timesheet sheet) => sheet.employeeId == '123';
      );
  } on Exception catch (ex) {
    print(ex);
  }
  return null;
}

    // Stream<List<Employee>> getEmployees({GeoPoint center, double radiusInKm})
    // {
    //       Query query = buildQuery(collection: empCollection, constraints: null);

    //     return getDataFromQuery<Employee>(
    //     query: query,
    //     // return getData<Employee>(source: locationCollection,
    //     // area: Area(center, radiusInKm),
    //     // locationFieldNameInDB: 'position',
    //     mapper: (doc) => EmployeeSerializer().fromMap(doc.data),
    //     // locationAccessor: (item) => item.position,
    //     // The distancemapper is applied after the mapper
    //     // distanceMapper: (item, dist) {
    //     //     item.distance = dist;
    //     //     return item;
    //     // } 

    //     );
    // }

    
}