extends Node2D

var map
var terrain
enum directions_list {north, east, south, west}
var directions = {north = Vector2(0,-1),
					east = Vector2(1,0),
					south = Vector2(0,1),
					west = Vector2(-1,0)}
					
export(directions_list) var facing_direction = directions.north

func _ready():
	map = find_parent("Level")
	terrain = map.find_node("FLOOR")
	facing_direction = directions.north
	position = terrain.map_to_world(terrain.world_to_map(position))


func process_turn():
	if ($Tween.is_active()):
		return
	if (terrain.get_cellv(terrain.world_to_map(global_position) + facing_direction) == 1):
		$Tween.interpolate_property(self, "global_position", global_position, terrain.map_to_world(terrain.world_to_map(global_position) + facing_direction) + terrain.cell_size*Vector2(0,.5),
				 .35, Tween.TRANS_LINEAR, Tween.EASE_IN)
		$Tween.start();
#		global_position = terrain.map_to_world(terrain.world_to_map(global_position) + facing_direction) + terrain.cell_size*Vector2(0,.5)
	else:
#		0123
		var num  = randi()%4
		match num:
			0:
				facing_direction = directions.east
				$icon.texture = load("res://assets/Sprite_Roomba/Sprite_Roomba-04.png")
			1:
				facing_direction = directions.south
				$icon.texture = load("res://assets/Sprite_Roomba/Sprite_Roomba-03.png")
			2:
				facing_direction = directions.west
				$icon.texture = load("res://assets/Sprite_Roomba/Sprite_Roomba-02.png")
			3:
				facing_direction = directions.north
				$icon.texture = load("res://assets/Sprite_Roomba/Sprite_Roomba-01.png")
		

func _process(delta):
	
	if (Input.is_action_just_pressed("ui_right") or not $Tween.is_active()):
		process_turn()
	
#	if (terrain.get_cellv(terrain.world_to_map(get_global_mouse_position())) == 1):
#		global_position = terrain.map_to_world(terrain.world_to_map(get_global_mouse_position())) + terrain.cell_size*Vector2(0,.5)
	
#	print(position)
	pass
