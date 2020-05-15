#version 300 es

precision mediump float;

in vec3 ambient;
in vec3 diffuse;
in vec3 specular;

uniform vec3 material_color;    // Ka and Kd
uniform vec3 material_specular; // Ks

out vec4 FragColor;

void main() 
{
    vec3 final_ambient = material_color * ambient;
    vec3 final_diffuse = material_color * diffuse;
    vec3 final_specular = material_specular * specular;
    
    vec3 final_color = final_ambient + final_diffuse + final_specular;
    
    final_color.x = min(final_color.x, 1.0);
    final_color.y = min(final_color.y, 1.0);
    final_color.z = min(final_color.z, 1.0);
    
    FragColor = vec4(final_color, 1.0);
}
