#version 460 core

#include <flutter/runtime_effect.glsl>

uniform vec2 uSize;
uniform vec4 uColor;
uniform float uSpeed;
uniform float uCloudSize;

out vec4 FragColor;
// Hash function
float hash(vec2 p) {
    return fract(sin(dot(p, vec2(12.9898, 78.233))) * 43758.5453);
}

// Interpolation function
float smoothstep(float edge0, float edge1, float x) {
    float t = clamp((x - edge0) / (edge1 - edge0), 0.0, 1.0);
    return t * t * (3.0 - 2.0 * t);
}

// Perlin noise function
float perlin(vec2 p) {
    vec2 i = floor(p);
    vec2 f = fract(p);
    
    // Four corners in 2D space
    float a = hash(i);
    float b = hash(i + vec2(1.0, 0.0));
    float c = hash(i + vec2(0.0, 1.0));
    float d = hash(i + vec2(1.0, 1.0));
    
    // Smooth the position within each grid cell
    vec2 u = smoothstep(0.0, 1.0, f);
    
    // Interpolate gradients
    float x1 = mix(a, b, u.x);
    float x2 = mix(c, d, u.x);
    float y = mix(x1, x2, u.y);
    
    return y;
}


void main() {
    // FlutterFragCoord() returns the coordinate of the current fragment in
    // Create a perlin noise value based on the current fragment's position
    float noise = perlin(FlutterFragCoord() * uCloudSize + uSpeed);

    // Use the noise value to create a color with uColor as the base
    vec4 color = vec4(uColor.r - noise, uColor.g - noise, uColor.b - noise, uColor.a);

    // Set the output color
    FragColor = color;


}


