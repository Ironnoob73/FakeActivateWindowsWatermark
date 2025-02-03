extends Control

func _ready() -> void:
	get_window().position = Vector2(1500,950)
func _process(delta: float) -> void:
	var rect = self.get_rect() as Rect2
	if get_global_mouse_position().y < rect.size.y && get_global_mouse_position().y >= 0 \
	&& get_global_mouse_position().x < rect.size.x && get_global_mouse_position().x >= 0:
		self.position.y = get_global_mouse_position().y + 1
	else:
		self.position.y = 0
	# https://forum.godotengine.org/t/how-can-i-click-through-the-screen-while-keeping-a-transparent-screen/64195/4
	var texture_corners: PackedVector2Array = [
	rect.position, # Top left corner
	rect.position + Vector2(rect.size.x, 0), # Top right corner
	rect.position + rect.size, # Bottom right corner
	rect.position + Vector2(0, rect.size.y) # Bottom left corner
	]
	DisplayServer.window_set_mouse_passthrough(texture_corners)

func _on_popup_menu_id_pressed(id: int) -> void:
	match $PopupMenu.get_item_text(id):
		"Position":
			$PosSettingWindow.show()
		"Text":
			$TextSettingWindow.show()
		"Color":
			$ColorSettingWindow.show()
		"Exit":
			get_tree().quit()

func _on_pos_button_down() -> void:
	get_window().position = Vector2(%XPos.value,%YPos.value)
	$PosSettingWindow.hide()

func _on_text_button_down() -> void:
	$Main.text = %MainTitleText.text
	$Sub.text = %SubTitleText.text
	$TextSettingWindow.hide()

func _on_color_button_down() -> void:
	$Main.modulate = %MainTitleColor.color
	$Sub.modulate = %SubTitleColor.color
	$ColorSettingWindow.hide()
