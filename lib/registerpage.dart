import 'package:flutter/material.dart';
import 'package:ucp1/loginpage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confpasswordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logospecss.png', height: 75),
              const SizedBox(height: 25),
              const Text(
                'DAFTAR AKUN BARU',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 20),
              // Nama Lengkap
              ListTile(
                title: const Text(
                  'Nama Lengkap',
                  style: TextStyle(fontSize: 13),
                ),
                subtitle: TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nama Lengkap',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama lengkap tidak boleh kosong';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text(
                        'Email',
                        style: TextStyle(fontSize: 13),
                      ),
                      subtitle: TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          prefixIcon: Icon(Icons.email),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text(
                        'No HP',
                        style: TextStyle(fontSize: 13),
                      ),
                      subtitle: TextFormField(
                        controller: phoneController,
                        decoration: const InputDecoration(
                          labelText: 'No HP',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          prefixIcon: Icon(Icons.phone),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'No HP tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text(
                        'Password',
                        style: TextStyle(fontSize: 13),
                      ),
                      subtitle: TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                        obscureText: _obscurePassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text(
                        'Konfirmasi Password',
                        style: TextStyle(fontSize: 13),
                      ),
                      subtitle: TextFormField(
                        controller: confpasswordController,
                        decoration: InputDecoration(
                          labelText: 'Konfirmasi Password',
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                        obscureText: _obscurePassword,
                        validator: (value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text(
                                'Password tidak sama',
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: const Color.fromARGB(
                                255,
                                255,
                                0,
                                0,
                              ),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                          if (value == null || value.isEmpty) {
                            return 'Konfirmasi password tidak boleh kosong';
                          }
                          if (value != passwordController.text) {
                            return 'Password dan konfirmasi password tidak cocok';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              // Daftar Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Setelah validasi sukses, lanjutkan ke HomePage
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => HomePage(
                              nama:
                                  nameController
                                      .text, // Passing name to HomePage
                            ),
                      ),
                    );
                  }
                },
                child: const Text('Daftar'),
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(Size.fromWidth(375)),
                  backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 252, 1, 1),
                  ),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              // Redirect ke LoginPage
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Sudah memiliki akun? Silahkan'),
                  const SizedBox(width: 5),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: const Text(
                      'Login Disini!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrangeAccent,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
