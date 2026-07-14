import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:look_back/domain/presentation/screen/home/home_screen.dart';
import 'package:look_back/domain/presentation/screen/initial/initial_state.dart';
import 'package:provider/provider.dart';


class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => InitialScreenState(),
      child: const InitialScreenContent(),
    );
  }
}

class InitialScreenContent extends StatelessWidget {
  const InitialScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
 
    return Scaffold(
      body: SafeArea(
        child: Consumer<InitialScreenState>(
          builder: (context, state, child) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
 
            final canProceed = state.canProceed;
 
                return Column(
                  children: [
                    Expanded(
                      child: PageView(
                        controller: state.pageController,
                        onPageChanged: (page) {
                          state.handlePageChanged(
                            page,
                            onNavigateToHome: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => const HomeScreen(),
                                  ),
                                );
                              
                            },
                          );
                        },
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 6,
                                  child: Image.asset(
                                    'assets/images/app_initial_image.png',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                const SizedBox(height: 32),
                                Text(
                                  'Reviva seus momentos',
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.headlineMedium,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'Guarde textos, fotos, áudios e localização em um só lugar.',
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    color: theme.colorScheme.onSurface.withOpacity(0.65),
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
 
                          // Página 2 — vitrine de recursos
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 28),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Registre como quiser',
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.headlineMedium,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Cada memória pode ser única',
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                                  ),
                                ),
                                const SizedBox(height: 36),
 
                                // Card — Registrar imagem
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.surface,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.18),
                                        blurRadius: 18,
                                        offset: const Offset(0, 8),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 44,
                                        height: 44,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: theme.colorScheme.primary.withOpacity(0.12),
                                        ),
                                        child: Icon(
                                          CupertinoIcons.photo_fill,
                                          color: theme.colorScheme.primary,
                                          size: 20,
                                        ),
                                      ),
                                      const SizedBox(width: 14),
                                      Expanded(
                                        child: Text(
                                          'Registrar imagem',
                                          style: theme.textTheme.titleMedium,
                                        ),
                                      ),
                                      Icon(
                                        CupertinoIcons.chevron_right,
                                        size: 18,
                                        color: theme.colorScheme.onSurface.withOpacity(0.35),
                                      ),
                                    ],
                                  ),
                                ),
 
                                const SizedBox(height: 14),
                                Text(
                                  'ou',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.onSurface.withOpacity(0.4),
                                  ),
                                ),
                                const SizedBox(height: 14),
 
                                // Card — Registrar áudio
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.surface,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.18),
                                        blurRadius: 18,
                                        offset: const Offset(0, 8),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 44,
                                        height: 44,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: theme.colorScheme.primary.withOpacity(0.12),
                                        ),
                                        child: Icon(
                                          CupertinoIcons.mic_fill,
                                          color: theme.colorScheme.primary,
                                          size: 20,
                                        ),
                                      ),
                                      const SizedBox(width: 14),
                                      Expanded(
                                        child: Text(
                                          'Registrar áudio',
                                          style: theme.textTheme.titleMedium,
                                        ),
                                      ),
                                      Icon(
                                        CupertinoIcons.chevron_right,
                                        size: 18,
                                        color: theme.colorScheme.onSurface.withOpacity(0.35),
                                      ),
                                    ],
                                  ),
                                ),
 
                                const SizedBox(height: 14),
                                Text(
                                  'ou',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.onSurface.withOpacity(0.4),
                                  ),
                                ),
                                const SizedBox(height: 14),
 
                                // Card — Registrar localização (com mini mapa falso)
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.surface,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.18),
                                        blurRadius: 18,
                                        offset: const Offset(0, 8),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 44,
                                            height: 44,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: theme.colorScheme.primary.withOpacity(0.12),
                                            ),
                                            child: Icon(
                                              CupertinoIcons.location_solid,
                                              color: theme.colorScheme.primary,
                                              size: 20,
                                            ),
                                          ),
                                          const SizedBox(width: 14),
                                          Expanded(
                                            child: Text(
                                              'Registrar localização',
                                              style: theme.textTheme.titleMedium,
                                            ),
                                          ),
                                          Icon(
                                            CupertinoIcons.chevron_right,
                                            size: 18,
                                            color: theme.colorScheme.onSurface.withOpacity(0.35),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 14),
 
                                      // Mini mapa falso — sem SDK de mapas, só decoração
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(14),
                                        child: SizedBox(
                                          height: 76,
                                          width: double.infinity,
                                          child: Stack(
                                            fit: StackFit.expand,
                                            children: [
                                              Container(
                                                color: theme.brightness == Brightness.dark
                                                    ? const Color(0xFF16233A)
                                                    : const Color(0xFFE7EEF7),
                                              ),
                                              Positioned(
                                                top: 14,
                                                left: -30,
                                                child: Transform.rotate(
                                                  angle: -0.35,
                                                  child: Container(
                                                    width: 220,
                                                    height: 3,
                                                    color: theme.colorScheme.onSurface.withOpacity(0.08),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top: 40,
                                                left: -40,
                                                child: Transform.rotate(
                                                  angle: 0.2,
                                                  child: Container(
                                                    width: 240,
                                                    height: 2,
                                                    color: theme.colorScheme.onSurface.withOpacity(0.06),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 6,
                                                right: -20,
                                                child: Transform.rotate(
                                                  angle: -0.5,
                                                  child: Container(
                                                    width: 180,
                                                    height: 2,
                                                    color: theme.colorScheme.onSurface.withOpacity(0.06),
                                                  ),
                                                ),
                                              ),
                                              Center(
                                                child: Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    Container(
                                                      width: 44,
                                                      height: 44,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: theme.colorScheme.primary.withOpacity(0.18),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.all(6),
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: theme.colorScheme.primary,
                                                      ),
                                                      child: const Icon(
                                                        CupertinoIcons.location_solid,
                                                        color: Colors.white,
                                                        size: 14,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
 
                          // Página 3 — olhar para trás + nome
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ÚLTIMO PASSO',
                                  style: theme.textTheme.labelMedium?.copyWith(
                                    color: theme.colorScheme.primary,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Como podemos te chamar?',
                                  style: theme.textTheme.headlineMedium,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Vamos usar seu nome para deixar suas lembranças mais pessoais.',
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                                  ),
                                ),
                                const SizedBox(height: 32),
                                TextField(
                                  controller: state.nameController,
                                  textCapitalization: TextCapitalization.words,
                                  style: theme.textTheme.titleLarge,
                                  cursorColor: theme.colorScheme.primary,
                                  decoration: InputDecoration(
                                    labelText: 'Seu nome',
                                    hintText: 'Ex: Ana',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide: BorderSide.none,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide: BorderSide(
                                        color: theme.colorScheme.primary,
                                        width: 1.4,
                                      ),
                                    ),
                                  ),
                                  onChanged: (_) => state.notifyListeners(),
                                  onSubmitted: (_) {
                                  
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
 
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
                      child: Row(
                        children: [
                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 200),
                            opacity: state.currentPage == 0 ? 0 : 1,
                            child: IgnorePointer(
                              ignoring: state.currentPage == 0,
                              child: SizedBox(
                                width: 56,
                                height: 56,
                                child: FilledButton(
                                  onPressed: state.previousPage,
                                  style: FilledButton.styleFrom(
                                    shape: const CircleBorder(),
                                    padding: EdgeInsets.zero,
                                    elevation: 4,
                                    shadowColor: theme.colorScheme.primary.withOpacity(0.4),
                                  ),
                                  child: const Icon(CupertinoIcons.chevron_back, size: 18),
                                ),
                              ),
                            ),
                          ),
 
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(state.pageCount, (index) {
                                final selected = index == state.currentPage;
 
                                return AnimatedContainer(
                                  duration: const Duration(milliseconds: 250),
                                  curve: Curves.easeOut,
                                  margin: const EdgeInsets.symmetric(horizontal: 4),
                                  width: selected ? 24 : 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: selected
                                        ? theme.colorScheme.primary
                                        : theme.colorScheme.outline.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                );
                              }),
                            ),
                          ),
 
                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 200),
                            opacity: canProceed ? 1 : 0.4,
                            child: SizedBox(
                              width: 56,
                              height: 56,
                              child: FilledButton(
                                onPressed: !canProceed
                                    ? null
                                    : () {
                                        state.handlePrimaryAction(
                                          onNavigateToHome: () {
                                              Navigator.of(context).pushReplacement(
                                                MaterialPageRoute(
                                                  builder: (context) => const HomeScreen(),
                                                ),
                                              );
                            
                                          },
                                        );
                                      },
                                style: FilledButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: EdgeInsets.zero,
                                  elevation: 4,
                                  shadowColor: theme.colorScheme.primary.withOpacity(0.4),
                                ),
                                child: Icon(
                                  state.isOnNamePage
                                      ? Icons.check_rounded
                                      : CupertinoIcons.chevron_forward,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
      );
  }
}