=== Pews ===
//TODO: add in bits about the people reflecting the books?
~ temp_string = ""
~pews = true
{
    - confessional_curtain_side:
        ~ temp_string += " Another key maybe?"
}

{
    - saw_locks && confessional_curtain_side:
        ~ temp_string += " Or maybe something to cut the sliding chain?"
    - saw_locks:
        ~ temp_string += " Maybe something to cut the sliding chain?"
}

{
    - number_combo == "":
        ~temp_string += " The code for the combination lock?"
}

{
    - !confessional_curtain_side || !saw_locks:
        ~temp_string += " You don't know exactly what for. It wouldn't really make sense for a heart to live among the pews. Maybe you should check the stage."
}
{
    - visited_first:
        ~ visited_first = false
        You make your way to the pews, and begin to search them for anything important.{temp_string}
    
    - else:
        Hesitantly, you make your way to the pews. They are empty, and there is no sign of the figures you saw before. You hope it stays that way, while you search them for anything important.{temp_string}

}

There are eight pews; two sections, containing four rows each. You seach from front-to-back, left-to-right. You feel underneath and behind each pew to make sure nothing is glued or taped to one. You move slowly and methodically, making sure you don't miss anything.

You don't find much of anything. With a huff, you plop onto the last pew you searched, taking a well-deserved break. You close your eyes and rub your face. What are you even looking for?

You lean back in your seat, eyes still closed, and sigh. There's no use sitting here. 


* {visited_first == false} [You should move on with your search.]

-
{
    - light_feeling == "confused":
        ~temp_string = "confusing"
        
    - light_feeling == "relief":
        ~temp_string = "reassuring."
        
    - light_feeling == "worry":
        ~temp_string = "uneasy"
}

Your eyes snap open as you hear a church organ begin to play. As you look around, you find the pews are filled with people. You can't make out any of the faces or any other distinguishing features. You can only tell that the figures are vaguely people-shaped. Their images flicker in and out of view. Some sit next to you, but none acknowledge you.

What you believe to be a priest ascends the stage and addresses the masses. You can't understand what's being said. It only sounds like grunts and groans to your ears.

*[Get up]
->Pews.Get_Up

*[Stay seated]

- You stay seated, only half listening to the murmurs. You look at the "people" sitting near you, trying to discern anything else about their forms. They're not fully translucent. You can see through their edges but their centers are opaque, almost like a thick black smoke.

*[Touch the person next to you]
    Curiosity gets the better of you and you attempt to touch the arm of the one seated next to you. Your hand passes right through them, and it's as though you've stuck your hand into a blast chiller.

    The figure makes a guttural sound and snaps their gaze towards you. Pain shoots through you as the temperature plummets in your arm. You pull back, holding it close to your body as you desperately try to warm yourself back up. "Sorry! Sorry!"

    The figure growls again, and moves further away from you. You don't think you should do that again.

*[Wait for the sermon to be over]
    ** [Get up] ->Pews.Get_Up

    ** [Wait for the sermon to be over]


- You stay in your seat, hoping it will end soon. You focus on the back of the seat in front of you. A bible is held in the pocket attached to the back of the pew.

Reading it will probably pass the time, but you can also still sneak away.

*[Open the bible]

*[Sneak away]
    ->Pews.Get_Up

- As you reach for the bible, a red spotlight land on you. You freeze. It's the light from the window behind the priest. It's the same {temp_string} feeling as before. { leave_light: It warms your body, and some of the tension melts away. | Your skin tingles under it's warmth. It's uncomfortable. } 

"Ah, there... you... are..." The pastor says, each word drawn out and emphasized. It's voice is raspy and harsh, like it's not used to speaking human language. 

