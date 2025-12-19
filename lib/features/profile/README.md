# Profile Screen - Complete Responsive Design

## Overview
`ProfileScreen` is a fully responsive user profile page built with Clean SaaS style and Glassmorphism design. It showcases user stats, contact information, achievements, and gamification elements.

## Features

### 1. **Responsive Design**
- **Desktop** (>900px): Two-column layout (65% info, 35% sidebar)
- **Tablet** (600-900px): Responsive sizing with adaptive spacing
- **Mobile** (<600px): Single-column layout with optimized touch targets

### 2. **Header Section**
- Gradient banner (Purple → Blue) with decorative overlay
- Circular avatar (120px desktop, 100px mobile) with white border
- User name, role, and bio
- Action buttons: "Edit Profile" (outlined) and "Settings" (filled)

### 3. **Stats Row**
- 4 responsive stat cards (2x2 on mobile, 1x4 on desktop)
- Each card shows: value, label, and colored icon
- Cards: Current Streak, Success Rate, Check-ins, Achievements

### 4. **Contact Information**
- Responsive grid (2 columns mobile, 4 columns desktop)
- Contact cards with icons and color coding:
  - Email, Phone, Location, Member Since

### 5. **About & Interests**
- "About Me" section with longer description text
- Interest tags (Chips) with primary color styling
- Responsive spacing and wrapping

### 6. **Gamification Sidebar**
- 3 gradient cards (only visible on desktop, below content on mobile)
- Cards: Total Habits Tracked, Hours Focused, Global Rank
- Colorful gradients (Blue, Purple, Pink)

## Navigation Integration

### From HomeScreen (Avatar Tap):
```dart
// In home_screen.dart, add to avatar GestureDetector:
GestureDetector(
  onTap: () {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ProfileScreen(),
      ),
    );
  },
  child: // ... avatar widget
)
```

### Using GoRouter (Recommended):
```dart
// In your router configuration:
GoRoute(
  path: '/profile',
  builder: (context, state) => const ProfileScreen(),
)

// In home_screen.dart:
GestureDetector(
  onTap: () => context.go('/profile'),
  child: // ... avatar widget
)
```

## Styling Details

### Colors
- **Primary**: #6C63FF (Purple)
- **Secondary Gradient**: #5A67D8 (Blue)
- **Background**: #F7F7F7 (Light Gray)
- **Surface**: #FFFFFF (White)

### Fonts
- **Headings**: Outfit (700 bold)
- **Body**: Inter (regular)
- **Secondary**: Inter (500/600 medium)

### Sizing
- **Desktop Avatar**: 120px
- **Mobile Avatar**: 100px
- **Banner Height Desktop**: 200px
- **Banner Height Mobile**: 160px

### Spacing
- **Padding Desktop**: 40px
- **Padding Mobile**: 24px
- **Card Radius**: 16px
- **Icon Radius**: 12px

## Mock Data
All data is hardcoded in the state:
- User name, email, phone, location
- Bio and interests
- Stats: streak, success rate, check-ins, achievements
- Gamification: habits tracked, hours focused, rank

## Responsive Behavior

### Desktop (>900px)
```
┌─────────────────────────────────────┐
│ Back    ← Settings → Share          │
├─────────────────────────────────────┤
│            [Avatar]                 │
│           Name, Role, Bio           │
│        [Edit Profile] [Settings]    │
├─────────────────────────────────────┤
│  [Stat1] [Stat2] [Stat3] [Stat4]   │
├──────────────────────┬──────────────┤
│  Contact Grid (4x1)  │ Total Habits │
│                      │ Hours Focus  │
│  About Me Section    │ Global Rank  │
│                      │              │
│  Interests (Chips)   │              │
└──────────────────────┴──────────────┘
```

### Mobile (<600px)
```
┌─────────────────────┐
│ Back  ← Settings →  │
├─────────────────────┤
│     [Avatar]        │
│    Name, Role       │
│   [Edit] [Settings] │
├─────────────────────┤
│ [Stat1] [Stat2]     │
│ [Stat3] [Stat4]     │
├─────────────────────┤
│ Contact (2x2)       │
│ About Me            │
│ Interests           │
│ Total Habits        │
│ Hours Focus         │
│ Global Rank         │
└─────────────────────┘
```

## Customization

### Change User Data
Edit the mock data properties in `_ProfileScreenState`:
```dart
final String userName = "Your Name";
final String userEmail = "your@email.com";
// ... more properties
```

### Add Navigation Integration
Update `_buildIconButton` to handle real Share/Settings navigation:
```dart
Widget _buildIconButton(IconData icon, String tooltip) {
  return Tooltip(
    message: tooltip,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.black87),
        onPressed: () {
          if (tooltip == "Share") {
            // Handle share
          } else if (tooltip == "Settings") {
            // Navigate to settings
          }
        },
      ),
    ),
  );
}
```

### Modify Colors
Update gradient colors in:
- `_buildHeader` - Banner gradient
- `_buildGradientCard` - Sidebar card gradients
- `_buildStatCard` - Icon colors

## Dependencies
- `flutter`: Core framework
- `lumi` (internal): `AppColors`, `ResponsiveUtil`

## Accessibility
- Back button for navigation (WillPopScope)
- Clear tooltip labels on AppBar buttons
- High contrast text colors
- Sufficient touch target sizes (48px+ recommended)

## Future Enhancements
1. Real data from Riverpod state management
2. Edit profile functionality
3. Image upload for avatar
4. Real social sharing
5. Settings page navigation
6. Landscape mode support
7. Profile preview before sharing
