import 'package:delivery_app/domain/entities/table_column_config.dart';
import 'package:flutter/material.dart';

class TableFormField extends StatelessWidget {
  final List<TableColumnConfig> columns;
  final List<Map<String, dynamic>> data;
  final ScrollController _controller = ScrollController();

  TableFormField({super.key, required this.columns, required this.data});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _controller,
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          ...columns.map(
            (c) => DataColumn(
                label: Text(c.label, overflow: TextOverflow.ellipsis)),
          )
        ],
        rows: data.map((row) {
          return DataRow(cells: [
            ...columns.map(
              (c) => DataCell(
                Text('${row[c.code] ?? '-'}', overflow: TextOverflow.ellipsis),
              ),
            )
          ]);
        }).toList(),
      ),
    );
  }
}
