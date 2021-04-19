extends TextureRect


# The maximum 8-bit value of a color channel held into 32-bit images.
# Named after the `Image.FORMAT_L8` format we use below.
const L8_MAX := 255

export var colormap: GradientTexture


func _ready() -> void:
  # The open simplex noise algorithm takes a while to generate the noise data so
  # we have to wait for it to finish updating before using it in any calculations.
  yield(texture, "changed")
  var heightmap_minmax := _get_heightmap_minmax(texture.get_data())
  # Use the material's `set_shader_param` method to assign values to a shader's uniforms.
  material.set_shader_param("noise_minmax", heightmap_minmax)


# Returns the lowest and highest value of the heightmap, converted to be in the [0.0, 1.0] range.
func _get_heightmap_minmax(image: Image) -> Vector2:
  # We convert the image to have a single channel of integer values that go from `0` to `255`.
  image.convert(Image.FORMAT_L8)
  # Gets the lowest and biggest values in the image and divides it to have values between 0 and 1.
  return _get_minmax(image.get_data()) / L8_MAX


# Utility function that returns the minimum and maximum value of an array as a `Vector2`
func _get_minmax(array: Array) -> Vector2:
  var out := Vector2(INF, -INF)
  for value in array:
    out.x = min(out.x, value)
    out.y = max(out.y, value)
  return out
