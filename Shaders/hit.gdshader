shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}


uniform float white : hint_range(0.0, 1.0); // Controla si el sprite se vuelve blanco

void fragment() {
    vec4 original_color = texture(TEXTURE, UV); // Obtén el color original del sprite
    vec4 white_color = vec4(1.0, 1.0, 1.0, original_color.a); // Color blanco con la misma opacidad
    COLOR = mix(original_color, white_color, white); // Mezcla entre original y blanco
}


//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
