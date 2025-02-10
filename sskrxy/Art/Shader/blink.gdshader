shader_type canvas_item;

uniform vec4 blink_color: source_color;
uniform float blink_value;

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	COLOR = mix(color, blink_color, blink_value * color.a);
}

