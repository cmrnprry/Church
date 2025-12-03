===After_First===

= Confessional_After
#CHECKPOINT: 3, The pews are... full? #IMAGE: Church_Inside
You exit the confessional, and stop in your tracks. The pews are full of people, and a church organ is playing. The people, if you could even call them that, have no faces or distinguishing marks. They're more of just... the general shape of people, flickering in and out of view. They don't seem to notice you. #PROP: [Pews true]

*[Take a seat at the pews]
    ->After_First.Take_Seat

*[Run to the stairwell]
    ->After_First.Stairs_After

*[Walk back into the confessional]
    ->After_First.Back_Confessional

= Take_Seat
{
    - Light_Feeling  == confused:
        ~temp_string = "confusing"
        
    - Light_Feeling  == relief:
        ~temp_string = "reassuring."
        
    - Light_Feeling  == worry:
        ~temp_string = "uneasy"
}

Quickly, and quietly you a seat in the front row, and the light dims. A pastor climbs the stage and looks around, nodding at the figures. It looks at you, and tilts it's head. While it has no face, you can feel it smiling. It raises a hand, and points at you. You try to hide in your seat, and look away.

A red spotlight land on you. You freeze. It's the light from the window behind the priest, and gives off the same {temp_string} feeling as before. {Church_Encounters ? (Leave_Light): "It warms your body, and some of the tension melts away." | "Your skin tingles under it's warmth. It's uncomfortable. " } #PROP: [Pews_Lighting true]

"Ah, there... you... are..." The pastor says, each word drawn out and emphasized. It's voice is raspy and harsh, like it's not used to speaking human language. 

