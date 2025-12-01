=== Open_the_Door ===
VAR crushed_at_door = false
#CHECKPOINT: 8, You open the locked door.
The door opens with a groan. The walls are bare, and the ceiling is low. The room inside is cramped, with a knee-high table in the center. On the table is a glass, and bread. Behind it, an ornate bowl with a glowing, stained glass heart inside.

"The heart...?"

You duck into the room and the door closes behind you, but you don't bother looking back. You approach the table, and sit in front of it. The heart is about the size of your fist. It floats in a small bowl of water, and is the source of the red glow. The glass is filled with a deep, red liquid. The bread next to it is short and stubby. It looks soft under the light of the heart.

~Intrusive(3, "Take a sip", "Open_the_Door.Consume")
~Intrusive(2, "So hungry", "Open_the_Door.Consume")
~Intrusive(2, "So thirstry", "Open_the_Door.Consume")
~ PlaySFX("stomach_growling", false, 0, 0)
Your mouth begins to water and your stomach growls. When was the last time you ate? Or the last time you drank?

~ temp_bool = true
*[Pick up the glass]
    #EFFECT: BlinkOnClick_False #EFFECT: Force_Open
    ~temp_bool = false
    ~Intrusive(2, "Delicious", "Open_the_Door.Consume")
    You pick up the glass and sniff the liquid. It smells like grapes. 
    **[Take a sip]
        -> Open_the_Door.Consume
        
    **[Put it down]
        #REMOVE: Intrusive
        You decide against it. You can always eat after you escape.
        -> Open_the_Door.Pick_Up

*[Pick up the heart]
    -> Open_the_Door.Pick_Up

= Consume
#REMOVE: Intrusive #CYCLE: pungent, tangy, sweet, delicious
{temp_bool: You pick up the glass and sniff the liquid. It smells like grapes.} You take a small sip and the taste is @. You can't stop yourself from gulping it down. Warm, thick liquid slides down your throat. 

