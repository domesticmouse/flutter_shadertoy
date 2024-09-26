// Copyright 2024 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

class ShaderPainter extends CustomPainter {
  const ShaderPainter(this.shader, this.time);
  final ui.FragmentShader shader;
  final double time;

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    shader.setFloatUniforms((uniforms) {
      uniforms.setSize(size);
      uniforms.setFloat(time);
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
