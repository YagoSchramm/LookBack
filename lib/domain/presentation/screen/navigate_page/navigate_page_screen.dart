import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:look_back/domain/presentation/screen/navigate_page/navigate_page_state.dart';
import 'package:provider/provider.dart';

class NavigatePageScreen extends StatelessWidget {
  const NavigatePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NavigatePageState(),
      child: const NavigatePageView(),
    );
  }
}

class NavigatePageView extends StatelessWidget {
  const NavigatePageView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = context.watch<NavigatePageState>();

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: state.currentPage,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        child: Container(
          height: 64,
          decoration: BoxDecoration(
            color: theme.colorScheme.surface.withOpacity(0.95),
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: _NavItem(
                  icon: CupertinoIcons.house_fill,
                  selected: state.currentIndex == 0,
                  onTap: () => state.setIndex(0),
                  theme: theme,
                ),
              ),
              Expanded(
                child: _NavItem(
                  icon: CupertinoIcons.person_fill,
                  selected: state.currentIndex == 1,
                  onTap: () => state.setIndex(1),
                  theme: theme,
                ),
              ),
              Expanded(
                child: _NavItem(
                  icon: CupertinoIcons.gear_alt_fill,
                  selected: state.currentIndex == 2,
                  onTap: () => state.setIndex(2),
                  theme: theme,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.selected,
    required this.onTap,
    required this.theme,
  });

  final IconData icon;
  final bool selected;
  final VoidCallback onTap;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: selected ? theme.colorScheme.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: selected ? theme.colorScheme.onPrimary : theme.colorScheme.onSurface.withOpacity(0.5),
            size: 22,
          ),
        ),
      ),
    );
  }
}
