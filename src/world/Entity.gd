extends Node
class_name Entity

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var id = 0
var hp = 100

enum Penalty {
  SLOW,
  BLEED
 }


func _init():
  id = Utils.generate_entity_id()


# Called when the node enters the scene tree for the first time.
func _ready():
  pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#  pass

func get_hit(damage: int):
  hp -= damage
