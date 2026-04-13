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
      backgroundColor: AppColors.backgroundLightBlue,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            const Spacer(),
            _buildOrbContainer(),
            const Spacer(),
            Text(
              _statusText,
              style: AppTextStyles.h2.copyWith(color: AppColors.primary, fontSize: 26),
            ),
            const Gap(8),
            Text(
              _hintText,
              style: AppTextStyles.bodyRegular.copyWith(fontSize: 12, color: AppColors.textSecondary),
            ),
            const Gap(32),
            _buildBottomControls(),
            const Gap(32),
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
          ClipOval(
            child: Image.asset('assets/images/avatar_1.png', width: 44, height: 44, fit: BoxFit.cover),
          ),
          Image.asset('assets/images/logo.png', width: 80, height: 35, fit: BoxFit.contain),
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.border),
            ),
            child: const Icon(Icons.notifications_none, color: AppColors.textPrimary, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildOrbContainer() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 800),
      transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
      child: _state == VoiceSathiState.responding || _state == VoiceSathiState.waiting
          ? _buildRespondingState()
          : _buildActiveOrb(),
    );
  }

  Widget _buildActiveOrb() {
    return Column(
      key: const ValueKey('active_orb'),
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 280,
          height: 380,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.primaryDeep, AppColors.primary],
            ),
          ),
          child: Center(
            child: _state == VoiceSathiState.listening 
              ? _buildListeningOrb() 
              : _buildInitializingOrb(),
          ),
        ),
      ],
    );
  }

  Widget _buildInitializingOrb() {
    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.brandLightBlue.withValues(alpha: 0.6),
            blurRadius: 60,
            spreadRadius: 20,
          ),
        ],
        gradient: const RadialGradient(
          colors: [AppColors.brandLightBlue, Colors.transparent],
        ),
      ),
    );
  }

  Widget _buildListeningOrb() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.brandLightBlue.withValues(alpha: 0.3), width: 2),
          ),
        ),
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.brandLightBlue.withValues(alpha: 0.8),
                blurRadius: 30,
                spreadRadius: 5,
              ),
            ],
            gradient: const RadialGradient(
              colors: [AppColors.brandCyan, AppColors.primary],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRespondingState() {
     return Column(
      key: const ValueKey('responding_state'),
      children: [
        // Small Orb at top
        Container(
           width: 80,
           height: 80,
           decoration: BoxDecoration(
             shape: BoxShape.circle,
             boxShadow: [
               BoxShadow(
                 color: AppColors.brandLightBlue.withValues(alpha: 0.5),
                 blurRadius: 20,
               ),
             ],
             gradient: const RadialGradient(
               colors: [AppColors.brandCyan, AppColors.primary],
             ),
           ),
        ),
        const Gap(24),
        // Response Card
        Container(
          width: 320,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.primaryDeep, AppColors.primary],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Chào Loi! Thật vui khi biết bạn đang coi trọng sức khỏe tinh thần của mình.',
                style: AppTextStyles.fontPoppins(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  height: 1.4,
                ),
              ),
              const Gap(12),
               Text(
                'Trước khi bắt đầu, tôi muốn bạn hít một hơi thật sâu trong 5 giây.',
                style: AppTextStyles.fontPoppins(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: 16,
                  height: 1.4,
                ),
              ),
              const Gap(16),
              const Text('.....', style: TextStyle(color: Colors.white, fontSize: 24)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomControls() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.close, color: AppColors.primary, size: 24),
          ),
          const Gap(24),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _state == VoiceSathiState.listening ? AppColors.primary : Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Icon(
              Icons.mic, 
              color: _state == VoiceSathiState.listening ? Colors.white : AppColors.primary, 
              size: 28
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
