extends KinematicBody2D

export var speed = 100
export var hp = 100
var temperature = 100
var screen_size: Vector2

signal hit

# Called when the node enters the scene tree for the first time.
func _ready():
  # hide()
  screen_size = get_viewport_rect().size

func _process(delta: float):
  var velocity = player_input()

  $AnimatedSprite.play()
  select_animation(velocity)

  position += move_and_slide(velocity) * delta
  position.x = clamp(position.x, 0, screen_size.x)
  position.y = clamp(position.y, 0, screen_size.y)

func start(pos: Vector2):
  position = pos
  hp = 5
  show()
  $CollisionShape2D.disabled = false

func player_input() -> Vector2:
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

func select_animation(velocity: Vector2) -> void:
  if velocity.x == 0:
    $AnimatedSprite.animation = "idle"

  if velocity.x != 0 || velocity.y !=0:
    $AnimatedSprite.animation = "walk"
    $AnimatedSprite.flip_v = false
    $AnimatedSprite.flip_h = velocity.x < 0


func _on_Enemy_body_entered(_body):
  emit_signal("hit")
  print("hit")

  $CollisionShape2D.set_deferred("disabled", true)

  hp -= 1
  if(hp <= 0):
    hide()
    self.queue_free()
    return

  yield(get_tree().create_timer(1.0), "timeout")

  $CollisionShape2D.set_deferred("disabled", false)


func _on_Hour_passed():
  temperature = get_node("../../World").current_heat
  print("player temp ", temperature)
  if temperature < 30:
    hp = hp - 10

  if temperature < 20:
    hp = hp - 20

  if temperature <=0:
    hp = hp - 100
