extends Node


# Declare member variables here. Examples:
var id := 0


# Called when the node enters the scene tree for the first time.
func _ready():
  pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#  pass

func generate_entity_id() -> int:
  id = id + 1
  return id;
  
func emit_entity_hit(damage_source, damage: int, entity: Entity):
  if entity.player:
    Events.emit_signal("player_hit_happened", damage_source, damage, entity)
  else:
    entity.hit(damage)
  
