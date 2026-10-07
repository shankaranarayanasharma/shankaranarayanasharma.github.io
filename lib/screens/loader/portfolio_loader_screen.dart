import 'package:flutter/material.dart';
import 'loader_background.dart';
import 'loader_controller.dart';
import 'loader_header_text.dart';
import 'loader_tagline.dart';
import 'loader_tech_stack.dart';
import 'loader_contact_info.dart';
import 'loader_progress_bar.dart';
import 'loader_profile_photo.dart';

/// Main Loader Screen with 2-second hold on completion & exact spacing
class PortfolioLoaderScreen extends StatefulWidget {
  final VoidCallback onLoaded;

  const PortfolioLoaderScreen({
    Key? key,
    required this.onLoaded,
  }) : super(key: key);

  @override
  State<PortfolioLoaderScreen> createState() => _PortfolioLoaderScreenState();
}

class _PortfolioLoaderScreenState extends State<PortfolioLoaderScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late LoaderAnimationController _anim;
  bool _isExiting = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3200),
    );
    _anim = LoaderAnimationController(controller: _controller);
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Wait for 2 seconds after loading 100% before navigating
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) _finishLoading();
        });
      }
    });
    _controller.forward();
  }

  void _finishLoading() {
    if (_isExiting) return;
    setState(() => _isExiting = true);
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) widget.onLoaded();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;

    final isDesktop = screenWidth > 1024;
    final isTablet = screenWidth > 600 && screenWidth <= 1024;

    // User's custom width setting
    final double cardWidth = isDesktop
        ? (screenWidth * 0.35).clamp(650.0, 800.0)
        : (isTablet ? screenWidth * 0.70 : screenWidth * 0.85);

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 350),
      opacity: _isExiting ? 0.0 : 1.0,
      child: Scaffold(
        backgroundColor: const Color(0xFF03050B),
        body: Stack(
          children: [
            LoaderBackground(glowAnimation: _anim.glowAnim),
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Container(
                  width: cardWidth,
                  padding: EdgeInsets.fromLTRB(
                    isDesktop ? 28 : (isTablet ? 20 : 14),
                    isDesktop ? 24 : (isTablet ? 18 : 12),
                    isDesktop ? 28 : (isTablet ? 20 : 14),
                    isDesktop ? 20 : (isTablet ? 16 : 12),
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF060B18).withValues(alpha: 0.94),
                    borderRadius: BorderRadius.circular(isDesktop ? 24 : 18),
                    border: Border.all(
                      color: const Color(0xFF007AFF).withValues(alpha: 0.85),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF007AFF).withValues(alpha: 0.38),
                        blurRadius: 32,
                        spreadRadius: 2,
                      ),
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.85),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      if (isDesktop)
                        Positioned(
                          top: -5,
                          bottom: 10,
                          right: -5,
                          child: LoaderProfilePhoto(animation: _anim.photoAnim),
                        ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (isDesktop)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(flex: 64, child: _buildLeftColumn(isDesktop)),
                                const Spacer(flex: 36),
                              ],
                            )
                          else
                            Column(
                              children: [
                                LoaderProfilePhoto(animation: _anim.photoAnim),
                                const SizedBox(height: 12),
                                _buildLeftColumn(isDesktop),
                              ],
                            ),
                          SizedBox(height: isDesktop ? 28 : 18),
                          LoaderProgressBar(
                            progressAnimation: _anim.progressAnim,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 24,
              right: 24,
              child: TextButton.icon(
                onPressed: _finishLoading,
                icon: const Icon(Icons.fast_forward_rounded,
                    size: 14, color: Colors.white54),
                label: const Text("Skip",
                    style: TextStyle(fontSize: 12, color: Colors.white54)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeftColumn(bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        LoaderHeaderText(
          nameProgress: _anim.nameAnim,
          roleProgress: _anim.roleAnim,
        ),
        SizedBox(height: isDesktop ? 14 : 10),
        LoaderTagline(animation: _anim.taglineAnim),
        SizedBox(height: isDesktop ? 16 : 12),
        LoaderTechStack(animation: _anim.techAnim),
        SizedBox(height: isDesktop ? 16 : 12),
        LoaderContactInfo(animation: _anim.contactAnim),
      ],
    );
  }
}
