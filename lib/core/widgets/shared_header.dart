import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lumi/core/services/auth_service.dart';
import '../theme/app_theme.dart';

/// A shared, public header used across Landing / Home / Tracker screens.
class SharedAppHeader extends StatefulWidget implements PreferredSizeWidget {
  const SharedAppHeader({Key? key}) : super(key: key);

  @override
  State<SharedAppHeader> createState() => _SharedAppHeaderState();

  @override
  Size get preferredSize => const Size.fromHeight(76);
}

class _SharedAppHeaderState extends State<SharedAppHeader> {
  bool _loggedIn = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final v = AuthService.isLoggedIn();
    if (!mounted) return;
    setState(() => _loggedIn = v);
  }

  Future<void> _logout() async {
    await AuthService.clearUser();
    if (!mounted) return;
    setState(() => _loggedIn = false);
    if (context.mounted) context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
        child: Container(
          height: 76,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(255, 255, 255, 0.72),
            border: const Border(
              bottom: BorderSide(color: Color(0x11000000), width: 1),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
            child: LayoutBuilder(builder: (context, constraints) {
              final isDesktop = constraints.maxWidth >= 800;
              if (!isDesktop) {
                return Row(
                  children: [
                    Row(children: [
                      Icon(Icons.spa_rounded, color: AppColors.primary),
                      const SizedBox(width: 8),
                      Text('LUMI',
                          style: Theme.of(context).textTheme.titleMedium),
                    ]),
                    const Spacer(),
                    Builder(builder: (ctx) {
                      return IconButton(
                        icon: const Icon(Icons.menu),
                        onPressed: () => Scaffold.of(ctx).openDrawer(),
                      );
                    })
                  ],
                );
              }

              return Row(
                children: [
                  Row(children: [
                    Icon(Icons.spa_rounded, color: AppColors.primary),
                    const SizedBox(width: 8),
                    Text('LUMI',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold)),
                  ]),
                  const Spacer(),
                  Row(children: [
                    TextButton(onPressed: () {}, child: const Text('Features')),
                    const SizedBox(width: 8),
                    TextButton(
                        onPressed: () {}, child: const Text('Solutions')),
                    const SizedBox(width: 8),
                    TextButton(
                        onPressed: () {}, child: const Text('Resources')),
                  ]),
                  const Spacer(),
                  Row(
                      children: _loggedIn
                          ? [
                              TextButton(
                                  onPressed: _logout,
                                  child: const Text('Log Out')),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () => context.push('/app'),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary),
                                child: const Text('Open App'),
                              ),
                            ]
                          : [
                              TextButton(
                                  onPressed: () => context.push('/auth'),
                                  child: const Text('Log In')),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () => context.push('/auth'),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary),
                                child: const Text('Get LUMI Free'),
                              ),
                            ]),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
