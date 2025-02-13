extends Node;
class_name Player_in_game;

const delta_gravity : int = 900;
const index_lerp_direction : float = 0.9;

var direction : Vector2;
var lerp_direction : Vector2;
var enabled : bool;

@onready var all_particles : Array[CPUParticles2D] = [$ParticlesLeft,$ParticlesCenter,$ParticlesRight];
@onready var player: Player = $"../..";

func _ready() -> void:
	for node_particle : CPUParticles2D in all_particles: #Grardamos la gravedad de las particulas
		node_particle.set_meta("real_gravity",node_particle.gravity);
	pass;

func start_state() -> void:
	for node_particle : CPUParticles2D in all_particles:
		node_particle.emitting = true;
	enabled = true;

func local_physics_process(delta: float) -> void:
	direction = Input.get_vector("ui_left","ui_right","ui_down","ui_up");
	
	lerp_direction = Vector2(
		lerp (lerp_direction.x,direction.x,index_lerp_direction),
		lerp (lerp_direction.y,direction.y,index_lerp_direction)
	);
	_SetGravityParticles(lerp_direction,delta);
	pass;

func end_state() -> void:
	for node_particle : CPUParticles2D in all_particles:
		node_particle.emitting = false;
	enabled = false;

func _SetGravityParticles(local_direction : Vector2,delta:float) -> void:
	local_direction.x = -local_direction.x/10; 
	#local_direction.x = 0;
	for node_particle in all_particles:
		node_particle.gravity = node_particle.get_meta("real_gravity") + local_direction*delta_gravity*delta;
	

func _input(event: InputEvent) -> void:
	if enabled and event.is_action_pressed("ui_attack"):
		var bullet : Bullet = GlobalVariables.create_bullet(1,true,false,true);
		get_parent().get_parent().add_sibling(bullet);
		bullet.position = get_parent().get_parent().position;

	if enabled and event.is_action_pressed("ui_dash"):
		player.admin_states.dash_mode();
