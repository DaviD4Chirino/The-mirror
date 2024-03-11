shader_type canvas_item;
uniform float fov = 77;
void vertex() {
	// Called for every vertex the material is visible on.
	
	float scale = 1.0 / tan(fov * 0.5 * PI / 180.0);
	
}

void fragment() {
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
