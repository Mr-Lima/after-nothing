extends Node2D


# Declare member variables here.
export var day = 1
export var time = 0
export var _heat_modifier = 0.5
export var current_heat = 0
export var hour_time_interval = 3
var _initial_heat = 50
var items = {}
var hour_timer


# Called when the node enters the scene tree for the first time.
func _ready():
  _load_timer()
  _load_items()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#  pass


func _load_timer(): 
  hour_timer = Timer.new()
  self.add_child(hour_timer)
  hour_timer.start(hour_time_interval)
  hour_timer.connect("timeout", self, "_on_Hour_passed")


func _on_Hour_passed():
  print("hour_passed")
  _pass_time()
  _handle_heat()
  

func _pass_time():
  if time > 23:
    _pass_day()
    time = 0
  else:
    time = time + 1
  Events.emit_signal("time_passed", day, time, current_heat)


func _handle_heat():
  var result = _get_temperature(time, _heat_modifier, _initial_heat)
  current_heat = stepify(result, 0.1)


func _pass_day():
  print("\nday_passed")
  day = day + 1
  _heat_modifier = _heat_modifier + 0.1
  Events.emit_signal("day_passed", day)


func _get_temperature(x, h, a) -> float:
  var y = -a * h * cos((PI*x)/12)
  return y


func _load_items():
  print("loading items...")
  var itemsFile = File.new()
  itemsFile.open("res://config/items.json", File.READ)
  var itemsStr = itemsFile.get_as_text()
  items = JSON.parse(itemsStr).result
  print("items loaded", items)
