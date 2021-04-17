extends KinematicBody2D

export var speed := 150
export var hp := 100

onready var temperature := 100
onready var inventory = {}
onready var screen_size: Vector2
onready var health_system := HealthSystem.new()

# Called when the node enters the scene tree for the first time.
func _ready():
  screen_size = get_viewport_rect().size


func _process(delta: float):
  var velocity = _player_input()

  $AnimatedSprite.play()
  _select_animation(velocity)

  position += move_and_slide(velocity * delta)
  position.x = clamp(position.x, 0, screen_size.x)
  position.y = clamp(position.y, 0, screen_size.y)


func hit(value, body_part) -> void:
  print("player_hit")
#  _start_plus_frames(1.0)
  health_system.hurt(value, body_part)


func start(pos: Vector2):
  position = pos
  hp = 5
  show()
  $CollisionShape2D.disabled = false


func _player_input() -> Vector2:
  var velocity = Vector2()
  if Input.is_action_pressed("ui_right"):
    velocity.x += 1
  if Input.is_action_pressed("ui_left"):
    velocity.x -= 1
  if Input.is_action_pressed("ui_down"):
    velocity.y += 1
  if Input.is_action_pressed("ui_up"):
    velocity.y -= 1
  if velocity.length() > 0:
    velocity = velocity.normalized() * speed
  return velocity


func _select_animation(velocity: Vector2) -> void:
  if velocity.x == 0:
    $AnimatedSprite.animation = "idle"

  if velocity.x != 0 || velocity.y !=0:
    $AnimatedSprite.animation = "walk"
    $AnimatedSprite.flip_v = false
    $AnimatedSprite.flip_h = velocity.x < 0


func _start_plus_frames(time: float):
  self.set_deferred("disabled", true)

  yield(get_tree().create_timer(time), "timeout")

  self.set_deferred("disabled", false)


func _on_Hour_passed():
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
