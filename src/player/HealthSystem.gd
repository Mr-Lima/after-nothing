class_name HealthSystem

# Declare member variables here. Examples:
var body = {
  "head": 100,
  "torso": 100,
  "legs": 100
 }


# Called when the node enters the scene tree for the first time.
func _ready():
  pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#  pass

func hurt(hp, body_part) -> void:
  body[body_part] -= hp
  
