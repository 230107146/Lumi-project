import 'package:flutter/material.dart';

/// Shared footer used across pages.
class SharedFooter extends StatelessWidget {
  const SharedFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF2D2D2D),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Row(children: [
                      Icon(Icons.spa_rounded, color: Colors.white),
                      const SizedBox(width: 8),
                      Text('LUMI',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: Colors.white))
                    ]),
                    const SizedBox(height: 12),
                    Text('Quit bad habits and build a better life.',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.white70))
                  ])),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text('Product',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    TextButton(
                        onPressed: () {},
                        child: const Text('Features',
                            style: TextStyle(color: Colors.white70))),
                    TextButton(
                        onPressed: () {},
                        child: const Text('Pricing',
                            style: TextStyle(color: Colors.white70)))
                  ])),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text('Legal',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    TextButton(
                        onPressed: () {},
                        child: const Text('Terms',
                            style: TextStyle(color: Colors.white70))),
                    TextButton(
                        onPressed: () {},
                        child: const Text('Privacy',
                            style: TextStyle(color: Colors.white70)))
                  ])),
            ]),
            const SizedBox(height: 24),
            Text('Copyright © 2025 LUMI',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.white70))
          ]),
        ),
      ),
    );
  }
}
