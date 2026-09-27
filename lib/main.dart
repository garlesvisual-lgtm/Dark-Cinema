import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const DarkCinemaEcosystemApp());
}

class DarkCinemaEcosystemApp extends StatelessWidget {
  const DarkCinemaEcosystemApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dark Cinema - Ultimate Global AI Ecosystem',
      debugShowCheckedModeBanner: false,
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      supportedLocales: const [
        Locale('es', 'MX'),
        Locale('en', 'US'),
        Locale('fr', 'FR'),
        Locale('pt', 'BR'),
        Locale('ja', 'JP'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0B0B0E),
        primaryColor: const Color(0xFF1C1C24),
        colorScheme: const ColorScheme.dark(
          surface: Color(0xFF14141A),
          secondary: Color(0xFF3B82F6),
        ),
        fontFamily: 'SansSerif',
      ),
      home: const CinematicTeaserScreen(),
    );
  }
}

class CinematicTeaserScreen extends StatelessWidget {
  const CinematicTeaserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0B0B0E), Color(0xFF14141A), Color(0xFF0B0B0E)],
          ),
        ),
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.movie_filter, size: 60, color: Color(0xFF3B82F6)),
            const SizedBox(height: 10),
            const Text(
              'DARK CINEMA',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 4.0, color: Colors.white),
            ),
            const SizedBox(height: 4),
            const Text(
              'Ecosistema Global • Motor Ultra 4K/8D & Regalías del Fundador',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF14141A),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFF3B82F6).withOpacity(0.4)),
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.play_circle_filled, size: 56, color: Color(0xFF3B82F6)),
                      SizedBox(height: 10),
                      Text(
                        'Cortometraje de Bienvenida 4K [Activo]',
                        style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 220,
              height: 44,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const AccountRegistrationScreen()),
                  );
                },
                child: const Text('Entrar al Ecosistema', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AccountRegistrationScreen extends StatefulWidget {
  const AccountRegistrationScreen({super.key});

  @override
  State<AccountRegistrationScreen> createState() => _AccountRegistrationScreenState();
}

class _AccountRegistrationScreenState extends State<AccountRegistrationScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  bool _irisScanned = false;

  void _performIrisScan() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF14141A),
        title: const Row(
          children: [
            Icon(Icons.remove_red_eye, color: Color(0xFF3B82F6)),
            SizedBox(width: 10),
            Text('Escáner Biométrico de Iris', style: TextStyle(color: Colors.white, fontSize: 15)),
          ],
        ),
        content: const Text(
          'Alineando sensor frontal para reconocimiento biométrico y validación de seguridad...',
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF3B82F6)),
            onPressed: () {
              setState(() {
                _irisScanned = true;
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('¡Iris escaneado y verificado con éxito!')),
              );
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }

  void _registerAccount(BuildContext context) {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String code = _codeController.text.trim().toUpperCase();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ingresa tu correo y contraseña.')),
      );
      return;
    }

    if (!_irisScanned) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Es indispensable completar el escaneo de iris.')),
      );
      return;
    }

    bool isSuperAdmin = false;

    if (code == 'DARK-FOUNDER-ADOLFO-99X') {
      isSuperAdmin = true;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('¡Bienvenido Adolfo García García! Acceso Fundador Admin & Regalías del 2% Activo.')),
      );
    } else if (code == 'DARK-VIP-FAMILIA-ANDREA-77') {
      isSuperAdmin = true;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('¡Bienvenida Andrea! Cuenta VIP Familiar autorizada.')),
      );
    } else if (code == 'YOUTUBE-PRO' || code == 'CREATOR-PASS') {
      isSuperAdmin = true;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('¡Pase de Creador / Youtuber validado por 30 días!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('¡Cuenta creada con éxito para $email!')),
      );
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MainNavigationScreen(isSuperAdmin: isSuperAdmin)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.movie_creation, size: 50, color: Color(0xFF3B82F6)),
                const SizedBox(height: 10),
                const Text(
                  'DARK CINEMA',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 3.0, color: Colors.white),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Correo electrónico',
                    prefixIcon: const Icon(Icons.email, color: Color(0xFF3B82F6)),
                    filled: true,
                    fillColor: const Color(0xFF14141A),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Contraseña',
                    prefixIcon: const Icon(Icons.lock, color: Color(0xFF3B82F6)),
                    filled: true,
                    fillColor: const Color(0xFF14141A),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 42,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: _irisScanned ? Colors.green : const Color(0xFF3B82F6)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      backgroundColor: _irisScanned ? Colors.green.withOpacity(0.1) : Colors.transparent,
                    ),
                    onPressed: _performIrisScan,
                    icon: Icon(
                      _irisScanned ? Icons.check_circle : Icons.remove_red_eye,
                      color: _irisScanned ? Colors.green : const Color(0xFF3B82F6),
                      size: 18,
                    ),
                    label: Text(
                      _irisScanned ? 'Iris Verificado OK' : 'Escanear Iris (Requerido)',
                      style: TextStyle(fontSize: 12, color: _irisScanned ? Colors.green : Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _codeController,
                  decoration: InputDecoration(
                    hintText: 'Código de Acceso (Fundador / VIP / Creador)',
                    prefixIcon: const Icon(Icons.card_giftcard, color: Colors.amber),
                    filled: true,
                    fillColor: const Color(0xFF14141A),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: 200,
                  height: 44,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B82F6),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () => _registerAccount(context),
                    child: const Text('Entrar', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 14),
                const Text(
                  '© 2026 Adolfo García García. Regalías pasivas justas del 2% para el Fundador.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 8, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  final bool isSuperAdmin;
  const MainNavigationScreen({super.key, required this.isSuperAdmin});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;
  int freeVideosLeft = 3;

  void consumeFreeVideo(BuildContext context) {
    if (widget.isSuperAdmin) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('[Modo Fundador / VIP] Renderizado ilimitado en Ultra 4K con ingresos vinculados.')),
      );
      return;
    }

    if (freeVideosLeft > 0) {
      setState(() {
        freeVideosLeft--;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Video procesado a Ultra 4K. Te quedan $freeVideosLeft créditos en este ciclo.')),
      );
    } else {
      _showPaywall(context);
    }
  }

  void _showPaywall(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF14141A),
        title: const Text('Límite de Videos Alcanzado', style: TextStyle(color: Colors.white)),
        content: const Text(
          'Suscríbete a Creator Pro por \$199 MXN al mes para desbloquear creaciones ilimitadas, los 50 filtros profesionales y estudio de audio 8D.',
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cerrar')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF3B82F6)),
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _currentIndex = 3;
              });
            },
            child: const Text('Pagar Suscripción (\$199 MXN)'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      StudioHomeTab(isSuperAdmin: widget.isSuperAdmin, freeVideosLeft: freeVideosLeft, onGenerate: () => consumeFreeVideo(context)),
      ProFiltersTab(isSuperAdmin: widget.isSuperAdmin),
      const AudioMusicStudioScreen(),
      SubscriptionCheckoutTab(isSuperAdmin: widget.isSuperAdmin),
    ];

    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        backgroundColor: const Color(0xFF14141A),
        selectedItemColor: const Color(0xFF3B82F6),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.videocam, size: 20), label: 'Estudio 4K'),
          BottomNavigationBarItem(icon: Icon(Icons.auto_awesome, size: 20), label: '50 Filtros'),
          BottomNavigationBarItem(icon: Icon(Icons.mic, size: 20), label: 'Audio & Lo-Fi'),
          BottomNavigationBarItem(icon: Icon(Icons.payment, size: 20), label: 'Pago \$199'),
        ],
      ),
    );
  }
}

