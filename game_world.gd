extends Node2D


# Declare member variables here.
export var day = 1
export var time = 0
export var _heat_modifier = 0.5
export var current_heat = 0
export var time_interval = 3
var _initial_heat = 50
var items = {}

# Called when the node enters the scene tree for the first time.
func _ready():
  get_node("Clock").start(time_interval)
  _loadItems()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#  pass


func _on_Hour_passed():
  _pass_time()
  _handleHeat()
#  print("\nhour_passed")
#  print("day ", day,"\ntime ", time,"\ncurrent_heat ", current_heat,"\n_heat_modifier ", _heat_modifier)
  
func _pass_time():
  if time > 23:
    _pass_day()
    time = 0
  else:
    time = time + 1
    
func _handleHeat():
  current_heat = _get_temperature(time, _heat_modifier, _initial_heat)

func _pass_day():
  print("\nday_passed")
  day = day + 1
  _heat_modifier = _heat_modifier + 0.1
  
func _get_temperature(x, h, a):
  var y = -a * h * cos((PI*x)/12)
  return y
  
func _loadItems():
  print("loading items...")
  var itemsFile = File.new()
  itemsFile.open("res://config/items.json", File.READ)
  var itemsStr = itemsFile.get_as_text()
  items = JSON.parse(itemsStr).result
  print("items loaded", items)
