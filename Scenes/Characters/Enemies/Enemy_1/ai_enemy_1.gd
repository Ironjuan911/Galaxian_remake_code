extends AI_Enemy;
class_name AI_Enemy_1;

func _ready() -> void:
	pass;

func _new_process(delta : float) -> void:

	pass;
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_attack"):
		print("start");
		start();

	
