import 'package:delivery_app/domain/entities/table_column_config.dart';
import 'package:flutter/material.dart';

class TableFormField extends StatefulWidget {
  final List<TableColumnConfig> columns;
  final List<Map<String, dynamic>> data;

  const TableFormField({
    super.key,
    required this.columns,
    required this.data,
  });

  @override
  State<TableFormField> createState() => _TableFormFieldState();
}

class _TableFormFieldState extends State<TableFormField> {
  final ScrollController _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: _controller,
      thumbVisibility: true,
      child: SingleChildScrollView(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: widget.columns
              .map((c) => DataColumn(
                    label: Text(c.label, overflow: TextOverflow.ellipsis),
                  ))
              .toList(),
          rows: widget.data.map((row) {
            return DataRow(
              cells: widget.columns
                  .map((c) => DataCell(
                        Text(
                          '${row[c.code] ?? '-'}',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ))
                  .toList(),
            );
          }).toList(),
        ),
      ),
    );
  }
}
