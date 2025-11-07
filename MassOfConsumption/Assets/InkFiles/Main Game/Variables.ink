EXTERNAL PlaySFX(src, loop, fade_in, delay)
EXTERNAL StopSFX(src, fade_out, delay)
EXTERNAL Intrusive(amount, text, jump_to)

//Temp
VAR temp_string = ""
VAR temp_bool = false
VAR temp_bool_2 = false
VAR temp_bool_3 = false

//Items
LIST items_obtained = Skeleton_Key, Simple_Key, Clippers, Combo

//Feelings
LIST Priest_Feeling = anger, guilt, dread
LIST Light_Feeling = relief, confused, worry

VAR Church_Interest = ""
LIST Church_Feeling = Familiar = 1, Uncomforable = 2, Evocative = 3, Laughing = 4, Crying = 5
LIST Church_List = Disappointed = 1, Satisfied = 2, Anxious = 3
VAR Church_Entered = None

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

VAR Stay_Tracker = 0
VAR Remembered_Past = false
VAR photo_ripped = false
VAR heard_melody = false
LIST RIPPED = AT_WORK, ALL_IN_POCKET, SOME_IN_POCKET

VAR Frozen_Hand = false
VAR finger_pain_pass = false
LIST Church_Encounters = Finger_Chopped, Leave_Light, Was_Coward

//Items && Office
VAR broke_key = false 
VAR read_mary_book = false

LIST Explore_Office_Bookshelf = Check_Books, Check_Boxes, Check_Chest, Broke_Chest, Check_Desk

LIST Book_Knowledge = Explored_Books, Read_End, Read_Start, Saw_Your_Book, Ripped_Pages, Kept_Book, Kept_Pages, Branded, Read_Mom_Old_Book, Read_Mom_Young_Book, Read_Oldin_Book

LIST Possible_Room_States = Default = 0, Short = 1, Half = 2, Crawl = 3, Gone = 4, Destroyed = 5
VAR Room_State = Default

//Confessional Variables
LIST Confessional_Encounters = Stubborn_to_Priest, Talked_to_Girl, Lie_to_Her, Pressed_Emily, Tell_Her_Leave, Saw_Her_Struggle, Reached_Through, Angered_Priest, Accepted_Priest, Killed_Girl, Finished_Curtain_Side, Finished_Door_Side, Asked_About_Dad

//where the player has been already
LIST Have_Visited = Main_Body, Confessional_DoorSide, Confessional_CurtainSide, Enter_Pews, Enter_Office, Stairs_Up

VAR current_area = -1
VAR previous_area = -1
VAR visited_state = 0

VAR Met_Mimic = false
VAR Creature_Attack = false
VAR Locked_Office = false
VAR Ophelia_Related = false

VAR Downstairs_State = None
LIST Possible_Downstairs_State = None, Bad_Vibes, Stink, Flesh

//locks
LIST Locks_Undone = Key_Lock, Combo_Lock, Clippers_lock //combo lock correct = 2758
VAR Saw_Locks = false //know that there is a locked door
VAR Investigated_Locks = false
VAR broke_key_lock = false
VAR Need_Double_Check = false
VAR Need_Find_Book = false
VAR Finish_ophelia = false


=== function PlaySFX(src, loop, fade_in, delay)
    ~ return 1

=== function StopSFX(src, fade_out, delay)
    ~ return 1

=== function Intrusive(amount, text, jump_to)
    ~ return 1







