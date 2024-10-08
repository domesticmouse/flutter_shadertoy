// Copyright 2024 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'mandelbrot_shader.dart';
import 'shader_art_shader.dart';
import 'shadertoy_new_shader.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorSchemeSeed: Colors.deepPurple),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

enum ShaderType { shadertoy, shaderart, mandelbrot }

class _MyHomePageState extends State<MyHomePage> {
  ShaderType _shaderType = ShaderType.shadertoy;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shader Gallery'),
        actions: <Widget>[
          PopupMenuButton<ShaderType>(
            onSelected: (ShaderType result) {
              setState(() {
                _shaderType = result;
              });
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: ShaderType.shadertoy,
                child: Text('Shadertoy'),
              ),
              PopupMenuItem(
                value: ShaderType.shaderart,
                child: Text('Shader Art'),
              ),
              PopupMenuItem(
                value: ShaderType.mandelbrot,
                child: Text('Mandelbrot'),
              ),
            ],
          ),
        ],
      ),
      body: switch (_shaderType) {
        ShaderType.shadertoy => ShadertoyNewShader(),
        ShaderType.shaderart => ShaderArtShader(),
        ShaderType.mandelbrot => MandelbrotShader(),
      },
    );
  }
}
