import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:video_player/video_player.dart';

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
      // Configuración automática del idioma por defecto según el país del dispositivo
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first; // Predeterminado a Español / Global
      },
      supportedLocales: const [
        Locale('es', 'MX'), // Español por defecto
        Locale('en', 'US'), // Inglés global
        Locale('fr', 'FR'), // Francés
        Locale('pt', 'BR'), // Portugués
        Locale('ja', 'JP'), // Japonés
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

class CinematicTeaserScreen extends StatefulWidget {
  const CinematicTeaserScreen({super.key});

  @override
  State<CinematicTeaserScreen> createState() => _CinematicTeaserScreenState();
}

class _CinematicTeaserScreenState extends State<CinematicTeaserScreen> {
  late VideoPlayerController _controller;
  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse('https://flutter.github.io/assets-for-video-assets/bee.mp4'),
    )..initialize().then((_) {
        setState(() {
          _isVideoInitialized = true;
        });
        _controller.setLooping(true);
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
            const Icon(Icons.movie_filter, size: 70, color: Color(0xFF3B82F6)),
            const SizedBox(height: 10),
            const Text(
              'DARK CINEMA',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 4.0, color: Colors.white),
            ),
            const SizedBox(height: 6),
            const Text(
              'Ecosistema Global • Multilenguaje Automático & Regalías del Fundador',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: Colors.grey),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF14141A),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFF3B82F6).withOpacity(0.4)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: _isVideoInitialized
                      ? Stack(
                          alignment: Alignment.center,
                          children: [
                            AspectRatio(
                              aspectRatio: _controller.value.aspectRatio,
                              child: VideoPlayer(_controller),
                            ),
                            Container(color: Colors.black26),
                            const Positioned(
                              bottom: 16,
                              child: Text(
                                'Cortometraje Global (Ultra 4K Adaptativo)',
                                style: TextStyle(color: Colors.white, fontSize: 12, backgroundColor: Colors.black54),
                              ),
                            )
                          ],
                        )
                      : const Center(child: CircularProgressIndicator(color: Color(0xFF3B82F6))),
                ),
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const AccountRegistrationScreen()),
                  );
                },
                child: const Text('Entrar al Ecosistema Global', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
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
            Text('Escáner Biométrico de Iris', style: TextStyle(color: Colors.white, fontSize: 16)),
          ],
        ),
        content: const Text(
          'Alineando sensor frontal para reconocimiento biométrico y validación de seguridad global...',
          style: TextStyle(color: Colors.grey),
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
            child: const Text('Confirmar Escaneo'),
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
        const SnackBar(content: Text('Por favor, ingresa tu correo y contraseña.')),
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
        padding: const EdgeInsets.all(28.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.movie_creation, size: 60, color: Color(0xFF3B82F6)),
                const SizedBox(height: 12),
                const Text(
                  'DARK CINEMA',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 3.0, color: Colors.white),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Detección Regional Automática & Seguridad',
                  style: TextStyle(fontSize: 11, color: Colors.grey),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Correo electrónico',
                    prefixIcon: const Icon(Icons.email, color: Color(0xFF3B82F6)),
                    filled: true,
                    fillColor: const Color(0xFF14141A),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
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
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: _irisScanned ? Colors.green : const Color(0xFF3B82F6)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      backgroundColor: _irisScanned ? Colors.green.withOpacity(0.1) : Colors.transparent,
                    ),
                    onPressed: _performIrisScan,
                    icon: Icon(
                      _irisScanned ? Icons.check_circle : Icons.remove_red_eye,
                      color: _irisScanned ? Colors.green : const Color(0xFF3B82F6),
                    ),
                    label: Text(
                      _irisScanned ? 'Iris Verificado OK' : 'Escanear Iris (Requerido)',
                      style: TextStyle(
                        fontSize: 13,
                        color: _irisScanned ? Colors.green : Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: _codeController,
                  decoration: InputDecoration(
                    hintText: 'Código de Acceso (Fundador / VIP / Youtuber)',
                    prefixIcon: const Icon(Icons.card_giftcard, color: Colors.amber),
                    filled: true,
                    fillColor: const Color(0xFF14141A),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B82F6),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    onPressed: () => _registerAccount(context),
                    child: const Text('Entrar al Ecosistema', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Derechos Reservados © 2026 Adolfo García García. Los contenidos generan un esquema de regalías pasivas justas del 2% para el Fundador. Prohibido su plagio.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 8.5, color: Colors.grey, height: 1.3),
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
          'Suscríbete a Creator Pro por \$199 MXN al mes (conversión automática a tu moneda local) para desbloquear creaciones ilimitadas, los 50 filtros profesionales y soporte de IA avanzado.',
          style: TextStyle(color: Colors.grey),
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
      AudioStudioTab(isSuperAdmin: widget.isSuperAdmin),
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
          BottomNavigationBarItem(icon: Icon(Icons.videocam), label: 'Estudio 4K'),
          BottomNavigationBarItem(icon: Icon(Icons.auto_awesome), label: '50 Filtros'),
          BottomNavigationBarItem(icon: Icon(Icons.mic), label: 'Audio & Lo-Fi'),
          BottomNavigationBarItem(icon: Icon(Icons.payment), label: 'Pago Global'),
        ],
      ),
    );
  }
}

