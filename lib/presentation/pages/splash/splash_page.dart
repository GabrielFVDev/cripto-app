import 'package:cointrack/core/constants/font_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _progressController;

  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoOpacityAnimation;
  late Animation<double> _textOpacityAnimation;
  late Animation<Offset> _textSlideAnimation;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();

    // Controlador para o logo
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Controlador para o texto
    _textController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // Controlador para o progress
    _progressController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    // Animações do logo
    _logoScaleAnimation =
        Tween<double>(
          begin: 0.5,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: _logoController,
            curve: Curves.elasticOut,
          ),
        );

    _logoOpacityAnimation =
        Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: _logoController,
            curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
          ),
        );

    // Animações do texto
    _textOpacityAnimation =
        Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: _textController,
            curve: Curves.easeIn,
          ),
        );

    _textSlideAnimation =
        Tween<Offset>(
          begin: const Offset(0, 0.5),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: _textController,
            curve: Curves.easeOutCubic,
          ),
        );

    // Animação do progress
    _progressAnimation =
        Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: _progressController,
            curve: Curves.easeInOut,
          ),
        );

    _startAnimations();
  }

  void _startAnimations() async {
    // Inicia a animação do logo
    _logoController.forward();

    // Aguarda um pouco e inicia o texto
    await Future.delayed(const Duration(milliseconds: 800));
    _textController.forward();

    // Inicia o progress
    await Future.delayed(const Duration(milliseconds: 500));
    await _progressController.forward();

    // Navega para a home page após completar todas as animações
    await Future.delayed(const Duration(milliseconds: 1000));
    if (mounted) {
      context.go('/home');
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF000000), // Preto puro no topo
              Color(0xFF0A0A0A), // Preto com leve variação
              Color(0xFF1A1A2E), // Transição para azul escuro
              Color(0xFF0F3460), // Azul final
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Center(
                  child: AnimatedBuilder(
                    animation: _logoController,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _logoOpacityAnimation.value,
                        child: Transform.scale(
                          scale: _logoScaleAnimation.value,
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.6),
                                  blurRadius: 25,
                                  offset: const Offset(0, 15),
                                ),
                                BoxShadow(
                                  color: const Color(
                                    0xFF0F3460,
                                  ).withValues(alpha: 0.8),
                                  blurRadius: 40,
                                  offset: const Offset(0, 8),
                                ),
                                BoxShadow(
                                  color: Colors.blue.withValues(alpha: 0.3),
                                  blurRadius: 60,
                                  offset: const Offset(0, 0),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.asset(
                                'assets/images/icone.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedBuilder(
                      animation: _textController,
                      builder: (context, child) {
                        return SlideTransition(
                          position: _textSlideAnimation,
                          child: Opacity(
                            opacity: _textOpacityAnimation.value,
                            child: Column(
                              children: [
                                Text(
                                  'CriptoApp',
                                  style: FontText.displayMedium.copyWith(
                                    letterSpacing: 1.2,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black.withValues(
                                          alpha: 0.5,
                                        ),
                                        offset: const Offset(0, 2),
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Seu portal para o mundo crypto',
                                  style: FontText.bodyMedium.copyWith(
                                    color: Colors.white.withValues(alpha: 0.8),
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 60),

                    // Progress indicator animado
                    AnimatedBuilder(
                      animation: _progressController,
                      builder: (context, child) {
                        return Column(
                          children: [
                            SizedBox(
                              width: 200,
                              child: LinearProgressIndicator(
                                value: _progressAnimation.value,
                                backgroundColor: Colors.white.withValues(
                                  alpha: 0.2,
                                ),
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white.withValues(alpha: 0.8),
                                ),
                                minHeight: 3,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Carregando...',
                              style: FontText.bodySmall.copyWith(
                                color: Colors.white.withValues(alpha: 0.6),
                                letterSpacing: 0.8,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),

              // Rodapé
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Text(
                  'v1.0.0',
                  style: FontText.bodySmall.copyWith(
                    color: Colors.white.withValues(alpha: 0.4),
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
