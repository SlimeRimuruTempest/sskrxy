shader_type canvas_item;

uniform vec4 blink_color: source_color;
uniform float blink_value: hint_range(0.0, 2.0);

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	COLOR = mix(color, blink_color, blink_value * color.a);
}

