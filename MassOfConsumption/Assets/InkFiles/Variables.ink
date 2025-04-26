//SCRIPTING VARIBLES
VAR SetImage = ""
VAR CurrentProp = ""

//SKIP
VAR skip_counter = -1

//Before Work Variables
VAR church_feeling = ""
VAR church_interest = ""
VAR investigated = false
VAR entered_feeling = -1
VAR called_number = false
VAR dropped_phone = false
VAR entered_church = false
VAR church_teleported = false
VAR saw_windows = false
VAR was_fired = false
VAR late_for_work = false


VAR turn = ""
VAR object = ""
VAR leg = ""
VAR sleep = ""
VAR temp_string = ""
VAR priest_feeling = ""
VAR light_feeling = ""

VAR name = false
VAR know_name = false
VAR lanturn = false
VAR temp_bool = false
VAR temp_bool_2 = false
VAR temp_bool_3 = false
VAR know = false
VAR avoid_church = false
VAR photo_ripped = false
VAR leave_light = false
VAR trapped_reject = false
VAR stubborn = false
VAR finger_chopped = false
VAR coward = false
VAR happy = false
VAR read_book = false
VAR know_book = false
VAR rip_page = false
VAR keep_book = false
VAR branded = false
VAR pressed_emily = false
VAR emily_hurt = false

VAR work = 0
VAR room = 0
VAR stay = 0
VAR church_anger  = 0
VAR temp_num = 0

//Confessional Variables
VAR confessional_door_side = false
VAR confessional_curtain_side = false
VAR killed_girl = false
VAR angered_priest = false
VAR reached_through = false
VAR talked_to_girl = false
VAR saw_her = false


//where the player has been already
LIST have_visited = Main_Body, Confessional_DoorSide, Confessional_CurtainSide, Enter_Pews, Enter_Office, Stairs_Up, Stairs_Down

VAR current_area = -1
VAR previous_area = -1
VAR visited_state = 0

LIST items_obtained = Key, Clippers, Combo

VAR pews = false
VAR after_first = false
VAR temp_visited = false //for the after first visit
VAR saw_locks = false //know that there is a locked door
VAR visited_second = 0
VAR visited_first = 0
VAR saw_books = false
VAR saw_desk = false
VAR broke_chest = false
VAR went_downstairs = 0 //0 = none, 1 = no stink, 2 = stink stink
VAR went_upstairs = false

//keys
VAR key = false
VAR number_combo = ""
VAR clippers = false

//locks
VAR key_lock = false
VAR number_lock = false // 2758 yes 2755 no
VAR clippers_lock = false
VAR locks = 0
VAR messed_locks = false
