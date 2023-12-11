shader_type canvas_item;
render_mode unshaded;

uniform float speed = 1.0;

vec2 rotateUV(vec2 uv, float rotation) {
	float cosa = cos(rotation);
	float sina = sin(rotation);
	return vec2(
		cosa * uv.x - sina * uv.y,
		cosa * uv.y + sina * uv.x 
	);
}

void vertex() {
	VERTEX = rotateUV(VERTEX, -TIME * speed);
}