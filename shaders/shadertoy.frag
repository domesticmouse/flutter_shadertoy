// Derived from the defualt shadertoy shader
//   https://www.shadertoy.com/new

#version 460 core

precision mediump float;

#include <flutter/runtime_effect.glsl>

uniform vec2 uSize;
uniform float uTime;

out vec4 fragColor;

void main()
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = FlutterFragCoord().xy/uSize.xy;

    // Time varying pixel color
    vec3 col = 0.5 + 0.5*cos(uTime+uv.xyx+vec3(0,2,4));

    // Output to screen
    fragColor = vec4(col,1.0);
}