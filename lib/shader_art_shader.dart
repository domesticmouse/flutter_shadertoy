// Copyright 2024 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

import 'shader_painter.dart';

class ShaderArtShader extends StatefulWidget {
  const ShaderArtShader({super.key});

  @override
  State<ShaderArtShader> createState() => _ShaderArtShaderState();
}

class _ShaderArtShaderState extends State<ShaderArtShader>
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
    return ShaderBuilder(
      (context, shader, child) => CustomPaint(
        painter: ShaderPainter(shader, _tick),
        child: child,
      ),
      assetKey: 'shaders/shader-art.frag',
      child: SizedBox.expand(),
    );
  }
}
