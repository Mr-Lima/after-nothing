class_name PlayerEntity
extends LivingEntity

export var speed := 150

onready var temperature := 100
onready var inventory = {}


# Called when the node enters the scene tree for the first time.
func _init():
  Events.emit_signal("player_loaded", id)


#func _process(delta: float):
#  pass


func apply_penalty(penalty_type):
  pass


func _start_plus_frames(time: float):
  self.set_deferred("disabled", true)

  yield(get_tree().create_timer(time), "timeout")

  self.set_deferred("disabled", false)


func _on_Time_passed(world_stats):
  temperature = get_node("../../World").current_heat
  print("player temp ", temperature)
#  if temperature < 30:
#    hp = hp - 10
#
#  if temperature < 20:
#    hp = hp - 20
#
#  if temperature <=0:
#    hp = hp - 100
