import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
// Certifique-se que o caminho do import está certo para o SEU projeto:
// import 'dashboard_screen.dart'; // Não precisamos importar se o main.dart gerencia a navegação

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  bool _loading = false;

  // --- LOGIN COM EMAIL ---
  Future<void> _loginComEmail() async {
    setState(() => _loading = true);
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _senhaController.text.trim(),
      );
      // O main.dart detectará a mudança e levará ao Dashboard automaticamente.
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao entrar: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  // --- LOGIN COM GOOGLE (COM O CORREÇÃO WEB) ---
  Future<void> _loginComGoogle() async {
    setState(() => _loading = true);
    try {
      // ⚠️ AQUI ESTÁ A CORREÇÃO IMPORTANTE PARA O WEB
      final GoogleSignIn googleSignIn = GoogleSignIn(
        clientId:
            '566490580489-1vpalicq8e4iicnuhkvmbjk1ke1r6bua.apps.googleusercontent.com',
      );

      final googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        setState(() => _loading = false);
        return; // Usuário cancelou
      }

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      // Não precisamos de Navigator.push aqui, o StreamBuilder no main.dart faz isso.
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro Google: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // ⚪ fundo branco
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 🟦 Logo principal (Se não tiver a imagem, comente esta linha)
                // Se der erro de "Asset not found", comente abaixo e use um Icon:
                Image.asset(
                  'assets/logo_pmap.png',
                  height:
                      250, // Ajustei levemente para caber melhor em telas menores
                  fit: BoxFit.contain,
                  errorBuilder: (c, o, s) => const Icon(
                      Icons.image_not_supported,
                      size: 100,
                      color: Colors.grey),
                ),
                const SizedBox(height: 40),

                // 📩 Campo de e-mail
                TextField(
                  controller: _emailController,
                  style: const TextStyle(color: Color(0xFF00294D)),
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    labelStyle: const TextStyle(color: Colors.black87),
                    hintText: 'exemplo@email.com',
                    hintStyle: const TextStyle(color: Color(0xFF00294D)),
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: Color(0xFF00294D),
                        width: 1.8,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF00294D),
                        width: 2.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // 🔒 Campo de senha
                TextField(
                  controller: _senhaController,
                  obscureText: true,
                  style: const TextStyle(color: Color(0xFF00294D)),
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    labelStyle: const TextStyle(color: Colors.black87),
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: Color(0xFF00294D),
                        width: 1.8,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF00294D),
                        width: 2.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // 🔘 Botão de entrar
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _loading ? null : _loginComEmail,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00294D),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: _loading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 2))
                        : const Text(
                            'Entrar',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
                const SizedBox(height: 20),

                // ou
                const Row(
                  children: [
                    Expanded(
                        child: Divider(thickness: 1, color: Colors.black26)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child:
                          Text('ou', style: TextStyle(color: Colors.black54)),
                    ),
                    Expanded(
                        child: Divider(thickness: 1, color: Colors.black26)),
                  ],
                ),
                const SizedBox(height: 20),

                // 🟠 Login com Google (usando google_icon)
                OutlinedButton.icon(
                  onPressed: _loading ? null : _loginComGoogle,
                  // Se não tiver o ícone, usa um Icon do Flutter
                  icon: Image.asset(
                    'assets/google_icon.png',
                    height: 24,
                    errorBuilder: (c, o, s) =>
                        const Icon(Icons.g_mobiledata, size: 28),
                  ),
                  label: const Text(
                    'Entrar com Google',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.black26),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 26, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 50),

                // ⚓ Rodapé — logo Marinauta + texto institucional
                Column(
                  children: [
                    // Se não tiver a imagem, o errorBuilder evita o crash
                    Image.asset(
                      'assets/logo_marinauta.png',
                      height: 40,
                      opacity: const AlwaysStoppedAnimation(0.8),
                      errorBuilder: (c, o, s) => const Icon(Icons.sailing,
                          size: 40, color: Colors.grey),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Marinauta – 24 HS. Sea Works & Marine Science Services',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
