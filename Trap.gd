extends Area2D


# Declare member variables here. Examples:
export var damage = 50


# Called when the node enters the scene tree for the first time.
func _ready():
# warning-ignore:return_value_discarded
  self.connect("body_entered", self, "_on_Trap_entity_entered")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#  pass


func _on_Trap_entity_entered(entity):
  if entity.player:
    Events.emit_signal("player_hit_happened", HealthSystem.DamageSource.TRAP, self.damage, entity.player)
  else:
    entity.get_hit(self.damage)
  
