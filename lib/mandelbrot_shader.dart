// Copyright 2024 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

class MandelbrotShader extends StatefulWidget {
  const MandelbrotShader({super.key});

  @override
  State<MandelbrotShader> createState() => _MandelbrotShaderState();
}

class _MandelbrotShaderState extends State<MandelbrotShader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..repeat(reverse: true);
    final Animation<double> curve =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _animation = Tween(begin: 0.0, end: 500.0).animate(curve);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShaderBuilder(
      (context, shader, child) {
        return AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return CustomPaint(
              painter: ShaderPainter(shader, _animation.value),
              child: child,
            );
          },
          child: child,
        );
      },
      assetKey: 'shaders/mandelbrot.frag',
      child: SizedBox.expand(),
    );
  }
}

class ShaderPainter extends CustomPainter {
  const ShaderPainter(this.shader, this.progress);
  final ui.FragmentShader shader;
  final double progress;

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    shader.setFloatUniforms((uniforms) {
      uniforms.setSize(size);
      uniforms.setFloat(progress);
    });
    canvas.drawRect(
        Offset.zero & size,
        Paint()
          ..style = ui.PaintingStyle.fill
          ..shader = shader);
  }

  @override
  bool shouldRepaint(covariant ShaderPainter oldDelegate) => true;
}
