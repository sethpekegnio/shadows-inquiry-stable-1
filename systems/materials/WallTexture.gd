# res://materials/WallTexture.gd
extends ShaderMaterial

func _ready():
    shader = Shader.new()
    shader.code = """
    shader_type spatial;
    render_mode blend_mix, depth_draw_opaque, cull_back;

    uniform vec4 wall_color : hint_color = vec4(0.95, 0.92, 0.85, 1.0); // Beige doux
    uniform vec4 accent_color : hint_color = vec4(0.75, 0.75, 0.78, 1.0); // Béton gris clair
    uniform vec4 brick_color : hint_color = vec4(0.75, 0.55, 0.45, 1.0); // Brique chaude
    uniform float texture_scale : hint_range(0.1, 5.0) = 2.0;
    uniform float roughness : hint_range(0.0, 1.0) = 0.8;
    uniform float metallic : hint_range(0.0, 1.0) = 0.0;

    // Bruit procédural (Perlin-like)
    float hash(vec2 p) {
        return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453123);
    }

    float noise(vec2 p) {
        vec2 i = floor(p);
        vec2 f = fract(p);
        f = f * f * (3.0 - 2.0 * f);
        float a = hash(i);
        float b = hash(i + vec2(1.0, 0.0));
        float c = hash(i + vec2(0.0, 1.0));
        float d = hash(i + vec2(1.0, 1.0));
        return mix(mix(a, b, f.x), mix(c, d, f.x), f.y);
    }

    void fragment() {
        vec2 uv = UV * texture_scale;
        
        // Base : enduit texturé
        float n = noise(uv * 3.0) * 0.5 + noise(uv * 8.0) * 0.3 + noise(uv * 20.0) * 0.2;
        vec3 base = mix(wall_color.rgb, accent_color.rgb, smoothstep(0.4, 0.6, n));
        
        // Brique douce (bandes verticales)
        float brick = smoothstep(0.45, 0.55, fract(uv.y * 10.0)) * 0.3;
        base = mix(base, brick_color.rgb, brick * smoothstep(0.0, 0.3, fract(uv.x * 5.0)));
        
        // Micro-texture enduit
        float detail = noise(uv * 50.0) * 0.1;
        base += detail;
        
        ALBEDO = base;
        ROUGHNESS = roughness;
        METALLIC = metallic;
        NORMAL = normalize(vec3(
            noise(uv * 30.0) - 0.5,
            noise(uv * 30.0 + vec2(1.0)) - 0.5,
            1.0
        )) * 0.05;
    }
    """