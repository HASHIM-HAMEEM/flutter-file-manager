import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';
import '../models/file_item.dart';
import '../services/file_operations.dart';

class FileViewerScreen extends StatefulWidget {
  final FileItem file;

  const FileViewerScreen({Key? key, required this.file}) : super(key: key);

  @override
  _FileViewerScreenState createState() => _FileViewerScreenState();
}

class _FileViewerScreenState extends State<FileViewerScreen> {
  VideoPlayerController? _videoController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeFile();
  }

  Future<void> _initializeFile() async {
    if (widget.file.fileType.toLowerCase() == 'mp4') {
      _videoController = VideoPlayerController.file(File(widget.file.path))
        ..initialize().then((_) {
          setState(() {
            _isLoading = false;
          });
        });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.file.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () async {
              await FileOperations().shareFile(widget.file);
            },
          ),
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () async {
              await FileOperations().downloadFile(widget.file);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('File downloaded successfully')),
              );
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildFilePreview(),
    );
  }

  Widget _buildFilePreview() {
    switch (widget.file.fileType.toLowerCase()) {
      case 'pdf':
        return PDFView(
          filePath: widget.file.path,
          enableSwipe: true,
          swipeHorizontal: false,
          autoSpacing: true,
          pageFling: true,
          onError: (error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: $error')),
            );
          },
        );

      case 'jpg':
      case 'jpeg':
      case 'png':
        return Center(
          child: InteractiveViewer(
            boundaryMargin: const EdgeInsets.all(20.0),
            minScale: 0.5,
            maxScale: 4.0,
            child: Image.file(File(widget.file.path)),
          ),
        );

      case 'mp4':
        if (_videoController != null && _videoController!.value.isInitialized) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AspectRatio(
                aspectRatio: _videoController!.value.aspectRatio,
                child: VideoPlayer(_videoController!),
              ),
              VideoProgressIndicator(
                _videoController!,
                allowScrubbing: true,
                padding: const EdgeInsets.all(16.0),
              ),
              IconButton(
                icon: Icon(
                  _videoController!.value.isPlaying
                      ? Icons.pause
                      : Icons.play_arrow,
                ),
                onPressed: () {
                  setState(() {
                    _videoController!.value.isPlaying
                        ? _videoController!.pause()
                        : _videoController!.play();
                  });
                },
              ),
            ],
          );
        }
        return const Center(child: Text('Error loading video'));

      case 'txt':
        return FutureBuilder<String>(
          future: File(widget.file.path).readAsString(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Text(snapshot.data!),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        );

      default:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.file_present, size: 72),
              const SizedBox(height: 16),
              Text(
                'Cannot preview this file type: ${widget.file.fileType}',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  await FileOperations().openFileWithDefaultApp(widget.file);
                },
                child: const Text('Open with default app'),
              ),
            ],
          ),
        );
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }
}
