extends KinematicBody2D

export var speed := 150
onready var screen_size: Vector2
onready var player := PlayerEntity.new()
onready var animated_sprite: AnimatedSprite = $AnimatedSprite


# Called when the node enters the scene tree for the first time.
func _ready():
  screen_size = get_viewport_rect().size


func _process(delta: float):
  var velocity = _get_player_input()

  animated_sprite.play()
  animated_sprite.animation = _select_animation(velocity)
  if animated_sprite.animation == "walk":
    animated_sprite.flip_v = false
    animated_sprite.flip_h = velocity.x < 0

  position += move_and_slide(velocity * delta)
  position.x = clamp(position.x, 0, screen_size.x)
  position.y = clamp(position.y, 0, screen_size.y)


#func start(pos: Vector2):
#  position = pos
#  hp = 5
#  show()
#  $CollisionShape2D.disabled = false


func _get_player_input() -> Vector2:
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


func _select_animation(velocity: Vector2) -> String:
  var animation_type = "idle"
  if velocity.x == 0:
    animation_type = "idle"

  if velocity.x != 0 || velocity.y !=0:
    animation_type = "walk"
  
  return animation_type


func _start_plus_frames(time: float):
  self.set_deferred("disabled", true)

  yield(get_tree().create_timer(time), "timeout")

  self.set_deferred("disabled", false)
