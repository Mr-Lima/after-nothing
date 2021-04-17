extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
# warning-ignore:return_value_discarded
  self.connect("body_entered", self, "_on_Trap_entity_entered")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#  pass


func _on_Trap_entity_entered(entity):
  if entity.has_method("hit"):
    entity.hit(70, "legs")
  
