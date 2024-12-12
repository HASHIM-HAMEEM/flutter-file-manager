import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as path;
import '../models/file_item.dart';

class FileOperations {
  Future<String> copyFile(File sourceFile, String category) async {
    final appDir = await getApplicationDocumentsDirectory();
    final categoryDir = Directory('${appDir.path}/$category');

    if (!await categoryDir.exists()) {
      await categoryDir.create(recursive: true);
    }

    final fileName = path.basename(sourceFile.path);
    final destinationPath = '${categoryDir.path}/$fileName';

    await sourceFile.copy(destinationPath);
    return destinationPath;
  }

  Future<void> deleteFile(FileItem file) async {
    final fileToDelete = File(file.path);
    if (await fileToDelete.exists()) {
      await fileToDelete.delete();
    }
  }

  Future<void> shareFile(FileItem file) async {
    final filePath = file.path;
    await Share.shareFiles([filePath], text: 'Sharing ${file.name}');
  }

  Future<void> downloadFile(FileItem file) async {
    final downloadDir = Directory('/storage/emulated/0/Download');
    if (!await downloadDir.exists()) {
      await downloadDir.create(recursive: true);
    }

    final sourceFile = File(file.path);
    final fileName = path.basename(file.path);
    final destinationPath = '${downloadDir.path}/$fileName';

    await sourceFile.copy(destinationPath);
  }

  Future<void> openFileWithDefaultApp(FileItem file) async {
    await OpenFile.open(file.path);
  }

  Future<String> moveFile(File sourceFile, String category) async {
    final destinationPath = await copyFile(sourceFile, category);
    await sourceFile.delete();
    return destinationPath;
  }

  Future<Map<String, int>> getStorageStats() async {
    final appDir = await getApplicationDocumentsDirectory();
    int totalFiles = 0;
    int totalSize = 0;

    await for (var entity in appDir.list(recursive: true)) {
      if (entity is File) {
        totalFiles++;
        totalSize += await entity.length();
      }
    }

    return {
      'totalFiles': totalFiles,
      'totalSize': totalSize,
    };
  }
}
