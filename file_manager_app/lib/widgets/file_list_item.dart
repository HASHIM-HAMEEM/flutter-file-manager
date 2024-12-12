import 'package:flutter/material.dart';
import '../models/file_item.dart';
import '../screens/file_viewer_screen.dart';
import 'package:intl/intl.dart';

class FileListItem extends StatelessWidget {
  final FileItem file;
  final Function()? onDelete;

  const FileListItem({
    Key? key,
    required this.file,
    this.onDelete,
  }) : super(key: key);

  IconData _getFileIcon() {
    switch (file.fileType.toLowerCase()) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'doc':
      case 'docx':
        return Icons.description;
      case 'jpg':
      case 'jpeg':
      case 'png':
        return Icons.image;
      case 'mp3':
      case 'wav':
        return Icons.audio_file;
      case 'mp4':
      case 'mov':
        return Icons.video_file;
      default:
        return Icons.insert_drive_file;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: Icon(
          _getFileIcon(),
          size: 36,
          color: Theme.of(context).primaryColor,
        ),
        title: Text(
          file.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          '${file.category} • ${DateFormat('MMM d, yyyy').format(file.dateAdded)}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) async {
            switch (value) {
              case 'view':
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FileViewerScreen(file: file),
                  ),
                );
                break;
              case 'delete':
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Delete File'),
                    content: const Text(
                        'Are you sure you want to delete this file?'),
                    actions: [
                      TextButton(
                        child: const Text('Cancel'),
                        onPressed: () => Navigator.pop(context),
                      ),
                      TextButton(
                        child: const Text('Delete'),
                        onPressed: () {
                          Navigator.pop(context);
                          onDelete?.call();
                        },
                      ),
                    ],
                  ),
                );
                break;
            }
          },
          itemBuilder: (BuildContext context) => [
            const PopupMenuItem(
              value: 'view',
              child: Text('View'),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: Text('Delete'),
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FileViewerScreen(file: file),
            ),
          );
        },
      ),
    );
  }
}
