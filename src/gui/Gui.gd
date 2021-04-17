extends Control


# Declare member variables here. Examples:
export var is_dev_mode := false
onready var dev_mode_path
onready var is_loaded := false

# Called when the node enters the scene tree for the first time.
func _ready():
# warning-ignore:return_value_discarded
  Events.connect("dev_mode_pressed", self, "_on_Dev_mode_pressed")
# warning-ignore:return_value_discarded
  Events.connect("time_passed", self, "_on_Time_passed")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
  if is_loaded:
    _set_fps()

func _on_Dev_mode_pressed():
  print("dev_mode_toggle")
  is_dev_mode = !is_dev_mode
  if !is_loaded:
    _load_scene()
  
  if is_dev_mode:
    $DevMode.show()
  else:
    $DevMode.hide()
    

func _on_Time_passed(day: int, time: int, current_heat: float):
  if is_loaded:
    $DevMode/MarginContainer/HBoxContainer/DayItem/MarginContainer/DayLabel.text = "Day: " + day as String
    $DevMode/MarginContainer/HBoxContainer/TimeItem/MarginContainer/TimeLabel.text = "Time: " + time as String
    $DevMode/MarginContainer/HBoxContainer/HeatItem/MarginContainer/HeatLabel.text = "Heat: " + current_heat as String    

    
func _load_scene():
  print("loading scene DevMode")
  dev_mode_path = preload("res://src/gui/DevMode.tscn").instance()
  self.add_child(dev_mode_path)
  is_loaded = true
  
  yield(get_tree().create_timer(60), "timeout")
  print("unloading DevMode")
  is_dev_mode = false
  is_loaded = false
  $DevMode.free()


func _set_fps():
  $DevMode/MarginContainer/HBoxContainer/FPSItem/MarginContainer/FPSLabel.text = "FPS: " + Performance.get_monitor(Performance.TIME_FPS) as String
