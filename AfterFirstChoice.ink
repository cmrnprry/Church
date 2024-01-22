===After_First===

= Confessional_After
~ visited_second = true
~temp_visited = true
You exit the confessional, and stop in your tracks. The pews are full of people, and a church organ is playing. The people, if you could even call them that, have no faces or distiguishing marks. They're more of just... the general shape of people, flickering in and out of view. They don't seem to notice you.

The stairwell at the other end of the room glows from a light, red light. Your eyes scan the windows, but the eyes are closed.

*[Take a seat at a pew]
->After_First.Take_Seat
*[Go to the stairwell]
->After_First.Stairs_After
*[Walk back into the confessional]
->After_First.Back_Confessional

= Take_Seat
{
    - light_feeling == "confused":
        ~temp_string = "confusing"
        
    - light_feeling == "relief":
        ~temp_string = "reassuring."
        
    - light_feeling == "worry":
        ~temp_string = "uneasy"
}

Quickly, and quietly you a seat in the front row, and the light dims. A pastor climbs the stage and looks around, nodding at the figures. It looks at you, and tilts it's head. While it has no face, you can feel it smiling. It raises a hand, and points at you. You try to hide in your seat, and look away.

A red spotlight land on you. You freeze. It's the light from the window behind the priest, and gives off the same {temp_string} feeling as before. { leave_light: "It warms your body, and some of the tension melts away."} { leave_light == false: "Your skin tingles under it's warmth. It's uncomfortable. " } 

"Ah, there... you... are..." The pastor says, each word drawn out and emphasized. It's voice is raspy and harsh, like it's not used to speaking human language. 

