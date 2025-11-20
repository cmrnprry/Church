=== Pews ===
TODO: add in bits about the people reflecting the books?
~ temp_string = ""
~ Have_Visited += (Enter_Pews)

{
    - visited_state <= 0:
        You make your way to the pews, and begin to search them for any hints about the heart{Saw_Locks: or keys for the locks. |. It wouldn't really make sense for a heart to live among the pews. Maybe you should check the stage?}
    
    - else:
        Hesitantly, you make your way to the pews. They are empty, and show no sign of the figures you saw before. You hope it stays that way while you search for any hints about the heart{Saw_Locks: or keys for the locks|. It wouldn't really make sense for a heart to live among the pews. Maybe you should check the stage?}
}

There are eight pews; two sections, containing four rows each. You search from front-to-back, left-to-right. You feel underneath and behind each pew to make sure nothing is glued or taped to one. You move slowly and methodically, making sure you don't miss anything.

You don't find much of anything. With a huff, you plop onto the last pew you searched. You close your eyes and rub your face. What are you even looking for? You lean back in your seat, eyes still closed, and sigh. There's no use sitting here. 


* [You should move on]
    ~PlayBGM("organ", false, 0, 0)

-
{
    - Light_Feeling  == confused:
        ~temp_string = "confusing"
        
    - Light_Feeling  == relief:
        ~temp_string = "reassuring"
        
    - Light_Feeling  == worry:
        ~temp_string = "uneasy"
}


Your eyes snap open as the church organ begins to play. You find the pews are {visited_state > 1: once again filled with flickering, faceless "people." | filled with people. You can't make out any of the faces or any other distinguishing features. You can only tell that the figures are vaguely people-shaped. Their images flicker in and out of view.} Some sit next to you, but none acknowledge you. #PROP: [Pews true]

~PlaySFX("talking_reverse", true, 1, 0)
A priest ascends the stage and addresses the masses. You can't understand what's being said. It only sounds like grunts and groans to your ears.

*[Sneak away]
    ->Pews.Get_Up

*[Stay seated]

- You stay seated, ignoring the grunts coming from the priest and murmurs of agreement from those in the pews. You look at the "people" sitting near you, trying to discern anything else about their forms. They're not fully transparent. You can see through their edges but their centers are opaque, almost like a thick grey smoke.

*[Touch the person next to you]
    ~ Frozen_Hand = true
    Curiosity gets the better of you and you reach out to touch the arm of the one seated next to you. Your hand passes right through them, and it feels as though you've stuck your hand into a sub zero water.

    The figure makes a guttural sound and snaps their gaze towards you. Pain shoots through you as the temperature plummets further. You pull back, cradling your hand close to your body as you desperately try to warm it back up. "Sorry! Sorry!"

    ~ PlaySFX("growling", false, 0, 0)
    The figure growls again, and seems to make itself smaller by pulling at its edges. Your fingers are stiff and any attempt to move them sends a dull pain up your arm.  You don't want to do that again.

*[Wait for the sermon to be over]
    

- 
~StopSFX("talking_reverse", 0.25, 0)
~PlaySFX("talking", true, 0.5, 0)
{Frozen_Hand: You press your hand between your thighs to warm it, and hope the sermon will be over soon. <>| You stay in your seat, hoping it will end soon. The longer you listen to the priest drone on, the more you find yourself nodding along. You flinch and pat your cheeks to wake yourself up. } 

You {Frozen_Hand: | lightly hum to drown out the priest's words and }focus on the back of the seat in front of you. A bible is held in the pocket attached to the back of the pew. Reading it will probably pass the time, but you can still sneak away.

~ temp chose_wait = false
*[Open the bible]
    ~StopSFX("talking_reverse", 1, 0)
    ~StopSFX("talking", 1, 0)
    As you reach for the bible, a red spotlight land on you. You freeze. It's the light from the window behind the priest. It's the same {temp_string} feeling as before. {Church_Encounters ? (Leave_Light): It warms your body, and some of the tension melts away. | Your skin tingles under it's warmth. It's uncomfortable. } #PROP: [Pews_Lighting true]

*[Sneak away]
    ->Pews.Get_Up
    
*[Wait a little longer]
    ~ chose_wait = true
    ~StopSFX("talking_reverse", 1, 0)
    ~StopSFX("talking", 1, 0)
    ~PlayBGM("organ", true, 0, 0)
    ~StopSFX("organ", 3, 1)
    The priest stops talking and shuffles to the organ. The people in the pews sway slightly and nod along. You close your eyes and sink in your seat. You keep humming, louder and louder to drown out the organ until you can only hear yourself and nothing else.
    
- 

"Ah, there... you... are..." The pastor says, each word drawn out and emphasized. It's voice is raspy and harsh, like it's not used to speaking human language. {chose_wait: It rises from the organ and points to you. You tense. The light from the window behind it spotlights you. It's the same {temp_string} feeling as before. {Church_Encounters !? (Leave_Light): It warms your body, and the tension in you shoulders melt away. | Your skin tingles under it's warmth. It's uncomfortable. }} #PROP: [Pews_Lighting true]

He beckons you to join him. All eyes are on you. {Church_Encounters !? (Leave_Light): You fidget with your clothing, unsure of what to do with your hands. You feel like a child getting called on in class when you don't know the answer. | A bead of sweat rolls down your face. Your eyes dart from the window, to the pastor, to the figures in the pews. }

~temp_bool = false

*[Go to the stage]
    ->Pews.Go_to_Stage

*[Turn the other way] 
    ->Pews.Try_Leave(false)

= Get_Up
You rise to your feet, intending to leave the area. You try to keep your head down to avoid being seen, but the moment you step into the aisle, a red light spotlights you. You tense. It's the same {temp_string} feeling as before. {Church_Encounters !? (Leave_Light): It warms your body, and the tension in you shoulders melt away. | Your skin tingles under it's warmth. It's uncomfortable.} #PROP: [Pews_Lighting true]

~StopSFX("talking_reverse", 1, 0)
~StopSFX("talking", 1, 0)
"Ah, there... you... are..." The pastor says, each word drawn out and emphasized. It's voice is raspy and harsh, like it's not used to speaking human language. It beckons you to join it on stage. All eyes are on you. 

{Church_Encounters ? (Leave_Light): You fidget with your clothing, unsure what to do with your hands. You feel like a child getting called on in class when you don't know the answer. | A bead of sweat rolls down your back. Your eyes dart from the window, to the pastor, to the figures in the pews. }

* [Go to the stage] ->Pews.Go_to_Stage

* [Turn the other way] -> Try_Leave(true)

= Try_Leave(In_Aisle)
You wave your hands in front of you, shake your head, and try to leave. The light follows your movements as you {In_Aisle: walk away from the stage. As you turn your attention away from| exit into the aisle. As you turn to walk opposite} the stage, you find that the pastor now stands in your path.

"How did you—?"

"Wrong way... The stage is... this way."

The pastor grabs you by the shoulders, and leads you to the stage. {Church_Encounters !? (Leave_Light): The pastor's hands are cold, as it guides you, but the warmth from the light counters it. | You try to worm your way out, but it holds its grip tight. Its icy hands growing colder and light warmer the more you try to resist. }

The pastor pushes you up the stage, and comes to stand next to you. It grabs your hand and raises it to the air, saying something in that guttural language. And then it laughs. The rest of the church does as well. {Stay_Tracker >= 1.5: You nervously laugh along. | You grit your teeth. }

*[Pull your hand from the pastor]
    ~ temp_bool = false
    
*[Ask what's going on]
    ~ temp_bool = true

- ->Pews.On_Stage

= Go_to_Stage
You shuffle your way up the aisle and to the pastor. No one here has a face or eyes, but their gaze follows you. Their stares boring holes straight through you. The light follows your movements as you approach the stage.

Once there, you stand next to the ghostly pastor. It grabs your hand and raises it to the air, saying something in that guttural language. And then it laughs. The rest of the church does as well. {Stay_Tracker >= 1.5: You nervously laugh along. | You grit your teeth. }

*[Pull your hand from the pastor]
    ~ temp_bool = false
    
*[Ask what's going on]
    ~ temp_bool = true

- ->Pews.On_Stage

= On_Stage
{ temp_bool: It ignores the question, and releases your hand. | You jerk your hand from its grasp, and it laughs again.} "Stand... Here..."

#PROP: [priest true]
"What is-" You try to ask, but the pastor once again takes ahold of you and moves you to be center stage. Another person appears, wheeling over a very tangible cart with a container of water. Their hands are more solid when touching the cart. Their left hand is missing a few fingers. The paster grabs something from behind the podium. "Can you explain to me what's—"

~ PlayBGM("watched", true, 20, 0)
~ StopSFX("inside", 20, 0)
"Now, which hand...?" It asks, its own behind it's back.

"Hand? For what?!"

"Left or right?"

*[Left]
    ~ Stay_Tracker += 0.5
    ~ temp_string = "Left"
    "Left, I guess, but for <i>what?</i>" you ask, exasperated.

*[Right]
    ~ Stay_Tracker += 0.5
    ~ temp_string = "Right"
    "Right, I guess, but for <i>what?</i>" you ask, exasperated.

*[Demand an answer]
    ~ Stay_Tracker -= 0.5
    ~ temp_string = ""

-

{temp_string != "": "Prove your... faith." It holds out a hand, evidently expecting yours in return. "Every member does it. It only hurts... a pinch."}

"I'm not doing <i>anything</i> until you tell me <i>what is going on!</i>" You borderline shout. 

"Cleanse. You... need to be... willing..." The pastor tilts it's head to the side. It's voice sounds more threatening than it did a moment ago. "Now, hand."

You look at the tub of water in front of you.

*[Give it your hand]
    ~ Stay_Tracker += 0.5
    
*[Refuse]
    ~ Stay_Tracker -= 0.5
    ->Pews.Refuse_Him

- You assume this will be a hand-washing ritual, and hold out your hand over the container of water. The pastor takes you by the wrist, and gently places it in the water. The crowd begins to chant. #PROP: [priest false]

"Hold it... there. Don't move." It says something to the crowd, and members of the audience each raise a hand. Some even raise two. All of them are missing at least one finger on their raised hand. "It will only... hurt a bit..."

"Hurt? What do you—?" Before you can finish speaking, it begins reciting something. It pulls its free hand from behind it's back, and reveals a pair of wire cutters. It dawns on you what exactly they're for only a moment too late. "Waitwaitwaitwait—!" #DELAY: 0.5

~ PlaySFX("climax_long", true, 0, 0) 
You try to pull back, but it's grip becomes like steel. It smiles at you. "Thank you..." it says softly and in one swift motion, cuts off one of your fingers with a sickening <i>crunch.</i> #EFFECT: Remove_Finger #EFFECT: Force_Open

~ StopSFX("climax_long", 10, 2)
~ StopSFX("watched", 10, 0)
~ PlaySFX("heartbeat", true, 5, 0) 
~ PlaySFX("tinitus", true, 5, 0) 
And then, it releases you.

* [You stumble back.]
    -> Pews.Finger_Gone

= Finger_Gone
~ Church_Encounters += (Finger_Chopped)
Your hand is gushing blood. You're screaming, you think. Everything is moving in slow motion as you stumble backwards. You don't know where you're going, just that you need to get away. #PROP: [Pews_Lighting false]

The pastor walks towards you with the severed finger in one hand and wire cutters in the other. It doesn't have a face but you know it's smiling. Your back reaches a wall and you slide into a sitting position. It crouches in front of you. "Hush... Hush... Hush..." it consoles you. "It only hurts... for a minute.

Your screams become whimpers as you wait for the pain to pass.
~ temp_bool = false

*[It never does]
    ~ Stay_Tracker -= 1
    ~ PlaySFX("growling", false, 0, 0)
    The pain never dies. It continues to be a harsh, pulsating hurt. "It won't go away... unless you let it," the pastor growls. "You need... to be willing."

    You furiously shake your head. "Fine fine finefineFINE!" The paster hurls the wire cutters to the ground, and stamps it's feet  like a child throwing a tantrum. "Have it... YOUR way, then."
    
    ~ PlaySFX("eating", false, 0, 0)
    You watch as he tilts his head back and slowly lowers your finger into his featureless face. There's a crunch that rips a breathless cry from you, followed by another, and another; each one sending a sharp jolt of pain down your arm. The way the man's jaw rolls with each <i>snap</i> turns your stomach.
    
    ** [You shake your head]
        It rips off a piece of cloth, dabs it's "mouth" with it, and then throws it at you. "We don't need... dirty blood... staining a holy place." 
    
        It returns to center stage, and the crowd erupts into applause. "Now... let us bow our heads... and pray." 
        
        ~ StopSFX("heartbeat", 5, 0) 
        ~ StopSFX("tinitus", 5, 0)
        You wrap up the bloody stump on your hand, hoping to escape while they're distracted. The prayer stops and you flinch, afraid of what will come next. And yet, nothing does. The ghastly priest is gone. The crowd is gone. All that remains of the encounter are the wire cutters sitting on the floor in front of you, and the dull pain where your finger used to be. #PROP: [Pews false]
        

*[At some point, it does]
    ~ Stay_Tracker += 1
    ~ finger_pain_pass = true
    ~ StopSFX("heartbeat", 5, 0) 
    ~ StopSFX("tinitus", 5, 0)
    You don't know how long it takes, but the pain dies to a dull throbbing. "There, you see?" the pastor says. "Now, be at peace."

    ~ PlaySFX("eating", false, 0, 0.5)
    You watch as he tilts his head back and slowly lowers your finger into his featureless face. There's a crunch that coaxes a gasp from you, followed by another, and another; each one making you feel lighter than the last. The way the man's jaw rolls with each <i>snap</i> makes you wince.
    
    "There. Not so bad, was it?"
    
    **[You nod]
    
        It reaches out, and pulls you into a standing position. You cradle your maimed hand as the pastor gently holds you, and brings you back to the main stage. It dips your hand in the water again before pulling out a bandage, and carefully wrapping up your finger stump. Applause rises from the masses.
    
        "Now... let us bow our heads... and pray." In unison, the crowd bows their heads. 
        
        ***[Bow your head]
            ~ temp_bool = true
            ~ Stay_Tracker += 0.5
            The pastor utters a prayer in the inhuman language. Yet, strangely enough, you feel as though you can understand it. Not to the extent that you would be able to translate it, but enough that you know innately the meaning behind each phrase. 
        
            When the prayer finishes you glance up, smiling, only to find yourself alone on stage. The crowd is gone. All that's left of the encounter is the wire cutters sitting on the floor where the pastor had once been, and a dull pain where your finger used to be. #PROP: [Pews false]
        
        ***[Turn away]
            ~ Stay_Tracker -= 0.5
            The pastor utters a prayer in the inhuman language. It is still harsh and foreign to your ears, and yet, it is strangely comforting. 
        
            When the prayer finishes you glance back, only to find yourself alone on stage. The crowd is gone. All that's left of the encounter is the wire cutters sitting on the floor where the pastor had once been, and a dull pain where your finger used to be. #PROP: [Pews false] 
            

- 
* [Pick up the wire cutters]
    ~ items_obtained += (Clippers)

- You grab the wire cutters, and slip them into your pocket{Saw_Locks:, knowing they'll be useful later.|. They might be useful later.} #EFFECT: Force_Blink

{temp_bool: You think about what the masses had been chanting while the pastor cut off your finger. In the prayer after, you could... understand what they were saying. Not with words, but... You shake your head. | You stare out at the empty pews, and wonder if this happens often. Or if it only happened because you were here.}

*[Return to your search]
    -> Pews.Pews_Continue

= Refuse_Him
You take another look at the water, then the pastor. "No, I think I'm okay." #PROP: [priest false]

~ PlaySFX("growling", false, 0, 0)
The pastor lets out a deep, guttural growl. "Fine then." He snaps his head to crowd, and points at a woman in the second row. "Your turn then." 

A woman floats to the stage, and stands next you. She looks at you, and though she doesn't have a face, you can sense of deep fear in her. She looks back to the pastor, who is holding out it's hand, waiting for hers. 
"Please..." she whimpers. "I have— I've already been cleansed."

You flinch at her voice, recognizing who it belongs to. {Ophelia_Related: Ophelia. | The woman who helped you.} The pastor ignores her and grabs her arm, forcing it over the container of water.

It could be another trick to force you to take her place. {Met_Mimic: The mimic was nearly identical.} There's no way to know. She looks at you. She is pleading. Do you want to take that chance?

* [Take her place] 

* [Let her do it]
    -> Pews.Coward

- "Wait!" You reach out, and stop the pastor. It cocks it's head to the side. "I'll do it."

"You are... willing, then?"

It releases the woman, grabs your wrist. She falls to her feet, thanking you. She bows her head to your feet and you notice her had is missing fingers.

*["Yes."]
    "Hold still..." It turns to the crowd, and they begin to chant. "It will only... hurt a bit..."

*["On second thought..."]
    "You are... willing...!" It turns to the crowd, and they begin to chant. "It will only... hurt a bit..."

- "Hurt? What do you—?" Before you can finish speaking, it begins reciting something. It pulls his free hand from behind it's back, and reveals a pair of wire cutters. "Waitwaitwaitwait—!" 

~ PlaySFX("climax_long", true, 0, 0) 
You try to pull back, but it's grip becomes like steel. It smiles at you. "Thank you..." it exclaims and in one swift motion, cuts off one of your fingers with a sickening <i>crunch.</i> #EFFECT: Remove_Finger #EFFECT: Force_Open

~ StopSFX("climax_long", 10, 2)
~ StopSFX("watched", 10, 0)
~ PlaySFX("heartbeat", true, 5, 0) 
~ PlaySFX("tinitus", true, 5, 0) 
It releases you. 

* [You stumble back.]
    -> Pews.Finger_Gone

= Coward
~ Church_Encounters += (Was_Coward)
"You've made... your choice..." The pastor turns to the crowd, and they begin to chant.

The pastor recites something. It pulls his free hand from behind his back, and reveals a pair of wire cutters. The woman is pleading with him. With you.

*[You do nothing to stop it]

*[You push her out of the way]
    She falls to the ground and it releases her, cocking it's head at you. She falls to her feet, thanking you. She bows her head to your feet and you notice her had is missing fingers.

    "You are... confusing." It grabs your wrist. "But this must mean... that you are willing. It will only... hurt a bit..." #EFFECT: Force_Blink

    ~ PlaySFX("climax_long", true, 0, 0) 
    It turns to the crowd, and they begin to chant. You try to pull back, but it's grip becomes like steel. It smiles at you. "Thank you..." it exclaims and in one swift motion, cuts off one of your fingers with a sickening <i>crunch.</i> #EFFECT: Remove_Finger #EFFECT: Force_Open
    
    ~ StopSFX("climax_long", 10, 2)
    ~ StopSFX("watched", 10, 0)
    ~ PlaySFX("heartbeat", true, 5, 0) 
    ~ PlaySFX("tinitus", true, 5, 0) 
    It releases you. 
    
    *** [You stumble back]
        -> Pews.Finger_Gone


- "Coward." she spits at you, before the pastor uses the cutters to cut off one of the woman's fingers with a sickening <i>crunch.</i> She falls to the ground, cradling her bleeding hand. You see that her other hand is also missing fingers. #EFFECT: Force_Blink

The pastor places the wire cutter on the tray with the container of now bloodied water. The crowd claps. "Now... let us bow our heads... and pray." The crowd bows their heads. #PROP: [Pews_Lighting false]

She looks up at you sobbing. "After everything I've done for you? This is how you repay me?" 

You feel sick, and stumble backwards. Her pain is real, but... She's already trapped here. You are not.

*[Look away]
    ~ Stay_Tracker += 0.5
    You turn away from her, unable to face her. 

    "Coward. Coward!" She clambers to her feet and pulls at your shirt collar. You squeeze your eyes shut. "After all I..."
    
    ~ StopSFX("watched", 3, 0)
    She releases you and throws something at your feet. Her voice rings in your ears, but eventually goes silent. When you turn back, you are alone on stage. The crowd is gone. {Ophelia_Related: Ophelia is gone.| The woman is gone.} All that's left of the encounter are the wire cutters sitting on at your feet and the blood staining your shirt. #PROP: [Pews false]

*[Apologize]
    ~ Stay_Tracker -= 0.5
    "I— I'm sorry. I— I— I didn't—" You stumble over your words.

    "Coward. Coward!" Her voice is full of hate. She clambers to her feet, and grabs the wire cutters with her non-hurt hand. She throws them at your feet. "After <i>everything</i> I did for you!"

    ~ StopSFX("watched", 3, 0)
    Her voice rings in your ears, and you look away. Eventually, it is silent. When you turn back, only to see you are alone on stage. The crowd is gone. {Ophelia_Related: Ophelia is gone. | The woman is gone.} All that's left of the encounter are the wire cutters sitting at your feet and blood staining the wood. #PROP: [Pews false]
- 

*[Pick up the wire cutters]
    ~ items_obtained += (Clippers)
    ~ Church_Encounters -= (Finger_Chopped)

- You grab the wire cutters, and slip them into your pocket{Saw_Locks:, knowing they'll be useful later.|. They might be useful later.} You stare out at the empty pews, and wonder if this happens often. Or if it only happened because you are here.

*[Return to your search]
    -> Pews.Pews_Continue

= Pews_Continue
~ previous_area = Enter_Pews
~ current_area = Main_Body 
~ Have_Visited += Enter_Pews
~ visited_state += 1
~PlayBGM("inside", true, 30, 0)

{
    - visited_state == 1:
        ->After_First.Pews_After
    - visited_state == 2:
        -> After_Second.Pews_Second
    - else:
        -> Last_Stop.Pews_Last
}













