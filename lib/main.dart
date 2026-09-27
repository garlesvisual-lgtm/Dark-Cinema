import 'package:flutter/material.dart';

void main() {
  runApp(const DarkCinemaEcosystemApp());
}

class DarkCinemaEcosystemApp extends StatelessWidget {
  const DarkCinemaEcosystemApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dark Cinema - Ultimate AI Studio',
      debugShowCheckedModeBanner: false,
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
            const Icon(Icons.movie_creation, size: 80, color: Color(0xFF3B82F6)),
            const SizedBox(height: 24),
            const Text(
              'DARK CINEMA',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 5.0, color: Colors.white),
            ),
            const SizedBox(height: 8),
            const Text(
              'El futuro del cine y la IA en tus manos',
              style: TextStyle(fontSize: 13, color: Colors.grey, letterSpacing: 1.2),
            ),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF14141A),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFF3B82F6).withOpacity(0.4)),
              ),
              child: const Column(
                children: [
                  Text(
                    '🎬 Seguridad y Acceso Biométrico:',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white70),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '• Registro obligatorio por Correo Electrónico\n• Autenticación biométrica por Escaneo de Iris\n• Control de cuentas y licencias Pro / VIP',
                    style: TextStyle(fontSize: 12, color: Colors.grey, height: 1.5),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 52,
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
                child: const Text('Crear Cuenta / Registrarse', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
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
    // Simula el escaneo de iris del dispositivo
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF14141A),
        title: const Row(
          children: [
            Icon(Icons.remove_red_eye, color: Color(0xFF3B82F6)),
            SizedBox(width: 10),
            Text('Escáner de Iris', style: TextStyle(color: Colors.white, fontSize: 16)),
          ],
        ),
        content: const Text(
          'Coloque su rostro frente a la cámara frontal para el reconocimiento de patrón de iris...',
          style: TextStyle(color: Colors.grey),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
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
            child: const Text('Completar Escaneo'),
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
        const SnackBar(content: Text('Por favor, ingresa tu correo electrónico y contraseña.')),
      );
      return;
    }

    if (!_irisScanned) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Es obligatorio completar el registro y escaneo de iris para crear tu cuenta.')),
      );
      return;
    }

    // Validación de códigos VIP / Creador
    bool isSuperAdmin = false;
    DateTime expirationDate = DateTime(2026, 10, 26);
    bool isExpired = DateTime.now().isAfter(expirationDate);

    if (code == 'DARK-FOUNDER-ADOLFO-99X' || code == 'DARK-VIP-FAMILIA-ANDREA-77') {
      isSuperAdmin = true;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('¡Cuenta VIP creada y verificada para $code!')),
      );
    } else if (code == 'YOUTUBE-PRO' || code == 'CREATOR-PASS') {
      if (isExpired) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('El código de creador ingresado ha expirado (vigencia de 30 días terminada).')),
        );
        return;
      } else {
        isSuperAdmin = true;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('¡Cuenta de Creador Pro activada por 30 días!')),
        );
      }
    } else if (code.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Código inválido. Cuenta creada con perfil estándar (3 videos gratuitos).')),
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
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.fingerprint, size: 64, color: Color(0xFF3B82F6)),
                const SizedBox(height: 16),
                const Text(
                  'REGISTRO DARK CINEMA',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 2.0, color: Colors.white),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Crea tu cuenta con correo y seguridad biométrica',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 24),
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
                const SizedBox(height: 12),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Contraseña de la cuenta',
                    prefixIcon: const Icon(Icons.lock, color: Color(0xFF3B82F6)),
                    filled: true,
                    fillColor: const Color(0xFF14141A),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 50,
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
                      _irisScanned ? 'Iris Verificado (Biometría OK)' : 'Escanear Iris (Requerido)',
                      style: TextStyle(
                        fontSize: 14,
                        color: _irisScanned ? Colors.green : Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _codeController,
                  decoration: InputDecoration(
                    hintText: 'Código VIP o Creador (Opcional)',
                    prefixIcon: const Icon(Icons.card_giftcard, color: Colors.amber),
                    filled: true,
                    fillColor: const Color(0xFF14141A),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B82F6),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    onPressed: () => _registerAccount(context),
                    child: const Text('Finalizar Registro e Ingresar', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Sistema de autenticación por correo e iris protegido por Dark Cinema.',
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
  int freeVideosLeft = 3;

  void consumeFreeVideo(BuildContext context) {
    if (widget.isSuperAdmin) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('[Admin] Video generado con licencia maestra ilimitada.')));
      return;
    }

    if (freeVideosLeft > 0) {
      setState(() {
        freeVideosLeft--;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Video generado con éxito. Te quedan $freeVideosLeft videos gratuitos en este ciclo de 15 días.')),
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
        title: const Text('¡Has agotado tus videos gratuitos!', style: TextStyle(color: Colors.white)),
        content: const Text(
          'Tus 3 videos gratuitos de este ciclo de 15 días han terminado. Suscríbete a Creator Pro por solo \$199 MXN al mes (conversión automática a tu moneda local) para obtener creaciones ilimitadas y 50 filtros Pro.',
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
            child: const Text('Suscribirse Pro (\$199 MXN)'),
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
    ];

    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        backgroundColor: const Color(0xFF14141A),
        selectedItemColor: const Color(0xFF3B82F6),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.videocam), label: 'Estudio'),
          BottomNavigationBarItem(icon: Icon(Icons.auto_awesome), label: 'Filtros Pro'),
          BottomNavigationBarItem(icon: Icon(Icons.mic), label: 'Audio & Lo-Fi'),
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
        title: Text(isSuperAdmin ? 'DARK CINEMA [FOUNDER ADMIN]' : 'DARK CINEMA STUDIO', style: const TextStyle(fontSize: 12, letterSpacing: 1.2)),
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
                  const Text('Créditos del ciclo (15 días):', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  Text(
                    isSuperAdmin ? 'Ilimitados (Admin)' : '$freeVideosLeft / 3 disponibles',
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
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.play_circle_fill, size: 64, color: Color(0xFF3B82F6)),
                      SizedBox(height: 12),
                      Text('Visor de Video 4K & IA Local', style: TextStyle(color: Colors.white70, fontSize: 14)),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF3B82F6), padding: const EdgeInsets.all(16)),
                    onPressed: onGenerate,
                    icon: const Icon(Icons.bolt),
                    label: const Text('Generar Video IA'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(padding: const EdgeInsets.all(16)),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Asistente Gemini escuchando comandos...')));
                    },
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
      {'name': 'Estilo Pixar 3D', 'isPro': true},
      {'name': 'Modo Plastilina (Claymation)', 'isPro': true},
      {'name': 'Estilo Cinematográfico Avatar', 'isPro': true},
      {'name': 'Cyberpunk Neon', 'isPro': true},
      {'name': 'Básico: Cine Noir', 'isPro': false},
      {'name': 'Básico: Sepia Vintage', 'isPro': false},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Galería de Filtros (50 Pro)', style: TextStyle(fontSize: 13)), backgroundColor: const Color(0xFF14141A)),
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
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Filtro "${filter['name']}" aplicado.')));
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
                    Icon(locked ? Icons.lock : Icons.auto_awesome, color: locked ? Colors.amber : const Color(0xFF3B82F6), size: 28),
                    const SizedBox(height: 8),
                    Text(
                      filter['name'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    if (locked)
                      const Text('Pro (\$199 MXN / Local)', style: TextStyle(fontSize: 9, color: Colors.amber)),
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
          'Desbloquea los 50 filtros con IA (Pixar, Plastilina, Avatar) suscribiéndote a Creator Pro por solo \$199 MXN al mes (conversión automática a tu moneda local).',
          style: TextStyle(color: Colors.grey),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cerrar')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF3B82F6)),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Procesando pago global...')));
            },
            child: const Text('Suscribirse Pro (\$199 MXN)'),
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
      appBar: AppBar(title: const Text('Audio, Voz de Estudio & Lo-Fi', style: TextStyle(fontSize: 13)), backgroundColor: const Color(0xFF14141A)),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Grabación y Clonación de Voz IA', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
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
                  const Text('Micrófono de Estudio Pro', style: TextStyle(color: Colors.white70)),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF3B82F6)),
                    onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Grabando voz...'))),
                    child: const Text('Grabar'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text('Generador de Ambientes Lo-Fi', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF14141A),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF3B82F6).withOpacity(0.3)),
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.radio, size: 48, color: Color(0xFF3B82F6)),
                      SizedBox(height: 12),
                      Text('Sintonizando frecuencias cinemáticas...', style: TextStyle(color: Colors.grey, fontSize: 12)),
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
