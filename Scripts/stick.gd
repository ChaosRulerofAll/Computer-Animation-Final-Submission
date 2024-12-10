extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.speed_scale = 1.5


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Attack"):
		$AnimationPlayer.play("CylinderAction")
