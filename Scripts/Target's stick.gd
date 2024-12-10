extends Node3D


@export var target : Node3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#keep the pole under the target
	self.position.x = target.position.x
	
	#keep the pole the right length
	self.scale.y = (2 + (-target.position.z / 2))
