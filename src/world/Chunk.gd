class_name Chunk
extends Node2D

var chunk_left: Chunk
var chunk_right: Chunk
var chunk_up: Chunk
var chunk_down: Chunk
var color_rect: ColorRect

func _init(size: int, position: Vector2):
  self.position = position
  self.color_rect = ColorRect.new()
  self.color_rect.rect_size = Vector2(size, size)
  self.color_rect.rect_position = Vector2.ZERO
  self.color_rect.color = Color(1, 1, 1, 1)

# Called when the node enters the scene tree for the first time.
func _ready():
  
  pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#  pass