The pastor on stage is beckoning you to join him. All eyes are on you. { leave_light: You fidget with your clothing, not sure what to do with your hands. You feel like a child getting called on in class when you don't knwo the answer.} { leave_light == false: A bead of sweat rolls down your back. Your eyes dart from the window, to the pastor, to the figures in the pews. }

~temp_bool = false

*[Go to the stage]
->Pews.Go_to_Stage

*[Leave]
->Pews.Try_Leave

= Stairs_After
There's no way to get to the stairs without the "people" noticing you. You take a breath before darting across the stage and to the stairs.

You hear someone call your name, but you don't dare turn around.
->Stairs.Office

= Back_Confessional
{
    - confessional_sin && !confessional_priest:
        ~temp_bool = false
        Slowly and carefully, you walk backwards, trying not to make a sound, until you feel the edge of the curtain. The sound is enough, and all heads snap to look at you. One of the people shifts, but you slip past the curtain, and into the booth. You sit on the bench, and pull your feet up so they can't be seen from under the curtain.
        
        You hold your breath, listening for movement. You hear a shuffling, and see a shadow move in front of the curtain. A hand with long, thin fingers reaches into the booth and slide from side to side.
        
        A scream bubbles in your throat, but you swallow it. It stops, and retreats. You hear it say something you can't understand. A cross between human language and the growl of a creature.
        
        And then it leaves.
        
        You don't move for a long time, until you feel safe again. Slowly, slowly, you place your feet back on the floor and peak out from the curtain. The creature is gone, but the light from the stairwell and people in th pews remain.
        
    - else:
        ~temp_bool = true
        Slowly and carefully, you walk backwards, trying not to make a sound, until your back hits the door with a light thud. The sound is enough, and all heads snap to look at you. One of the people stands, growing taller and taller, never seeming to stop.
        
        
        You fumble to for the knob, not wanting to take your eyes off it. It stops growing, and bends, leaning toward you.
        
        A scream bubbles in your throat, but never makes it out. It stops in front of you, and tilts it's head. It says something you can't understand. A cross between human language and the growl of a creature. It reaches out.
        
        You find the knob and turn it, falling back into the confessional. You kick the door closed and scramble toward it, using your body to hold the creature back. It never pushes back.
        
        Slowly, slowly, you reach get to your feet, and look through the grate. The creature is gone, but the light from the stairwell and people in th pews remain.
}

*[Take a seat at a pew]
->After_First.Take_Seat

*[Got to the stairwell]
->After_First.Stairs_After

*[Stay hidden]

-

{
    - confessional_sin && confessional_priest:
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
    - light_feeling == "confused":
        ~temp_string = "confusing"
        
    - light_feeling == "relief":
        ~temp_string = "reassuring."
        
    - light_feeling == "worry":
        ~temp_string = "uneasy"
}

You listen to the voices outside the door, while you wait. Some sounds are more human language than others. You can make out some words, but even then you're not too sure.

After some time the sounds stop. You wait a few minutes to be safe, before opening the door. 

As soon as you step outside a red spotlight land on you. You freeze. It's the light from the window behind the priest, and gives off the same {temp_string} feeling as before. { leave_light: "It warms your body, and some of the tension melts away."} { !leave_light: "Your skin tingles under it's warmth. It's uncomfortable. " } 

"Ah, there... you... are..." The pastor says, each word drawn out and emphasized. It's voice is raspy and harsh, like it's not used to speaking human language. 

The pastor on stage is beckoning you to join him. All eyes are on you. { leave_light: You fidget with your clothing, not sure what to do with your hands. You feel like a child getting called on in class when you don't know the answer.} { !leave_light: A bead of sweat rolls down your back. Your eyes dart from the window, to the pastor, to the figures in the pews. }

~temp_bool = false

*[Go to the stage]
->Pews.Go_to_Stage

*[Run to the stairwell]
Your eyes dart from the stairwell to the pastor and back again, before breaking into a run toward the stairs.

You hear them call your name, but you don't dare turn around.
->Stairs.Office

= Pews_After
~visited_first = false
~temp_bool = true
~ visited_second = true
You drop down from the stage, and walk through the pews. Everyone is gone.

{finger_chopped: You stop when you reach the end of the rows. You look back at the stage, and at the window. It's eye is closed. You sit on the floor, crossed legged, and stare at the window. {happy == false:Your hand aches, and you lightly touch the wound.<br><br>It hurts.}{happy: You feel a twinge in your hand. You can't say it hurts anymore. Instead it feels...<br><br> Soothing.}} { coward: You stop at the pew {name:Ophelia}{name == false: the woman} had sat at. You put your hand, your intact hand, on the wooden pew before taking a seat yourself.}

You bow your head and close your eyes. <Anxiety, Dread, Doubt, Confusion> bubble up in your chest, and tears form in your eyes. 

#play: child-wood-footsteps, 1 #play: curtain
You jerk your head up, and look to the sound. The curtain of the confessional sways. Someone is inside. You slowly stand, watching the confessional.

#play: child-wood-footsteps
You whip around, and just barely miss seeing someone run up the stairs.

*[Check inside the confessional]
->Confessional_Curtain

*[Follow them up the stairs]
->Stairs

= Side_Room_After
~temp_visited = true
~visited_first = false
~ visited_second = true
You return to the main body of the church, but stop on the last step. The church organ is playing. You peak out from the stair well to see the pews are full of people. The people, if you could even call them that, have no faces or distiguishing marks. They're more of just... the general shape of people, flickering in and out of view. They don't seem to notice you.

The confessional at the other end of the room glows from a light, red light. Your eyes scan the windows, but the eyes are closed.

*[Take a seat at a pew]
->After_First.Take_Seat

*[Go to the confessional]

- There's no way to get to the stairs without the "people" noticing you. You take a breath before darting across the stage and to the stairs.

You hear someone call your name, but you don't dare turn around. Insead, you quicken your pace and hide in the...

*[Door side confessional]
-> Confessional_Door

*[Curtain side confessional]
~temp_bool = false
-> Confessional_Curtain


===After_Second===

= Pews_Second
You drop down from the stage, and walk through the pews. Everyone is gone.

{finger_chopped: You stop when you reach the end of the rows. You look back at the stage, and at the window. It's eye is closed. You sit on the floor, crossed legged, and stare at the window. {happy == false:Your hand aches, and you lightly touch the wound.<br><br>It hurts.}{happy: You feel a twinge in your hand. You can't say it hurts anymore. Instead it feels...<br><br> Soothing.}} { coward: You stop at the pew {name:Ophelia}{name == false: the woman} had sat at. You put your hand, your intact hand, on the wooden pew before taking a seat yourself.}

