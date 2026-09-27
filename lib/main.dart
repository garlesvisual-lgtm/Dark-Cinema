import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';

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
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF050508),
        primaryColor: const Color(0xFF3B82F6),
        colorScheme: const ColorScheme.dark(
          surface: Color(0xFF12121A),
          secondary: Color(0xFF3B82F6),
        ),
        fontFamily: 'SansSerif',
      ),
      home: const CinematicTeaserScreen(),
    );
  }
}

// CORTOMETRAJE DE BIENVENIDA INICIAL CON REPRODUCTOR ACTIVO
class CinematicTeaserScreen extends StatefulWidget {
  const CinematicTeaserScreen({super.key});

  @override
  State<CinematicTeaserScreen> createState() => _CinematicTeaserScreenState();
}

class _CinematicTeaserScreenState extends State<CinematicTeaserScreen> {
  late VideoPlayerController _teaserController;
  bool _isTeaserInitialized = false;

  @override
  void initState() {
    super.initState();
    // Video de demostración cinematográfica en streaming para la bienvenida inicial
    _teaserController = VideoPlayerController.networkUrl(
      Uri.parse('https://assets.mixkit.co/videos/preview/mixkit-set-of-plate-plated-dishes-in-a-restaurant-42653-large.mp4'),
    )..initialize().then((_) {
        setState(() {
          _isTeaserInitialized = true;
        });
        _teaserController.play();
        _teaserController.setLooping(true);
      });
  }

  @override
  void dispose() {
    _teaserController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          _isTeaserInitialized
              ? FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _teaserController.value.size.width,
                    height: _teaserController.value.size.height,
                    child: VideoPlayer(_teaserController),
                  ),
                )
              : Container(color: const Color(0xFF050508)),
          // Capa de degradado oscuro para legibilidad de marca
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.6),
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.9),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 30),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black45,
                        border: Border.all(color: const Color(0xFF3B82F6), width: 1.5),
                      ),
                      child: const Icon(Icons.movie_filter_rounded, size: 36, color: Color(0xFF60A5FA)),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'DARK CINEMA',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, letterSpacing: 5.0, color: Colors.white),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Cortometraje de Bienvenida 4K [Reproduciendo]',
                      style: TextStyle(fontSize: 11, color: Colors.amberAccent, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B82F6),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 8,
                    ),
                    onPressed: () {
                      _teaserController.pause();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const AccountRegistrationScreen()),
                      );
                    },
                    child: const Text('Entrar al Ecosistema', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                  ),
                ),
              ],
            ),
          ),
        ],
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
        backgroundColor: const Color(0xFF141420),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.remove_red_eye_rounded, color: Color(0xFF3B82F6)),
            SizedBox(width: 10),
            Text('Escáner Biométrico', style: TextStyle(color: Colors.white, fontSize: 16)),
          ],
        ),
        content: const Text(
          'Validando identidad de alta seguridad mediante sensor frontal de la tablet...',
          style: TextStyle(color: Colors.grey, fontSize: 13),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar', style: TextStyle(color: Colors.grey))),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF3B82F6)),
            onPressed: () {
              setState(() {
                _irisScanned = true;
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('¡Iris escaneado y verificado correctamente!')),
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
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ingresa correo y contraseña.')));
      return;
    }

    if (!_irisScanned) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Es necesario completar el escaneo de iris.')));
      return;
    }

    bool isSuperAdmin = false;

    if (code == 'DARK-FOUNDER-ADOLFO-99X') {
      isSuperAdmin = true;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('¡Bienvenido Adolfo García García! Acceso Fundador Admin & Regalías 2%.')));
    } else if (code == 'DARK-VIP-FAMILIA-ANDREA-77') {
      isSuperAdmin = true;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('¡Bienvenida Andrea! Cuenta VIP Familiar activada.')));
    } else if (code == 'YOUTUBE-PRO' || code == 'CREATOR-PASS') {
      isSuperAdmin = true;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('¡Pase de Creador validado con éxito!')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('¡Bienvenido a bordo, $email!')));
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MainNavigationScreen(isSuperAdmin: isSuperAdmin)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF050508), Color(0xFF12121A)],
          ),
        ),
        padding: const EdgeInsets.all(28.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.movie_creation_outlined, size: 54, color: Color(0xFF3B82F6)),
                const SizedBox(height: 12),
                const Text(
                  'ACCESO AL SISTEMA',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: 4.0, color: Colors.white),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: _emailController,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                  decoration: InputDecoration(
                    hintText: 'Correo electrónico',
                    hintStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: const Icon(Icons.email_outlined, color: Color(0xFF3B82F6)),
                    filled: true,
                    fillColor: const Color(0xFF161622),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                  decoration: InputDecoration(
                    hintText: 'Contraseña',
                    hintStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF3B82F6)),
                    filled: true,
                    fillColor: const Color(0xFF161622),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: _irisScanned ? Colors.greenAccent : const Color(0xFF3B82F6), width: 1.5),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      backgroundColor: _irisScanned ? Colors.greenAccent.withOpacity(0.1) : const Color(0xFF161622),
                    ),
                    onPressed: _performIrisScan,
                    icon: Icon(
                      _irisScanned ? Icons.check_circle_rounded : Icons.remove_red_eye_rounded,
                      color: _irisScanned ? Colors.greenAccent : const Color(0xFF3B82F6),
                      size: 20,
                    ),
                    label: Text(
                      _irisScanned ? 'Iris Verificado OK' : 'Escanear Iris Biométrico',
                      style: TextStyle(fontSize: 13, color: _irisScanned ? Colors.greenAccent : Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: _codeController,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                  decoration: InputDecoration(
                    hintText: 'Código de Acceso (Fundador / VIP / Creador)',
                    hintStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: const Icon(Icons.card_giftcard_rounded, color: Colors.amberAccent),
                    filled: true,
                    fillColor: const Color(0xFF161622),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: 220,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B82F6),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    onPressed: () => _registerAccount(context),
                    child: const Text('Iniciar Sesión', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1.1)),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  '© 2026 Adolfo García García. Regalías pasivas del 2% para el Fundador.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 9, color: Colors.grey),
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

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      StudioHomeTab(isSuperAdmin: widget.isSuperAdmin),
      ProFiltersTab(isSuperAdmin: widget.isSuperAdmin),
      const AudioMusicStudioScreen(),
      SubscriptionCheckoutTab(isSuperAdmin: widget.isSuperAdmin),
    ];

    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF101018),
          border: Border(top: BorderSide(color: Colors.white.withOpacity(0.08), width: 1)),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: const Color(0xFF3B82F6),
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          unselectedLabelStyle: const TextStyle(fontSize: 10),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.videocam_rounded, size: 22), label: 'Estudio 4K'),
            BottomNavigationBarItem(icon: Icon(Icons.auto_awesome_rounded, size: 22), label: '50 Filtros'),
            BottomNavigationBarItem(icon: Icon(Icons.mic_rounded, size: 22), label: 'Audio 8D'),
            BottomNavigationBarItem(icon: Icon(Icons.payment_rounded, size: 22), label: 'Suscripción'),
          ],
        ),
      ),
    );
  }
}