class StudioHomeTab extends StatefulWidget {
  final bool isSuperAdmin;
  final int freeVideosLeft;
  final VoidCallback onGenerate;

  const StudioHomeTab({super.key, required this.isSuperAdmin, required this.freeVideosLeft, required this.onGenerate});

  @override
  State<StudioHomeTab> createState() => _StudioHomeTabState();
}

class _StudioHomeTabState extends State<StudioHomeTab> {
  late VideoPlayerController _studioVideoController;
  bool _isStudioVideoInitialized = false;
  final TextEditingController _geminiPromptController = TextEditingController();
  bool _isGeneratingByGemini = false;

  @override
  void initState() {
    super.initState();
    _studioVideoController = VideoPlayerController.networkUrl(
      Uri.parse('https://flutter.github.io/assets-for-video-assets/bee.mp4'),
    )..initialize().then((_) {
        setState(() {
          _isStudioVideoInitialized = true;
        });
        _studioVideoController.setLooping(true);
        _studioVideoController.play();
      });
  }

  @override
  void dispose() {
    _studioVideoController.dispose();
    super.dispose();
  }

  void _openGeminiCommandDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          backgroundColor: const Color(0xFF14141A),
          title: const Row(
            children: [
              Icon(Icons.smart_toy, color: Color(0xFF3B82F6)),
              SizedBox(width: 10),
              Text('Motor de IA Gemini Studio (Escalado 4K)', style: TextStyle(color: Colors.white, fontSize: 14)),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Indica la instrucción para que Gemini optimice tu metraje básico a cine Ultra 4K:',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _geminiPromptController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Ej. Mejorar iluminación y nitidez a Ultra 4K...',
                  filled: true,
                  fillColor: const Color(0xFF0B0B0E),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
              ),
              if (_isGeneratingByGemini) ...[
                const SizedBox(height: 16),
                const LinearProgressIndicator(color: Color(0xFF3B82F6)),
                const SizedBox(height: 8),
                const Text('Aplicando red neural de escalado...', style: TextStyle(color: Color(0xFF3B82F6), fontSize: 11)),
              ]
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF3B82F6)),
              onPressed: _isGeneratingByGemini ? null : () async {
                if (_geminiPromptController.text.trim().isEmpty) return;
                setDialogState(() {
                  _isGeneratingByGemini = true;
                });
                
                await Future.delayed(const Duration(seconds: 3));

                setDialogState(() {
                  _isGeneratingByGemini = false;
                });
                Navigator.pop(context);

                widget.onGenerate();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('¡Metraje optimizado y elevado a Ultra 4K!')),
                );
              },
              child: const Text('Procesar Video IA'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isSuperAdmin ? 'DARK CINEMA [FUNDADOR ADMIN]' : 'DARK CINEMA STUDIO',
          style: const TextStyle(fontSize: 12, letterSpacing: 1.2),
        ),
        backgroundColor: const Color(0xFF14141A),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF14141A),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF3B82F6).withOpacity(0.3)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Créditos del ciclo (Escalado 4K):', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  Text(
                    widget.isSuperAdmin ? 'Ilimitados (Admin/Fundador)' : '${widget.freeVideosLeft} / 3 disponibles',
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF3B82F6)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF14141A),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFF3B82F6).withOpacity(0.3)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: _isStudioVideoInitialized
                      ? Stack(
                          alignment: Alignment.center,
                          children: [
                            AspectRatio(
                              aspectRatio: _studioVideoController.value.aspectRatio,
                              child: VideoPlayer(_studioVideoController),
                            ),
                            Container(color: Colors.black26),
                            const Positioned(
                              bottom: 12,
                              child: Text(
                                'Visor Activo • Calidad Ultra 4K Optimizada por IA',
                                style: TextStyle(color: Colors.white, fontSize: 11, backgroundColor: Colors.black54),
                              ),
                            )
                          ],
                        )
                      : const Center(child: CircularProgressIndicator(color: Color(0xFF3B82F6))),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF3B82F6), padding: const EdgeInsets.all(16)),
                    onPressed: widget.onGenerate,
                    icon: const Icon(Icons.bolt),
                    label: const Text('Generar / Escalar Video'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(padding: const EdgeInsets.all(16)),
                    onPressed: () => _openGeminiCommandDialog(context),
                    icon: const Icon(Icons.smart_toy, color: Color(0xFF3B82F6)),
                    label: const Text('Comando Gemini'),
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
      {'name': '1. Estilo Pixar 3D Cinematic', 'isPro': true},
      {'name': '2. Modo Plastilina (Claymation HD)', 'isPro': true},
      {'name': '3. Estilo Avatar & Pandora', 'isPro': true},
      {'name': '4. Cyberpunk Neon Distopía', 'isPro': true},
      {'name': '5. Unreal Engine 5 Photorealistic', 'isPro': true},
      {'name': '6. Anime Masterpiece Shinkai', 'isPro': true},
      {'name': '7. Dark Fantasy Gothic', 'isPro': true},
      {'name': '8. Óleo Renascentista', 'isPro': true},
      {'name': '9. Sci-Fi Interstellar 8D', 'isPro': true},
      {'name': '10. Noir Detective 1940s', 'isPro': true},
      {'name': '11. Estilo Cómics Marvel/DC', 'isPro': true},
      {'name': '12. Retro VHS Analógico 90s', 'isPro': true},
      {'name': '13. Golden Hour Luxury Glow', 'isPro': true},
      {'name': '14. Minimalista Chukum & Madera', 'isPro': true},
      {'name': '15. Termográfico Predator AI', 'isPro': true},
      {'name': '16. Estilo Matrix Code Stream', 'isPro': true},
      {'name': '17. Cinematic Teal & Orange Pro', 'isPro': true},
      {'name': '18. Acuarela Artística Digital', 'isPro': true},
      {'name': '19. Estilo Stop-Motion Clásico', 'isPro': true},
      {'name': '20. Hyper-Realistic 8K Portrait', 'isPro': true},
      {'name': '21. Estilo Neón Synthwave', 'isPro': true},
      {'name': '22. Drama Monocromático Profundo', 'isPro': true},
      {'name': '23. Estilo Cuento de Hadas Disney', 'isPro': true},
      {'name': '24. Textura Mármol & Oro Fino', 'isPro': true},
      {'name': '25. Estilo Fotografía de Moda Alta Costura', 'isPro': true},
      {'name': '26 al 50. Suite Completa 25 Filtros IA Ultra', 'isPro': true},
      {'name': 'Base 1: Cine Noir Estándar', 'isPro': false},
      {'name': 'Base 2: Sepia Vintage Clásico', 'isPro': false},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Galería Oficial: 50 Filtros Pro en Ultra 4K', style: TextStyle(fontSize: 12)), backgroundColor: const Color(0xFF14141A)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.3,
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
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Filtro "${filter['name']}" aplicado con éxito.')));
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF14141A),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: locked ? Colors.amber.withOpacity(0.4) : Colors.white10),
                ),
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(locked ? Icons.lock : Icons.auto_awesome, color: locked ? Colors.amber : const Color(0xFF3B82F6), size: 26),
                    const SizedBox(height: 6),
                    Text(
                      filter['name'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    if (locked)
                      const Text('Pro (\$199 MXN / Mes)', style: TextStyle(fontSize: 8.5, color: Colors.amber)),
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
        title: const Text('Función Pro Exclusiva', style: TextStyle(color: Colors.white)),
        content: const Text(
          'Desbloquea los 50 filtros profesionales suscribiéndote por \$199 MXN al mes.',
          style: TextStyle(color: Colors.grey),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cerrar')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF3B82F6)),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Redirigiendo a pasarela global de pagos...')));
            },
            child: const Text('Ir a Pagar (\$199 MXN)'),
          ),
        ],
      ),
    );
  }
}

