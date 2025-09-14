=== Open_the_Door ===
#CHECKPOINT: 8, You open the locked door.
The door opens with a groan. The walls are bare, and the ceiling is low. The room inside is cramped, with a knee-high table in the center. On the table is a glass, and bread. Behind it, an ornate bowl with a glowing, stained glass heart inside.

"The heart...?"

You duck into the room and the door closes behind you, but you don't bother looking back. You approach the table, and sit in front of it. The heart is about the size of your fist. It floats in a small bowl of water, and is the source of the red glow. The glass is filled with a deep, red liquid. The bread next to it is short and stubby. It looks soft under the light of the heart.

Your mouth begins to water and your stomach growls. When was the last time you ate? Or the last time you drank?

*[Consume what's on the table]
-> Open_the_Door.Consume

*[Pick up the heart]
-> Open_the_Door.Pick_Up

= Consume
#EFFECT: BlinkOnClick_False #EFFECT: Force_Open
You pick up the glass and sniff the liquid. It smells like grapes. 

*[Take a sip]

*[Put it back]
You decide against it. You can always eat after you escape.
-> Open_the_Door.Pick_Up

- You take a small sip. It's <pungent, tangy, sweet, delicious>. You can't stop yourself from gulping it down. Warm, thick liquid slides down your throat. 

*[You can't get enough.]

- 
{
    - stay >= 2.5:
        ~temp_string = "bone"
    - else:
        ~temp_string = "[bone]"
}

Your stomach growls and you stop drinking, only long enough to take a breath, and snatch the bread from the table. You rip into it, tearing the flesh from the bone.

The bread is <chewy, soft, meaty, exquisite>. You can't chew fast enough, taking bigger and bigger bites, and barely stopping to swallow. When it's gone, you lick the {stay >= 2.5: bone | [bone]} clean.

*[You need more.]

{
    - stay < 2.5:
        *[bone]
        ->Open_the_Door.Bone
}

- You look back to the table to see its covered in <bread, flesh>, and that your glass has filled itself back up with <wine, blood>. 

You keep eating and drinking. Never satisfied. Always needing more. 

*[And there is always more for you.]

- 
#ENDING: 6, Bad Ending: Eating Forever
*[The church makes sure of it]
->END

= Bone
#EFFECT: EFFECT: BlinkOnClick_True #EFFECT: Force_Closed
Bone...? 

The realization snaps you out it. Your hands shake as you look down at what's in them. 

Your hands are covered in the sticky, red liquid that's in the glass. The bread— What you had <i>thought</i> was bread, is— It looks like— You drop the small bones and look at the plate. It's filled with finger—sized pieces of— Not bread. It was <i>never</i> bread. It's— 

You cover your mouth, and your stomach lurches. You turn away from the table and retch. Everything you ate and drank comes out as an acidic, red, chunky mess. When your stomach is empty, you wipe your mouth with your sleeve, and slam your fist on the table.

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

#PLAY: groan #EFFECT: BlinkOnClick_False #EFFECT: Force_Open
Carefully, you reach out and take the heart out of the water. The church groans. The heart softly pulses in your hand.

{temp_string}

{
    - stay >= 2.5:
        ~temp_string = "The heart is warm. The stained glass feels delicate in your hand. One wrong move could crush it. You gently press your thumb on it's center. The room shakes in response."
    - stay >= 1.5:
        ~temp_string = "The heart is warm. You roll it around in your hands before softly squeezing it. The room shakes in response. It's more delicate than you had imagined."
    - else:
        ~temp_string = "The heart is uncomfortably warm, almost burning. It appears to be made of thick glass, but it feels like you could crush it in your hands with little effort. You squeeze it, and the room shakes in response."
}

{temp_string} 

*[Crush it]
    ~temp_bool_2 = false
    ->Open_the_Door.Crush_it

*[Bring it to the front door]
    ->Open_the_Door.Front_Door

= Front_Door
You don't know what will happen to you or the church if you destroy the heart up here, and you don't really want to find out. You don't think the church will try anything while you're holding it's heart, but...

You hold onto the heart tightly, and leave the room. The door opens for you, and the stairs turn into a ramp leading back into the main body of the church. {pews: The pews are full again. The ghostly, faceless beings are all standing. They're watching you. | The pews are full of ghostly, faceless beings. All standing. All watching you.}

*[The church is afraid.]

- You are at the front door. It opens, showing off the moonlit sidewalk of the outside world. A cool breeze blows by and you take a deep breath of the crisp, fresh air. 

You are so close to freedom.

You stand in the doorway. The heart pulses faster, matching your own. You look down at it.

*[Exit the church]
    #EFFECT: Force_Closed
    You step outside, into the real world, and take the heart with you. The church gates creak open, allowing you to finally escape it's grasp.
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
#EFFECT: Force_Open
Holding the heart in one hand, you begin to squeeze. It doesn't take much effort, almost like breaking an egg. The heart begins to bleed and pulse faster. The light begins to die.

The whine of a wounded animal reverberates through the room.

*[The church is in pain]

- It shakes. It pleads. It begs you to stop.
~temp_string = ""
{
    - Confessional_Encounters ? (Killed_Girl):
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


You think of everything you went through because of the church. You think of the church's sight. {temp_string} Of all the people who can never leave. Will never leave.

#EFFECT: Force_Closed
You squeeze harder, until your nails pierce your palm. The light is almost gone now. The church squeals pitifully in response. You drop whatever remains of the heart, and it falls to the floor with a wet <i>splat!</i>

*[The light dies.]

- {temp_bool_2: The building begins to shake. You try the door, but it is gone. | The room goes dark, and the building begins to shake. You try the door, but it is gone.}

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
        In one calm movement, you step outside the doorway, and though the gates.
        
        You hear the church groan. It screams as it falls in on itself. It begins to shine so brightly that you are forced to shield your eyes. With one last cry, the light is gone. When you look back, so is the church.
        
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

- Above you is a sky dotted with stars. You are not falling, but laying in soft dirt.

You sit up and realize you are in an empty field of dirt. The place where a church once sat.

*[The church is gone.]
    -> Open_the_Door.Leave

= Leave
You are alone. You are free.

*[You made it out ]

- You cover your mouth with your hand, and let out a shaky laugh. This is what you wanted{stay >= 2.5: ?:.}

*[You escaped.]

-

{
    - stay >= 2.5:
        ~temp_string = "You eyes grow hot"
    - else:
        ~temp_string = "A giggle escapes you"
}

A surge of uncontrollable laughter bursts out of you. You can't stop it. You laugh until your stomach hurts. 

*[{temp_string}]

-
{
    - stay >= 2.5:
        The laughter changes and suddenly you're sobbing. Fat, heavy tears roll down your cheeks as you gasp for air. You can barely breathe.
         ~temp_string = "What have you done?"
    - else:
        When your laughter finally dies down, you lay there for a moment. You think about everything. After an unmeasurable amount of time passes, you get to your feet, take a deep breath of fresh air, and begin walking home.

        ~temp_string = "You could really use a nice, warm bath."
}

*[{temp_string}]
{
    - stay < 2.5:
        #ENDING: 9, Good Ending: It Has Been a Long, Long Night
        ->END
}

- Through blurry eyes you dig into the soft earth.

*[The church is gone.]

- You don't know what you're looking for. Or what you're still doing here.

*[You killed it.]

- You didn't mean to. You only wanted to leave.

*[You feel empty.]

- Maybe... if you dig deep enough...

*[There must be something left.]

- You want to take it back. But why?

*[You got what you wanted.]

- You're sorry. You shouldn't be.

*[You got out]

- That's what you wanted, right? 

*[The church is gone.]

- You should go home now.

*[It's over.]

-
#ENDING: 8, ??? Ending: What Have You Done?
You stand, wipe your eyes, and dust yourself off.

*[It's time to go home.]
->END

= Eat_it
#EFFECT: BlinkOnClick_True #EFFECT: Force_Open
The heart beats in your hand, a lovely red color. It resembles a sweet apple.

Are you certain?

*[Yes]

- You raise the heart to your lips.

*[Take a bite]

- 
#PLAY: shriek #CLASS: Angry-Screeching
#EFFECT: Force_Blink
The church shrieks in response. It shakes and shutters. The ghostly figures clutch their heads in agony.

Cool, sweet juice slides down your face. 

Yes. It tastes just like an apple. The sweetest, crispest apple you've ever had.

Your body feels a bit lighter. 

*[Take another bite]

- The ghosts fall to their knees, reaching for you. They cry for you.

All your worries melt away. You're not even sure why you were fighting so hard to get out. You can barely feel anything. Even the sweet taste is nothing more than a fleeting memory.

*[Finish it]

- You chew and chew until there's nothing left.

The heart is gone. 

You are gone.

*[You are the church]

- #ENDING: 10, ??? Ending: You Are the Church
*[And the church is you]
->END


