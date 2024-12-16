extends Node;

var direction_x : float;
var direction_y : float;

const meter : int  = GlobalVariables.meter;
var speed : int = 15;

@onready var player: Player = $"../..";

func local_physics_process(delta: float) -> void:
	direction_x = Input.get_axis("ui_left","ui_right"); #Definimos las direcciones
	direction_y = Input.get_axis("ui_down","ui_up");
	
	if (direction_x != 0 or direction_y != 0):
		general_movement(delta);
	else:
		idle_movement(delta);
	#print("x: " + str(direction_x) + ", y: " + str(direction_y));
	pass;

func general_movement(delta: float) -> void:
	
	player.velocity.x = lerp(player.velocity.x,meter*speed*delta*direction_x,0.05);
	player.velocity.y = lerp(player.velocity.y,-meter*speed*delta*direction_y,0.05);
	
func idle_movement(delta: float) -> void:
	player.velocity.x = lerp(player.velocity.x,0.0,0.1);
	player.velocity.y = lerp(player.velocity.y,0.0,0.1);
	pass