He beckons you to join him. All eyes are on you. { leave_light: You fidget with your clothing, unsure of what to do with your hands. You feel like a child getting called on in class when you don't know the answer. | A bead of sweat rolls down your face. Your eyes dart from the window, to the pastor, to the figures in the pews. }

~temp_bool = false

*[Go to the stage]
    ->Pews.Go_to_Stage

*[Leave] 
    ->Pews.Try_Leave

= Get_Up
Slowly you rise to your feet, intending to leave the area. <br><br> "Ah, there... you... are..." The pastor says, each word drawn out and emphasized. It's voice is raspy and harsh, like it's not used to speaking human language. <br><br> e beckons you to join him. All eyes are on you. { leave_light: You fidget with your clothing, unsure what to do with your hands. You feel like a child getting called on in class when you don't know the answer. | A bead of sweat rolls down your back. Your eyes dart from the window, to the pastor, to the figures in the pews. }

* [Go to the stage] ->Pews.Go_to_Stage
* [Try to Leave] -> Try_Leave

= Try_Leave
You wave your hands in front of you, shake your head, and try to leave. The light follows your movements as you exit into the aisle. As you turn to walk opposite the stage, you find that the pastor now stands in your path.

"How did you—?"

"Wrong way... The stage is... this way."

The pastor grabs you by the shoulders, and leads you to the stage. { leave_light: The pastor's hands are cold, as it guides you, but the warmth from the light counters it. | You try to worm your way out, but it holds its grip tight. Its icy hands growing colder the more you try to resist. }

The pastor pushes you up the stage, and comes to stand next to you. It grabs your hand and raises it to the air, saying something in that gutteral language. And then it laughs. The rest of the church does as well. { stay >= 1.5: You nervously laugh along. | You grit your teeth. }

*[Pull your hand from the pastor]
~ temp_bool = false
*[Ask what's going on]
~ temp_bool = true

- ->Pews.On_Stage

= Go_to_Stage
You exit into the aisle, and slowly make your way towards the pastor. No one here has a face or eyes, but you can feel their stares boring holes straight through you. The light follows your movements as you approach the stage.

nce there, you move to stand next to the ghostly pastor. It grabs your hand and raises it to the air, saying something in that gutteral language. And then it laughs. The rest of the church does as well. { stay >= 1.5: You nervously laugh along. | You grit your teeth. }

*[Pull your hand from the pastor]
~ temp_bool = false
*[Ask what's going on]
~ temp_bool = true

- ->Pews.On_Stage

= On_Stage
{ temp_bool: It ignores the question, and releases your hand. | You jerk your hand from its grasp, and it laughs again.} "Stand... Here..."

"What is-" You try to ask, but the pastor once again takes ahold of you and moves you to be center stage. Another person appears, wheeling over a cart that has a container of water on it. Their left hand is missing a few fingers. The paster grabs something from behind the podium. "Can you explain to me what's—"

"Now, which hand...?" It asks, its own behind it's back.

"Hand? For what?!"

"Left or right?"

*[Left]
~ stay += 0.5
~ temp_string = "Left"

*[Right]
~ stay += 0.5
~ temp_string = "Right"

*[Demand an answer]
~ stay -= 0.5
~ temp_string = ""

-
{ temp_string != "": "{temp_string}, I guess, but for <i>what?</i>" you ask, exasperated. <br><br> "Prove your... faith." It holds out a hand, evidently expecting yours in return. "Every member does it. It only hurts... a pinch." <br><br> "What are you going to do?" | "I'm not doing <i>anything</i> until you tell me <i>what is going on!</i>" You borderline shout. } 

"Cleanse. You... need to be... willing..." The pastor tilts it's head to the side. It's voice sounds more threatening than it did a moment ago. "Now, hand."

You look at the tub of water in front of you.

*[Give it your hand]
~ stay += 0.5
*[Refuse]
~ stay -= 0.5
->Pews.Refuse_Him

- You assume this will be some hand-washing ritual, and hold out your hand over the container of water. The pastor takes you by the wrist, and gently places it in the water. The crowd begins to chant. 

"Hold it... there. Don't move." It says something to the crowd, and members of the audience each raise a hand. Some even raise two. All of them are missing at least one finger on their raised hand. "It will only... hurt a bit..."

"Hurt? What do you—?" Before you can finish speaking, it begins reciting something. It pulls its free hand from behind it's back, and reveals a pair of wire cutters. It dawns on you what exactly they're for only a moment too late. "Waitwaitwaitwait—!" 

You try to pull back, but it's grip becomes like steel. It smiles at you. "Thank you..." it says softly and in one swift motion, cuts off one of your fingers with a sickening <i>crunch.</i> 

And then, it releases you.

* [You stumble back.]
-> Pews.Finger_Gone

= Finger_Gone
~ finger_chopped = true
Your hand is gushing blood. You're screaming, you think. Everything is moving in slow motion as you stumble backwards. You don't know where you're going, just that you need to get away.

The pastor walks towards you with the severed finger in one hand and wire cutters in the other. It doesn't have a face but you know it's smiling manically. Your back reaches a wall and you slide into a sitting position. It crouches in front of you. "Hush... Hush... Hush..." it consoles you. "It only hurts... for a minute.

Your screams become wimpers as you wait for the pain to pass.

*[It never does]
    ~ stay -= 1
    ~ temp_bool = false
    The pain never dies. It continues to be a harsh, pulsating hurt. "It won't go away... unless you let it," the pastor growls. "You need... to be willing."

    You furiously shake your head. "Fine fine finefineFINE!" The paster hurls the wire cutters to the ground, and stamps it's feet  like a child throwing a tantrum. "Have it... YOUR way, then." 

    You watch in horror as he tilts it head back and slowly lowers your finger into it not face. You hear the sound of crunching as it chews, and you feel each, and every crunch. You gasp in pain as it loudly gulps, then looks at you again.
    
    You watch as he tilts his head back and slowly lowers your finger into his featureless face. There's a crunch that rips a breathless cry from you, followed by another, and another; each one sending a sharp jolt of pain down your arm. The way the man's jaw rolls with each <i>snap</i> turns your stomach.

*[At some point, it does]
    ~ stay += 1
    ~ temp_bool = true
    ~ happy = true
    You don't know how long it takes, but eventually the pain dies to a dull throbbing. "There, you see?" the pastor says. "Now, be at peace."

    ou watch as he tilts his head back and slowly lowers your finger into his featureless face. There's a crunch that coaxes a gasp from you, followed by another, and another; each one making you feel lighter than the last. The way the man's jaw rolls with each <i>snap</i> makes you wince.

- "There. Not so bad, was it?"

*[You shake your head.]

-
{ temp_bool: It reaches out, and pulls you into a standing position. You craddle your maimed hand as the pastor gently holds you, and brings you back to the main stage. It dips your hand in the water again before pulling out a bandage, and carefully wrapping up your finger stump. Applause rises from the masses. <br><br> "Now... let us bow our heads... and pray." TIn unison, the crowd bows their heads, and you follow suit. <br><br> The pastor utters a prayer in the inhuman language. Yet, strangely enough, you feel as though you can understand it. Not to the extent that you would be able to translate it, but enough that you know innately the meaning behind each phrase. <br><br> When the prayer finishes you glance up, smiling, only to find you are alone on stage. The crowd is gone. All that's left of the encounter is the wire cutters sitting on the floor where the pastor had once been, and a dull pain where your finger used to be. | It rips off a piece of cloth, dabs it's "mouth" with it, and then jeeringly throws it at you. "We don't need... dirty blood... staining a holy place." <br><br> It returns to center stage, and the crowd erupts into applause. "Now... let us bow our heads... and pray." <br><br> As they pray, you wrap up the bloody stump on your hand, hoping to escape while they're distracted. Before you know it however, the prayer stops and you look up, afraid of what will come next. And yet, nothing does. The ghastly priest is gone. The crowd is gone. All that remains of the encounter are the wire cutters sitting on the floor in front of you, and the dull pain where your finger used to be. }

* [Pick up the wire cutters]
    ~ clippers = true

- You grab the wire cutters, and slip them into your pocket{saw_locks:, knowing they'll be useful later.|. They might be useful later.}

{temp_bool: You think about what the masses had been chanting while the pastor cut off {coward:her|your} finger. In the prayer after, you could... understand what they were saying. Not with words, but... You shake your head. | You stare out at the empty pews, and wonder if this happens often. Or if it only happened becasue you were here.}

*[Return to your search]
{
    - visited_first:
        ->After_First.Pews_After
     - visited_second:
        -> After_Second.Pews_Second
    - else:
        -> Last_Stop.Pews_Last
}

= Refuse_Him
You take another look at the water, then the pastor. "No, I think I'm okay." 

The pastor lets out a deep, gutteral growl. "Fine then." He snaps his head to crowd, and points at a woman in the second row. "Your turn then." 

A woman floats to the stage, and stands next you. She looks at you, and though she doesn't have a face, you can sense of deep fear in her. She looks back to the pastor, who is holding out it's hand, waiting for hers. 

"Please..." she wimpers. "I have— I've already been cleansed."

The pastor ignores her and grabs her arm, forcing it over the container of water. She looks at you. She is pleading.

* [Take her place] 

* [Let her do it]
-> Pews.Coward

- "Wait!" You reach out, and stop the pastor. It cocks it's head to the side. "I'll do it."

"You are... willing, then?"

It releases the woman, grabs your wrist. She falls to her feet, thanking you, before returning to her seat.

*["Yes."]
"Hold still..." It turns to the crowd, and they begin to chant. "It will only... hurt a bit..."

"Hurt? What do you—?" Before you can finish speaking, it begins reciting something. It pulls his free hand from behind it's back, and reveals a pair of wire cutters. "Waitwaitwaitwait—!" 

You try to pull back, but it's grip becomes like steel. It smiles at you. "Thank you..." it explaims and in one swift motion, cuts off one of your fingers with a sickening <i>crunch.</i> 

*["On second thought..."]
"You are... willing...!" It turns to the crowd, and they begin to chant. "It will only... hurt a bit..."

"Hurt? What do you—?" Before you can finish speaking, it begins reciting something. It pulls his free hand from behind it's back, and reveals a pair of wire cutters. "Waitwaitwaitwait—!" 

You try to pull back, but it's grip becomes like steel. It smiles at you. "Thank you..." it explaims and in one swift motion, cuts off one of your fingers with a sickening <i>crunch.</i> 

- 
It releases you. 

* [You stumble back.]
-> Pews.Finger_Gone

= Coward
~ coward = true
"You've made... your choice..." The pastor turns to the crowd, and they begin to chant.

The pastor recites something. It pulls his free hand from behind his back, and reveals a pair of wire cutters. The woman is pleading with him. With you.

*[You do nothing to stop it.]

- 
"Coward." she spits at you, before the pastor uses the cutters to cut off one of the woman's fingers with a sickening <i>crunch.</i> She falls to the ground, cradling her injured hand. You see that her other hand is also missing fingers.

The pastor places the wire cutter on the tray with the container of now bloodied water. The crowd claps. "Now... let us bow our heads... and pray." The crowd bows their heads.

She looks up at you sobbing. "After everything I've done for you? This is how you repay me?"

You feel sick, and stumble backwards. {name: <i>Ophelia...?</i> | <i>Is she...?</i>}

*[Look away]
~stay += 0.5
    You turn away from her, unable to face her. 

    "Coward. Coward!"

    Her voice rings in your ears, and eventually goes silent. When you turn back, you are alone on stage. The crowd is gone. {name:Ophelia is gone.| The woman is gone.} All that's left of the encounter is the wire cutters sitting on the floor at your feet.

*[Appologize]
~stay -= 0.5
    "I— I'm sorry. I— I— I didn't—" You stumble over your words.

    "Coward. Coward!" Her voice is full of hate. She clambers to her feet, and grabs the wire cutters with her non-hurt hand. She throws them at your feet. "After <i>everything</i> I did for you!"

    Her voice rings in your ears, and you look away. Eventually goes silent. When you turn back, only to see you are alone on stage. The crowd is gone. {name:Ophelia is gone. | The woman is gone.} All that's left of the encounter is the wire cutters sitting at your feet.
- 

*[Pick up the wire cutters]
    ~ clippers = true
    ~ finger_chopped = true

- You grab the wire cutters, and slip them into your pocket{saw_locks:, knowing they'll be useful later.|. They might be useful later.}

{temp_bool: You think about what they have been chanting while the pastor cut off {coward:her|your} finger. In the prayer after, you could... understand what they were saying. Not with words, but... You shake your head. | You stare out at the empty pews, and wonder if this happens often. Or if it only happened becasue you are here.}

*[Return to your search]
{
    - visited_first:
        ->After_First.Pews_After
     - visited_second:
        -> After_Second.Pews_Second
    - else:
        -> Last_Stop.Pews_Last
}















