//Temp
VAR temp_string = ""
VAR temp_bool = false
VAR temp_bool_2 = false
VAR temp_bool_3 = false

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

//Walk Home Variables
VAR FaceIt = false
VAR differnt_path = false
VAR turn = ""

//Trapped Variables
VAR object = ""
VAR took_object = false
VAR leg = ""
VAR sleep = ""
VAR has_flashlight = false

//Church Variables
VAR priest_feeling = ""
VAR light_feeling = ""

VAR name = false
VAR know_name = false
VAR lanturn = false

VAR know = false
VAR avoid_church = false
VAR photo_ripped = false
VAR leave_light = false
VAR trapped_reject = false
VAR stubborn = false
VAR finger_chopped = false
VAR coward = false
VAR happy = false
VAR broke_key = false
VAR pressed_emily = false
VAR emily_hurt = false

//Book variables
VAR read_end_book = false
VAR read_start_book = false
VAR know_book = false
VAR rip_page = false
VAR keep_book = false
VAR branded = false


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
VAR finished_confession = false



//where the player has been already
LIST have_visited = Main_Body, Confessional_DoorSide, Confessional_CurtainSide, Enter_Pews, Enter_Office, Stairs_Up, Stairs_Down

VAR current_area = -1
VAR previous_area = -1
VAR visited_state = 0

LIST items_obtained = Skeleton_Key, Simple_Key, Clippers, Combo
LIST locks_undone = Key_Lock, Combo_lock, Clippers_lock
LIST found_your_book = Used_Simple_Key, Used_Skeleton_Key, Broke_Chest
LIST explore_office_bookshelf = Check_Books, Check_Boxes, Check_Chest

VAR pews = false
VAR after_first = false
VAR temp_visited = false //for the after first visit
VAR saw_locks = false //know that there is a locked door

VAR saw_books = false
VAR saw_desk = false
VAR broke_chest = false
VAR went_downstairs = 0 //0 = none, 1 = no stink, 2 = stink stink
VAR went_upstairs = false

//locks
VAR key_lock = false
VAR number_lock = false // 2758 yes 2755 no
VAR clippers_lock = false
VAR locks = 0
VAR messed_locks = false

// Sectiosn of gameplay
VAR visited_second = false //after getting the second big event
VAR visited_first = false //after getting one big event








































