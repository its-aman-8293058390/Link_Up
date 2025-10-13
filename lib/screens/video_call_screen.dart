import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import '../utils/constants.dart';

class VideoCallScreen extends StatefulWidget {
  final String contactName;
  final int contactIndex;
  
  const VideoCallScreen({
    Key? key,
    required this.contactName,
    required this.contactIndex,
  }) : super(key: key);

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen>
    with SingleTickerProviderStateMixin {
  bool _isMuted = false;
  bool _isSpeakerOn = false;
  bool _isVideoOn = true;
  bool _isOnHold = false;
  late AnimationController _animationController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Remote video feed (placeholder)
          Container(
            color: Colors.primaries[widget.contactIndex % Colors.primaries.length],
            child: Center(
              child: Text(
                '${widget.contactName}\'s Video',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Local video preview (picture-in-picture)
          Positioned(
            right: 20,
            top: 100,
            child: Container(
              width: 120,
              height: 160,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
              child: Center(
                child: Text(
                  'You',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          // Call info overlay
          SafeArea(
            child: Column(
              children: [
                // Contact info
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      // Contact name
                      Text(
                        widget.contactName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Call status
                      Text(
                        _isOnHold ? 'On Hold' : 'Video Calling...',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Call timer
                      Text(
                        '00:05',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                // Call controls
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      // Top row controls
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Mute button
                          _buildControlButton(
                            _isMuted ? Icons.mic_off : Icons.mic,
                            _isMuted ? Colors.red : Colors.white70,
                            'Mute',
                            () {
                              setState(() {
                                _isMuted = !_isMuted;
                              });
                            },
                          ),
                          // Video on/off button
                          _buildControlButton(
                            _isVideoOn
                                ? Icons.videocam
                                : Icons.videocam_off,
                            _isVideoOn ? Colors.white70 : Colors.red,
                            'Video',
                            () {
                              setState(() {
                                _isVideoOn = !_isVideoOn;
                              });
                            },
                          ),
                          // Speaker button
                          _buildControlButton(
                            _isSpeakerOn
                                ? Icons.volume_up
                                : Icons.volume_down,
                            _isSpeakerOn ? AppColors.primary : Colors.white70,
                            'Speaker',
                            () {
                              setState(() {
                                _isSpeakerOn = !_isSpeakerOn;
                              });
                            },
                          ),
                          // Hold button
                          _buildControlButton(
                            _isOnHold ? Icons.play_arrow : Icons.pause,
                            _isOnHold ? AppColors.primary : Colors.white70,
                            _isOnHold ? 'Resume' : 'Hold',
                            () {
                              setState(() {
                                _isOnHold = !_isOnHold;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      // End call button
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 70,
                          height: 70,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.call_end,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton(
    IconData icon,
    Color color,
    String label,
    VoidCallback onPressed,
  ) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white24,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                icon,
                color: color,
                size: 25,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}