#pragma header

uniform float uTime;

vec3 mod289_vec3(vec3 x) {
    return x - floor(x * (1.0 / 289.0)) * 289.0;
}

vec2 mod289_vec2(vec2 x) {
    return x - floor(x * (1.0 / 289.0)) * 289.0;
}

vec3 permute(vec3 x) {
    return mod289_vec3(((x * 34.0) + 1.0) * x);
}

float snoise(vec2 v)
{
    const vec4 C = vec4(
        0.211324865405187,
        0.366025403784439,
       -0.577350269189626,
        0.024390243902439
    );

    vec2 i = floor(v + dot(v, C.yy));
    vec2 x0 = v - i + dot(i, C.xx);

    vec2 i1;
    if (x0.x > x0.y) {
        i1 = vec2(1.0, 0.0);
    } else {
        i1 = vec2(0.0, 1.0);
    }

    vec4 x12 = x0.xyxy + C.xxzz;
    x12.xy = x12.xy - i1;

    i = mod289_vec2(i);

    vec3 p = permute(
        permute(i.y + vec3(0.0, i1.y, 1.0))
        + i.x + vec3(0.0, i1.x, 1.0)
    );

    vec3 m = max(
        0.5 - vec3(
            dot(x0, x0),
            dot(x12.xy, x12.xy),
            dot(x12.zw, x12.zw)
        ),
        0.0
    );

    m = m * m;
    m = m * m;

    vec3 x = 2.0 * fract(p * C.www) - 1.0;
    vec3 h = abs(x) - 0.5;
    vec3 ox = floor(x + 0.5);
    vec3 a0 = x - ox;

    m = m * (1.79284291400159 - 0.85373472095314 * (a0 * a0 + h * h));

    vec3 g;
    g.x = a0.x * x0.x + h.x * x0.y;
    g.yz = a0.yz * x12.xz + h.yz * x12.yw;

    return 130.0 * dot(m, g);
}

float rand(vec2 co)
{
    return fract(sin(dot(co.xy, vec2(12.9898, 78.233))) * 43758.5453);
}

void main()
{
    vec2 uv = openfl_TextureCoordv.xy;
    vec2 resolution = openfl_TextureSize.xy;

    float time = uTime * 2.0;

    float noiseLarge = max(
        0.0,
        snoise(vec2(time, uv.y * 0.3)) - 0.3
    ) * (1.0 / 0.7);

    float noiseSmall =
        (snoise(vec2(time * 10.0, uv.y * 2.4)) - 0.5) * 0.15;

    float noise = noiseLarge + noiseSmall;

    float xpos = uv.x - noise * noise * 0.25;

    vec4 color = flixel_texture2D(bitmap, vec2(xpos, uv.y));

    float interference = rand(vec2(uv.y * time, uv.y));
    color.rgb = mix(color.rgb, vec3(interference), noise * 0.3);

    // Scanline effect without mod()
    float lineIndex = floor(uv.y * resolution.y * 0.25);
    float scanMask = step(0.5, fract(lineIndex * 0.5));
    color.rgb = mix(color.rgb * (1.0 - 0.15 * noise), color.rgb, scanMask);

    float gShift = flixel_texture2D(bitmap, vec2(xpos + noise * 0.05, uv.y)).g;
    float bShift = flixel_texture2D(bitmap, vec2(xpos - noise * 0.05, uv.y)).b;

    color.g = mix(color.r, gShift, 0.25);
    color.b = mix(color.r, bShift, 0.25);

    gl_FragColor = color;
}