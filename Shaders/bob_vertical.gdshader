shader_type canvas_item;

uniform float amplitude = 50.0;
uniform float frequency = 1.0;

void vertex() {
	VERTEX = vec2(VERTEX.x, VERTEX.y + amplitude * sin(frequency * TIME));
}