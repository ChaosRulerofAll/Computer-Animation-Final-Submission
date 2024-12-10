extends CharacterBody3D


const base_y : float = 0.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.speed_scale = 2
	$AnimationPlayer.play("Walk")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if self.global_position.x < 3 and self.global_position.x > -3:
		self.global_position.y = base_y
	elif self.global_position.x > 3:
		self.global_position.y = base_y + ((self.global_position.x - 3)/3)
	elif self.global_position.x < -3:
		self.global_position.y = base_y - ((self.global_position.x + 3)/3)