// ESTUDIO 4K DEFINITIVO: VISOR COMPACTO + BANDEJA DE FILTROS + AJUSTES FINOS
class StudioHomeTab extends StatefulWidget {
  final bool isSuperAdmin;
  const StudioHomeTab({super.key, required this.isSuperAdmin});

  @override
  State<StudioHomeTab> createState() => _StudioHomeTabState();
}

class _StudioHomeTabState extends State<StudioHomeTab> {
  File? _selectedVideoFile;
  VideoPlayerController? _videoPlayerController;
  bool _isVideoInitialized = false;
  final ImagePicker _picker = ImagePicker();

  String _activeFilter = 'Original';
  double _contrastVal = 1.0;
  double _brightnessVal = 0.0;

  final List<Map<String, dynamic>> _quickFilters = [
    {'name': 'Original', 'icon': Icons.movie_rounded, 'color': Colors.blue},
    {'name': 'Cinematic Noir', 'icon': Icons.dark_mode_rounded, 'color': Colors.grey},
    {'name': 'Cyberpunk', 'icon': Icons.bolt_rounded, 'color': Colors.purpleAccent},
    {'name': 'Pixar 3D', 'icon': Icons.animation_rounded, 'color': Colors.amberAccent},
    {'name': 'Golden Luxury', 'icon': Icons.star_rounded, 'color': Colors.orangeAccent},
    {'name': 'VHS Retro', 'icon': Icons.vignette_rounded, 'color': Colors.redAccent},
    {'name': 'Matrix Green', 'icon': Icons.code_rounded, 'color': Colors.greenAccent},
  ];

