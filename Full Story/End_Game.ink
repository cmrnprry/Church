=== Open_the_Door ===
#CHECKPOINT: 8, You open the locked door.
The door opens with a groan. The walls are bare, and the ceiling is low. The room inside is cramped, with a knee high table in the center. On the table is a glass, and bread. Behind it, an ornate bowl with a glowing, stained glass heart inside.

"The heart...?"

You duck into the room and the door closes behind you, but you don't bother looking back. You approach the table, and sit in front of it. The heart is about the size of your fist. It floats in a small bowl of water, and is the source of the red glow. The glass is filled with a deep, red liquid. The bread next to it is short and stubby. It looks soft under the light of the heart.

Your mouth begins to water and your stomach growls. When was the last time you ate? drank?

*[Consume what's on the table]
-> Open_the_Door.Consume

*[Pick up the heart]
-> Open_the_Door.Pick_Up

= Consume
You pick up the glass, and sniff the liquid. It smells like grapes. 

*[Take a sip]

*[Put it back]
You decide against it. You can always eat after you escape.
-> Open_the_Door.Pick_Up

- You take a small sip. It's <pundgent, tangy, sweet, delicious>. You can't stop yourself from gluping it down. Warm, thick liquid slides down your throat. 

*[You can't get enough.]

- 
{
    - stay >= 2.5:
        ~temp_string = "bone"
    - else:
        ~temp_string = "[bone]"
}

Your stomach growls and you stop drinking, only long enough to take a breath, and snatch the bread from the table. You rip into it, tearing the flesh from the bone.

The bread is <chewy, soft, meaty, exquisite>. You can't chew fast enough, taking bigger and bigger bites, barely stopping to swallow. When it's gone, you lick the {temp_string} clean.

*[You need more.]

{
    - stay < 2.5:
        *[bone]
        ->Open_the_Door.Bone
}

- You look back to the table to see its covered in <bread, flesh>, and that your glass has filled itself back up with <wine, blood>. 

You keep eating and drinking, never satisified. Always needing more. 

*[And there is always more for you.]

- 
#ENDING: Eating Forever
*[The church makes sure of it]
->Credits

= Bone
Bone...? 

The realization snaps you out it. Your hands shake as you look down at what's in your them. 

They're covered in the sticky, red liquid that is in the glass. The bread- What you had _thought_ was bread, is- It looks like- You drop the small bones and look at the plate. It's filled with finger sized pieces of bread- no. Not bread. It was _never_ bread. It's- 

You cover your mouth, and your stomach lurches. You turn away from the table and retch. Everything you ate and drank comes out is a acidic, red, chunky mess. You wipe your mouth with your sleeve, and bang you fist on the table.

You look back at the glowing heart.

*[Pick up the heart]
-> Open_the_Door.Pick_Up

= Pick_Up
{
    - stay >= 2.5:
        ~temp_string = "It's beautiful."
    - stay >= 1.5:
        ~temp_string = "It's unnatural."
    - else:
        ~temp_string = "It's disgusting."
}

#PLAY: groan
Carefully, you reach out and take the heart out of the water. The church groans, and heart softly pulses in your hand.

{temp_string}

{
    - stay >= 2.5:
        ~temp_string = "The heart is warm. The stained glass feels delicate in your hand, where one wrong move could crush it. You gently press your thumb on it's center. The room shakes in response."
    - stay >= 1.5:
        ~temp_string = "The heart is warm. You roll it around in your hand before softly squeezing it in your hand. The room shakes in response. It's more delicate than you had imagined."
    - else:
        ~temp_string = "The heart is uncomfortably warm, almost burning. It must be made of thick glass, but it feels like you could crush it in your hands with little effort. You squeeze it, and the room shakes in response."
}

{temp_string} 

*[Crush it]
~temp_bool_2 = false
->Open_the_Door.Crush_it

*[Bring it to the front door]
->Open_the_Door.Front_Door

= Front_Door
You don't know what will happen to you or the church if you destroy the heart up here, and you don't really want to find out. You don't think the church will pull anything while your holding it's heart, but...

{
    - pews:
        ~ temp_string = "The pews are full again. The ghostly, faceless beings are all standing, watching you."
    - else:
        ~ temp_string = "The pews are dull of ghostly, faceless beings, all standing. All watching you."
    
}

You hold onto the heart tightly, and leave the room. The door opens for you, and the stairs turn into a ramp leading back into the main body of the church. {temp_string}

*[The church is afraid.]

- You are at the front door. It opens, showing off the moonlit sidewalk of the outside world. The cool breeze blows in and you take a deep breath of the crsip, fresh air. 

You are so close to freedom.

You stand in the doorway. The heart pulses faster, matching your own. You look down at it.

*[Exit the church]
You step outside, into the real world, taking the heart with you. The church gates creak open, allowing you to fully leave it's grasp.
-> Open_the_Door.Leave

*[Crush the heart]
~temp_bool_2 = true
-> Open_the_Door.Crush_it
{
    - stay >= 2.5:
        *[Eat the heart]
            ->Open_the_Door.Eat_it
}



= Crush_it
Holding the heart in one hand, you begin to squeeze. It doesn't take much effort, almost like breaking an egg. The heart begins to bleed and pulse faster. The light begins to die.

The sound of a wounded animal reveberates through the room.

*[The church is in pain]

- It shakes. It pleads. It begs you to stop.
~temp_string = ""
{
    - confessional_priest:
        ~temp_string += "Of the little girl you couldn't save."
}

{
    - finger_chopped:
    ~temp_string += "Of the church taking your finger."
}

{
    - leave_light:
    ~temp_string += "Of the tantrums it would throw when you didn't listen."
}

{
    - stay >= 2:
    ~temp_string += "Of being tricked into thinking you want to stay."
}


You think of everythign you went through becasue of the church. Of the church's sight. {temp_string} Of all the people who can never leave. Will never leave.

You squeeze harder, until your nails peirce your palm. The light is almost gone now. The church sqeaks pitifully in response. You drop whatever remains of the heart, and it falls to the floor with a wet <i>splat!</i>

*[The light dies.]

- 
{
    - temp_bool_2:
        The building begins to shake. You try the door, but it is gone.
        
    - else:
        The room goes dark, and the building begins to shake. You try the door, but it is gone.

}

*[The church whimpers.]

-

{
    - temp_bool_2:
        The church begins to collapse.
        ~temp_string = "Step outside"
        
    - else:
        The room goes dark, and the building begins to shake. You try the door, but it is gone.
        ~temp_string = "You are falling."
}

*[{temp_string}]

- 

{
    - temp_bool_2:
        With one calm movement, you step outside the doorway, and though the gates.
        
        You watch the church groan and scream as it falls in on itself. It begins to glow so brightly that you shield your eyes. With one last cry, the light is gone, and when you look back, so is the church.
        
        -> Open_the_Door.Leave
        
    - else:
        You squeeze your eyes shut. 

}

*[Is this how it ends?]

- You fall.

And fall.

And fall some more.

For what seems like forever.

*[Open your eyes.]

- Above you is a sky of stars. You are not falling, but laying in soft dirt.

You sit up and realize you are in an empty field of dirt. The place where a church once sat.

*[The church is gone.]
-> Open_the_Door.Leave

= Leave
You are alone. You are free.

*[You made it out ]

- 
{
    - stay >= 2.5:
        ~temp_string = "?"
    - else:
        ~temp_string = "."
}

You cover your mouth with your hand, and let out a shaky laugh. This is what you wanted{temp_string}

*[You escaped.]

-

{
    - stay >= 2.5:
        ~temp_string = "You eyes grow hot."
    - else:
        ~temp_string = "Stand up."
}

A surge of uncontrollable laughter escapes you. You can't stop it. You laugh until your stomach hurts. 

*[{temp_string}]

-
{
    - stay >= 2.5:
        The laughter changes and suddenly you're sobbing. Fat heavy tears roll down your cheeks, and your gasping for air. You can barely breathe.
         ~temp_string = "What have you done?"
    - else:
        You get to your feet, take a deep breath of fresh air, and begin walking home. 

        ~temp_string = "You could really use a nice, warm bath."
}

*[{temp_string}]
{
    - stay < 2.5:
        #ENDING: It Has Been a Long, Long Night
        ->Credits
}

- Through blury eyes you being to dig into the soft earth.

*[The church is gone.]

- You don't know what you're looking for. Or what you're still doing here.

*[You killed it.]

- You didn't mean to. You only wanted to leave.

*[You feel empty.]

- Maybe.. if you dig deep enough...

*[There must be something left.]

- You want to take it back. But why?

*[You got what you wanted.]

- You're sorry. You shouldn't be. Why are you sorry?

*[You got out]

- That's what you wanted right? 

*[The church is gone.]

- You should go home now.

*[It's over.]

-
#ENDING: What Have You Done?
You stand, and dust yourself off.

*[It's time to go home.]
->Credits

= Eat_it
The heart beats in your hand, a lovely red color. Almost like a sweet apple. You raise the heart to your lips.

Are you certain?

*[Take a bite]

- 
#PLAY: shriek #CLASS: Angry-Screeching
The church shrieks in response. It shakes and shutters. The ghostly figures grab their heads in agony.

Cool, sweet juice slides down your face. Yes. It tastes just like an apple. The sweetest, crispest apple you've ever had.

Your body begins to feel a bit lighter. 

*[Take another bite.]

- The ghosts fall to their knees, reaching for you. They cry for you.

All your worries seemingly melt away. You're not even sure why you were fighting so hard to get out. You can barely feel anything. Even the taste is nothing more than a fleeting memory.

*[Finish the heart]

- You chew and chew until there's nothing left.

The heart is gone. 

You are gone.

*[You are the church.]

- #ENDING: You Are the Church
*[And the church is you]
->Credits







