class StudioHomeTab extends StatelessWidget {
  final bool isSuperAdmin;
  final int freeVideosLeft;
  final VoidCallback onGenerate;

  const StudioHomeTab({super.key, required this.isSuperAdmin, required this.freeVideosLeft, required this.onGenerate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isSuperAdmin ? 'DARK CINEMA [FUNDADOR ADMIN]' : 'DARK CINEMA STUDIO',
          style: const TextStyle(fontSize: 12, letterSpacing: 1.2),
        ),
        backgroundColor: const Color(0xFF14141A),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF14141A),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFF3B82F6).withOpacity(0.3)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Créditos del ciclo (Escalado 4K):', style: TextStyle(fontSize: 11, color: Colors.grey)),
                  Text(
                    isSuperAdmin ? 'Ilimitados (Admin/Fundador)' : '$freeVideosLeft / 3 disponibles',
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF3B82F6)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF14141A),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF3B82F6).withOpacity(0.3)),
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.video_library, size: 50, color: Color(0xFF3B82F6)),
                      SizedBox(height: 10),
                      Text(
                        'Visor 4K • Listo para Metraje de la Tablet',
                        style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 180,
                  height: 40,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B82F6),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: onGenerate,
                    icon: const Icon(Icons.bolt, size: 16),
                    label: const Text('Generar / Escalar', style: TextStyle(fontSize: 12)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ProFiltersTab extends StatelessWidget {
  final bool isSuperAdmin;
  const ProFiltersTab({super.key, required this.isSuperAdmin});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> filters = [
      {'name': '1. Pixar 3D Cinematic', 'preview': 'Estilo animación 3D de alta gama', 'isPro': true},
      {'name': '2. Modo Plastilina HD', 'preview': 'Textura arcilla y stop-motion real', 'isPro': true},
      {'name': '3. Estilo Avatar & Pandora', 'preview': 'Tonos bioluminiscentes y selva', 'isPro': true},
      {'name': '4. Cyberpunk Neon Distopía', 'preview': 'Luces de neón y lluvia urbana', 'isPro': true},
      {'name': '5. Unreal Engine 5 Pro', 'preview': 'Fotorrealismo extremo en render', 'isPro': true},
      {'name': '6. Anime Shinkai Master', 'isPro': true, 'preview': 'Cielos vibrantes y atardeceres anime'},
      {'name': '7. Dark Fantasy Gothic', 'preview': 'Sombras profundas y castillos', 'isPro': true},
      {'name': '8. Óleo Renascentista', 'preview': 'Pinceladas de museo clásico', 'isPro': true},
      {'name': '9. Sci-Fi Interstellar 8D', 'preview': 'Espacio profundo y distorsión', 'isPro': true},
      {'name': '10. Noir Detective 1940s', 'preview': 'Blanco y negro dramático', 'isPro': true},
      {'name': '11. Cómics Marvel/DC', 'preview': 'Entintado y colores pop-art', 'isPro': true},
      {'name': '12. Retro VHS Analógico', 'preview': 'Ruido magnético y fecha naranja', 'isPro': true},
      {'name': '13. Golden Hour Luxury', 'preview': 'Luz cálida de atardecer boutique', 'isPro': true},
      {'name': '14. Chukum & Madera', 'preview': 'Estilo minimalista natural y cálido', 'isPro': true},
      {'name': '15. Termográfico AI', 'preview': 'Visor de calor y espectro térmico', 'isPro': true},
      {'name': '16. Matrix Code Stream', 'preview': 'Lluvia digital verde neón', 'isPro': true},
      {'name': '17. Teal & Orange Pro', 'preview': 'Contraste cinematográfico de estudio', 'isPro': true},
      {'name': '18. Acuarela Digital', 'preview': 'Efecto pintura sobre papel húmedo', 'isPro': true},
      {'name': '19. Stop-Motion Clásico', 'preview': 'Fotogramas artesanales con grano', 'isPro': true},
      {'name': '20. Hyper-Realistic 8K', 'preview': 'Retrato con detalle ultra nítido', 'isPro': true},
      {'name': '21. Neón Synthwave 80s', 'preview': 'Atardecer retro con retícula láser', 'isPro': true},
      {'name': '22. Drama Monocromático', 'preview': 'Grisáceos profundos y expresivos', 'isPro': true},
      {'name': '23. Cuento de Hadas Disney', 'preview': 'Fantasía luminosa y colorida', 'isPro': true},
      {'name': '24. Mármol & Oro Fino', 'preview': 'Texturas de lujo y acabados oro', 'isPro': true},
      {'name': '25. Moda Alta Costura', 'preview': 'Iluminación de pasarela internacional', 'isPro': true},
      {'name': '26 al 50. Suite 25 Filtros IA', 'preview': 'Colección avanzada de efectos extra', 'isPro': true},
      {'name': 'Base 1: Cine Noir', 'preview': 'Clásico y elegante', 'isPro': false},
      {'name': 'Base 2: Sepia Vintage', 'preview': 'Tono envejecido tradicional', 'isPro': false},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Galería: 50 Filtros Pro con Vista Previa', style: TextStyle(fontSize: 12)), backgroundColor: const Color(0xFF14141A)),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.15,
          ),
          itemCount: filters.length,
          itemBuilder: (context, index) {
            final filter = filters[index];
            final bool locked = filter['isPro'] && !isSuperAdmin;

            return GestureDetector(
              onTap: () {
                if (locked) {
                  _showPaywall(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Aplicando filtro "${filter['name']}"...')));
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF14141A),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: locked ? Colors.amber.withOpacity(0.4) : Colors.white10),
                ),
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(locked ? Icons.lock : Icons.auto_awesome, color: locked ? Colors.amber : const Color(0xFF3B82F6), size: 20),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            filter['name'],
                            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0B0B0E),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        filter['preview'],
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 9.5, color: Colors.grey),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (locked)
                      const Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Text('Pro (\$199 MXN)', style: TextStyle(fontSize: 8, color: Colors.amber)),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showPaywall(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF14141A),
        title: const Text('Función Pro Exclusiva', style: TextStyle(color: Colors.white, fontSize: 16)),
        content: const Text(
          'Desbloquea los 50 filtros profesionales con vista previa en vivo suscribiéndote por \$199 MXN al mes.',
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cerrar')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF3B82F6)),
            onPressed: () => Navigator.pop(context),
            child: const Text('Ir a Pagar (\$199 MXN)'),
          ),
        ],
      ),
    );
  }
}