You bow your head and close your eyes. <Anxiety, Dread, Doubt, Confusion> bubbles up in your chest, and tears form in your eyes. Your body shutters as you cry. Deep, heavy sobs wrack your body.

*[This is all so much.]

- Your cries echo through the empty church, only seving to remind you that you are alone here.

*[You let youself cry until you have no more tears.]

- You sniff, and wipe your eyes. You need to pull yourself together if you want to get out of here. You get to your feet at face the church. 

{stay <= 2: "I'm <i>going</i> to get out of here." You say. "Do you hear me? I'm <i>going</i> to get out of here!"}{stay>2: <i>I will get out of here.</i> you think to yourself. <i>At least, I hope so...</i>}

You need to return to your search. <>
-> After_Second.Return_to_Search

= Confessional_Priest_Second

{
    - emily_hurt:
        {
            - temp_string == "Your hands tremble":
                You pace in a circle, not sure what to do next. You know what you saw, what you heard, but... You glance back at the intact cutain. You can't be too sure.
                
                The church can adapt and change, do anything to keep you here. {key: Does that mean you can't trust the key you found?} { number_combo != "": Can you trust the information you have?} What can you trust? How much is real, tangible, and how much is the church?
                
                You shake your head. This is what the church wants. It wants you to doubt yourself. To think you can't trust anything. If you can't trust anything, then how could you escape? It wants to wear you down, slowly.
                
            - temp_string == "You grimce":
                You shuffle away from the confessional, not even wanting to look at it. You can't... You don't want to think about it. You know you need to keep moving forward, to find a way of of here, but...
                
                <Shame, Guilt, Doubt, Regret> bubbles up in your chest, and tears form in your eyes. Your body shutters, but you don't allow yourself to cry.
                
                You bite the inside of your cheek. <>
                
            - temp_string == "You grind your teeth":
                You stomp away from the confessional. You want to hit something. Or break something. Just do anything to get all this emotion out. 
                
                You kick a pew, hard, stubbing your toe. You curse like a sailor, and pull at your hair. You're going to lose it before you get out of here. 
        }
        
        You need to return to your search. <>
        
    - else:
        You don't know how to feel. Did you help her? Does it matter if you did? Was that <i>reallys</i> her, or just another trick of the church?
        
        You hope it was the former. You hope that you did help her. That she finds her parents, and lives happily with them.
        
        You should return to your search. <>
        
}

There are still more places you can look for the heart or an escape. <>

-> After_Second.Return_to_Search

= Confessional_Sin_Second
{
    - temp_string == "accept":
        ~ temp_string = ""
    - temp_string == "angry":
        ~ temp_string = ""
    - temp_string == "reach through":
        ~ temp_string = ""
}

You leave the booth, {temp_string == "accept": key weighing heavily in your pocket.}{temp_string != "accept": key in your pocket.} {saw_locks and broke_chest == false: You should see if it fits the chest you found in the side office. And if it doesn't there, then maybe on the lock on the door upstairs... Thinking back to how long it took you to get up there, maybe you should wait until you know for sure you can open the other locks. }{broke_chest == false: You should see if it fits the chest you found in the side office.} {saw_locks: You should see if it fits the lock on the door upstairs... Thinking back to how long it took you to get up there, maybe you should wait until you know for sure you can open the other locks.}

There are still more places you can look for the heart or an escape. <>

-> After_Second.Return_to_Search

= Stairs_Second
{
    - 
}
->END


= Return_to_Search
~ visited_second = false
You decide to look...

* {pews} [In the pews]
-> Pews

*{!confessional_sin or !confessional_priest}[In the confessional]
-> Confessional

*[Somewhere up the stairs]
-> Stairs


=== Last_Stop ===
->END
















