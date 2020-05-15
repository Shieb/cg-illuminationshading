#version 300 es

precision mediump float;

in vec3 ambient;
in vec3 diffuse;
in vec3 specular;
in vec2 frag_texcoord;

uniform vec3 material_color;    // Ka and Kd
uniform vec3 material_specular; // Ks
uniform sampler2D image;        // use in conjunction with Ka and Kd

out vec4 FragColor;

void main() 
{
    vec4 final_ambient = vec4(ambient * material_color, 1.0);
    vec4 final_diffuse = vec4(diffuse * material_color, 1.0);
    vec4 final_specular = vec4(specular * material_specular, 1.0);

    vec4 color = final_ambient + final_diffuse + final_specular;

    color.x = min(color.x, 1.0);
    color.y = min(color.y, 1.0);
    color.z = min(color.z, 1.0);
    
    FragColor = texture(image, frag_texcoord);
}
