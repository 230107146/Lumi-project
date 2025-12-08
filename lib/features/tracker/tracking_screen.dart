import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_theme.dart';
import '../../core/services/auth_service.dart';
import '../home/models/habit_model.dart';
import '../../core/widgets/responsive_wrapper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lumi/core/widgets/shared_header.dart';
import 'package:lumi/core/widgets/shared_footer.dart';

class TrackingScreen extends StatefulWidget {
  final Habit habit;

  const TrackingScreen({super.key, required this.habit});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  late int _counter;
  late double _hours;
  final TextEditingController _noteController = TextEditingController();

  static const double _kHeaderHeight = 76.0;

  @override
  void initState() {
    super.initState();
    _counter = widget.habit.currentProgress;
    _hours = 0.0;
    // Remember this route as last visited when user opens a tracker
    AuthService.saveLastRoute('/track');
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _saveProgress() async {
    await showDialog<void>(
        context: context,
        builder: (dialogContext) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_circle, size: 64, color: AppColors.primary),
                  const SizedBox(height: 12),
                  Text('Progress Saved!',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('One step closer to your goal!',
                      style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 16),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(dialogContext).pop();
                        // navigate back to home/root
                        context.go('/');
                      },
                      child: const Text('Done'))
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final screenHeight = MediaQuery.of(context).size.height;

    return ResponsiveWrapper(
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        drawer: null,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: _kHeaderHeight),

                    // HERO: full-bleed gradient background that fills remaining viewport
                    Container(
                      width: double.infinity,
                      constraints: BoxConstraints(
                          minHeight: screenHeight - _kHeaderHeight),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF6C63FF), Color(0xFF8B85FF)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 48, horizontal: 16),
                      child: Column(
                        children: [
                          Center(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 1100),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(widget.habit.title,
                                      style: GoogleFonts.outfit(
                                          fontSize: 40,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.white)),
                                  const SizedBox(height: 12),
                                  Text('How did it go today?',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                  const SizedBox(height: 24),

                                  // Interaction controls (counter / timer)
                                  if (widget.habit.type ==
                                      AddictionType.counter) ...[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          radius: 26,
                                          backgroundColor: Colors.white24,
                                          child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                if (_counter > 0) _counter--;
                                              });
                                            },
                                            icon: const Icon(Icons.remove,
                                                color: Colors.white),
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                        Text('$_counter',
                                            style: const TextStyle(
                                                fontSize: 56,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white)),
                                        const SizedBox(width: 20),
                                        CircleAvatar(
                                          radius: 26,
                                          backgroundColor: Colors.white,
                                          child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _counter++;
                                              });
                                            },
                                            icon: Icon(Icons.add,
                                                color: AppColors.primary),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ] else ...[
                                    Column(
                                      children: [
                                        Text(
                                            _hours % 1 == 0
                                                ? '${_hours.toInt()} hours'
                                                : '${_hours.toStringAsFixed(1)} hours',
                                            style: const TextStyle(
                                                fontSize: 40,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white)),
                                        const SizedBox(height: 12),
                                        Slider(
                                          min: 0,
                                          max: 12,
                                          divisions: 24,
                                          value: _hours,
                                          activeColor: Colors.white,
                                          inactiveColor: Colors.white38,
                                          label: _hours % 1 == 0
                                              ? '${_hours.toInt()} h'
                                              : '${_hours.toStringAsFixed(1)} h',
                                          onChanged: (v) =>
                                              setState(() => _hours = v),
                                        ),
                                      ],
                                    ),
                                  ],

                                  const SizedBox(height: 24),
                                  ConstrainedBox(
                                    constraints:
                                        const BoxConstraints(maxWidth: 760),
                                    child: TextField(
                                      controller: _noteController,
                                      maxLines: 4,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white24,
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        labelText: 'Note',
                                        labelStyle: const TextStyle(
                                            color: Colors.white70),
                                        hintText: 'How do you feel?',
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 28),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ElevatedButton(
                                        onPressed: _saveProgress,
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(14))),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 18.0, vertical: 14.0),
                                          child: Text('Save Progress',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: AppColors.primary)),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      OutlinedButton(
                                          onPressed: () => context.go('/app'),
                                          style: OutlinedButton.styleFrom(
                                              side: BorderSide(
                                                  color: Colors.white24)),
                                          child: const Text('Back to Home',
                                              style: TextStyle(
                                                  color: Colors.white)))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 36),

                          // Full-width statistic band that stretches the full screen
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 0),
                            child: Container(
                              width: double.infinity,
                              height: 140,
                              color: Colors.white24,
                              child: Center(
                                child: ConstrainedBox(
                                  constraints:
                                      const BoxConstraints(maxWidth: 1100),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Daily Goals',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineSmall
                                                    ?.copyWith(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                            const SizedBox(height: 6),
                                            Text(
                                                'You are doing great! Keep it up.',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(
                                                        color: Colors.white70)),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 120,
                                        child: Center(
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              CircularProgressIndicator(
                                                  value: 0.44,
                                                  color: Colors.white70,
                                                  backgroundColor:
                                                      Colors.white24),
                                              const Text('44%',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold))
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Shared footer
                    const SharedFooter(),

                    // Bottom spacer so floating UI doesn't block content
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),

            // Fixed header (shared)
            const Positioned(
                top: 0, left: 0, right: 0, child: SharedAppHeader()),
          ],
        ),
      ),
    );
  }
}
