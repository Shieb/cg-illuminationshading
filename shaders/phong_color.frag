#version 300 es

precision mediump float;

in vec3 frag_pos;
in vec3 frag_normal;

uniform int num_of_lights;
uniform vec3 light_ambient;
uniform vec3 light_position[10];
uniform vec3 light_color[10];
uniform vec3 camera_position;
uniform vec3 material_color;      // Ka and Kd
uniform vec3 material_specular;   // Ks
uniform float material_shininess; // n

out vec4 FragColor;

void main() 
{
    vec3 ambient = light_ambient * material_color;

    for(int i = 0; i < num_of_lights; i++) 
    {
        vec3 light_direction = normalize(light_position[i] - frag_pos);
        vec3 diffuse = light_color[i] * material_color * max(dot(frag_normal, light_direction), 0.0);
    
        vec3 reflection = normalize(reflect(light_direction, frag_normal));
        vec3 view_direction = normalize(camera_position - frag_pos);
        vec3 specular = light_color[i] * material_color * clamp(pow(dot(reflection, view_direction), material_shininess), 0.0, 1.0);
    }
    vec3 final_color = ambient + diffuse + specular;
    final_color.x = min(final_color.x, 1.0);
    final_color.y = min(final_color.y, 1.0);
    final_color.z = min(final_color.z, 1.0);

    FragColor = vec4(final_color, 1.0);
}
