extends Sprite

signal remove

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_AnimationPlayer_animation_finished(anim_name):
	emit_signal("remove")
