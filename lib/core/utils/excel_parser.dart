import 'dart:io';
import 'package:excel/excel.dart';

class ExcelParser {
  List<Map<String, dynamic>> parseExcel(File file) {
    final bytes = file.readAsBytesSync();
    final excel = Excel.decodeBytes(bytes);

    List<Map<String, dynamic>> rows = [];

    for (var sheet in excel.tables.keys) {
      final table = excel.tables[sheet];
      if (table != null) {
        final headers = table.rows.first
            .map((header) => header?.value?.toString() ?? '')
            .toList();

        for (int i = 1; i < table.rows.length; i++) {
          final row = table.rows[i];
          final rowData = <String, dynamic>{};

          for (int j = 0; j < headers.length; j++) {
            final columnName = headers[j];
            if (columnName.isNotEmpty && j < row.length) {
              rowData[columnName] = row[j]?.value?.toString() ?? '';
            }
          }
          rows.add(rowData);
        }
      }
    }
    return rows;
  }
}
