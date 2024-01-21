===After_First===

= Confessional_After
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

A red spotlight land on you. You freeze. It's the light from the window behind the priest, and gives off the same {temp_string} feeling as before. { leave_light: "It warms your body, and some of the tension melts away."} { !leave_light: "Your skin tingles under it's warmth. It's uncomfortable. " } 

"Ah, there... you... are..." The pastor says, each word drawn out and emphasized. It's voice is raspy and harsh, like it's not used to speaking human language. 

The pastor on stage is beckoning you to join him. All eyes are on you. { leave_light: You fidget with your clothing, not sure what to do with your hands. You feel like a child getting called on in class when you don't knwo the answer.} { !leave_light: A bead of sweat rolls down your back. Your eyes dart from the window, to the pastor, to the figures in the pews. }

~temp_bool = false

*[Go to the stage]
->Pews.Go_to_Stage

*[Leave] 
~temp_bool = true
->Pews.Get_Up

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
        ->Confessional_Curtain


}

- You listen to the voices outside the door, while you wait. Some sounds are more human language than others. You can make out some words, but even then you're not too sure.

After some time the sounds stop. You wait a few minutes to be safe, before opening the door. 

As soon as you step outside a red light is placed on you, and you freeze. The people in the pews are looking at you. The preist on stages has his arms open toward you.

= Pews_After
~visited_first = false
->END

= Side_Room_After
~temp_visited = true
~visited_first = false
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
-> Confessional_Curtain


===After_Second===
->END