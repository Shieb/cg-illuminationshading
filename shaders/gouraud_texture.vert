#version 300 es

precision highp float;

in vec3 vertex_position;
in vec3 vertex_normal;
in vec2 vertex_texcoord;

uniform int num_of_lights;
uniform vec3 light_ambient;
uniform vec3 light_position[10];
uniform vec3 light_color[10];
uniform vec3 camera_position;
uniform float material_shininess;
uniform vec2 texture_scale;
uniform mat4 model_matrix;
uniform mat4 view_matrix;
uniform mat4 projection_matrix;

out vec3 ambient;
out vec3 diffuse;
out vec3 specular;
out vec2 frag_texcoord;

void main() {
    gl_Position = projection_matrix * view_matrix * model_matrix * vec4(vertex_position, 1.0);
    frag_texcoord = vertex_texcoord * texture_scale;

    // Calculate ambient light
    ambient = vec3(light_ambient);

    vec3 v_position = vec3(model_matrix * vec4(vertex_position, 1.0));
    vec3 v_normal = normalize(vec3(inverse(transpose(mat3(model_matrix))) * vertex_normal));

    for(int i = 0; i < num_of_lights; i++) {
      //diffuse
      vec3 light_direction = normalize(light_position[i] - v_position);
      float dot_product = max(dot(v_normal, light_direction), 0.0);
      diffuse += light_color[i] * dot_product;

      //specular
      vec3 reflection_direction = reflect(-light_direction, v_normal);
      vec3 view_direction = normalize(camera_position - v_position);
      float dot_product2 = max(dot(reflection_direction, view_direction), 0.0);
      specular += light_color[i] * pow(dot_product2, material_shininess);
    }

}
