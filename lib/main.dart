// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

void main() {
  runApp(const MyApp());
}

/// The application that contains datagrid on it.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Syncfusion DataGrid Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

/// The home page of the application which hosts the datagrid.
class MyHomePage extends StatefulWidget {
  /// Creates the home page.
  const MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  List<Employee> employees = <Employee>[];
  late List<GridColumn> columns;
  late EmployeeDataSource employeeDataSource;

  @override
  void initState() {
    super.initState();

    columns = getColumns;
    employees = getEmployeeData();
    employeeDataSource =
        EmployeeDataSource(employees: employees, columns: columns);
  }

  List<GridColumn> get getColumns {
    return <GridColumn>[
      GridColumn(
          columnName: 'id',
          label: Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: const Text(
                'ID',
              ))),
      GridColumn(
          columnName: 'name',
          label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text('Name'))),
      GridColumn(
          columnName: 'designation',
          label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Designation',
                overflow: TextOverflow.ellipsis,
              ))),
      GridColumn(
          columnName: 'email',
          label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Email',
                overflow: TextOverflow.ellipsis,
              ))),
      GridColumn(
          columnName: 'salary',
          label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text('Salary'))),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Syncfusion Flutter DataGrid')),
      body: SfDataGrid(
        source: employeeDataSource,
        columnWidthMode: ColumnWidthMode.fill,
        allowColumnsDragging: true,
        columns: columns,
        onColumnDragging: (DataGridColumnDragDetails details) {
          if (details.action == DataGridColumnDragAction.dropped &&
              details.to != null) {
            final GridColumn rearrangeColumn = columns[details.from];
            columns.removeAt(details.from);
            columns.insert(details.to!, rearrangeColumn);
            employeeDataSource.buildDataGridRows();
            employeeDataSource.refreshDataGrid();
          }
          return true;
        },
      ),
    );
  }
}

class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource({required this.employees, required this.columns}) {
    buildDataGridRows();
  }

  void buildDataGridRows() {
    dataGridRows = employees.map<DataGridRow>((employee) {
      return DataGridRow(
          cells: columns.map<DataGridCell>((column) {
        return DataGridCell(
          columnName: column.columnName,
          value: employee[column.columnName],
        );
      }).toList());
    }).toList();
  }

  List<Employee> employees = [];

  List<GridColumn> columns = [];

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map((dataGridCell) {
      return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            dataGridCell.value.toString(),
          ));
    }).toList());
  }

  refreshDataGrid() {
    notifyListeners();
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the employee which will be rendered in datagrid.
class Employee {
  /// Creates the employee class with required details.
  Employee(this.id, this.name, this.designation, this.email, this.salary);

  /// Id of an employee.
  final int id;

  /// Name of an employee.
  final String name;

  /// Designation of an employee.
  final String designation;

  final String email;

  /// Salary of an employee.
  final int salary;

  /// Overrides the indexing operator to provide access to specific properties of the [Employee] class.
  operator [](Object? value) {
    if (value == 'id') {
      return id;
    } else if (value == 'name') {
      return name;
    } else if (value == 'designation') {
      return designation;
    } else if (value == 'email') {
      return email;
    } else if (value == 'salary') {
      return salary;
    } else {
      throw ArgumentError('Invalid property: $value');
    }
  }
}

List<Employee> getEmployeeData() {
  return [
    Employee(10001, 'Jack Anderson', 'Manager', 'jack@gmail.com', 120000),
    Employee(10002, 'Olivia Wilson', 'Developer', 'olivia@gmail.com', 500000),
    Employee(10003, 'Emma Wilson', 'Developer', 'emma.wilson@gmail.com', 49000),
    Employee(10004, 'Thomas Hardy', 'Developer', 'thomas@gmail.com', 48000),
    Employee(10005, 'Mia Garcia', 'Developer', 'mia.garcia@gmail.com', 47000),
    Employee(10006, 'John Smith', 'Developer', 'john@gmail.com', 43000),
    Employee(10007, 'Maria Andres', 'Developer', 'maria@gmail.com', 41000),
    Employee(10008, 'Samuel Martinez', 'Developer', 'samuel@gmail.com', 40000),
    Employee(10009, 'Hanna Moos', 'Developer', 'hanna@gmail.com', 40000),
    Employee(10010, 'Amelia Young', 'Developer', 'amelia@gmail.com', 39000),
    Employee(
        10011, 'Patricio Simpson', 'Developer', 'patricio@gmail.com', 39000)
  ];
}
