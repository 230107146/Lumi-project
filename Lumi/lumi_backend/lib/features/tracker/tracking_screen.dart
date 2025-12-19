import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lumi/core/services/auth_service.dart';
import 'package:lumi/core/utils/responsive.dart';
import '../home/models/habit_model.dart';

class TrackingScreen extends StatefulWidget {
  final Habit habit;

  const TrackingScreen({super.key, required this.habit});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  late int _counter;
  late TextEditingController _noteController;

  @override
  void initState() {
    super.initState();
    _counter = widget.habit.currentProgress;
    _noteController = TextEditingController();
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
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle,
                    color: Color(0xFF6C63FF), size: 64),
                const SizedBox(height: 20),
                Text(
                  'Progress Saved!',
                  style: GoogleFonts.outfit(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF6C63FF),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Great work on "${widget.habit.title}"!',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                    context.go('/app');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF6C63FF),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    minimumSize: const Size(double.infinity, 56),
                  ),
                  child: Text(
                    'Continue',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _getHabitEmoji(String habitTitle) {
    final title = habitTitle.toLowerCase();
    if (title.contains('phone') || title.contains('social')) {
      return '📱';
    } else if (title.contains('smoke') || title.contains('smoking')) {
      return '🚭';
    } else if (title.contains('junk') || title.contains('food')) {
      return '🍕';
    } else if (title.contains('game') || title.contains('gaming')) {
      return '🎮';
    }
    return '✨';
  }

  @override
  Widget build(BuildContext context) {
    final isDesktopLayout = ResponsiveUtil.isDesktop(context);

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;
          final isDesktop = maxWidth > 1000 && isDesktopLayout;

          if (isDesktop) {
            // DESKTOP: True split-screen (Notion/Linear style)
            return Row(
              children: [
                // LEFT SIDE: White background with form/counter
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 80,
                      vertical: 40,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Back button (top-left)
                        GestureDetector(
                          onTap: () => context.go('/app'),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.arrow_back,
                                size: 24,
                                color: Color(0xFF6C63FF),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Back',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF6C63FF),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const Spacer(),

                        // Center content: Title and counter
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Log Activity',
                              style: GoogleFonts.outfit(
                                fontSize: 48,
                                fontWeight: FontWeight.w900,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              widget.habit.title,
                              style: GoogleFonts.inter(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 48),

                            // Counter display
                            Center(
                              child: Column(
                                children: [
                                  // Large number
                                  Text(
                                    '$_counter',
                                    style: GoogleFonts.outfit(
                                      fontSize: 140,
                                      fontWeight: FontWeight.w900,
                                      color: Color(0xFF6C63FF),
                                      height: 1.0,
                                    ),
                                  ),
                                  const SizedBox(height: 24),

                                  // Increment/Decrement buttons
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            if (_counter > 0) {
                                              _counter--;
                                            }
                                          });
                                        },
                                        child: Container(
                                          width: 56,
                                          height: 56,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[100],
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: const Center(
                                            child: Icon(
                                              Icons.remove,
                                              size: 24,
                                              color: Color(0xFF6C63FF),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() => _counter++);
                                        },
                                        child: Container(
                                          width: 56,
                                          height: 56,
                                          decoration: BoxDecoration(
                                            color: Color(0xFF6C63FF),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: const Center(
                                            child: Icon(
                                              Icons.add,
                                              size: 24,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 48),

                            // Note field
                            TextField(
                              controller: _noteController,
                              maxLines: 3,
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[50],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: Colors.grey[300]!,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF6C63FF),
                                    width: 2,
                                  ),
                                ),
                                labelText: 'Notes (optional)',
                                labelStyle: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: Colors.black38,
                                ),
                                hintText: 'How did you feel?',
                                hintStyle: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: Colors.black26,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 14,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const Spacer(),

                        // Save button (bottom-left)
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _saveProgress,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF6C63FF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                              ),
                            ),
                            child: Text(
                              'Save Progress',
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // RIGHT SIDE: Purple gradient with large emoji/visual
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF6C63FF),
                          Color(0xFF2563EB),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Large emoji icon
                          Text(
                            _getHabitEmoji(widget.habit.title),
                            style: const TextStyle(fontSize: 300),
                          ),
                          const SizedBox(height: 40),

                          // Motivational text
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Text(
                              'You\'re building better habits',
                              style: GoogleFonts.outfit(
                                fontSize: 36,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                height: 1.3,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Text(
                              'Every action counts. Keep going!',
                              style: GoogleFonts.inter(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.white70,
                                height: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            // MOBILE: Stacked single-column layout
            return SingleChildScrollView(
              child: Column(
                children: [
                  // White form section
                  Container(
                    color: Colors.white,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 32,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Back button
                        GestureDetector(
                          onTap: () => context.go('/app'),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.arrow_back,
                                size: 20,
                                color: Color(0xFF6C63FF),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Back',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF6C63FF),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Title
                        Text(
                          'Log Activity',
                          style: GoogleFonts.outfit(
                            fontSize: 36,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.habit.title,
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 40),

                        // Counter display
                        Center(
                          child: Column(
                            children: [
                              Text(
                                '$_counter',
                                style: GoogleFonts.outfit(
                                  fontSize: 100,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF6C63FF),
                                  height: 1.0,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (_counter > 0) {
                                          _counter--;
                                        }
                                      });
                                    },
                                    child: Container(
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[100],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.remove,
                                          size: 20,
                                          color: Color(0xFF6C63FF),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() => _counter++);
                                    },
                                    child: Container(
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF6C63FF),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.add,
                                          size: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 40),

                        // Note field
                        TextField(
                          controller: _noteController,
                          maxLines: 3,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[50],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Colors.grey[300]!,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: Color(0xFF6C63FF),
                                width: 2,
                              ),
                            ),
                            labelText: 'Notes (optional)',
                            labelStyle: GoogleFonts.inter(
                              fontSize: 14,
                              color: Colors.black38,
                            ),
                            hintText: 'How did you feel?',
                            hintStyle: GoogleFonts.inter(
                              fontSize: 14,
                              color: Colors.black26,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Save button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _saveProgress,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF6C63FF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 14,
                              ),
                            ),
                            child: Text(
                              'Save Progress',
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Purple gradient visual section
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF6C63FF),
                          Color(0xFF2563EB),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 60,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Emoji
                        Text(
                          _getHabitEmoji(widget.habit.title),
                          style: const TextStyle(fontSize: 120),
                        ),
                        const SizedBox(height: 32),

                        // Motivational text
                        Text(
                          'You\'re building better habits',
                          style: GoogleFonts.outfit(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            height: 1.3,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Every action counts. Keep going!',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white70,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
