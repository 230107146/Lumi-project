import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/services/auth_service.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen>
    with SingleTickerProviderStateMixin {
  bool isLoginMode = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscure = true;
  late final AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController =
        AnimationController(vsync: this, duration: const Duration(seconds: 4))
          ..repeat(reverse: true);
  }

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() != true) return;
    final email = _emailController.text.trim();
    final pass = _passwordController.text.trim();

    if (!isLoginMode) {
      final registered = await AuthService.registerUser(email, pass);
      if (!registered) {
        if (!mounted) return;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.orange.shade700,
              content: const Text('Account already exists, please sign in.'),
            ));
            setState(() => isLoginMode = true);
          }
        });
        return;
      }
      await AuthService.saveUser(email);
      if (!mounted) return;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green.shade700,
            content: const Text('Account created — logged in.'),
          ));
        }
      });
      final last = await AuthService.getLastRoute();
      if (!mounted) return;
      final route = last ?? '/app';
      // ignore: use_build_context_synchronously
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) context.go(route);
      });
      return;
    }

    final ok = await AuthService.validateCredentials(email, pass);
    if (ok) {
      await AuthService.saveUser(email);
      if (!mounted) return;
      final last = await AuthService.getLastRoute();
      if (!mounted) return;
      final route = last ?? '/app';
      // ignore: use_build_context_synchronously
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) context.go(route);
      });
      return;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red.shade700,
          content: const Text('Wrong email or password'),
        ));
      }
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(color: Colors.white),
          AnimatedBuilder(
            animation: _animController,
            builder: (context, child) {
              return Stack(
                children: [
                  Positioned(
                    top: -200 + (_animController.value * 40),
                    left: -200,
                    child: Container(
                      width: 600,
                      height: 600,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFD8B3F8).withValues(alpha: 0.35),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
                        child: Container(color: Colors.transparent),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -200 + (_animController.value * 40),
                    right: -200,
                    child: Container(
                      width: 600,
                      height: 600,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFB3E5FC).withValues(alpha: 0.35),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
                        child: Container(color: Colors.transparent),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: true),
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 40, horizontal: 24),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 380),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                          child: Container(
                            padding: const EdgeInsets.all(40),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.45),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.6),
                                  width: 1.5),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.04),
                                  blurRadius: 20,
                                  spreadRadius: -2,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 48,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(colors: [
                                        Color(0xFFA855F7),
                                        Color(0xFF3B82F6)
                                      ]),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Center(
                                        child: Icon(Icons.auto_awesome,
                                            color: Colors.white, size: 24)),
                                  ),
                                  const SizedBox(height: 16),
                                  Text('LUMI',
                                      style: GoogleFonts.outfit(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFF0F172A))),
                                  const SizedBox(height: 8),
                                  Text(
                                      isLoginMode
                                          ? 'Welcome Back'
                                          : 'Create Account',
                                      style: GoogleFonts.outfit(
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFF0F172A))),
                                  const SizedBox(height: 8),
                                  Text(
                                      isLoginMode
                                          ? 'Enter your details to access your account.'
                                          : 'Join us to get started with LUMI.',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.inter(
                                          fontSize: 14,
                                          color: const Color(0xFF64748B))),
                                  const SizedBox(height: 32),
                                  _ModernTextField(
                                      controller: _emailController,
                                      label: 'Email Address',
                                      hint: 'example@email.com',
                                      icon: Icons.mail_outline,
                                      validator: (value) {
                                        final v = value?.trim() ?? '';
                                        if (v.isEmpty)
                                          return 'Email is required';
                                        if (!RegExp(r"^[\w\.-]+@[\w\.-]+\.\w+")
                                            .hasMatch(v))
                                          return 'Enter a valid email';
                                        return null;
                                      }),
                                  const SizedBox(height: 20),
                                  _ModernTextField(
                                      controller: _passwordController,
                                      label: 'Password',
                                      hint: '••••••••',
                                      icon: Icons.lock_outline,
                                      isPassword: true,
                                      obscureText: _obscure,
                                      onToggleVisibility: () =>
                                          setState(() => _obscure = !_obscure),
                                      validator: (value) {
                                        final v = value ?? '';
                                        if (v.isEmpty)
                                          return 'Password is required';
                                        if (!RegExp(r'^[a-zA-Z0-9]{6,}$')
                                            .hasMatch(v))
                                          return 'Min 6 chars, Latin letters & numbers only';
                                        return null;
                                      }),
                                  if (isLoginMode) ...[
                                    const SizedBox(height: 16),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(children: [
                                            SizedBox(
                                                height: 24,
                                                width: 24,
                                                child: Checkbox(
                                                    value: false,
                                                    onChanged: (v) {},
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4)))),
                                            const SizedBox(width: 8),
                                            Text('Remember me',
                                                style: GoogleFonts.inter(
                                                    fontSize: 13,
                                                    color: const Color(
                                                        0xFF475569))),
                                          ]),
                                          TextButton(
                                              onPressed: () {},
                                              child: Text('Forgot password?',
                                                  style: GoogleFonts.inter(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: const Color(
                                                          0xFFA855F7)))),
                                        ]),
                                  ],
                                  const SizedBox(height: 24),
                                  Container(
                                      width: double.infinity,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          gradient: const LinearGradient(
                                              colors: [
                                                Color(0xFFA855F7),
                                                Color(0xFF3B82F6)
                                              ]),
                                          boxShadow: [
                                            BoxShadow(
                                                color: const Color(0xFFA855F7)
                                                    .withValues(alpha: 0.3),
                                                blurRadius: 12,
                                                offset: const Offset(0, 4))
                                          ]),
                                      child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                              onTap: _submit,
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              child: Center(
                                                  child: Text(
                                                      isLoginMode
                                                          ? 'Sign In'
                                                          : 'Create Account',
                                                      style: GoogleFonts.inter(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors
                                                              .white)))))),
                                  const SizedBox(height: 24),
                                  Row(children: [
                                    Expanded(
                                        child:
                                            Divider(color: Colors.grey[200])),
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Text('or',
                                            style: TextStyle(
                                                color: Colors.grey[400],
                                                fontSize: 13))),
                                    Expanded(
                                        child: Divider(color: Colors.grey[200]))
                                  ]),
                                  const SizedBox(height: 24),
                                  OutlinedButton(
                                      onPressed: () {},
                                      style: OutlinedButton.styleFrom(
                                          foregroundColor: Colors.black,
                                          side: BorderSide(
                                              color: Colors.grey[200]!),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 14)),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(Icons.g_mobiledata,
                                                size: 24),
                                            const SizedBox(width: 8),
                                            Text(
                                                'Sign ${isLoginMode ? "in" : "up"} with Google',
                                                style: GoogleFonts.inter(
                                                    fontWeight:
                                                        FontWeight.w500))
                                          ])),
                                  const SizedBox(height: 24),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                            isLoginMode
                                                ? "Don't have an account? "
                                                : "Already have an account? ",
                                            style: GoogleFonts.inter(
                                                color:
                                                    const Color(0xFF64748B))),
                                        GestureDetector(
                                            onTap: () => setState(() =>
                                                isLoginMode = !isLoginMode),
                                            child: Text(
                                                isLoginMode
                                                    ? "Sign Up"
                                                    : "Sign In",
                                                style: GoogleFonts.inter(
                                                    color:
                                                        const Color(0xFFA855F7),
                                                    fontWeight:
                                                        FontWeight.bold)))
                                      ]),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ModernTextField extends StatelessWidget {
  final String label, hint;
  final IconData icon;
  final bool isPassword, obscureText;
  final VoidCallback? onToggleVisibility;
  final TextEditingController controller;
  final String? Function(String?) validator;

  const _ModernTextField({
    required this.label,
    required this.hint,
    required this.icon,
    required this.controller,
    required this.validator,
    this.isPassword = false,
    this.obscureText = false,
    this.onToggleVisibility,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF334155))),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[400]),
            prefixIcon: Icon(icon, color: Colors.grey[400], size: 20),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                        obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey[400],
                        size: 20),
                    onPressed: onToggleVisibility)
                : null,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.grey[200]!)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide:
                    const BorderSide(color: Color(0xFFA855F7), width: 1.5)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.red[200]!)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.red[300]!, width: 1.5)),
          ),
        ),
      ],
    );
  }
}
