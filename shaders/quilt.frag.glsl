precision mediump float;

uniform vec2 resolution;
uniform float time;
uniform float seed;

void main() {
    vec2 coord = gl_FragCoord.xy / resolution;

    // Output RGB color in range from 0.0 to 1.0
    vec3 color = vec3(coord.x, coord.y, 0.0);
    color.z += abs(sin(time));

    // 1. Uncomment these lines to draw triangles
    vec2 squareCoord = 15.0 * (2.0 + log(0.01 + seed)) * gl_FragCoord.xy / resolution.y + vec2(time);
    vec2 loc = fract(squareCoord);
    color = vec3(smoothstep(-0.05, 0.05, (seed + 1.0) * loc.y - loc.x));

    // 2. Uncomment these lines to invert some of the triangles
    vec2 cell = squareCoord - loc;
    if (mod(cell.x + cell.y + seed, 2.0) == 1.0)
    {
        color = 1.0 - color;
    }


    // 3. Uncomment these lines to produce interesting colors
    float a = mod(6.0 * cell.x + 4.0 * cell.y, 9.0) / 9.0;
    float b = mod(1.53 * cell.x + 5.32 * cell.y, 3.0) / 3.0;
    float c = mod(3.0 * cell.x + 2.0 * cell.y, 7.0) / 7.0;
    color = 1.0 - (1.0 - color) * vec3(a, b, c);

    // 4. Uncomment to lighten the colors
    // color = sqrt(color);

    gl_FragColor = vec4(color, 1.0);
}
