import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class fileOperations {
  Future<String> get _localPathForUserTransactions async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFileForUserTransactions async {
    final path = await _localPathForUserTransactions;
    return File('$path/userTransactions.json');
  }

  Future<String> get _localPathForNumberOUserTransactions async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFileForNumberOfUserTransactions async {
    final path = await _localPathForNumberOUserTransactions;
    return File('$path/NumberOfuserTransactions.json');
  }

  void writeToFile(
      String userTransactionInJsonFormat, int numberOfTransactions) async {
    final userTransactionsFile = await _localFileForUserTransactions;
    final NumberOfuserTransactionsFile =
        await _localFileForNumberOfUserTransactions;
    // print(userTransactionInJsonFormat);
    userTransactionsFile.writeAsString(userTransactionInJsonFormat);
    NumberOfuserTransactionsFile.writeAsString(numberOfTransactions.toString());
  }

  Future<String> readUserTransactionsFromFile() async {
    final file = await _localFileForUserTransactions;
    if (!file.existsSync()) {
      writeToFile("", 0);
    } else {
      if (readNumberOfUserTransactionsFromFile() == "0") {
        return "No Data";
      } else {
        try {
          final file = await _localFileForUserTransactions;
          final jsonUserTransactionContentsInFile =
              await file.readAsString(encoding: utf8);
          return jsonUserTransactionContentsInFile;
        } catch (e) {
          print('Error while reading data');
        }
      }
    }
    return "0";
  }

  Future<String> readNumberOfUserTransactionsFromFile() async {
    final file = await _localFileForNumberOfUserTransactions;
    if (!file.existsSync()) {
      print('file does not exists');
    }
    try {
      final file = await _localFileForNumberOfUserTransactions;
      final jsonNumberOfUserTransactions =
          await file.readAsString(encoding: utf8);
      return jsonNumberOfUserTransactions;
    } catch (e) {
      print('Error while reading number of user data');
    }
    return "0";
  }
}
