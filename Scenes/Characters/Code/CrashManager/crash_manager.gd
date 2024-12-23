extends Area2D;
class_name CrashManager;

@onready var character : Character = get_parent();
@onready var isFromPlayer : bool = character is Player;
@onready var crash_timer: Timer = $CrashTimer;
@onready var animation_player: AnimationPlayer = $AnimationPlayer

const maxImpactSpeed : int = 25;
const minImpactSpeed : int = 5;
const timeOutInvincibility : int = 5;

var canCrash : bool = true;

func _ready() -> void:
	crash_timer.wait_time = timeOutInvincibility;
	pass;


func _on_area_entered(area: Area2D) -> void:
	if area is CrashManager and area.isFromPlayer != isFromPlayer:
		CrashEnabled(area);

func CrashEnabled(area : Area2D) -> void:
	character.all_state_node["hit"].directionHit = GlobalVariables.get_vector(area.character.position,character.position);
	area.character.all_state_node["hit"].impactSpeed = sqrt((character.velocity.x**2+character.velocity.y**2)/16) + minImpactSpeed;
	if area.character.all_state_node["hit"].impactSpeed >= maxImpactSpeed:
		area.character.all_state_node["hit"].impactSpeed = maxImpactSpeed;
	area.character.admin_states.hit();
	
	canCrash = false;
	crash_timer.start();


func _canCrash() -> void:
	canCrash = true;
	pass;
