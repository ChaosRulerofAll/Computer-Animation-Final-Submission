extends Node3D


@export var targettarget : Node3D
@export var Lerp : Node3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	self.position = Lerp.my_lerp(self.position, targettarget.position, 0.1)
