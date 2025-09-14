//Temp
VAR temp_string = ""
VAR temp_bool = false
VAR temp_bool_2 = false
VAR temp_bool_3 = false

//Before Work Variables
LIST Church_Interest = No_Care = 1, Drawn = 2, Nauseous = 3

LIST Church_Feeling = Familiar = 1, Uncomforable = 2, Evocative = 3, Laughing = 4, Crying = 5

LIST Church_Entered = Disappointed = 1, Satisfied = 2, Anxious = 3

LIST Church_Investigation = Investigated, Called, Dropped_Phone, Entered, Teleported, Saw_Windows, Late, Starving

//Work Variables
LIST Work_Encounter = Scanner_Interaction = 1, Wrong_Email = 2, Attack_Coworker = 3, Fired = 4, Leave_Suddenly = 5

//Walk Home Variables
LIST Walk_Home = Face_It, Different_Path

//Trapped Variables
LIST Leg = (Normal = -1), Tense = 1, Sore = 2, Limping = 3
LIST Object = (Nothing = -1), screwdriver = 1, crowbar = 2, sledgehammer = 3
VAR sleep = ""
VAR has_flashlight = false

//Church Variables
VAR priest_feeling = ""
VAR light_feeling = ""

TODO: variable used in multiple ways that doesn't make sense
VAR know_name = false


VAR Remembered_Past = false
VAR photo_ripped = false
VAR leave_light = false
VAR finger_chopped = false
VAR coward = false
VAR happy = false


//Items && Office
VAR broke_key = false 
LIST items_obtained = Skeleton_Key, Simple_Key, Clippers, Combo
LIST explore_office_bookshelf = Check_Books, Check_Boxes, Check_Chest

LIST Book_Knowledge = Read_End, Read_Start, Saw_Your_Book, Ripped_Pages, Kept_Book, Kept_Pages, Branded, Know_Ophelia_Name, Know_Emily_Name

VAR room = 0
VAR stay = 0
VAR church_anger = 0

//Confessional Variables
LIST Confessional_Encounters = Stubborn_to_Priest, Talked_to_Girl, Lie_to_Her, Pressed_Emily, Saw_Her_Struggle, Reached_Through, Angered_Priest, Killed_Girl, Finished_Curtain_Side, Finished_Door_Side

//where the player has been already
LIST have_visited = Main_Body, Confessional_DoorSide, Confessional_CurtainSide, Enter_Pews, Enter_Office, Stairs_Up, Stairs_Down

VAR current_area = -1
VAR previous_area = -1
VAR visited_state = 0


VAR pews = false
VAR after_first = false
VAR temp_visited = false //for the after first visit
VAR saw_locks = false //know that there is a locked door

LIST locks_undone = Key_Lock, Combo_lock, Clippers_lock

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

// Sections of gameplay
VAR visited_second = false //after getting the second big event
VAR visited_first = false //after getting one big event








































