import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lumi/core/theme/app_theme.dart';
import 'package:lumi/core/utils/responsive.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  // Mock user data
  final String userName = "Alex Johnson";
  final String userRole = "Pro Member";
  final String userBio = "Passionate about self-improvement.";
  final String userEmail = "alex.johnson@example.com";
  final String userPhone = "+1 (555) 123-4567";
  final String userLocation = "San Francisco, CA";
  final String memberSince = "Jan 2024";
  final String aboutMe =
      "I'm dedicated to breaking bad habits and building positive routines. Love fitness, reading, and personal development.";
  final List<String> interests = [
    "Health",
    "Sport",
    "Reading",
    "Personal Development",
    "Tech"
  ];

  final int currentStreak = 28;
  final int successRate = 87;
  final int totalCheckIns = 2400;
  final int achievements = 24;

  final int totalHabitsTracked = 12;
  final int hoursFocused = 324;

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final padding = ResponsiveUtil.getPadding(context);
    final isMobile = ResponsiveUtil.isMobile(context);

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Stack(
          children: [
            // Ambient Blobs Background
            Positioned(
              top: -50,
              left: -50,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF6C63FF).withValues(alpha: 0.08),
                ),
              ),
            ),
            Positioned(
              bottom: -80,
              right: -80,
              child: Container(
                width: 350,
                height: 350,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF2563EB).withValues(alpha: 0.08),
                ),
              ),
            ),

            // Main Content
            FadeTransition(
              opacity: _fadeAnimation,
              child: CustomScrollView(
                slivers: [
                  // Custom AppBar
                  SliverAppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    pinned: true,
                    leading: Container(
                      margin: EdgeInsets.only(left: padding * 0.5),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.4),
                          width: 1,
                        ),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_rounded,
                              color: Colors.black87),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                    ),
                    actions: [
                      Padding(
                        padding: EdgeInsets.only(right: padding * 0.5),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildIconButton(Icons.share_rounded, "Share"),
                            SizedBox(width: padding * 0.3),
                            _buildIconButton(
                                Icons.settings_rounded, "Settings"),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Content
                  SliverToBoxAdapter(
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1200),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: padding, vertical: padding),
                          child: Column(
                            children: [
                              // Main Layout - Desktop Row or Mobile Column
                              if (isMobile)
                                _buildMobileLayout(context)
                              else
                                _buildDesktopLayout(context),

                              SizedBox(height: padding),
                            ],
                          ),
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
    );
  }

  /// Desktop Layout - Row with main card on left, sidebar on right
  Widget _buildDesktopLayout(BuildContext context) {
    final padding = ResponsiveUtil.getPadding(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // LEFT COLUMN (Flex 7) - Main Profile Card + About + Interests
        Expanded(
          flex: 7,
          child: Column(
            children: [
              _buildMainProfileCard(context),
              SizedBox(height: padding * 1.5),
              _buildLeftColumn(context),
            ],
          ),
        ),
        SizedBox(width: padding * 2),

        // RIGHT COLUMN (Flex 3) - Sidebar with contacts and gamification
        Expanded(
          flex: 3,
          child: _buildRightSidebar(context),
        ),
      ],
    );
  }

  /// Mobile Layout - Single column
  Widget _buildMobileLayout(BuildContext context) {
    final padding = ResponsiveUtil.getPadding(context);

    return Column(
      children: [
        _buildMainProfileCard(context),
        SizedBox(height: padding * 1.5),
        _buildLeftColumn(context),
        SizedBox(height: padding * 1.5),
        _buildRightSidebar(context),
      ],
    );
  }

  /// Main Profile Card - LinkedIn style unified card with header, avatar, stats
  Widget _buildMainProfileCard(BuildContext context) {
    final isDesktop = ResponsiveUtil.isDesktop(context);
    final padding = ResponsiveUtil.getPadding(context);
    final avatarSize = isDesktop ? 120.0 : 100.0;
    final bannerHeight = isDesktop ? 160.0 : 130.0;
    final headlineSize = ResponsiveUtil.getHeadline2FontSize(context);
    final subtitleSize = ResponsiveUtil.getBodyFontSize(context);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // BANNER (top with upper rounded corners)
          Container(
            height: bannerHeight,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6C63FF), Color(0xFF2563EB)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Stack(
              children: [
                // Decorative element
                Positioned(
                  right: -40,
                  top: -40,
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.08),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // AVATAR (overlaps banner using Stack)
          Transform.translate(
            offset: Offset(0, -avatarSize / 2),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Glow
                Container(
                  width: avatarSize + 20,
                  height: avatarSize + 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF6C63FF).withValues(alpha: 0.15),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF6C63FF).withValues(alpha: 0.2),
                        blurRadius: 40,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                ),
                // Gradient border
                Container(
                  width: avatarSize,
                  height: avatarSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF6C63FF),
                        Color(0xFF2563EB),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF6C63FF).withValues(alpha: 0.3),
                        blurRadius: 25,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(3),
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/avatar.png',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            child: Icon(
                              Icons.person_rounded,
                              size: avatarSize * 0.5,
                              color: AppColors.primary,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // USER INFO (Name, Role, Location)
          Padding(
            padding: EdgeInsets.only(
              left: padding,
              right: padding,
              top: padding * 0.5,
              bottom: padding * 0.5,
            ),
            child: Column(
              children: [
                Text(
                  userName,
                  style: TextStyle(
                    fontSize: headlineSize,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                    fontFamily: 'Outfit',
                  ),
                ),
                SizedBox(height: padding * 0.25),
                Text(
                  userRole,
                  style: TextStyle(
                    fontSize: subtitleSize * 0.95,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary,
                    fontFamily: 'Inter',
                  ),
                ),
                SizedBox(height: padding * 0.1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on_rounded,
                      size: subtitleSize * 0.8,
                      color: Colors.grey[600],
                    ),
                    SizedBox(width: padding * 0.2),
                    Text(
                      userLocation,
                      style: TextStyle(
                        fontSize: subtitleSize * 0.85,
                        color: Colors.grey[600],
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: padding * 0.5),

          // DIVIDER
          Divider(
            color: Colors.grey.withValues(alpha: 0.15),
            height: 1,
            thickness: 1,
            indent: padding,
            endIndent: padding,
          ),

          // STATS SECTION (Compact layout without overflow)
          SizedBox(height: padding * 0.5),
          _buildCompactStatsRow(context),
          SizedBox(height: padding * 0.5),
        ],
      ),
    );
  }

  /// Compact Stats Row - Fixed layout with Expanded to prevent overflow
  Widget _buildCompactStatsRow(BuildContext context) {
    final isMobile = ResponsiveUtil.isMobile(context);
    final padding = ResponsiveUtil.getPadding(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: isMobile
          ? Column(
              children: [
                _buildStatItemCompact(
                  value: "$currentStreak",
                  label: "Streak",
                  icon: Icons.local_fire_department_rounded,
                  iconColor: const Color(0xFFFF6B6B),
                ),
                SizedBox(height: padding * 0.5),
                _buildStatItemCompact(
                  value: "$successRate%",
                  label: "Success",
                  icon: Icons.trending_up_rounded,
                  iconColor: const Color(0xFF51CF66),
                ),
                SizedBox(height: padding * 0.5),
                _buildStatItemCompact(
                  value:
                      "${totalCheckIns ~/ 1000}.${(totalCheckIns % 1000) ~/ 100}k",
                  label: "Check-ins",
                  icon: Icons.check_circle_rounded,
                  iconColor: const Color(0xFF4DABF7),
                ),
                SizedBox(height: padding * 0.5),
                _buildStatItemCompact(
                  value: "$achievements",
                  label: "Awards",
                  icon: Icons.emoji_events_rounded,
                  iconColor: const Color(0xFFFFD43B),
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: _buildStatItemCompact(
                    value: "$currentStreak",
                    label: "Streak",
                    icon: Icons.local_fire_department_rounded,
                    iconColor: const Color(0xFFFF6B6B),
                  ),
                ),
                Expanded(
                  child: _buildStatItemCompact(
                    value: "$successRate%",
                    label: "Success",
                    icon: Icons.trending_up_rounded,
                    iconColor: const Color(0xFF51CF66),
                  ),
                ),
                Expanded(
                  child: _buildStatItemCompact(
                    value:
                        "${totalCheckIns ~/ 1000}.${(totalCheckIns % 1000) ~/ 100}k",
                    label: "Check-ins",
                    icon: Icons.check_circle_rounded,
                    iconColor: const Color(0xFF4DABF7),
                  ),
                ),
                Expanded(
                  child: _buildStatItemCompact(
                    value: "$achievements",
                    label: "Awards",
                    icon: Icons.emoji_events_rounded,
                    iconColor: const Color(0xFFFFD43B),
                  ),
                ),
              ],
            ),
    );
  }

  /// Build header with glass banner and gradient avatar

  /// Build compact stat item for profile card (without left-aligned Row)
  Widget _buildStatItemCompact({
    required String value,
    required String label,
    required IconData icon,
    required Color iconColor,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 20,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
            fontFamily: 'Outfit',
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey[600],
            fontFamily: 'Inter',
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  /// Left column - Info section with Glass panels
  Widget _buildLeftColumn(BuildContext context) {
    final padding = ResponsiveUtil.getPadding(context);
    final headlineSize = ResponsiveUtil.getHeadline3FontSize(context);
    final bodySize = ResponsiveUtil.getBodyFontSize(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Contact Information Section
        _buildSectionTitle("Contact Information", headlineSize),
        SizedBox(height: padding * 0.5),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.grey.withValues(alpha: 0.2),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          padding: EdgeInsets.all(padding * 0.8),
          child: _buildContactListItems(context),
        ),
        SizedBox(height: padding),

        // About Me Section
        _buildSectionTitle("About Me", headlineSize),
        SizedBox(height: padding * 0.5),
        Container(
          padding: EdgeInsets.all(padding),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.grey.withValues(alpha: 0.2),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Text(
            aboutMe,
            style: TextStyle(
              fontSize: bodySize,
              color: Colors.grey[700],
              fontFamily: 'Inter',
              height: 1.6,
            ),
          ),
        ),
        SizedBox(height: padding),

        // Interests Section
        _buildSectionTitle("Interests", headlineSize),
        SizedBox(height: padding * 0.5),
        Wrap(
          spacing: padding * 0.4,
          runSpacing: padding * 0.4,
          children: interests
              .map(
                (interest) => Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary.withValues(alpha: 0.25),
                        AppColors.primary.withValues(alpha: 0.15),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.5),
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: padding * 0.6,
                    vertical: padding * 0.35,
                  ),
                  child: Text(
                    interest,
                    style: TextStyle(
                      fontSize: bodySize * 0.85,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                      fontFamily: 'Outfit',
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  /// Build contact list items
  Widget _buildContactListItems(BuildContext context) {
    final isMobile = ResponsiveUtil.isMobile(context);

    if (isMobile) {
      return Column(
        children: [
          _buildContactListTile(
            icon: Icons.email_rounded,
            title: "Email",
            value: userEmail,
            color: const Color(0xFF4DABF7),
          ),
          Divider(
            color: Colors.grey.withValues(alpha: 0.15),
            height: 1,
            thickness: 1,
          ),
          _buildContactListTile(
            icon: Icons.phone_rounded,
            title: "Phone",
            value: userPhone,
            color: const Color(0xFF51CF66),
          ),
          Divider(
            color: Colors.grey.withValues(alpha: 0.15),
            height: 1,
            thickness: 1,
          ),
          _buildContactListTile(
            icon: Icons.location_on_rounded,
            title: "Location",
            value: userLocation,
            color: const Color(0xFFFF6B6B),
          ),
          Divider(
            color: Colors.grey.withValues(alpha: 0.15),
            height: 1,
            thickness: 1,
          ),
          _buildContactListTile(
            icon: Icons.calendar_today_rounded,
            title: "Member Since",
            value: memberSince,
            color: const Color(0xFFFFD43B),
          ),
        ],
      );
    } else {
      return GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: ResponsiveUtil.getPadding(context) * 0.5,
        crossAxisSpacing: ResponsiveUtil.getPadding(context) * 0.5,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _buildContactCard(
            icon: Icons.email_rounded,
            title: "Email",
            value: userEmail,
            color: const Color(0xFF4DABF7),
          ),
          _buildContactCard(
            icon: Icons.phone_rounded,
            title: "Phone",
            value: userPhone,
            color: const Color(0xFF51CF66),
          ),
          _buildContactCard(
            icon: Icons.location_on_rounded,
            title: "Location",
            value: userLocation,
            color: const Color(0xFFFF6B6B),
          ),
          _buildContactCard(
            icon: Icons.calendar_today_rounded,
            title: "Member Since",
            value: memberSince,
            color: const Color(0xFFFFD43B),
          ),
        ],
      );
    }
  }

  /// Build contact list tile
  Widget _buildContactListTile({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    fontFamily: 'Inter',
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Right sidebar - Gamification cards with vibrant gradients
  Widget _buildRightSidebar(BuildContext context) {
    final padding = ResponsiveUtil.getPadding(context);

    return Column(
      spacing: padding * 0.5,
      children: [
        _buildVibrantGradientCard(
          title: "Total Habits\nTracked",
          value: "$totalHabitsTracked",
          gradient: const LinearGradient(
            colors: [Color(0xFF2E5090), Color(0xFF4DABF7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          icon: Icons.checklist_rounded,
        ),
        _buildVibrantGradientCard(
          title: "Hours\nFocused",
          value: "$hoursFocused",
          gradient: const LinearGradient(
            colors: [Color(0xFF4C1B6B), Color(0xFF9333EA)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          icon: Icons.schedule_rounded,
        ),
        _buildVibrantGradientCard(
          title: "Global Rank",
          value: "Top 5%",
          gradient: const LinearGradient(
            colors: [Color(0xFFB91C1C), Color(0xFFEF4444)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          icon: Icons.trending_up_rounded,
        ),
      ],
    );
  }

  /// Build vibrant gradient card with icon
  Widget _buildVibrantGradientCard({
    required String title,
    required String value,
    required LinearGradient gradient,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white70,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              fontFamily: 'Outfit',
            ),
          ),
        ],
      ),
    );
  }

  /// Build individual contact card (for grid layout)
  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.85),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.4),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
              fontFamily: 'Inter',
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
              fontFamily: 'Inter',
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  /// Build section title
  Widget _buildSectionTitle(String title, double fontSize) {
    return Text(
      title,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w700,
        color: Colors.black87,
        fontFamily: 'Outfit',
      ),
    );
  }

  /// Build outlined button

  /// Build icon button for AppBar
  Widget _buildIconButton(IconData icon, String tooltip) {
    return Tooltip(
      message: tooltip,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(12),
        ),
        child: IconButton(
          icon: Icon(icon, color: Colors.black87),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('$tooltip feature coming soon'),
                duration: const Duration(milliseconds: 1500),
              ),
            );
          },
        ),
      ),
    );
  }
}
