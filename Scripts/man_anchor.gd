extends Node3D


@export var target : Node3D
@export var dir : Node3D
@export var Lerp : Node3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#keep the man under the target
	self.position.x = target.position.x
	
	if dir.going_forward():
		self.rotation.y = Lerp.my_lerp(self.rotation.y, deg_to_rad(90), 0.03)
	else:
		self.rotation.y = Lerp.my_lerp(self.rotation.y, deg_to_rad(-90), 0.03)