class AudioStudioTab extends StatelessWidget {
  final bool isSuperAdmin;
  const AudioStudioTab({super.key, required this.isSuperAdmin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Audio Studio, Clonación de Voz & Lo-Fi 8D', style: TextStyle(fontSize: 12)), backgroundColor: const Color(0xFF14141A)),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Grabación y Clonación de Voz con IA', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF14141A),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF3B82F6).withOpacity(0.3)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Micrófono de Estudio & Masterización 8D', style: TextStyle(color: Colors.white70, fontSize: 12)),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF3B82F6)),
                    onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Grabando voz y aplicando masterización espacial de estudio...')),
                    ),
                    child: const Text('Grabar & Clonar'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text('Generador de Ambientes Lo-Fi & Frecuencias Cinemáticas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF14141A),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF3B82F6).withOpacity(0.3)),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.radio, size: 48, color: Color(0xFF3B82F6)),
                      const SizedBox(height: 12),
                      const Text('Sintonizador Lo-Fi Activo (Lluvias, Neón, Vinilo)', style: TextStyle(color: Colors.white, fontSize: 12)),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF3B82F6)),
                        onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Reproduciendo atmósfera Lo-Fi cinemática en segundo plano...')),
                        ),
                        child: const Text('Reproducir Lo-Fi Beats'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
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
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 6),
              const Text(
                'Desbloquea procesamiento ilimitado en Ultra 4K, 50 filtros profesionales y estudio de audio 8D con adaptación de moneda local.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF14141A),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF3B82F6).withOpacity(0.4)),
                ),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Equivalente mensual base:', style: TextStyle(color: Colors.white70, fontSize: 13)),
                        Text('\$199.00 MXN', style: TextStyle(color: Color(0xFF3B82F6), fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const Divider(color: Colors.white24, height: 24),
                    widget.isSuperAdmin
                        ? const Text(
                            '✨ Cuenta con Estatus de Fundador / VIP. Ingresos y regalías pasivas del 2% vinculadas a tus cuentas globales.',
                            style: TextStyle(color: Colors.greenAccent, fontSize: 12, height: 1.4),
                          )
                        : const Text(
                            '🌍 La pasarela detecta automáticamente el país del dispositivo y realiza la conversión a la moneda local correspondiente.',
                            style: TextStyle(color: Colors.amber, fontSize: 12, height: 1.4),
                          ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text('Método de Pago Internacional', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: ChoiceChip(
                      label: const Text('Tarjeta Global'),
                      selected: _selectedPaymentMethod == 'tarjeta',
                      onSelected: (selected) => setState(() => _selectedPaymentMethod = 'tarjeta'),
                      selectedColor: const Color(0xFF3B82F6),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ChoiceChip(
                      label: const Text('PayPal / App Stores'),
                      selected: _selectedPaymentMethod == 'paypal',
                      onSelected: (selected) => setState(() => _selectedPaymentMethod = 'paypal'),
                      selectedColor: const Color(0xFF3B82F6),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              if (_selectedPaymentMethod == 'tarjeta') ...[
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Número de Tarjeta',
                    filled: true,
                    fillColor: const Color(0xFF14141A),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'MM/AA',
                          filled: true,
                          fillColor: const Color(0xFF14141A),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'CVV',
                          filled: true,
                          fillColor: const Color(0xFF14141A),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                        ),
                      ),
                    ),
                  ],
                ),
              ] else ...[
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF14141A),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Se procesará mediante la tienda de aplicaciones oficial o PayPal con conversión automática a tu moneda local.',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),
              ],
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B82F6),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
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
                    widget.isSuperAdmin ? 'Ver Panel de Ingresos del Fundador' : 'Pagar Suscripción Global',
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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
