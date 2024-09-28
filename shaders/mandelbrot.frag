// Adapted for Flutter from https://www.youtube.com/shorts/h5PuIm6fRr8

#version 460 core

precision mediump float;

#include <flutter/runtime_effect.glsl>

uniform vec2 uSize;
uniform float uProgress;

out vec4 fragColor;

const float MAX_ITER = 512.0;

float mandelbrot(vec2 uv) {
  const float MAX_ITER = 128;
  vec2 c = 2.4 * uv - vec2(0.7, 0.0);
  vec2 z = vec2(0.0);

  for (float iter = 0.0; iter < MAX_ITER; iter++) {
    z = vec2(z.x * z.x - z.y * z.y, 2.0 * z.x * z.y) + c;
    if (length(z) > 4.0) {
      return iter / MAX_ITER;
    }
  }

  return 0.0;
}

vec3 hash13(float m) {
  if (m == 0.0)
    return vec3(0.0);

  float r = fract(sin(m) * uProgress);
  float g = fract(sin(m + r));
  float b = fract(sin(m + r + g));
  return vec3(r, g, b);
}

void main() {

  vec2 uv = (FlutterFragCoord().xy - 0.5 * uSize.xy) / uSize.y;
  float m = mandelbrot(uv);
  vec3 col = hash13(m);

  fragColor = vec4(col, 1.0);
}