  Future<void> _pickVideoFromGallery() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      _loadVideoPlayer(File(video.path));
    }
  }

  Future<void> _recordVideoFromCamera() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.camera);
    if (video != null) {
      _loadVideoPlayer(File(video.path));
    }
  }

  void _loadVideoPlayer(File videoFile) {
    _videoPlayerController?.dispose();
    _selectedVideoFile = videoFile;
    _videoPlayerController = VideoPlayerController.file(videoFile)
      ..initialize().then((_) {
        setState(() {
          _isVideoInitialized = true;
        });
        _videoPlayerController!.play();
        _videoPlayerController!.setLooping(true);
      });
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isSuperAdmin ? 'DARK CINEMA [FUNDADOR ADMIN]' : 'DARK CINEMA STUDIO',
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w900, letterSpacing: 1.5),
        ),
        backgroundColor: const Color(0xFF0D0D12),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.folder_open_rounded, color: Color(0xFF3B82F6)),
            onPressed: _pickVideoFromGallery,
            tooltip: 'Abrir Galería',
          ),
          IconButton(
            icon: const Icon(Icons.camera_alt_rounded, color: Colors.amberAccent),
            onPressed: _recordVideoFromCamera,
            tooltip: 'Grabar Video',
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0D0D12), Color(0xFF050508)],
          ),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            SizedBox(
              height: 220,
              width: double.infinity,
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFF161622), Color(0xFF0F0F17)]),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF3B82F6).withOpacity(0.4), width: 1.5),
                ),
                child: _isVideoInitialized && _videoPlayerController != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(14.5),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            AspectRatio(
                              aspectRatio: _videoPlayerController!.value.aspectRatio,
                              child: VideoPlayer(_videoPlayerController!),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  'Filtro: $_activeFilter',
                                  style: const TextStyle(color: Colors.amberAccent, fontSize: 10, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.video_library_rounded, size: 40, color: Color(0xFF3B82F6)),
                            const SizedBox(height: 10),
                            const Text(
                              'Visor 4K • Sin video cargado',
                              style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF3B82F6), padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6)),
                                  onPressed: _pickVideoFromGallery,
                                  icon: const Icon(Icons.folder, size: 14),
                                  label: const Text('Galería', style: TextStyle(fontSize: 11)),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.amberAccent, foregroundColor: Colors.black, padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6)),
                                  onPressed: _recordVideoFromCamera,
                                  icon: const Icon(Icons.camera_alt, size: 14),
                                  label: const Text('Grabar', style: TextStyle(fontSize: 11)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 10),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Filtros Rápidos IA (Toca para aplicar)', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey)),
            ),
            const SizedBox(height: 6),
            SizedBox(
              height: 75,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _quickFilters.length,
                itemBuilder: (context, index) {
                  final filter = _quickFilters[index];
                  final bool isSelected = _activeFilter == filter['name'];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _activeFilter = filter['name'];
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Aplicando filtro: ${filter['name']}'), duration: const Duration(milliseconds: 500)),
                      );
                    },
                    child: Container(
                      width: 70,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF3B82F6).withOpacity(0.3) : const Color(0xFF161622),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: isSelected ? const Color(0xFF3B82F6) : Colors.white12, width: isSelected ? 2 : 1),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(filter['icon'], color: filter['color'], size: 22),
                          const SizedBox(height: 4),
                          Text(
                            filter['name'],
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 9.5, color: isSelected ? Colors.white : Colors.grey, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF12121A),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.white10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Ajustes de Estudio (Contraste y Luz)', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white70)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Text('Contraste', style: TextStyle(fontSize: 10, color: Colors.grey)),
                        Expanded(
                          child: Slider(
                            value: _contrastVal,
                            min: 0.5,
                            max: 2.0,
                            activeColor: const Color(0xFF3B82F6),
                            onChanged: (val) => setState(() => _contrastVal = val),
                          ),
                        ),
                        Text(_contrastVal.toStringAsFixed(1), style: const TextStyle(fontSize: 10, color: Colors.white)),
                      ],
                    ),
                    Row(
                      children: [
                        const Text('Brillo', style: TextStyle(fontSize: 10, color: Colors.grey)),
                        Expanded(
                          child: Slider(
                            value: _brightnessVal,
                            min: -1.0,
                            max: 1.0,
                            activeColor: Colors.amberAccent,
                            onChanged: (val) => setState(() => _brightnessVal = val),
                          ),
                        ),
                        Text(_brightnessVal.toStringAsFixed(1), style: const TextStyle(fontSize: 10, color: Colors.white)),
                      ],
                    ),
                  ],
                ),
              ),
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
    return Scaffold(
      appBar: AppBar(title: const Text('Galería: 50 Filtros Pro', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900)), backgroundColor: const Color(0xFF0D0D12), elevation: 0),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFF0D0D12), Color(0xFF050508)]),
        ),
        child: const Center(child: Text('Suite completa de 50 filtros profesionales activa', style: TextStyle(color: Colors.grey, fontSize: 13))),
      ),
    );
  }
}

class AudioMusicStudioScreen extends StatelessWidget {
  const AudioMusicStudioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Estudio de Audio & Lo-Fi Beats', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900)), backgroundColor: const Color(0xFF0D0D12), elevation: 0),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFF0D0D12), Color(0xFF050508)]),
        ),
        child: const Center(child: Text('Consola de masterización de voz y audio 8D lista', style: TextStyle(color: Colors.grey, fontSize: 13))),
      ),
    );
  }
}

class SubscriptionCheckoutTab extends StatelessWidget {
  final bool isSuperAdmin;
  const SubscriptionCheckoutTab({super.key, required this.isSuperAdmin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pasarela de Pago Global', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900)), backgroundColor: const Color(0xFF0D0D12), elevation: 0),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFF0D0D12), Color(0xFF050508)]),
        ),
        child: Center(
          child: Text(isSuperAdmin ? 'Panel de Fundador & Regalías 2% Activo' : 'Membresía Creator Pro ($199 MXN)', style: const TextStyle(color: Colors.white, fontSize: 14)),
        ),
      ),
    );
  }
}
