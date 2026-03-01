#pragma header

uniform float uTime;

void main()
{
    vec2 uv = openfl_TextureCoordv.xy;
    vec2 resolution = openfl_TextureSize.xy;

    vec2 fragCoord = uv * resolution;

    vec2 p = (2.0 * fragCoord - resolution) / min(resolution.x, resolution.y);

    for (float i = 1.0; i < 8.0; i += 1.0)
    {
        p.y += 0.1 *
               sin(p.x * i * i + uTime * 0.5) *
               sin(p.y * i * i + uTime * 0.5);
    }

    vec3 col;
    col.r = p.y - 0.1;
    col.g = p.y + 0.3;
    col.b = p.y + 0.95;

    gl_FragColor = vec4(col, 1.0);
}