class AudioMusicStudioScreen extends StatelessWidget {
  const AudioMusicStudioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estudio de Audio, Voz IA & Lo-Fi Beats', style: TextStyle(fontSize: 12)),
        backgroundColor: const Color(0xFF14141A),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Clonación y Masterización de Voz', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.white)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF14141A),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFF3B82F6).withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Micrófono de Estudio 8D', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                        SizedBox(height: 2),
                        Text('Procesa tu voz con IA espacial', style: TextStyle(color: Colors.grey, fontSize: 10)),
                      ],
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3B82F6),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      ),
                      onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Grabando voz y aplicando masterización espacial...')),
                      ),
                      child: const Text('Grabar Voz', style: TextStyle(fontSize: 11)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text('Consola de Beats Lo-Fi Predeterminados', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.white)),
              const SizedBox(height: 8),
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 1.6,
                children: [
                  _buildLofiCard(context, 'Lluvia Nocturna Lo-Fi', Icons.cloud_queue, 'Ambiente relajante con vinilo'),
                  _buildLofiCard(context, 'Neon City Vibes', Icons.nightlife, 'Frecuencias urbanas de medianoche'),
                  _buildLofiCard(context, 'Cinematic Chillhop', Icons.headphones, 'Ritmos suaves para edición'),
                  _buildLofiCard(context, 'Space Ambient 8D', Icons.blur_circular, 'Sonidos envolventes estelares'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLofiCard(BuildContext context, String title, IconData icon, String subtitle) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF14141A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: const Color(0xFF3B82F6), size: 18),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 9, color: Colors.grey),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),
          SizedBox(
            height: 24,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6).withOpacity(0.2),
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 8),
              ),
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Reproduciendo atmósfera: $title')),
              ),
              child: const Text('Reproducir', style: TextStyle(fontSize: 9, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}

class SubscriptionCheckoutTab extends StatefulWidget {
  final bool isSuperAdmin;
  const SubscriptionCheckoutTab({super.key, required this.isSuperAdmin});

  @override
  State<SubscriptionCheckoutTab> createState() => _SubscriptionCheckoutTabState();
}

class _SubscriptionCheckoutTabState extends State<SubscriptionCheckoutTab> {
  String _selectedPaymentMethod = 'tarjeta';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pasarela de Pago Global (\$199 MXN)', style: TextStyle(fontSize: 12)), backgroundColor: const Color(0xFF14141A)),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Membresía Creator Pro (Global)',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 4),
              const Text(
                'Desbloquea procesamiento ilimitado en Ultra 4K, 50 filtros profesionales y estudio de audio con conversión de moneda local.',
                style: TextStyle(fontSize: 11, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF14141A),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFF3B82F6).withOpacity(0.4)),
                ),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Equivalente mensual:', style: TextStyle(color: Colors.white70, fontSize: 12)),
                        Text('\$199.00 MXN', style: TextStyle(color: Color(0xFF3B82F6), fontSize: 15, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const Divider(color: Colors.white24, height: 18),
                    widget.isSuperAdmin
                        ? const Text(
                            '✨ Cuenta con Estatus de Fundador / VIP. Ingresos y regalías pasivas del 2% vinculadas a tus cuentas globales.',
                            style: TextStyle(color: Colors.greenAccent, fontSize: 11, height: 1.3),
                          )
                        : const Text(
                            '🌍 La pasarela detecta automáticamente el país del dispositivo y realiza la conversión a la moneda local.',
                            style: TextStyle(color: Colors.amber, fontSize: 11, height: 1.3),
                          ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text('Método de Pago', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: ChoiceChip(
                      label: const Text('Tarjeta Global', style: TextStyle(fontSize: 11)),
                      selected: _selectedPaymentMethod == 'tarjeta',
                      onSelected: (selected) => setState(() => _selectedPaymentMethod = 'tarjeta'),
                      selectedColor: const Color(0xFF3B82F6),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ChoiceChip(
                      label: const Text('PayPal / App Stores', style: TextStyle(fontSize: 11)),
                      selected: _selectedPaymentMethod == 'paypal',
                      onSelected: (selected) => setState(() => _selectedPaymentMethod = 'paypal'),
                      selectedColor: const Color(0xFF3B82F6),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              if (_selectedPaymentMethod == 'tarjeta') ...[
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Número de Tarjeta',
                    filled: true,
                    fillColor: const Color(0xFF14141A),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'MM/AA',
                          filled: true,
                          fillColor: const Color(0xFF14141A),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'CVV',
                          filled: true,
                          fillColor: const Color(0xFF14141A),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                        ),
                      ),
                    ),
                  ],
                ),
              ] else ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF14141A),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'Se procesará mediante la tienda de aplicaciones oficial o PayPal con conversión automática.',
                    style: TextStyle(color: Colors.grey, fontSize: 11),
                  ),
                ),
              ],
              const SizedBox(height: 22),
              SizedBox(
                width: double.infinity,
                height: 44,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B82F6),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    if (widget.isSuperAdmin) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('[Modo Fundador] Las cuentas de cobro y regalías del 2% están listas para configurarse.')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('¡Suscripción global procesada y activada con éxito!')),
                      );
                    }
                  },
                  child: Text(
                    widget.isSuperAdmin ? 'Ver Panel de Ingresos del Fundador' : 'Pagar Suscripción (\$199 MXN)',
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
