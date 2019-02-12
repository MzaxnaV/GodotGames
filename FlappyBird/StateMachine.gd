extends Node

onready var state_map = {
	'title' : $TitleScreenState,
	'play' :  $PlayState,
	'score' : $ScoreState,
	'count' : $CountDownState
}

var current_state = null
var params = null

func _ready():
	change_state('title')

func change_state(stateName):
	if (current_state):
		params = current_state.exit()
	current_state = state_map[stateName]
	current_state.enter(params)

func _physics_process(delta):
	current_state.update(delta)

func _input(event):
	current_state.handle_event(event)