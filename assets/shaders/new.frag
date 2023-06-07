#version 460 core

#include <flutter/runtime_effect.glsl>

uniform vec2 uSize;
uniform vec4 uColor;
uniform float uTime; // Add this line

out vec4 FragColor;


vec4 getBackgroundCOLOR() {
    vec2 uv = fragCoord.xy / uSize;
    vec2 pos = (uv.xy - 0.5);
    vec2 cir = ((pos.xy * pos.xy + sin(uv.x * 18.0 + uTime) / 25.0 * sin(uv.y * 7.0 + uTime * 1.5) / 1.0) + uv.x * sin(uTime) / 16.0 + uv.y * sin(uTime * 1.2) / 16.0);
    float circles = (sqrt(abs(cir.x + cir.y * 0.5) * 25.0) * 5.0);
    return vec4(sin(circles * 1.25 + 2.0), abs(sin(circles * 1.0 - 1.0) - sin(circles)), abs(sin(circles) * 1.0), 1.0);
}

vec4 getFractalCOLOR() {
    vec2 pixel = FlutterFragCoord() / uSize;
    float scale = 1.0 / uTime; // Use uTime here to modify the scale
    float x = (pixel.x - 0.5) * scale + 0.25;
    float y = (pixel.y - 0.5) * scale * uSize.y / uSize.x;
    vec2 z = vec2(x, y);
    vec2 c = vec2(-0.74543, 0.11301);
    vec2 v = vec2(0.0);
    float i = 0.0;
    for (int n = 0; n < 100; n++) {
        if (i > 1.0) {
            break;
        }
        v = vec2(v.x * v.x - v.y * v.y, 2.0 * v.x * v.y) + c;
        if (dot(v, v) > 4.0) {
            break;
        }
        i += 0.01;
    }
    return vec4(i, i, i, 1.0);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec4 background = getBackgroundCOLOR();
    vec4 fractal = getFractalCOLOR();

    fragColor = mix(background, fractal, 0.5);
}
void main() {
    mainImage(FragColor, FlutterFragCoord());
}


