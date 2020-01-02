extends Node2D

var player_ship = preload("res://Player.tscn")
var npc_ship = preload("res://NPC.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	# Announce ready to spawn here.
	rpc_id(1, "spawn_for")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

remote func spawn_player(p_info):
	if (p_info.id == get_tree().get_network_unique_id()):
		var ship = player_ship.instance()
		ship.name = str(get_tree().get_network_unique_id())
		ship.player_init = p_info
		ship.initialize()
		self.add_child(ship)
		var map_limits = $Map01/Boundary.get_used_rect()
		var map_cellsize = $Map01/Boundary.cell_size
		ship.set_camera_limits(map_limits,map_cellsize)
	else:
		var ship = npc_ship.instance()
		ship.name = str(p_info.id)
		ship.get_node("NPCBoat").collision_layer = 1
		ship.get_node("NPCBoat").collision_mask = 1
		ship.player_init = p_info
		ship.initialize()
		self.add_child(ship)