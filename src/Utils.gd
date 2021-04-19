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
  

func emit_entity_hit(damage_source, damage: int, entity):
  if entity.player:
    Events.emit_signal("player_hit_happened", damage_source, damage, entity)
  else:
    entity.hit(damage)
    

func pair_numbers(x: int, y:int) -> int:
  var unique_number = ((x+y+1)*(x+y)/2) + y
  return unique_number
  

func unpair_number(z: int):
  var w = floor((sqrt(8 * z + 1) - 1)/2)
  var t = (pow(w,2) + w) / 2
  var y = int(z - t)
  var x = int(w - y)
