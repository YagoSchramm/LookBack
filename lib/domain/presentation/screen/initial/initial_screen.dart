import 'package:flutter/material.dart';
import 'package:look_back/domain/presentation/screen/initial/initial_state.dart';
import 'package:provider/provider.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Consumer<InitialScreenState>(
          builder: (context, state, child) {
            if (state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: state.pageController,
                    onPageChanged: state.onPageChanged,
                    children: [
                      // Page 1
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                           Image.asset("./assets/images/initial_image.png")
                          ],
                        ),
                      ),

                      // Página 2
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.edit_note_rounded,
                              size: 140,
                            ),
                            const SizedBox(height: 48),
                            Text(
                              "Escreva do seu jeito",
                              textAlign: TextAlign.center,
                              style: theme.textTheme.headlineMedium,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "Cada lembrança pode conter apenas texto ou ser enriquecida com fotos, áudios e localização.",
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),

                      // Página 3
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.history_rounded,
                              size: 140,
                            ),
                            const SizedBox(height: 48),
                            Text(
                              "Olhe para trás",
                              textAlign: TextAlign.center,
                              style: theme.textTheme.headlineMedium,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "Relembre sua trajetória e veja o quanto você cresceu ao longo do tempo.",
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyLarge,
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
                      IconButton(
                        onPressed:
                            state.currentPage == 0 ? null : state.previousPage,
                        icon: const Icon(Icons.arrow_back_ios_new_rounded),
                      ),

                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            3,
                            (index) {
                              final selected =
                                  index == state.currentPage;

                              return AnimatedContainer(
                                duration:
                                    const Duration(milliseconds: 250),
                                curve: Curves.easeOut,
                                margin: const EdgeInsets.symmetric(horizontal: 4),
                                width: selected ? 24 : 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: selected
                                      ? theme.colorScheme.primary
                                      : theme.colorScheme.outline.withOpacity(.3),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      FilledButton(
                        onPressed: state.nextPage,
                        style: FilledButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(16),
                        ),
                        child: Icon(
                          state.currentPage == 2
                              ? Icons.check_rounded
                              : Icons.arrow_forward_rounded,
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