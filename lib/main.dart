// Copyright 2024 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late Ticker _ticker;
  double _tick = 0;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((elapsed) {
      setState(() {
        _tick += 0.025;
      });
    });
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ShaderBuilder(
        (context, shader, child) => CustomPaint(
          painter: ShaderPainter(
            shader,
            _tick,
          ),
          child: child,
        ),
        assetKey: 'shaders/shadertoy.frag',
        child: Center(
          child: Text('Hello, Shader'),
        ),
      ),
    );
  }
}

class ShaderPainter extends CustomPainter {
  const ShaderPainter(this.shader, this.time);
  final ui.FragmentShader shader;
  final double time;

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    shader.setFloatUniforms(
      (uniforms) {
        uniforms.setSize(size);
        uniforms.setFloat(time);
      },
    );
    canvas.drawRect(
        Offset.zero & size,
        Paint()
          ..style = ui.PaintingStyle.fill
          ..shader = shader);
  }

  @override
  bool shouldRepaint(covariant ShaderPainter oldDelegate) => true;
}
