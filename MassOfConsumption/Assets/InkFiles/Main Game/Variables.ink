//Temp
VAR temp_string = ""
VAR temp_bool = false
VAR temp_bool_2 = false
VAR temp_bool_3 = false

// Sections of gameplay
LIST Gameplay_Event = (First_Event = 1), Second_Event = 2, Last_Event = 3

//Items
LIST items_obtained = Skeleton_Key, Simple_Key, Clippers, Combo

//Walk_Home is {Walk_Home} <br>


//Feelings
LIST Priest_Feeling = anger, guilt, dread
LIST Light_Feeling = relief, confused, worry

TODO: check interest and feeling
LIST Church_Interest = No_Care = 1, Drawn = 2, Nauseous = 3
LIST Church_Feeling = Familiar = 1, Uncomforable = 2, Evocative = 3, Laughing = 4, Crying = 5
LIST Church_Entered = Disappointed = 1, Satisfied = 2, Anxious = 3
~ Church_Entered = -1 //setting this to start

//Before Work Investigation
LIST Church_Investigation = Investigated, Called, Dropped_Phone, Entered, Teleported, Saw_Windows, Late, Starving

//Work Variables
LIST Work_Encounter = Scanner_Interaction = 1, Wrong_Email = 2, Attack_Coworker = 3, Fired = 4, Leave_Suddenly = 5

//Walk Home Variables
LIST Walk_Home = Face_It, Different_Path

//Trapped Variables
VAR Looked_For_Items = false
VAR Took_Item = false
VAR Leg_State = Normal
LIST Possible_Leg_States = Normal = 0, Tense = 1, Sore = 2, Limping = 3
LIST Possible_Object_States = Nothing = 0, screwdriver = 1, crowbar = 2, sledgehammer = 3
VAR Object = Nothing


VAR sleep = ""
VAR has_flashlight = false

TODO: variable used in multiple ways that doesn't make sense
VAR know_name = false

VAR Stay_Tracker = 0
VAR Remembered_Past = false
VAR photo_ripped = false
VAR heard_melody = false
LIST RIPPED = AT_WORK, ALL_IN_POCKET, SOME_IN_POCKET
VAR finger_pain_pass = false
LIST Church_Encounters = Finger_Chopped, Leave_Light, Was_Coward

//Items && Office
VAR broke_key = false 

LIST Explore_Office_Bookshelf = Check_Books, Check_Boxes, Check_Chest, Broke_Chest, Check_Desk

LIST Book_Knowledge = Explored_Books, Read_End, Read_Start, Saw_Your_Book, Ripped_Pages, Kept_Book, Kept_Pages, Branded, Know_Ophelia_Name, Know_Emily_Name

LIST Possible_Room_States = Default = 0, Short = 1, Half = 2, Crawl = 3, Gone = 4, Destroyed = 5
VAR Room_State = Default

//Confessional Variables
LIST Confessional_Encounters = Stubborn_to_Priest, Talked_to_Girl, Lie_to_Her, Pressed_Emily, Saw_Her_Struggle, Reached_Through, Angered_Priest, Killed_Girl, Finished_Curtain_Side, Finished_Door_Side

//where the player has been already
LIST Have_Visited = Main_Body, Confessional_DoorSide, Confessional_CurtainSide, Enter_Pews, Enter_Office, Stairs_Up, Stairs_Down

VAR current_area = -1
VAR previous_area = -1
VAR visited_state = 0

VAR Downstairs_State = None
LIST Possible_Downstairs_State = None, Bad_Vibes, Stink, Flesh

//locks
LIST Locks_Undone = Key_Lock, Combo_Lock, Clippers_lock
VAR Saw_Locks = false //know that there is a locked door
VAR Investigated_Locks = false








































