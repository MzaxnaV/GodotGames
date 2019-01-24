extends Node

onready var state_map = {
	'start' : $StartState,
	'highscore' : $HighScoreState,
	'serve' : $ServeState,
	'play' : $PlayState,
	'victory' : $VictoryState,
	'gameover' : $GameOverState,
	'enterscore' : $EnterHighScoreState
}

var current_state = null
var params = null

func _ready():
	change_state('start')

func _physics_process(delta):
	current_state.update_physics(delta)

func _process(delta):
	current_state.update(delta)

func _input(event):
	current_state.handle_event(event)

func change_state(state_name):
	if (current_state):
		params = current_state.exit()
	print("StateMachine.gd: Entering state: ", state_name)
	current_state = state_map[state_name]
	current_state.enter(params)