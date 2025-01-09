import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CalculatorTipsPage extends StatefulWidget {
  const CalculatorTipsPage({super.key});

  @override
  _CalculatorTipsPageState createState() => _CalculatorTipsPageState();
}

class _CalculatorTipsPageState extends State<CalculatorTipsPage> {
  List<dynamic> videos = [];

  @override
  void initState() {
    super.initState();
    _loadVideos();
  }

  /// Memuat daftar video dari file JSON
  Future<void> _loadVideos() async {
    final String response = await rootBundle.loadString('assets/videos.json');
    final List<dynamic> data = json.decode(response);
    setState(() {
      videos = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tips Video'),
        backgroundColor: const Color(0xFF8D6E63),
        elevation: 0,
      ),
      body: videos.isEmpty
          ? const Center(
        child: CircularProgressIndicator(), // Loading jika data belum dimuat
      )
          : Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: ListView.builder(
          itemCount: videos.length,
          itemBuilder: (context, index) {
            final video = videos[index];
            return _buildVideoCard(video);
          },
        ),
      ),
    );
  }

  Widget _buildVideoCard(dynamic video) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ExpansionTile(
        title: Text(
          video['title'],
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        trailing: const Icon(
          Icons.play_arrow,
          size: 30,
          color: Color(0xFF8D6E63),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Image.network(
                  video['thumbnailUrl'], // Menampilkan thumbnail video dari URL
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 10),
                Text(
                  'Klik untuk menonton video',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Navigasi ke halaman YouTube Player untuk memutar video
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => YouTubePlayerPage(
                          videoId: video['url'],
                          title: video['title'],
                        ),
                      ),
                    );
                  },
                  child: const Text('Tonton Video'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8D6E63),  // Gantilah primary menjadi backgroundColor
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class YouTubePlayerPage extends StatefulWidget {
  final String videoId;
  final String title;

  const YouTubePlayerPage({super.key, required this.videoId, required this.title});

  @override
  _YouTubePlayerPageState createState() => _YouTubePlayerPageState();
}

class _YouTubePlayerPageState extends State<YouTubePlayerPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        enableCaption: true,
        isLive: false,
        forceHD: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Fungsi untuk maju 5 detik
  void _seekForward() {
    final currentPosition = _controller.value.position;
    final newPosition = currentPosition + const Duration(seconds: 5);
    _controller.seekTo(newPosition);
  }

  // Fungsi untuk mundur 5 detik
  void _seekBackward() {
    final currentPosition = _controller.value.position;
    final newPosition = currentPosition - const Duration(seconds: 5);
    _controller.seekTo(newPosition);
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      onEnterFullScreen: () {
        // Memasukkan mode fullscreen
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      },
      onExitFullScreen: () {
        // Keluar dari mode fullscreen
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      },
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.red,
        // Menambahkan tombol di area bawah video
        bottomActions: [
          IconButton(
            icon: const Icon(Icons.replay_5, color: Colors.white),
            onPressed: _seekBackward,
          ),
          const CurrentPosition(),
          const ProgressBar(isExpanded: true),
          const RemainingDuration(),
          IconButton(
            icon: const Icon(Icons.forward_5, color: Colors.white),
            onPressed: _seekForward,
          ),
          FullScreenButton(
            controller: _controller,
          ),
        ],
      ),
      builder: (context, player) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            backgroundColor: const Color(0xFF8D6E63),
            elevation: 0,
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: player,
            ),
          ),
        );
      },
    );
  }
}