*[You can't get enough.]

- 
~ PlaySFX("stomach_growling", false, 0, 0)
Your stomach growls and you stop drinking, only long enough to take a breath, and snatch the bread from the table. You rip into it, tearing the flesh from the bone.

#CYCLE: chewy, soft, meaty, exquisite
The bread is @. You can't chew fast enough, taking bigger and bigger bites, and barely stopping to swallow. When it's gone, you lick the {Stay_Tracker >= 2.5: bone | [bone]} clean.

*[You need more.]

{
    - Stay_Tracker < 2.5:
        *[bone]
        ->Open_the_Door.Bone
}

- 
#CYCLE: bread, flesh #CYCLE: wine, blood
You look back to the table to see its covered in @, and that your glass has filled itself back up with @. 

You keep eating and drinking. Never satisfied. Always needing more. 

*[And there is always more for you.]

- 
#ENDING: 6, Bad Ending - Never Satisfied
*[The church makes sure of it]
    ->Endings.Bad_End_6

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
~ PlaySFX("groaning_afraid", false, 0, 0)
Carefully, you reach out and take the heart out of the water. The church groans. The heart softly pulses in your hand. #EFFECT: BlinkOnClick_False #EFFECT: Force_Open

{Stay_Tracker >= 2.5: It's beautiful. | {Stay_Tracker >= 1.5: It's unnatural. | It's disgusting.}}

{Stay_Tracker >= 2.5:The heart is warm. The stained glass feels delicate in your hand, the glass not really being glass at all but a thin shining skin. One wrong move could destroy it. You gently press your thumb on it's center. The room shakes in response. {Stay_Tracker >= 1.5: The heart is warm. You roll it around in your hands before softly squeezing it. The room shakes in response. It's more delicate than you had imagined, the glass not really being glass at all but a thin shining skin. | The heart is uncomfortably warm, almost burning. It appears to be made of thick glass, but it feels like you could crush it in your hands with little effort. The glass is not really glass at all but a thin shining skin. You squeeze it, and the room shakes in response.}}

*[Crush it]
    ~crushed_at_door = false
    ->Open_the_Door.Crush_it

*[Bring it to the front door]
    ->Open_the_Door.Front_Door
    

= Front_Door
You don't know what will happen to you or the church if you destroy the heart up here, and you don't really want to find out. You don't think the church will try anything while you're holding it's heart, but...

You hold onto the heart tightly, and leave the room. The door opens for you, and the stairs turn into a ramp leading back into the main body of the church. {Have_Visited ? (Enter_Pews): The pews are full again. The ghostly, faceless beings are all standing. They're watching you. | The pews are full of ghostly, faceless beings. All standing. All watching you.}

*[The church is afraid]

- You approach the front door. It opens, showing off the moonlit sidewalk of the outside world. A cool breeze blows by and you take a deep breath of the crisp, fresh air. 

You are so close to freedom. You stand in the doorway. The heart pulses faster, matching your own. You look down at it.

{
    - Stay_Tracker >= 4.5:
        *[Eat the heart]
            ->Open_the_Door.Eat_it
}

*[Exit the church]
    #EFFECT: Force_Closed
    You step outside, into the real world, and take the heart with you. The church gates creak open, allowing you to finally escape it's grasp. 
    
    **[Leave the heart in the church]
        ~ PlaySFX("groaning_happy", false, 0, 0)
        ~ Stay_Tracker += 0.5
        You leave the heart at the gates as you set off the property. The church purrs in thanks, and snaps the gates shut. You blink and it's gone, leaving behind an empty plot of land.
        -> Open_the_Door.Leave(false)
        
    **[Take the heart with you]
        ~ Stay_Tracker -= 0.5
        You step off the property, taking the heart with you. The church cries and the heart pulsates rapidly before melting into ooze in your hand. The church howls and it starts to collapse in on itself. The roof falls and the door pathetically opens, begging for your return. You blink and it's gone, leaving behind an empty plot of land.
        -> Open_the_Door.Leave(false)

*[Crush the heart]
    ~crushed_at_door = true
    -> Open_the_Door.Crush_it

= Crush_it
~ WinAchievement(4)
Holding the heart in one hand, you begin to squeeze. It doesn't take much effort, almost like crushing an egg. The heart oozes blood and pulsates faster. The light begins to die.#EFFECT: Force_Open #PROP: [squeeze_heart true]

~ PlaySFX("groaning_hurt_1", false, 0, 0)
The whine of a wounded animal reverberates through the room.

*[The church is in pain]

- It shakes. It pleads. It begs you to stop.

You think of everything you went through because of the church. You think of the church's sight. {Confessional_Encounters ? (Killed_Girl):Of the little girl you couldn't save.}{Church_Encounters ? (Finger_Chopped):Of the finger that was taken from you.}{Church_Encounters ? (Leave_Light):Of the tantrums the church would throw when you didn't listen.} Of all the tricks it used into making you think you wanted to stay. Of all the people who can never leave. Will never leave.

#EFFECT: Force_Closed 
~ PlaySFX("groaning_hurt_2", false, 0, 0)
You squeeze harder, until your nails pierce your palm. The light is almost gone now. The church squeals pitifully in response. You drop whatever remains of the heart, and it falls to the floor with a wet <i>splat!</i>

*[The light fades to nothing]

- {crushed_at_door: The building shakes. You try the door, but it is gone. | The room goes dark, and the building shakes. You try the door, but it's gone.} #PROP: [squeeze_heart false]

*[{crushed_at_door: Step outside | You are falling }]

- 

{
    - crushed_at_door:
        In one calm movement, you step outside the doorway. You walk backwards, watching the church until you are outside its gates.
        
        ~ PlaySFX("screeching", true, 0, 0)
        ~ StopSFX("screeching", 1, 0.5)
        The church groans and screams as it falls in on itself. It begins to shine so brightly that you are forced to shield your eyes. With one last cry, the light is gone. When you look back, so is the church.
        
        -> Open_the_Door.Leave(false)
        
    - else:
        You squeeze your eyes shut. 

}

*[Is this how it ends?]

- 
#DELAY: 1
You fall.

#DELAY: 1
And fall.

#DELAY: 1
And fall some more.

For what seems like forever.

*[Open your eyes]

- Above you is a sky dotted with stars. You are not falling, but laying in soft dirt. You sit up and realize you are in an empty field of dirt. The place where a church once sat.

*[The church is gone]
    -> Open_the_Door.Leave(false)

= Leave(From_Office)
You are alone. You are free. The wind blows through your hair and the ground is solid beneath your feet. {Book_Knowledge ? (Branded): You rub your hands over the scars, picking at the rough skin. | {Church_Encounters ? (Finger_Chopped): You unbandage your hand and stare at the missing finger. }}

*[You made it out]

- You cover your mouth with your hand, and let out a shaky laugh. This is what you wanted{Stay_Tracker >= 2.5:, isn't it?|.}

*[You escaped]

-A surge of uncontrollable laughter bursts out of you. You can't stop it. You laugh until your stomach hurts. 

*[{Stay_Tracker >= 4.5: You eyes grow hot | A giggle escapes you}]

-
{Stay_Tracker >= 4.5: The laughter changes and suddenly you're sobbing. Fat, heavy tears roll down your cheeks as you gasp for air. You can barely breathe. | When your laughter finally dies down, you lay there for a moment. You think about everything. After an unmeasurable amount of time passes, you get to your feet, take a deep breath of fresh air, and begin walking home.}

*[{Stay_Tracker >= 4.5: What have you done? | It has been a long night}]
{
    - Stay_Tracker < 4.5:
        #ENDING: 9, Good Ending - It Has Been a Long, Long Night
        ->Endings.Good_End_9
}

- {crushed_at_door or From_Office: You stumble forward onto the dirt where a church once sat.} Through blurry eyes you dig into the soft earth.

*[The church is gone.]

- You don't know what you're looking for. Or what you're still doing here.

*[{From_Office: You ran away. | You killed it.}]

- {From_Office: You could have stayed. It was your choice. So why do you feel so...? | You didn't mean to. You only wanted to leave.}

*[You feel empty.]

*[You feel numb.]

*[You feel wrong.]

- Maybe... if you dig deep enough...

*[There must be something left.]

- You want to take it back. But why?

*[You got out!]

*[You got escaped!]

*[You won!]

- That's what you wanted, right? 

*[{From_Office: The church is gone. | The church is dead.}]

- You should go home now.

*[It's over.]

-
#ENDING: 8, ??? Ending - What Have You Done?
You stand, wipe your eyes, and dust yourself off.

*[It's time to go home.]
    ->Endings.Waht_End_8

= Eat_it
#EFFECT: BlinkOnClick_True #EFFECT: Force_Open
The heart beats in your hand, a lovely red color. It resembles a sweet apple. Are you certain?

*[Yes]

*[No]
    You shake your head. You can't. You shouldn't. You need to destroy it. <>
    -> Open_the_Door.Crush_it

- You raise the heart to your lips.

*[Take a bite]
    ~ WinAchievement(3)
    
*[Resist]
    You shake your head. You can't. You shouldn't. You need to destroy it. <>
    -> Open_the_Door.Crush_it

- 
~ PlaySFX("shriek", false, 0, 0)
The church shrieks in response. It shakes and shutters. The ghostly figures clutch their heads in agony. #PROP: [eat_heart true] #CLASS: Angry-Screeching #EFFECT: Force_Blink

Cool, sweet juice slides down your face. Yes. It tastes just like an apple. The sweetest, crispest apple you've ever had.

Your body feels a bit lighter. 

*[Take another bite]

- The ghosts fall to their knees, reaching for you. They cry for you.

All your worries melt away. You're not even sure why you were fighting so hard to get out. You can barely feel anything. Even the sweet taste is nothing more than a fleeting memory.

*[Finish it]

- You chew and chew until there's nothing left. #PROP: [eat_heart false]

The heart is gone. 

You are gone.

*[You are the church]

- #ENDING: 12, ??? Ending - You Are the Church
*[And the church is you]
->Endings.Waht_End_12


