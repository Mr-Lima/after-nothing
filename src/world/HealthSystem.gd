class_name HealthSystem
extends Node

enum SeriousDamage {
  LEG_BREAK,
  ARM_BREAK,
  HYPOTHERMIA,
 }

enum DamageSource {
  TRAP,
 }

# Declare member variables here. Examples:
var players := {}


# Called when the node enters the scene tree for the first time.
func _init():
  Events.connect("player_loaded", self, "_on_Player_loaded")
  Events.connect("player_hit_happened", self, "_on_Player_Hit_happened")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#  pass
  
func _on_Player_loaded(player_id: int):
    players[player_id] = _player_body_factory()
    

func _on_Player_Hit_happened(damage_source, damage: int, entity: PlayerEntity):
  match damage_source:
    DamageSource.TRAP:
      players[entity.id].legs -= damage
      if players[entity.id].legs < 30:
        entity.apply_penalty(Entity.Penalty.SLOW)
      
    
    
func _player_body_factory():
  return {
    "head": 100,
    "torso": 100,
    "legs": 100
  }

  
