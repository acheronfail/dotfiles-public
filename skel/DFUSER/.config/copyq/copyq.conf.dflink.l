[General]
plugin_priority=itemimage, itemencrypted, itemfakevim, itemnotes, itempinned, itemsync, itemtags, itemtext

[Commands]
1\Command=copyq: plugins.itemencrypted.encryptItems()
1\Icon=\xf023
1\InMenu=true
1\Input=!OUTPUT
1\Name=Encrypt (needs GnuPG)
1\Output=application/x-copyq-encrypted
1\Shortcut=ctrl+l
2\Command=copyq: plugins.itemencrypted.decryptItems()
2\Icon=\xf09c
2\InMenu=true
2\Input=application/x-copyq-encrypted
2\Name=Decrypt
2\Output=application/x-copyq-item
2\Shortcut=ctrl+l
3\Command=copyq: plugins.itemencrypted.copyEncryptedItems()
3\Icon=\xf13e
3\InMenu=true
3\Input=application/x-copyq-encrypted
3\Name=Decrypt and Copy
3\Shortcut=ctrl+shift+l
4\Command=copyq: plugins.itemencrypted.pasteEncryptedItems()
4\Icon=\xf13e
4\InMenu=true
4\Input=application/x-copyq-encrypted
4\Name=Decrypt and Paste
4\Shortcut=enter
size=4

[Options]
action_has_input=false
action_has_output=false
action_output_tab=
action_separator=\\n
activate_closes=true
activate_focuses=true
activate_pastes=true
always_on_top=true
autocompletion=true
autostart=true
check_clipboard=true
check_selection=false
clipboard_notification_lines=0
clipboard_tab=&clipboard
close_on_unfocus=true
command_history_size=100
confirm_exit=true
copy_clipboard=false
copy_selection=false
disable_tray=false
edit_ctrl_return=true
editor=gedit --standalone -- %1
expire_tab=0
hide_main_window=false
hide_main_window_in_task_bar=false
hide_tabs=false
hide_toolbar=false
hide_toolbar_labels=true
item_popup_interval=0
language=en
max_process_manager_rows=1000
maxitems=200
move=true
notification_horizontal_offset=10
notification_maximum_height=100
notification_maximum_width=300
notification_position=3
notification_vertical_offset=10
number_search=false
open_windows_on_current_screen=true
run_selection=true
save_filter_history=false
show_advanced_command_settings=false
show_simple_items=false
show_tab_item_count=false
tab_tree=false
tabs=&clipboard
text_wrap=false
transparency=0
transparency_focused=0
tray_commands=true
tray_images=true
tray_item_paste=true
tray_items=5
tray_tab=
tray_tab_is_current=true
vi=true

[Plugins]
itemencrypted\enabled=true
itemfakevim\enabled=true
itemimage\enabled=true
itemimage\image_editor=
itemimage\max_image_height=240
itemimage\max_image_width=320
itemimage\svg_editor=
itemnotes\enabled=true
itemnotes\notes_at_bottom=false
itemnotes\notes_beside=false
itemnotes\show_tooltip=false
itempinned\enabled=true
itemsync\enabled=true
itemtags\enabled=true
itemtext\enabled=true
itemtext\max_height=0
itemtext\max_lines=3
itemtext\use_rich_text=true

[Shortcuts]
about=shift+f1
change_tab_icon=ctrl+shift+t
commands=f6
copy_selected_items=ctrl+c
delete_item=del
edit=f2
edit_notes=shift+f2
editor=ctrl+e
exit=ctrl+q
export=ctrl+s
find_items=f3
format-next=ctrl+right
format-previous=ctrl+left
help=f1
import=ctrl+i
item-menu=shift+f10
move_down=ctrl+down
move_to_bottom=ctrl+end
move_to_clipboard=
move_to_top=ctrl+home
move_up=ctrl+up
new=ctrl+n
new_tab=ctrl+t
next_tab=right
paste_selected_items=ctrl+v
preferences=ctrl+p
previous_tab=left
process_manager=ctrl+shift+z
remove_tab=ctrl+w
rename_tab=ctrl+f2
reverse_selected_items=ctrl+shift+r
show-log=f12
show_clipboard_content=ctrl+shift+c
show_item_content=f4
show_item_preview=f7
sort_selected_items=ctrl+shift+s
system-run=f5
toggle_clipboard_storing=ctrl+shift+x

[Tabs]
1\icon=
1\max_item_count=0
1\name=&clipboard
1\store_items=true
size=1

[Theme]
alt_bg=#31363b
alt_item_css=
bg=#232629
css=
cur_item_css="\n    ;border: 0.1em solid ${sel_bg}"
edit_bg=#232629
edit_fg=#eff0f1
edit_font=
fg=#eff0f1
find_bg=#ff0
find_fg=#000
find_font=
font=
font_antialiasing=true
item_css=
item_spacing=
menu_bar_css="\n    ;background: ${bg}\n    ;color: ${fg}"
menu_bar_disabled_css="\n    ;color: ${bg - #666}"
menu_bar_selected_css="\n    ;background: ${sel_bg}\n    ;color: ${sel_fg}"
menu_css="\n    ;border: 1px solid ${sel_bg}\n    ;background: ${bg}\n    ;color: ${fg}"
notes_bg=#31363b
notes_css=
notes_fg=#eff0f1
notes_font=
notification_bg=#333
notification_fg=#ddd
notification_font=
num_fg=#ffffff
num_font=
search_bar="\n    ;background: ${edit_bg}\n    ;color: ${edit_fg}\n    ;border: 1px solid ${alt_bg}\n    ;margin: 2px"
search_bar_focused="\n    ;border: 1px solid ${sel_bg}"
sel_bg=#3daee9
sel_fg=#eff0f1
sel_item_css=
show_number=true
show_scrollbars=true
style_main_window=false
tab_bar_css="\n    ;background: ${bg - #222}"
tab_bar_item_counter="\n    ;color: ${fg - #044 + #400}\n    ;font-size: 6pt"
tab_bar_scroll_buttons_css="\n    ;background: ${bg - #222}\n    ;color: ${fg}\n    ;border: 0"
tab_bar_sel_item_counter="\n    ;color: ${sel_bg - #044 + #400}"
tab_bar_tab_selected_css="\n    ;padding: 0.5em\n    ;background: ${bg}\n    ;border: 0.05em solid ${bg}\n    ;color: ${fg}"
tab_bar_tab_unselected_css="\n    ;border: 0.05em solid ${bg}\n    ;padding: 0.5em\n    ;background: ${bg - #222}\n    ;color: ${fg - #333}"
tab_tree_css="\n    ;color: ${fg}\n    ;background-color: ${bg}"
tab_tree_item_counter="\n    ;color: ${fg - #044 + #400}\n    ;font-size: 6pt"
tab_tree_sel_item_counter="\n    ;color: ${sel_fg - #044 + #400}"
tab_tree_sel_item_css="\n    ;color: ${sel_fg}\n    ;background-color: ${sel_bg}\n    ;border-radius: 2px"
tool_bar_css="\n    ;color: ${fg}\n    ;background-color: ${bg}\n    ;border: 0"
tool_button_css="\n    ;color: ${fg}\n    ;background: ${bg}\n    ;border: 0\n    ;border-radius: 2px"
tool_button_pressed_css="\n    ;background: ${sel_bg}"
tool_button_selected_css="\n    ;background: ${sel_bg - #222}\n    ;color: ${sel_fg}\n    ;border: 1px solid ${sel_bg}"
use_system_icons=false