The pastor on stage is beckoning you to join him. All eyes are on you. {Church_Encounters ? (Leave_Light): You fidget with your clothing, not sure what to do with your hands. You feel like a child getting called on in class when you don't know the answer. | A bead of sweat rolls down your back. Your eyes dart from the window, to the pastor, to the figures in the pews. }

~temp_bool = false

*[Go to the stage]
    ->Pews.Go_to_Stage

*[Leave]
    ->Pews.Try_Leave(false)

= Stairs_After
There's no way to get to the stairs without the "people" noticing you. You take a breath before darting across the stage and to the stairs. At the top of the stairs is {Looked_For_Items: the office door from earlier. | a closed door.} The hallway extends to a larger set of stairs going up and down. #IMAGE: Default #PROP: [Pews false]

You hear someone call your name, but you don't dare turn around. You don't know if you're being followed or not. You choose the... 

*[{Looked_For_Items: Office | Door}]
    ~ Creature_Attack = true
    You throw yourself through the door and slam it shut, bracing it with your body. You hear your name again, followed by a rough scratching sound pass and continue into the hall way.
    
    You hold your breath and count to a hundred, hoping to hear it cross back before thinking you're fully safe. Eventually, you hear a distant howl and a wet thumping sound. The screaming continues as it gets closer and stops outside.
    
    **[Lock the door]
        ~ Locked_Office = true
        You fiddle with the knob, and lock it. Once the lock turns, the thing slams itself against the door. It screeches again when the door doesn't open and stops.
        
    **[Don't move]
        You squeeze your eyes shut and pray it will keep moving. Instead, the thing outside slams itself against the door. You press all your weight against the door, trying to hold it back. It screeches again when the door doesn't open and stops.
        
    -- You hear receding footsteps and breathe a sigh of relief before you hear running and the thing crashes into the door. {Leg_State >= Sore: Your legs give {Locked_Office: and you fall back. The lock keeps the door closed, but creature makes a small hole in the door. It moves to look through.| and the door flings open, pushing with it and pinning you between the wall in the door.} | You are taken back for a moment before pushing back, {Locked_Office: the lock helping keep the door shut.| keeping the door shut.} A small hole was created in the door from the struggle. The thing shoves a limb through feeling around before quickly retracting it.}
    
    ***[{Leg_State >= Sore and !Locked_Office: Hold your breath | Move away from the hole}]
        {Leg_State >= Sore and !Locked_Office: You freeze and hold your breath. The thing whines and moans before stomping its feet and leaving. You hear distant crashing before it all goes quiet. You close the door, and hope whatever that was won't come back. | You side-step the hole, pressing yourself against the wall. The creature presses its face against the hole. You hold your breath, praying that it won't notice you. The thing whines and moans before stomping its feet and punching the door one last time. You hear distant crashing before it all goes quiet. You hope whatever that was won't come back.}
        
        You turn and take in the room you're standing in. {Looked_For_Items: The office doesn't look much different from what you saw earlier, though, you can now make out more with the help of your flashlight. | The room seems to be an office, and smells incredibly musty.} It's a tight space with bookshelves lining the side walls, each shelf packed with books and boxes. A desk sits at the far wall, covered in dust and cobwebs, and a stained glass window above it. {Church_Investigation ? (Saw_Windows): You avoid looking at it.}
        
        You decide to look around a bit before leaving, just in case.
        
        ->Office_Area.Enter_From_Encounter
    
    ***[{Leg_State >= Sore and !Locked_Office: Push the door closed | Stab debris through the hole}]
        {Leg_State >= Sore and !Locked_Office: You take a deep breath before pushing against the door with all your might, shoving the thing out of the room. It screams again and sticks its hand through the hole, grabbing your chest, and pulling you into the door | You scoop up a large piece of the door and shove it through the hole, stabbing whatever lies on the other side. You retract your hand as it screams. The creature sticks its hand through the hole, grabbing your chest, and pulling you into the door.}
        
        TODO gross sound
        It repeatedly slams you into the door, your face crashing into the wood over and over again. You kick out your feet to stop yourself and brace your face with your arms. The creature snarls and yanks you forward again with incredible force. You legs hit the door and you hear a disgusting crunch as your knees pop. 
        
        You wail in agony and the creature laughs in response. It hold you against the door and begins to pull. The wood of the door creaks, but holds firm. You slam your hands against the door and creature as your legs hang uselessly by your side. 
        
        The creature continues to laugh and pull you through the hole by your center. The wood catches your skin, digging underneath and pulling it from your flesh bit by bit. When your chest gets stuck, the creature pulls harder, sharply folding your body back. #ENDING: 3, Bad Ending 11 - Fold and Snap
        
        ****[There's a sharp crack.]
            ->Endings.Bad_End_11
    
    

*[Stairs]
    ~ Met_Mimic = true
    You take off down the hallway. The stairs going up, is a spiral staircase, while going down, is a long set of stairs. You grab the railing and pull yourself down the stairs. You stop when you can just barely see the top and crouch, listening for any sign that you're being followed.
    
    You hear your name again and tense, taking a few more steps down the stairs. A large shadow obscures the opening of the stairs. They call for you again, staying above the stairs, "Come out. It's just me." Their voice echos down the stairwell and you shiver. It's voice matches the one from the woman who let you the flashlight.
    
    **[Come out]
        The voice, the intonation, it matches to perfectly to simply be a good mimic. You begin to stand when freezing cold hands press down on your shoulders. "It's not me," she breaths into your ear, voice barely audible. "It's-" 
        {
            - Stay_Tracker > 3:
            You don't care, you know what you heard. Who's to say <i>this</i> voice is the fake? You shrug it off and climb the stairs. "I'm here!"
            
            #CYCLE: walks, slithers, clops, flies, swims
            "I'm here." The person turns to face you. You turn on your flashlight at you reach the top, shining it on the <s>person</s> being in front of you, and stop. It is much taller than you, and covered in what looks like a patchwork quilt. Every part being swallowed up by fabric. It @ closer toward you.
            
            #CYCLE: hand, claw, tentacle, paw, fin
            It smiles says "Found... You..." The words reverberate inside your brain. It holds out a @ for you to take.
            
            
            ***[Take it]
                #CYCLE: hand, claw, tentacle, paw, fin
                "Don't!" She screams, but again you wave her off and take its @. It laughs, or at least, that's what you think the sound is. It stops and pulls you closer, lowering it's hood. You scream and pull away, but its grip on you is like steel.
                
                TODO gluping sound
                Its face is an empty hole of mouths. Tendrils rise out of the hole and shoot toward your face. They enter your nose, ears, eyes, mouth, anywhere they can, and they begin to drink.
                
                TODO gross popping sound
                You shriek and squirm and hit, but nothing matters. It takes more than blood, but less than flesh. A tendril wraps around your eye and squeezes until it pops, slurping up the jelly pieces left behind. You can feel them ripping your insides apart and pulverizing them into a think soup. Any part it doesn't want are unceremoniously ripped out and discarded. #ENDING: 3, Bad Ending 10 - Juice box
                    
                ****[Ithurtsithurtsithurtsithurtsithurts]
                    -> Endings.Bad_End_10
                
            ***[<s>Don't</s> Take it]
                "Don't!" She screams. You shake your head but feel your body move on its own. "No!"
                
                You feel a strong push and you're falling back. The mimic shrieks at the loss of it's pray and leaps toward you, but misses. <>
                -> Stairs.Upstairs_Landing(true)
                
            ***[<s>Take it</s>]
                "Don't!" She screams. You shake your head but feel your body move on its own. "No!"
                
                You feel a strong push and you're falling back. The mimic shrieks at the loss of it's pray and leaps toward you, but misses. <>
                -> Stairs.Upstairs_Landing(true)
 

            
            - else: 
            TODO more feeling
            You nod, and crouch lower, her voice snapping you out of it. If you listen closer, you can hear ragged breathing coming from the mimic and a scraping against the wood as it moves. 
            
            You feel her nearby as you wait out the creature. Eventually, it howls and rams itself into the wall. Over and over, a wet slamming sound. With a final scream, you hear receding footsteps. You hold the position for a moment longer before deciding it was safe enough. You stand.
            
            "Thank you." You say, but she's already gone. You blow air out of your nose and glace between the pool of darkness down the stairs and back up to where the mimic was.
            
            ***[Continue down the stairs]
                You don't really want to go back up. The mimic is <i>probably</i> gone, but you don't want to take the chance. <>
                ->Stairs.Down_None(true)
        
            ***[Climb up the stairs]
                ->Office_Area.Office
        }
    
    **[Stay put]
        You don't move. You highly doubt that's actually her. If it is, you hope she'll forgive you. Eventually, it howls and rams itself into the wall. Over and over, a wet slamming sound. With a final scream, you hear receding footsteps. You hold the position for a moment longer before deciding it was safe enough. You stand.
        
         You blow air out of your nose and glace between the pool of darkness down the stairs and back up to where the mimic was.
        
        ***[Continue down the stairs]
            You don't really want to go back up. The mimic is <i>probably</i> gone, but you don't want to take the chance. <>
            ->Stairs.Down_None(true)
            
        ***[Climb up the stairs]
            ->Office_Area.Office

= Back_Confessional
{
    - Confessional_Encounters !? (Finished_Curtain_Side) && Confessional_Encounters ? (Finished_Door_Side):
        ~temp_bool = false
        Slowly and carefully, you walk backwards, trying not to make a sound, until you feel the edge of the curtain. The sound is enough, and all heads snap to look at you. One of the people shifts, but you slip past the curtain, and into the booth. You sit on the bench, and pull your feet up so they can't be seen from under the curtain. #IMAGE: Default #PROP: [Pews false]
        
        You hold your breath, listening for movement. You hear a shuffling, and see a shadow move in front of the curtain. A hand with long, thin fingers reaches into the booth and slide from side to side.
        
        A scream bubbles in your throat, but you swallow it. It stops, and retreats. You hear it say something you can't understand. A cross between human language and the growl of a creature.
        
        And then it leaves.
        
        You don't move for a long time, until you feel safe again. Slowly, slowly, you place your feet back on the floor and peak out from the curtain. The creature is gone, but the light from the stairwell and people in th pews remain.
        
    - else:
        ~temp_bool = true
        ~PlaySFX("door_thud", false, 0, 0)
        Slowly and carefully, you walk backwards, trying not to make a sound, until your back hits the door with a light thud. The sound is enough, and all heads snap to look at you. One of the people stands, growing taller and taller, never seeming to stop. 
        
        TODO make this effect maybe
        You fumble to for the knob, not wanting to take your eyes off it. It stops growing, and bends, leaning toward you.
        
        A scream bubbles in your throat, but never makes it out. It stops in front of you, and tilts it's head. It says something you can't understand. A cross between human language and the growl of a creature. It reaches out.
        
        You find the knob and turn it, falling back into the confessional. You kick the door closed and scramble toward it, using your body to hold the creature back. It never pushes back. #IMAGE: Default #PROP: [Pews false]
        
        Slowly, slowly, you reach get to your feet, and look through the grate. The creature is gone, but the light from the stairwell and people in th pews remain.
}

*[Take a seat at a pew]
    ->After_First.Take_Seat

*[Sprint to the stairwell]
    ->After_First.Stairs_After

*[Stay hidden]

-

{
    - Confessional_Encounters ? (Finished_Curtain_Side) && Confessional_Encounters ? (Finished_Door_Side):
        You sit back on the bench and pull your feet up, with your back to the wall. Outside, the music quiets, and you can hear the same low rumblings of whatever creature was after you before.
        
    - temp_bool:
        You sit on the cold wooden bench. Just like the outside, the inside doesn't have many details. The grate that a priest would speak through has the same lattice work that the door does. Outside, the music quiets, and you can hear the same low rumblings of whatever creature was after you before.
        ->Confessional_Door
    - !temp_bool:
        You sit on the cold wooden bench. Just like the outside, the inside doesn't have many details. The grate that a priest would speak through has the same lattice work that the door does. Outside, the music quiets, and you can hear the same low rumblings of whatever creature was after you before.
        ~temp_bool = false
        ->Confessional_Curtain
}

- 
{
    - Light_Feeling  == confused:
        ~temp_string = "confusing"
        
    - Light_Feeling  == relief:
        ~temp_string = "reassuring."
        
    - Light_Feeling  == worry:
        ~temp_string = "uneasy"
}

You listen to the voices outside the door, while you wait. Some sounds are more human language than others. You can make out some words, but even then you're not too sure.

After some time the sounds stop. You wait a few minutes to be safe, before opening the door. 

As soon as you step outside a red spotlight land on you. You freeze. It's the light from the window behind the priest, and gives off the same {temp_string} feeling as before. {Church_Encounters ? (Leave_Light): "It warms your body, and some of the tension melts away." | "Your skin tingles under it's warmth. It's uncomfortable. " } 

"Ah, there... you... are..." The pastor says, each word drawn out and emphasized. It's voice is raspy and harsh, like it's not used to speaking human language. 

The pastor on stage is beckoning you to join him. All eyes are on you. {Church_Encounters ? (Leave_Light): You fidget with your clothing, not sure what to do with your hands. You feel like a child getting called on in class when you don't know the answer. | A bead of sweat rolls down your back. Your eyes dart from the window, to the pastor, to the figures in the pews. }

~temp_bool = false

*[Go to the stage]
    ->Pews.Go_to_Stage

*[Run to the stairwell]
    Your eyes dart from the stairwell to the pastor and back again, before breaking into a run toward the stairs.
    
    You hear them call your name, but you don't dare turn around.
    ->Office_Area.Office

= Pews_After
~temp_bool = true
#CHECKPOINT: 3, Everyone is gone, and you feel...
You drop down from the stage and walk past the pews. Everyone is gone.
{Church_Encounters ? (Finger_Chopped): You stop when you reach the end of the rows. You look back at the stage, then up at the window. It's eye is closed. You sit on the floor, crossed—legged, and just stare at the window. {finger_pain_pass: Your hand twitches. You can't say it hurts anymore. Instead, it feels... Soothing. | Your hand aches, and you lightly brush the wound. It hurts.}} {Church_Encounters ? (Was_Coward): You stop at the pew {Book_Knowledge ? (Read_Mom_Old_Book):Ophelia | the woman} had sat at. You put your hand— your intact hand— on the wooden pew before taking a seat yourself.}

~ PlaySFX("curtain", false, 0, 2.5) 
You bow your head and close your eyes. @ bubbles up in your chest. #CYCLE: Anxiety, Dread, Doubt, Confusion #DELAY: 3

~ PlaySFX("child-wood-footsteps", false, 0, 2.5)
You jerk your head up, and look to the sound. The curtain of the confessional sways. Someone is inside. You slowly stand, watching the confessional. #IMAGE: Confessional_CloseUp #PROP: [curtain_wiggle true] #DELAY: 3

 
You whip around, and just barely miss seeing someone run up the stairs. #IMAGE: Church_Inside #PROP: [curtain_wiggle false]

*[Check inside the confessional]
    ->Confessional_Curtain

*[Follow them up the stairs]
    ->Stairs.Examine_Stairs

= Side_Room_After
#CHECKPOINT: 3, The pews are... full?
~PlayBGM("organ", false, 0, 0)
You return to the main body of the church, but stop on the last step. The church organ is playing. You peak out from the stairwell to see the pews are full of people. The people, if you could even call them that, have no faces or distinguishing marks. They're more of just... the general shape of people, flickering in and out of view. They don't seem to notice you.

The confessional at the other end of the room glows from a light, red light. 

*[Take a seat at a pew]
    ->After_First.Take_Seat

*[Go to the confessional]
    ~ previous_area = Enter_Pews

- There's no way to get to the stairs without the "people" noticing you. You take a breath before darting across the stage and to the stairs. 

You hear someone call your name, but you don't dare turn around. Instead, you quicken your pace and hide in the... # IMAGE: Confessional_CloseUp #PROP: [curtain_full true] #EFFECT: click_move_confessional

*[door]
    -> Confessional_Door

*[curtain]
    ~temp_bool = false
    -> Confessional_Curtain

=== After_Second===

= Pews_Second
#CHECKPOINT: 4, Everyone is gone, and you feel...
You drop down from the stage, and walk through the empty pews.

#CYCLE: Soothing, Reassuring, Calming, Pleasant
{Church_Encounters ? (Finger_Chopped): You stop when you reach the end of the rows. You look back at the stage, then up at the window. It's eye is closed. You sit on the floor, crossed—legged, and just stare at the window. {finger_pain_pass: Your hand twitches. You can't say it hurts anymore. Instead, it feels... @. | Your hand aches, and you lightly brush the wound. It hurts.}} {Church_Encounters ? (Was_Coward): You stop at the pew {Ophelia_Related: Ophelia | the woman} had sat at. You put your hand— your intact hand— on the wooden pew before taking a seat yourself.}

#CYCLE: Anxiety, Dread, Doubt, Confusion
You bow your head and close your eyes. @ bubbles up in your chest, and tears form in your eyes. Your body shutters as you cry. Deep, heavy sobs wrack your body.

*[This is all so much.]

- Your cries echo through the empty church, only serving to remind you that you are alone here.

*[You let yourself cry until you have no more tears.]

- You sniff, and wipe your eyes. You need to pull yourself together if you want to get out of here. You get to your feet at face the church. 

{Stay_Tracker <= 2: "I'm <i>going</i> to get out of here." You say. "Do you hear me? I'm <i>going</i> to get out of here!" | <i>I will get out of here.</i> you think to yourself. <i>I...</i>}

You need to return to your search. <>
    -> After_Second.Return_to_Search

= Confessional_Priest_Second
{
    - Confessional_Encounters ? (Killed_Girl):
        {
            - temp_string == "Your hands tremble":
                #CHECKPOINT: 4, You know what you saw.
                You pace in a circle, not sure what to do next. You know what you saw, what you heard, but... You glance back at the intact curtain. You can't be too sure.
                
                The church can adapt and change, do anything to keep you here. {items_obtained ? (Skeleton_Key): Does that mean you can't trust the key you found?} { items_obtained ? (Combo): Can you trust the information you have?} What can you trust? How much is real, tangible, and how much is the church?
                
                You shake your head. This is what the church wants. It wants you to doubt yourself. To think you can't trust anything. If you can't trust anything, then how could you escape? It wants to wear you down, slowly.
                
            - temp_string == "You grimace":
                #CHECKPOINT: 4, What have you done?
                You shuffle away from the confessional, not even wanting to look at it. You can't... You don't want to think about it. You know you need to keep moving forward, to find a way of of here, but...
                
                <Shame, Guilt, Doubt, Regret> bubbles up in your chest, and tears form in your eyes. Your body shutters, but you don't allow yourself to cry.
                
                You bite the inside of your cheek. <>
                
            - temp_string == "You grind your teeth":
                #CHECKPOINT: 4, Is this all just a sick game?
                You stomp away from the confessional. You want to hit something. Or break something. Just do anything to get all this emotion out. 
                
                You kick a pew, hard, stubbing your toe. You curse like a sailor, and pull at your hair. You're going to lose it before you get out of here. 
        }
        
        You need to return to your search. <>
        
    - else:
        #CHECKPOINT: 4, Did you do the right thing?
        You don't know how to feel. Did you help her? Does it matter if you did? Was that <i>really</i> her, or just another trick of the church?
        
        You hope it was the former. You hope that you did help her. That she finds her parents, and lives happily with them.
        
        You should return to your search. <>
        
}

There are still more places you need to look. <>

-> After_Second.Return_to_Search

= Confessional_Sin_Second
#CHECKPOINT: 4, You gained a key, but...
{
    - temp_string == "accept":
        ~ temp_string = ""
    - temp_string == "angry":
        ~ temp_string = ""
    - temp_string == "reach through":
        ~ temp_string = ""
}

You leave the booth, {temp_string == "accept": key weighing heavily in your pocket. | key in your pocket.} {Saw_Locks and Explore_Office_Bookshelf ? (Broke_Chest) == false: You should see if it fits the chest you found in the side office. And if it doesn't fit, then maybe on the lock on the door upstairs... Thinking back to how long it took you to get up there, maybe you should wait until you know for sure you can open the other locks. }{Explore_Office_Bookshelf ? (Broke_Chest): You should see if it fits the chest you found in the side office.} {Saw_Locks: You should see if it fits the lock on the door upstairs... Thinking back to how long it took you to get up there, maybe you should wait until you know for sure you can open the other locks.} 

There are still more places you need to look. <>

-> After_Second.Return_to_Search

= Stairs_Second
{
    - Book_Knowledge ? (Read_Mom_Old_Book, Saw_Your_Book):
        #CHECKPOINT: 4, You found your book... and a code
        
    - Book_Knowledge ? (Saw_Your_Book) && Book_Knowledge !? (Read_Mom_Old_Book):
        #CHECKPOINT: 4, You found your book...
        
    - Book_Knowledge !? (Read_Mom_Old_Book, Saw_Your_Book):
        #CHECKPOINT: 4, You found a code
}

{Book_Knowledge ? (Kept_Book): You hold your book tightly to your chest{Book_Knowledge ? (Ripped_Pages):, one hand over your pocket holding the ripped page,} as you return down the stairs.| {Book_Knowledge ? (Ripped_Pages): You keep one hand over your pocket holding the ripped page, as you return down the stairs.}} You sit on the last step and look out into the main body of the church.

{
- previous_area == Enter_Office:
    {Saw_Locks: You have a code to the combo lock|You found what might be a code}<>
        {
            - items_obtained ? (Skeleton_Key, Simple_Key):
                {broke_key:, but broke one of your keys. {Saw_Locks: You hope it wasn't the one for the locks upstairs.}}
                
            - items_obtained ? (Simple_Key) or items_obtained ? (Skeleton_Key):
                {broke_key:, but broke your key. {Saw_Locks:You hope it wasn't the one for the locks upstairs.}|, and have a key{Saw_Locks: that hopefully fits one of the locks upstairs.|.}}
            - else:
                {items_obtained ? (Clippers): |, but not much else. {Book_Knowledge ? (Read_Mom_Old_Book) and !Saw_Locks: You think should should go upstairs.}}
        }
        
        <> {items_obtained ? (Clippers): {Saw_Locks: You managed to acquire | You acquired} a pair of wire cutters, but... {Church_Encounters ? (Finger_Chopped): Your stump pulsates in response. | {Church_Encounters ? (Was_Coward): Her voice reverberates in your mind.} }} {Book_Knowledge ? (Kept_Book): You trace the number on the front cover.} {Book_Knowledge ? (Branded): Your skin stings.} 

- else:
    #CHECKPOINT: 4, You found a locked room.
    You stare up at the ceiling. {Have_Visited ? (Stairs_Up): You found where the heart is, or at least where you think it is. With all those locks and the light from under the door... It has to be there. {Downstairs_State > Bad_Vibes: Unless... It could be downstairs.} | {Downstairs_State > Bad_Vibes: You still haven't found the heart. Unless... It could be downstairs.}}
        
    {Downstairs_State > None: Your skin shivers.}
        
    {Saw_Locks and Downstairs_State > None: You would rather remove all the locks to see what's behind that door rather than go back down there.} {Downstairs_State > Bad_Vibes: The smell still lingers in your nose... |{Downstairs_State <= Bad_Vibes: You didn't see anything but...}} <> You shake your head. There are still more places you need to look if you want to get out of here. <>
}

-> After_Second.Return_to_Search

= Return_to_Search
#CHECKPOINT: 5, You need to keep searching. #EFFECT: click_move_main #IMAGE: Church_Inside
You decide to look...

* {Have_Visited !? (Enter_Pews)} [pews]
    -> Pews

*{Confessional_Encounters !? (Finished_Curtain_Side) or Confessional_Encounters !? (Finished_Door_Side)}[confessional]
    -> Confessional

* [stairs]
    -> Stairs.Examine_Stairs

=== Last_Stop ===

= Pews_Last
#CHECKPOINT: 6, Everyone is gone, and you feel...
You drop down from the stage, and walk through the empty pews. <>

#CYCLE: Soothing, Reassuring, Calming, Pleasant
{Church_Encounters ? (Finger_Chopped): You stop when you reach the end of the rows, look back at the stage, then up at the window. Its eye is closed. You sit on the floor, crossed—legged, and just stare at the window. {finger_pain_pass: Your hand twitches. You can't say it hurts anymore. Instead, it feels... @. | Your hand aches, and you lightly brush the wound. It hurts.}} {Church_Encounters ? (Was_Coward): You stop at the pew {Ophelia_Related: Ophelia | the woman} had sat at. You put your hand— your intact hand— on the wooden pew before taking a seat yourself.}

You bow your head and squeeze the wire cutters in your hand.<>

{Saw_Locks: {items_obtained ? (Combo): {items_obtained ? (Skeleton_Key) or items_obtained ? (Simple_Key): With the key{items_obtained ? (Skeleton_Key, Simple_Key) and (!broke_key or !broke_key_lock):s}, code and wire cutters, you should be able to open the locked door. | You have a code and wire cutters. The chains on the locks weren't that thick, you might be able to open the door with only these items.} | Even with the wire cutters{items_obtained ? (Skeleton_Key) or items_obtained ? (Simple_Key): and key{items_obtained ? (Skeleton_Key, Simple_Key) and (!broke_key or !broke_key_lock):s}}, without the code to the combo lock, you don't think you'll be able to fully unlock the door without it.}} 

{
    - items_obtained ? (Combo) and (items_obtained ? (Skeleton_Key) or items_obtained ? (Simple_Key)):
            ~ temp_string = "the code and the key"
            {
                - items_obtained ? (Skeleton_Key, Simple_Key) and (!broke_key or !broke_key_lock):
                    ~ temp_string += "s,"
                - else:
                    ~ temp_string += ","
            }
    - items_obtained ? (Combo):
        ~ temp_string = "and the code,"
        
}

{Have_Visited !? (Stairs_Up): With them, {temp_string} you assume they'll help you escape, but you still don't know where the heart is. {Book_Knowledge ? (Read_Mom_Old_Book): You think you should find the stairs that Ophelia went up.}} 

You're close to the end of this, you can feel it. {Stay_Tracker >= 2.5: Your leg bounces and you stare at the front door. At the end of this... maybe you'll choose to... You shake the thought from your head.| <>}


->Last_Stop.Return_to_Search

= Confessional_Priest_Last
{
    - Confessional_Encounters ? (Killed_Girl):
        {
            - temp_string == "Your hands tremble":
                #CHECKPOINT: 6, You know what you saw.
                You pace in a circle, not sure what to do next. You know what you saw, what you heard, but... You glance back at the intact curtain. You can't be too sure.
                
                The church can adapt and change, do anything to keep you here. {items_obtained ? (Skeleton_Key): Does that mean you can't trust the key you found?} { items_obtained ? (Combo): Can you trust the information you have?} What can you trust? How much is real, tangible, and how much is the church?
                
                You shake your head. This is what the church wants. It wants you to doubt yourself. To think you can't trust anything. If you can't trust anything, then how could you escape? It wants to wear you down, slowly.
                
            - temp_string == "You grimace":
                #CHECKPOINT: 6, What have you done?
                You shuffle away from the confessional, not even wanting to look at it. You can't... You don't want to think about it. You know you need to keep moving forward, to find a way of of here, but...
                
                #CYCLE: null, Shame, Guilt, Doubt, Regret
                @ bubbles up in your chest, and tears form in your eyes. Your body shutters, but you don't allow yourself to cry.
                
                You bite the inside of your cheek. <>
                
            - temp_string == "You grind your teeth":
                #CHECKPOINT: 6, Is this all just a sick game?
                You stomp away from the confessional. You want to hit something. Or break something. Just do anything to get all this emotion out. 
                
                You kick a pew, hard, stubbing your toe. You curse like a sailor, and pull at your hair. You're going to lose it before you get out of here. 
                
                You need to get a grip. <>
        }
        
        
        
    - else:
        #CHECKPOINT: 6, Did you do the right thing?
        You don't know how to feel. Did you help her? Does it matter if you did? Was that <i>really</i> her, or just another trick of the church?
        
        You hope it was the former. You hope that you did help her. That she finds her parents, and lives happily with them.
        
        You need to move on. <>
        
}

-> Last_Stop.Return_to_Search

= Confessional_Sin_Last
#CHECKPOINT: 6, You found a key, but...
{
    - Confessional_Encounters ? (Accepted_Priest):
        ~ temp_string = ""
    - Confessional_Encounters ? (Angered_Priest):
        ~ temp_string = ""
    - Confessional_Encounters ? (Reached_Through):
        ~ temp_string = ""
}

You leave the booth, {Confessional_Encounters ? (Accepted_Priest): key weighing heavily in your pocket. | key in your pocket.} {Saw_Locks and (Explore_Office_Bookshelf !? (Broke_Chest) and !broke_key and Book_Knowledge !? (Saw_Your_Book)): You should see if it fits the chest you found in the side office. And if it doesn't fit, then maybe on the lock on the door upstairs... Thinking back to how long it took you to get up there, maybe you should wait until you know for sure you can open the other locks. | {Explore_Office_Bookshelf !? (Broke_Chest) and !broke_key and Book_Knowledge !? (Saw_Your_Book): You should see if it fits the chest you found in the side office. | <>} {Saw_Locks: You should see if it fits the lock on the door upstairs... Thinking back to how long it took you to get up there, maybe you should wait until you know for sure you can open the other locks. | <>}}

-> Last_Stop.Return_to_Search

= Stairs_Last
{
    - Book_Knowledge ? (Read_Mom_Old_Book, Saw_Your_Book):
        #CHECKPOINT: 6, You found your book... and a code
        {
            - Book_Knowledge ? (Kept_Book, Ripped_Pages):
                You hold your book tightly in your hands as you return down the stairs, and to the main body of the church. <>
            - Book_Knowledge !? (Kept_Book) && Book_Knowledge ? (Ripped_Pages):
                You keep your hand over your pocket as you return down the stairs, and to the main body of the church. <>
            - Book_Knowledge ? (Kept_Book) && Book_Knowledge !? (Ripped_Pages):
                You hold your book tightly in your hands as you return down the stairs, and to the main body of the church. <>
        }
        
        You sit on the last step and look out into the empty room. You have a code to the lock {items_obtained ? (items_obtained ? (Clippers)): and wire cutters}{items_obtained ? (Skeleton_Key): and a key}{broke_key: and lost your key}. {Book_Knowledge ? (Kept_Book): You trace the number on the front cover.} {Book_Knowledge ? (Branded): Your skin stings.}
    - Book_Knowledge ? (Saw_Your_Book) && Book_Knowledge !? (Read_Mom_Old_Book):
        #CHECKPOINT: 6, You found your book...
        {Book_Knowledge ? (Kept_Book): You hold your book tightly in your hands as you return down the stairs, and to the main body of the church.} You sit on the last step and look out into the empty room. {Book_Knowledge ? (Kept_Book): You trace the number on the front cover.} {Book_Knowledge ? (Branded): Your skin stings.}
        
    - Book_Knowledge !? (Read_Mom_Old_Book, Saw_Your_Book):
        #CHECKPOINT: 6, You found a code
        {Book_Knowledge ? (Ripped_Pages): You keep your hand over your pocket as you return down the stairs, and to the main body of the church.} You sit on the last step and look out into the empty room. You have a code to the lock {items_obtained ? (Clippers): and wire cutters}{items_obtained ? (Skeleton_Key): and a key}{broke_key: and lost your key}.
        
    - Book_Knowledge !? (Read_Mom_Old_Book, Saw_Your_Book):
        You walk down the steps until you reach the last, and sit, looking out into main body of the church. <>
        
        {
            - Have_Visited ? (Stairs_Up) && Downstairs_State == 0:
                #CHECKPOINT: 6, You found a locked room.
                You stare up at the ceiling. You found where the heart is, or at least where you think it is. With all those locks and the light from under the door... It has to be there.
            
            - Have_Visited ? (Stairs_Up) && Downstairs_State > 1:
                #CHECKPOINT: 6, You found a locked room.
                You stare up at the ceiling. You found where the heart is, or at least where you think it is. With all those locks and the light from under the door... It has to be there. Unless... It could be downstairs.
                
                Your skin shivers.
                
                You would rather remove all the locks to see what's behind that door rather than go back down there. The smell still lingers in your nose...
                
                You shake your head. There are still more places you need to look if you want to get out of here. <>
            
            - else:
                #CHECKPOINT: 6, You found a locked room.
                {
                    - Downstairs_State > 1:
                        You still haven't found the heart. Unless... It could be downstairs.
                
                        Your skin shivers.
                
                        You would rather remove all the locks to see what's behind that door rather than go back down there. The smell still lingers in your nose...
                
                        You shake your head. There are still more places you need to look if you want to get out of here. <>
                    - Downstairs_State == 1:
                        You still haven't found the heart. Unless... It could be downstairs.
                
                        Your skin shivers.
                
                        You would rather remove all the locks to see what's behind that door rather than go back down there. You didn't see anything but...
                
                        You shake your head. There are still more places you need to look if you want to get out of here. <>
                }
        }
}


->After_Second.Return_to_Search

= Return_to_Search
#CHECKPOINT: 7, There's only a few places left to look. #EFFECT: click_move_main #IMAGE: Church_Inside
{LIST_COUNT(Have_Visited) >= 4: There's only one place you haven't checked yet. {Saw_Locks: | You have collected a variety of items. If, no. <i>When</i> you find the heart, you hope you'll be ready.} | {LIST_COUNT(Have_Visited) >= 3: There are only a couple places you haven't looked yet. }}{Saw_Locks: You know where the heart most likely is, {items_obtained ? (Combo, Clippers): and you should have enough items to open the door.} Whenever you're ready, the heart is waiting. }

+{Confessional_Encounters !? (Finished_Curtain_Side) or Confessional_Encounters !? (Finished_Door_Side)}[confessional] -> Confessional

+ {Have_Visited !? (Stairs_Up)} [stairs]
    -> Inside.Investigate_Stairs_Area

+ {Have_Visited ? (Stairs_Up)} [stairs] 
    ~temp_bool = false
    You stare up the stairs. They are just as tall as you remember. You take a deep breath, shake out your limbs and begin to climb.
    
+ {Have_Visited !? (Enter_Pews)} [pews] -> Pews

- 

*[It was easier this time around.]
    -> Stairs.Upstairs_End









