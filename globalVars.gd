extends Node
# Keeps track of variables global to the project

var current_level = 0

var levels = ["Level1.tscn", "Level2.tscn"]

var debug = false
# What color is currently shown
var color_index = 0
# List of all the normal colors
var colors = ["#DCE1DE","#216869","#49A078","#9CC5A1"]
# List of darker colors
var dark_colors = ["#7E9987", "#2C4647", "#3A5447", "#4F6651"]
# :ist of ligher colors
var light_colors = ["#E8EFEA", "#7A9188", "#A5BAA9", "#ADC9B8"]