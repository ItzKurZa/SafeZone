import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'dart:async';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class CallingPage extends StatefulWidget {
  final Map<String, dynamic> data;

  const CallingPage({
    super.key,
    required this.data,
  });

  @override
  State<CallingPage> createState() => _CallingPageState();
}

class _CallingPageState extends State<CallingPage> {
  Timer? _timer;
  int _seconds = 0;
  bool _isMuted = false;
  bool _isSpeakerOn = true;
  bool _isCallEnded = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _seconds++;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatTime(int totalSeconds) {
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient / Blur Effect
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFB9938D),
                  Color(0xFFE5CCC8),
                  Color(0xFFFFFFFF),
                ],
              ),
            ),
          ),
          
          SafeArea(
            child: Column(
              children: [
                // Top Nav
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.textPrimary, size: 20),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Image.asset(
                        'assets/images/logo.png',
                        height: 24,
                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.security, color: AppColors.primary),
                      ),
                      const CircleAvatar(
                        radius: 18,
                        backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=rescuer'),
                      ),
                    ],
                  ),
                ),
                
                const Gap(32),
                
                // Emergency Call Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.emergency, color: Color(0xFFBA1A1A), size: 16),
                      const Gap(8),
                      Text(
                        'CUỘC GỌI KHẨN CẤP',
                        style: AppTextStyles.fontInter(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF410002),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const Gap(40),
                
                // Profile Photo
                Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white, width: 3),
                    image: DecorationImage(
                      image: widget.data['image'] != null
                          ? NetworkImage(widget.data['image'])
                          : const AssetImage('assets/images/victim_placeholder.png') as ImageProvider,
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                ),
                
                const Gap(40),
                
                // Name and Status
                Text(
                  widget.data['name'] ?? 'Người gặp nạn',
                  style: AppTextStyles.fontManrope(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                const Gap(12),
                Text(
                  _isCallEnded ? 'Cuộc gọi kết thúc...' : 'Đang kết nối...',
                  style: AppTextStyles.fontInter(
                    fontSize: 18,
                    color: AppColors.onSurfaceVariant.withValues(alpha: 0.7),
                  ),
                ),
                const Gap(16),
                Text(
                  _formatTime(_seconds),
                  style: AppTextStyles.fontManrope(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFFBA1A1A),
                  ),
                ),
                
                const Spacer(),
                
                // Call Controls
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _ControlButton(
                        icon: _isMuted ? Icons.mic_off : Icons.mic_none,
                        label: 'TẮT MIC',
                        isActive: _isMuted,
                        onTap: () => setState(() => _isMuted = !_isMuted),
                      ),
                      _ControlButton(
                        icon: Icons.grid_view_rounded,
                        label: 'BÀN PHÍM',
                        isActive: false,
                        onTap: () {},
                      ),
                      _ControlButton(
                        icon: Icons.volume_up_outlined,
                        label: 'LOA NGOÀI',
                        isActive: _isSpeakerOn,
                        onTap: () => setState(() => _isSpeakerOn = !_isSpeakerOn),
                      ),
                    ],
                  ),
                ),
                
                const Gap(60),
                
                // End Call Button
                GestureDetector(
                  onTap: () {
                    if (_isCallEnded) return;
                    setState(() {
                      _isCallEnded = true;
                      _timer?.cancel();
                    });
                    final navigator = Navigator.of(context);
                    Future.delayed(const Duration(milliseconds: 1500), () {
                      if (mounted) navigator.pop();
                    });
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: const Color(0xFFBA1A1A),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFBA1A1A).withValues(alpha: 0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        const Icon(Icons.call_end, color: Colors.white, size: 36),
                        if (_isCallEnded)
                          CustomPaint(
                            size: const Size(100, 100),
                            painter: _CrossPainter(),
                          ),
                      ],
                    ),
                  ),
                ),
                
                const Gap(60),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ControlButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _ControlButton({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: isActive ? const Color(0xFF001D40).withValues(alpha: 0.1) : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: isActive ? Border.all(color: const Color(0xFF0061A5), width: 1) : null,
            ),
            child: Icon(
              icon,
              color: isActive ? const Color(0xFF0061A5) : AppColors.onSurfaceVariant,
              size: 28,
            ),
          ),
        ),
        const Gap(12),
        Text(
          label,
          style: AppTextStyles.fontInter(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: isActive ? const Color(0xFF0061A5) : AppColors.onSurfaceVariant,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}

class _CrossPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas.drawLine(Offset.zero, Offset(size.width, size.height), paint);
    canvas.drawLine(Offset(0, size.height), Offset(size.width, 0), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
