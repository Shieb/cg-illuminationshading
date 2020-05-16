#version 300 es

precision highp float;

in vec3 vertex_position;
in vec3 vertex_normal;


uniform vec3 light_ambient;
uniform vec3 light_position;
uniform vec3 light_color;
uniform vec3 camera_position;
uniform float material_shininess;
uniform mat4 model_matrix;
uniform mat4 view_matrix;
uniform mat4 projection_matrix;

out vec3 ambient;
out vec3 diffuse;
out vec3 specular;

void main() {
    gl_Position = projection_matrix * view_matrix * model_matrix * vec4(vertex_position, 1.0);

    ambient = light_ambient;

    vec3 vert_pos = vec3(model_matrix * vec4(vertex_position, 1.0));
    vec3 vert_norm = normalize(vec3(inverse(transpose(mat3(model_matrix))) * vertex_normal));



      vec3 light_direction = normalize(light_position - vert_pos);
      diffuse += (light_color * max(dot(vert_norm, light_direction), 0.0));

      vec3 reflection_direction = reflect(-light_direction, vert_norm);
      vec3 view_direction = normalize(camera_position - vert_pos);
      float dot_prod = max(dot(reflection_direction, view_direction), 0.0);
      specular += light_color * pow(dot_prod, material_shininess);

}
