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
    
    // I think these are correct??
    vec3 vert_position = vec3(model_matrix * (vec4(vertex_position), 1.0));
    vec3 vert_normal = normalize(vec3(inverse(transpose(mat3(model_matrix))) * vertex_normal));
    
    for(int i = 0; i < num_of_lights; i++)
    {
        vec3 light_direction = normalize(light_position[i] - v_position);
        float diff_dot = max(dot(v_normal, light_direction), 0.0);
        diffuse = diffuse + (light_color[i] * diff_dot);
        
        vec3 reflection_direction = reflect(-light_direction, v_normal);
        vec3 view_direction = normalize(camera_position - v_position);
        float spec_dot = max(dot(reflection_direction, view_direction), 0.0);
        specular = specular + (light_color[i] * pow(spec_dot, material_shininess));
    }
}
