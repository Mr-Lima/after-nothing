class_name ChunkSystem
extends Node

enum ChunkSide {
  LEFT,
  RIGHT,
  UP, 
  DOWN
 }


export var chunk_size  = 720

func generate_initial_chunks() -> Chunk:
  var center = Chunk.new(chunk_size, Vector2.ZERO)
  center.chunk_left = Chunk.new(chunk_size, _get_chunk_position(ChunkSide.LEFT, center.position))
  center.chunk_right = Chunk.new(chunk_size, _get_chunk_position(ChunkSide.RIGHT, center.position))
  center.chunk_up = Chunk.new(chunk_size, _get_chunk_position(ChunkSide.UP, center.position))
  center.chunk_down = Chunk.new(chunk_size, _get_chunk_position(ChunkSide.DOWN, center.position))
  
  return center
  
  
func _generate_cross_chunks(center_chunk: Chunk):
  pass
  
func _get_chunk_position(chunk_side, reference_chunk_position: Vector2) -> Vector2:
  var final_position = Vector2.ZERO
  
  match chunk_side:
    ChunkSide.LEFT:
      final_position = Vector2(
        reference_chunk_position.x - chunk_size, 
        reference_chunk_position.y
      )
    ChunkSide.RIGHT:
      final_position = Vector2(
        reference_chunk_position.x + chunk_side,
        reference_chunk_position.y  
      )
    ChunkSide.UP:
      final_position = Vector2(
        reference_chunk_position.x,
        reference_chunk_position.y - chunk_side  
      )
    ChunkSide.DOWN:
      final_position = Vector2(
        reference_chunk_position.x,
        reference_chunk_position.y + chunk_side
      )
    
  return final_position
