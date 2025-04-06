shader_type canvas_item;

uniform vec2 speed = vec2(0.0, 0.0);

uniform float wave_Frequency = 5.0;
uniform float wave_Speed = 1.0;
uniform float wave_Amplitude = 10.0;

void vertex() 
{
	float y_Wave = sin(VERTEX.x * wave_Frequency + TIME * wave_Speed) * wave_Amplitude;
	VERTEX.y += y_Wave * (1.0f - UV.y);
}

void fragment() 
{
	vec2 uv = UV;
	vec2 scroll_Offset = TIME * speed;
	uv += scroll_Offset;
	
	COLOR = texture(TEXTURE, mod(uv, 1.0));
}