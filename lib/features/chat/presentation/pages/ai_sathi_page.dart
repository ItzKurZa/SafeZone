import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

enum VoiceSathiState { initializing, listening, responding, waiting }

class AiSathiPage extends StatefulWidget {
  const AiSathiPage({super.key});

  @override
  State<AiSathiPage> createState() => _AiSathiPageState();
}

class _AiSathiPageState extends State<AiSathiPage> {
  VoiceSathiState _state = VoiceSathiState.initializing;
  String _statusText = 'Đang khởi động...';
  final String _hintText = 'Chạm vào mic để bắt đầu';
  
  // Simulation timer
  Timer? _stateTimer;

  @override
  void initState() {
    super.initState();
    _startSimulation();
  }

  void _startSimulation() {
    _stateTimer = Timer(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _state = VoiceSathiState.listening;
          _statusText = 'Đang nghe...';
        });
        
        _stateTimer = Timer(const Duration(seconds: 3), () {
          if (mounted) {
            setState(() {
              _state = VoiceSathiState.responding;
              _statusText = 'Đang phản hồi...';
            });
            
             _stateTimer = Timer(const Duration(seconds: 5), () {
              if (mounted) {
                setState(() {
                  _state = VoiceSathiState.waiting;
                  _statusText = 'Còn gì nữa không?';
                });
              }
            });
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _stateTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            const Gap(40),
            Expanded(
              child: Center(
                child: _buildMainContent(),
              ),
            ),
            const Gap(24),
            Text(
              _statusText,
              style: AppTextStyles.fontPoppins(
                color: AppColors.primary,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Gap(8),
            Text(
              _hintText,
              style: AppTextStyles.bodyRegular.copyWith(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
            const Gap(40),
            _buildBottomNavBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/images/avatar_1.png',
                width: 44,
                height: 44,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Image.asset(
            'assets/images/logo.png',
            width: 80,
            height: 35,
            fit: BoxFit.contain,
          ),
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(color: const Color(0xFFE0E0FF), width: 2),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.05),
                  blurRadius: 10,
                ),
              ],
            ),
            child: const Icon(Icons.notifications_none, color: AppColors.textPrimary, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return SizedBox(
      width: 300,
      height: 420,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          // Main Card
          Container(
            width: 300,
            height: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF38B6FF), Color(0xFF1800AD), Color(0xFF0F006D)],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              child: _buildStateContent(),
            ),
          ),

          // Overlapping Visualizer
          Positioned(
            top: -45,
            child: _buildVisualizer(),
          ),

          // Embedded Controls
          Positioned(
            bottom: 24,
            child: _buildEmbeddedControls(),
          ),
        ],
      ),
    );
  }

  Widget _buildVisualizer() {
    final bool isActive = _state == VoiceSathiState.listening || _state == VoiceSathiState.responding;
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00E0FF).withValues(alpha: 0.5),
            blurRadius: isActive ? 40 : 20,
            spreadRadius: isActive ? 10 : 0,
          ),
        ],
        gradient: const RadialGradient(
          colors: [Color(0xFF00E0FF), Color(0xFF1800AD), Colors.transparent],
          stops: [0.3, 0.7, 1.0],
        ),
      ),
      child: Center(
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: SweepGradient(
              colors: const [
                Color(0xFF00E0FF),
                Color(0xFF1800AD),
                Color(0xFF00E0FF),
              ],
              stops: const [0.0, 0.5, 1.0],
              transform: GradientRotation(isActive ? 2.0 : 0.0),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStateContent() {
    if (_state == VoiceSathiState.responding || _state == VoiceSathiState.waiting) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(40),
          Text(
            'Chào Loi! Thật vui khi biết bạn đang coi trọng sức khỏe tinh thần của mình.',
            style: AppTextStyles.fontPoppins(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              height: 1.4,
            ),
          ),
          const Gap(16),
          Text(
            'Trước khi bắt đầu, tôi muốn bạn hít một hơi thật sâu trong 5 giây.',
            style: AppTextStyles.fontPoppins(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 15,
              height: 1.5,
            ),
          ),
          const Gap(24),
          const Text('.....', style: TextStyle(color: Colors.white, fontSize: 30)),
        ],
      );
    }

    if (_state == VoiceSathiState.listening) {
      return Center(
        child: Container(
          width: 180,
          height: 180,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black.withValues(alpha: 0.2),
            border: Border.all(
              color: const Color(0xFF00E0FF).withValues(alpha: 0.3),
              width: 2,
            ),
          ),
          child: const Center(
            child: Icon(Icons.mic, color: Colors.white, size: 60),
          ),
        ),
      );
    }

    return Center(
      child: Container(
        width: 180,
        height: 180,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              const Color(0xFF00E0FF).withValues(alpha: 0.3),
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmbeddedControls() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF0F006D).withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.close, color: Colors.white.withValues(alpha: 0.8), size: 24),
          ),
          const Gap(30),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.mic,
              color: _state == VoiceSathiState.listening ? AppColors.primary : const Color(0xFF1800AD),
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.calendar_today_outlined, color: Colors.black.withValues(alpha: 0.6)),
          Icon(Icons.call_outlined, color: Colors.black.withValues(alpha: 0.6)),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
            child: const Icon(Icons.home, color: Colors.white),
          ),
          const Icon(Icons.chat_bubble, color: AppColors.primary),
          Icon(Icons.person_outline, color: Colors.black.withValues(alpha: 0.6)),
        ],
      ),
    );
  }
}
