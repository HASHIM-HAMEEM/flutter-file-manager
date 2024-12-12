import 'package:flutter/material.dart';
import '../models/file_item.dart';
import '../services/storage_service.dart';
import '../widgets/file_list_item.dart';

class AllFilesScreen extends StatefulWidget {
  const AllFilesScreen({Key? key}) : super(key: key);

  @override
  _AllFilesScreenState createState() => _AllFilesScreenState();
}

class _AllFilesScreenState extends State<AllFilesScreen> {
  final StorageService _storageService = StorageService();
  List<FileItem> _files = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFiles();
  }

  Future<void> _loadFiles() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final files = await _storageService.getAllFiles();
      setState(() {
        _files = files;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading files: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Files'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Navigate to search screen
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'name':
                  setState(() {
                    _files.sort((a, b) => a.name.compareTo(b.name));
                  });
                  break;
                case 'date':
                  setState(() {
                    _files.sort((a, b) => b.dateAdded.compareTo(a.dateAdded));
                  });
                  break;
                case 'type':
                  setState(() {
                    _files.sort((a, b) => a.fileType.compareTo(b.fileType));
                  });
                  break;
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                value: 'name',
                child: Text('Sort by Name'),
              ),
              const PopupMenuItem(
                value: 'date',
                child: Text('Sort by Date'),
              ),
              const PopupMenuItem(
                value: 'type',
                child: Text('Sort by Type'),
              ),
            ],
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _files.isEmpty
              ? const Center(child: Text('No files found'))
              : RefreshIndicator(
                  onRefresh: _loadFiles,
                  child: ListView.builder(
                    itemCount: _files.length,
                    itemBuilder: (context, index) {
                      return FileListItem(
                        file: _files[index],
                        onDelete: () async {
                          await _storageService.deleteFile(_files[index].id!);
                          await _loadFiles();
                        },
                      );
                    },
                  ),
                ),
    );
  }
}
