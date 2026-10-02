varying vec4 v_vColour;
varying vec3 v_vWorldNormal;
varying vec2 v_vTexcoord;

uniform vec4 u_Color;
//uniform vec3 lightDirection;
//uniform vec3 lightColor;

void main() {
    vec3 lightDirection = vec3(1, -0.9, -0.8);
    vec3 lightColor = vec3(1, 1, 1);
    vec4 color = vec4(lightColor, 1);
	float intensity = dot(normalize(v_vWorldNormal), normalize(-lightDirection));
    gl_FragColor = texture2D( gm_BaseTexture, v_vTexcoord ) * u_Color * v_vColour * sqrt(max(0.25, intensity)) * color;
    gl_FragColor.a = 1.;
}