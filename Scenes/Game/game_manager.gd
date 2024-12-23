extends Node;

var player_data : PackedScene = preload("res://Scenes/Characters/Player/player.tscn");
var world : Node2D;

func _ready() -> void:
	await get_tree().process_frame;
	world = get_tree().get_first_node_in_group("World");

func CreatePlayer():
	await get_tree().create_timer(1).timeout;
	var player : Player = player_data.instantiate();
	world.add_child(player);
	player.position = Vector2(0,0);
