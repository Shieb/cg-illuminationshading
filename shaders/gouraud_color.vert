#version 300 es

precision highp float;

in vec3 vertex_position;
in vec3 vertex_normal;

uniform vec3 light_ambient;
uniform vec3 light_position;
uniform vec3 light_color;
uniform vec3 camera_position;
uniform float material_shininess; // n
uniform mat4 model_matrix;
uniform mat4 view_matrix;
uniform mat4 projection_matrix;

out vec3 ambient;
out vec3 diffuse;
out vec3 specular;

void main() 
{
    gl_Position = projection_matrix * view_matrix * model_matrix * vec4(vertex_position, 1.0);
    
   ambient = light_ambient; 
    
    vec3 vertex_position_new = vec3(model_matrix * vec4(vertex_position, 1.0)); 
    vec3 vertex_normal_new = normalize(inverse(transpose(mat3(model_matrix))) * vertex_normal); 
    vec3 light_vector = normalize(light_position - vertex_position_new); 
    
    diffuse = light_color * clamp(dot(vertex_normal_new, light_vector), 0.0, 1.0); 
    
    
    vec3 reflected = normalize(reflect(normalize(light_vector), normalize(vertex_normal))); 
    vec3 view_direction = normalize(vec3(camera_position - vertex_position)); 
    
    
    specular = light_color * clamp(pow(dot(reflected, view_direction), material_shininess), 0.0, 1.0); 
}
