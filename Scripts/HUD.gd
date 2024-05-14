extends CanvasLayer

func _ready():
	$ProgressBar.value = get_parent().get_node("Player").health
	$points.text = str(get_parent().get_node("Player").points)

func _process(delta):
	$ProgressBar.value = get_parent().get_node("Player").health
	$points.text = str(get_parent().get_node("Player").points)
