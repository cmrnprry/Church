=== Confessional_Curtain ===
TODO: Rememeber to unset if the player just leaves and to set previous if we do do something
//As we enter the curtain side, set all variables. 
~ current_area = Confessional_CurtainSide // set the current area
~ have_visited += Confessional_CurtainSide //set that we have visisted the area
{
    //if this is the first area we are visiting
    - previous_area == -1:
        ~ visited_state = 0
        #PLAY: curtain
        You push aside the curtain and find a small, mostly empty room. A slab of wood juts out from the far wall, creating an uncomfortable bench, and a small bucket sits in the corner by the divider. You assume the booth must leak, but the bucket is empty.
        
        You think you'd know if there were anything else in here.
        
        *[Search the area anyway]
            You don't know what the heart even is, so you may as well check every inch of this place. You sigh and hold the flashlight in your mouth while you lightly brush your hands across every surface. Under the bench, in the bucket, even wipeing away the cobwebs gathered in the corners.
            
            You plop onto wooden bench, and rub your eyes. There's nothing here. Of course not. What did you expect? Why did you enter?
            
            -> Confessional_Curtain.Nothing_Here(true)
        
        *[What is the point of searching?]
            ~ stay += 0.5
            You plop onto wooden bench, and stare into dark abyss that is the church. If the heart is the church's weakness, it's not going to be left in the open or easy to find. There's no way to know if it even <i>exists.</i> There's no way of knowing if that voice was even really here to help you or just another trick of the church.
            
            Of course the confessional is empty. What did you expect? Why did you enter?
            -> Confessional_Curtain.Nothing_Here(false)
        
    - previous_area != Enter_Pews: 
        TODO: figure out this nonsense
        You sit on the cold wooden bench. {confessional_door_side: It's almost identical to the other side. | The grate that a priest would speak through has the same lattice work that the door does. }
    
        A small bucket sits in the corner by the divider. You assume the booth must leak, but the bucket is empty.
    
        {confessional_door_side: What are you expecting to find here? Why did you enter? | There is nothing remotely resembling the heart in here. What were you expecting? Why did you enter?}
        -> Confessional_Curtain.Nothing_Here(true)
        
    - else:
        { visited_state:
            - 1:
                While you wait for the service to be over, you look around the cramed space for something useful.
    
                A small bucket sits in the corner by the divider. You assume the booth must leak, but the bucket is empty.
            
                You find nothing. The booth is empty.
            
                The rumbling of the sound outside have gone quiet, and when you peak out again, the people and red light are gone. It's probably safe to leave now.
                
                You sigh in relief, and move to leave when you hear a voice float through the grate. 
                
                "Already leaving?" You freeze. The voice is deep. "Why did you enter only to leave? Aren't you looking for somehting?"
                ->Confessional_Curtain.Why_Enter
            - 2:
                //We come here if it's after the pews 1st choice
                You decide to check the confessional. You saw the curtain move, someone <i>must</i> be in there. Carefully and quietly, you approach it.
                
                Once in front of it, you think you can hear shuffling from inside. You steel yourself, and rip the curtain open. 
                
                It's empty. "Ha.. Hahaha..." you laugh and step inside. {confessional_door_side: It's almost identical to the other side. | The grate that a priest would speak through has the same lattice work that the door does. } A small bucket sits in the corner by the divider.
                
                You plop onto wooden bench, and rub your eyes. There's nothing here. There's no <i>one</i> here. Of course not. What did you expect? Why did you enter?
                -> Confessional_Curtain.Nothing_Here(true)
        }
}

= Nothing_Here(checked_area)
*[To confess]
#PLAY: curtain 
~temp_bool = true
"What is it you have to confess?" The curtain zips closed and you jump at the deep voice coming from the other side of the screen. "I am here to listen."

* {checked_area} [To look for clues]
~temp_bool = false
You look around the small space again, touching the smooth wood to find anything you may have missed.

#PLAY: curtain 
"Looking for something?" The curtain zips closed and you jump at the deep voice comeing from the other side of the screen. "I may be able to help?"

*[You don't know]
#PLAY: curtain 
~temp_bool = false
"Lost are we?" The curtain zips closed and you jump at the deep voice coming from the other side of the screen. "Maybe I can help?"


- ->Confessional_Curtain.Why_Enter

= Why_Enter
Your heart races and your entire body tenses. Another person? Here? Do they know about the heart? Can you trust them? 
TODO: cross reference other sections to see if player has been tricked by fake people before. do something with stay variable vs tricked

*["Have you seen a heart?"]
#DELAY: 1
"I cannot say I have." He chuckles. "Unless you mean your own? Maybe a confession would help you find it?"

*["Who are you?"]
#DELAY: 1
"That does not matter." He says. {temp_bool: "I will ask again: What is it you have to confess?" | "Do you have something to confess?"}

*[Leave the booth]
#PLAY: curtain
You quickly leave the booth, and stare at the confessional. It's quiet. You're not sure what's in there, but you do know that you don't want to speak to it.
    
There was nothing in there, anyway. You should return to your search.
->Confessional_Curtain.Leave_NoProgress

- 
#PLAY: liquid-drop
<i>Plink!</i> A drop of water falls into the bucket. {stay < 1.5: You frown and point your flashlight at the corner. You don't hear rain from outside.}

"Well?" He prods you. {stay < 1.5: You set the flashlight on the bench beside you and choose to ignore the leak. It wouldn't be the first time the church tricked your senses.}

{
    - stay >= 1.5:
    You wring your hands together. A confession? Talking to someone might talk your mind off of things...
    
    You take a deep breath, suddenly nervous.
    
        *[Talk about work]
            -> Confessional_Curtain.Work_Confession
        *[Talk about something personal]
            -> Confessional_Curtain.Personal_Confession
        *[Talk about nothing]
            -> Confessional_Curtain.No_Confession
    - else:
        *["Tell me who you are first."]
            {
                - confessional_door_side: 
                    #REPLACE: I am a pastor here,
                    "Hmm..." The voice grunts. "[I am a pastor here,] is that not obvious?"
                - else: "Hmm..." The voice grunts. "I am a pastor here, is that not obvious?"
            }

            -> Confessional_Curtain.Question(true)
            
        *["Are you part of the church?"]
            {
                - confessional_door_side: 
                    #REPLACE: As a man of cloth,
                    "[As a man of cloth,] I assume I must be. What an odd question to ask."
                - else: "As a man of cloth, I assume I must be. What an odd question to ask."
            }

            ->Confessional_Curtain.Question(false)

        *[Leave the booth]
        #PLAY: curtain
        You don't care to find out and quickly leave the booth. You stare at the confessional. It's quiet. You're not sure what's in there, but you do know that you don't want to speak to it.
        
        There was nothing in there, anyway. You should look for the heart elsewhere for now.
        ->Confessional_Curtain.Leave_NoProgress
}

= Question(replace)
#DELAY: 1.5
You frown, "No, that's not what-"

"I do not have all day, and there are others waiting their turn." The voice cuts you off. "So this is the last time I'll ask you this: What. Do. You. Wish. To. Confess?"

You don't think you will get an answer. The voice is pushing you to confess.

You take a deep breath. You need to confess something? Fine. {stay < 1: He never said you have to say anything useful. You'll say enough to satisfy him and then push for more answers. | It might help you get some things off your chest. This could be... theraputic. You can push for answers later. }
{
    - confessional_door_side:
        
        {
            - replace:
                *[I am a pastor here,]
                    ->Confessional_Curtain.Know_Father
            - else: 
                *[As a man of cloth,]
                ->Confessional_Curtain.Know_Father
        }
        
}

*[Talk about work]
    -> Confessional_Curtain.Work_Confession
*[Talk about something personal]
    -> Confessional_Curtain.Personal_Confession
*[Talk about nothing]
    -> Confessional_Curtain.No_Confession
            
* {stay < 1} [Leave the booth]
You need to confess something? No. No, you won't play along. For all you know this is another attempt by the church to get you to stay.

#PLAY: curtain
You swiftly leave the booth, and stare at the confessional. It's quiet. Whatever is in there, it won't tell you anything important. And you don't like that it was pushing you to "confess."
    
There was nothing in there, anyway. You should look for the heart elsewhere for now. 
->Confessional_Curtain.Leave_NoProgress

= Work_Confession
~ temp Temp_String = ""
TODO: add more fired and walk out work things
{
    - work == 1:
        ~Temp_String = "\"I sent multiple wrong copies to a department. I only realized when a coworker called me out. She seemed worried about me, but... I don't know.\""
    - work == 2:
        ~Temp_String = "\"I think I was fired.\" You laugh. \"I sent a nonsense email to our biggest client and they were very upset. My supervisor was really, really mad at me.\""
    - else:
        ~Temp_String = "\"A coworker was trying to help me today, but I pushed him away.\""
}


"Today was awful. I was never the best worker at my job, but today was particularly bad." You trace the wooden grooves of the wall with your finger. {stay < 1: You wince at the memory, but keep your voice steady. | The words feel stuck in your throat as you recall your day. }

{Temp_String}

#PLAY: liquid-drop #DELAY: 1.5
<i>Plink!</i>

#DELAY: 3
The voice is silent. You squirm uncomfortably in your seat. {stay < 1: You press your lips firmly together.} 

#DELAY: 2
{stay < 1: You want to keep silent, but the silence feels too loud. | What you say next seems to just tumble out.}


{ - stay < 1: 
    #DELAY: 3
    You need to say something. There's an itch caught in your throat, begging you to speak. You bite your lip.
}

{ - stay < 1: 
    #DELAY: 3
    What you say next seems to just tumble out.
}

{
    - work == 1:
        "I— We rarely talk, but her concern felt so foreign. I didn't know what to do with it, so I just... I just left."
        ~Temp_String = "often ignore or push away the ones who reach out first?\""
    - work == 2:
        "My supervisor has always looked out for me even though I never meet their standards. I think this was the straw that broke the camel's back." You fidgit with your nail. "The look they gave me..."
        ~Temp_String = "think you did all you could?\""
    - else:
        "I had never spoken to him before— I— I mainly keep to myself at work. I didn't know how to handle his help, so... I pushed him away and left. He wasn't too happy with me."
        ~Temp_String = "often ignore or push away the ones who reach out first?\""
}

#PLAY: liquid-drop #PLAY: 2, liquid-drop #DELAY: 2.5
<i>Plink! Plink!</i>

"I see..." The voice is quiet for a moment before continuing, "Do you {Temp_String}

~ temp Temp_Bool = false

*[Agree]
~Temp_Bool = true

*[Disagree] 
~Temp_Bool = false

- 

{
    - Temp_Bool:
        #DELAY: 1
        You nod. Your chest is tight.
        
        #PLAY: liquid-drop #PLAY: 2, liquid-drop #DELAY: 1.5
        <i>Plink! Plink!</i>
        
        {
            - work == 1 or work == 3:
                "Do you feel unworthy of their concern?"
                ~Temp_String = "feel this way?"
            - else:
                "And you work hard anyway?"
                ~Temp_String = "do that?"
        }
    
    - else:
        {
            - work == 1 or work == 2:
                ~Temp_String = "small talk in the kitchen. How your coworkers offer to let you join them for lunch, but you always turn them down. How you don't have many, if any, work friends. How anyone who reaches out first is met with a swift denial."
            - else:
                ~Temp_String = "overlooked promotions. When you finally felt you proved yourself on a project, and your efforts were met with a pat on the back. How even after pushing the issue, your emails didn't get a response. How no matter what you did, how hard you worked, you got nothing in return."
        }
        
        You shake your head. "I can't say that's the case. Today was—"

        "A fluke? A one off? {work == 2: You were <i>fired</i> over it.}" The voice sneers. "Are you so sure about that?"

        You flinch at it's tone,{stay < 1: and grip the bench. Was that because you disagreed with it? | and look at your shoes. Did you say something wrong? You mumble an apology and kick the floor.}
        
        "I'm not scolding you." The voice softens, and {stay < 1: you lessen your grip. Maybe you were overreacting? | some of your anxiety alleviates. You sit up a little straighter. } "But can you really say this was a one off event?" 
        
        You think back to {Temp_String}
}

*[Agree]
    {
        - Temp_Bool: //agreed last time
            #DELAY: 1
            You hesitate, but nod. Why? Why do you {Temp_String} What's the point?
        - else: //disagreed last time
            You hesitate, but slowly, shake your head. The more you think, the more realize the voice is right.
        
    }
    ~Temp_Bool = true

*[Disagree]
    {
        - Temp_Bool: //agreed last time
            {
                - work == 1 or work == 3:
                   ~Temp_String = "Unworthy is a strong word. Can anyone be unworthy of another's time?"
                - else:
                   ~Temp_String = "You think you do, but at the same time..."
            }
            #DELAY: 1
            You hesitate. Do you? {Temp_String}
        - else: //disagreed last time
            {
                - work == 1 or work == 2:
                    ~Temp_String = "<i>You</i> choose to push people away. It's not their fault if they decide to stop when all you do is push them away."
                - else:
                    ~Temp_String = "A job is just that. A job. They may not value you the way you wish they would, but maybe it's time to look for one that does."
            }
            It makes you angry, the way they treat you, but... {Temp_String} 
        
    }
    ~Temp_Bool = false

- 

{
    - Temp_Bool: //agreed last time
        #PLAY: liquid-drop #DELAY: 1.5
        <i>Plink!</i> The bucket is half full.

        "I understand. Do you feel a sense of relief now?" You do. You feel a little lighter after someone saying it out loud. "Knowing you don't have to go back to that?"

        Your stomach drops.
        
        *["What?"]
        ->Confessional_Curtain.Middle

        *["I don't...?"]
        ->Confessional_Curtain.Middle
    
    - else: //disagreed last time
        "I don't think—"
        
        The voice cuts you off. "From what you told me, you are <i>miserable</i> out there!" The voice is loud, and you jump in your seat. "The church has so much to offer you. And you are <i>here</i> now, safe in the church's embrace. You <i>are</i> happier here, yes?"
        
        #DELAY: 1.5
        Safe? Happy? You think about everything you've experienced up til now. {leave_light: Of the warmth you've felt.} {know: Of your polaroid sitting in pieces in your desk. You | You touch the pocket that holds the pieces of your polaroid, and }look at the ceiling of the booth. {stay < 1: You chuckle to yourself. Is this what safety feels like? Happiness? | Is this any better or worse than your day to day? You're not sure how to feel.}
    
        #PLAY: liquid-drop #DELAY: 1.5 #REPLACE: liquid
        <i>Plink!</i> The bucket is filling fast. You can see that the [liquid] seems... thicker than just water.
        
        *[liquid]
            ->Confessional_Curtain.liquid
        
        *{stay < 1} ["I don't want to be here."]
            The rapid drips from the leak stop. "You must be mistaken." The voice laughs, an angry and cruel laugh. "You <i>do</i> want to be here. You're just a bit confu—"
            ->Confessional_Curtain.Reject("how am I confused?")
    
        *[Stay silent.]
            ->Confessional_Curtain.Agree
}

= liquid
You look closer. The liquid in the bucket is slightly viscous. It looks almost like—

"Well?" The voice is growing impatient. You tense. "You are happier here, yes?"

*["Maybe..."]
->Confessional_Curtain.Agree

*{stay < 1} ["I don't want to be here."]
The rapid drips from the leak stop. "You must be mistaken." The voice laughs, an angry and cruel laugh. "You <i>do</i> want to be here. You're just a bit confu-"
->Confessional_Curtain.Reject("how am I confused?")

*["I don't know.]
->Confessional_Curtain.Agree

= Middle
#PLAY: liquid-drop #DELAY: 1.5
<i>Plink!</i>

{
    - work == 1 or work == 3:
        "You say you are not worthy of the concern of others. You keep to yourself, so your work." The voice is gentle. "But you are here now, safe in the church's embrace. You <i>are</i> happier here, yes?"
    - else:
        "You don't think you could have done better, that you worked harder to make up for it. And yet, your efforts fell to deaf ears." The voice is gentle. "But you are here now, safe in the church's embrace. You <i>are</i> happier here, yes?"
}

#PLAY: liquid-drop #DELAY: 1.5
<i>Plink!</i>

#REPLACE: liquid
The bucket is filling fast. You can see that the [liquid] seems... thicker than just water.

*[liquid]
    ->Confessional_Curtain.liquid
    
* {stay < 1} ["I don't want to be here."]
    The rapid drips from the leak stop. "You must be mistaken." The voice laughs, an angry and cruel laugh. "You <i>do</i> want to be here. You're just a bit confu-"
    ->Confessional_Curtain.Reject("how am I confused?")

*[Stay silent.]
    ->Confessional_Curtain.Agree

= Reject(reason)
"{avoid_church: When I tried to avoid the church, it pulled me back.} {leave_light: When I rejected it's sight, it burned me.} {object != "": When I tried to escape, it <i>taunted</i> me with a {object}.}When I wanted to <i>leave</i> the church <i>would not let me."</i> You clench your fists. "So tell me, {reason}"

*[The voice is silent.]

- 
~ angered_priest = true
#CLASS: Bang_Confessional #PLAY: bang_confessional #DELAY: 0.5
Bang!

The wood divider splinters as <strike>the priest</strike> whatever is on the other side slams into it. "HOW could you be so IGNORANT? So UNGRATEFUL? SO STUPID?" The calm softness <strike>he</strike>it used to speak to you before is gone. It's voice contorts and stretches as it changes from something human to something gutteral and monsterous.

The bucket tips over, and the liquid spills out. It sticks to your shoes, much thicker than water.

*[Is that... saliva?]

- #CLASS: Bang_Confessional #PLAY: bang_confessional #DELAY: 0.5
Bang!

"It only want to HELP you. It LET you go, to SHOW you that. How UN-GRATE-FUL." With enery syllable it slams into the wood. The grate it has been talking through falls onto your side of the confessional. It's voice screeches. "STUPID STUPID STUPID STUPID!"

The booth could come apart at any moment. You need to get out of here.

*[Get out of the confessional]
    -> Confessional_Curtain.Get_Out

*[Look into the other side]
    -> Confessional_Curtain.Look_Other_Side

= Get_Out
#CLASS: Bang_Confessional #PLAY: bang_confessional #DELAY: 0.5
Bang!

You cover your face as tiny, stinging, wooden splinters fly toward you. You need to get OUT, before that... that THING gets IN.

You {leg == "worst": hobble through the curtain as fast as you can | rush through the curtain}, and turn to see the confessional shuttering under whatever inside continues banging on the walls.
~ temp Temp_Bool = false
~ temp Temp_String = ""

*[Open the confessional door]
    ~ Temp_Bool = true

*[Wait until it stops]
    ~ Temp_Bool = false

- 
#CLASS: Bang_Confessional #PLAY: bang_confessional #DELAY: 0.5
Bang!


{

- Temp_Bool:
    Carefully, you approach the door. Whatever is inside has started to wail and scream. You place your hand on the knob.
    
    { stay >= 1: There's an unwanted pang in your heart as you listen to cry and beg.} You steel yourself, ready to face wahtever lies on the otherside.

    ~Temp_String = "Turn the handle"
- else:
    You stand outside the confessional, waiting for whatever's inside to stop. Whatever is inside has continues to scream and curse at you. <i>How STUPID! How UNGRATEFUL!</i>

    The words echo throughout the space. You ignore it, and wait. 
    
    After a few moments, the screams turn to wails, to low moans, to quiet sobs. It begs you to reconsider. Begs you to understand.
    
    { stay >= 1: There's an unwanted pang in your heart as you listen to cry and beg. You dig your nails into your palms and stare at the floor. | You continue to ignore. Whatever is inside is made of the church. It would say anything to hurt you. To make you stay.}
    
    ~Temp_String = "Eventually it goes quiet"
}

*[{Temp_String}]

- Inside, the booth is empty, and pristine. The divider is not splintered, and the separating grate is back in place. It looks almost identical to the side you had been on. 

On the bench sits a small key. { stay >= 1: You pick it up and turn it over in your hands. Was this a gift? {Temp_Bool: | A peace offering from the creature that had once been here? } | You pick it up, and shove it in your pocket, hoping it will be useful later. You wonder why the church gave it to you. What it means that it gave you something possibly valuable. } You offer the confessional one last look, pondering the key's meaning.

*[Return to your search]
    -> Confessional_Curtain.Leave_Progress

= Look_Other_Side
#CLASS: Bang_Confessional #PLAY: bang_confessional #DELAY: 0.5
Bang!

You cover your face as wooden splinters fly toward you as tiny, stinging flecks of wood. You take a step closer to the hole in the divider. You raise your flashlight, and peer through the hole.

*[Turn on the flashlight]

- 
#PLAY: click-on #EFFECT: flashlight_on
The flash light clicks on, and everything stops.

The other side is pristine. It looks almost identical to the side you had been on. No one is inside.

On the bench sits a small key. 

*[Reach your arm through]
    ~ reached_through = true
    #PLAY: click-off #EFFECT: flashlight_off
    You place the flashlight back in your pocket, and reach your arm through. blindly feeling around.  Your fingertips just barely brush the bench it's sitting on. 

    You reach in deeper, your face pressing against the mangled wood. "Just a bit... more..." you mumble to yourself.
    
    Your fingers brush against the key again when a cold hand grabs your arm. You jerk away, but it holds tight, fingers digging into your wrist.

    "The more you fight, the sweeter the meal you will be." The gruff voice from earlier growls. It's scratchy and low. "Don't mistake this for kindness."

    Something cold and metal is pressed into your palm, and you're released. You yank your arm back through the opening, falling into the opposite side. Your arm throbs where the thing grabbed you. In your hand is the key.
    
    The booth is quiet, save for your own breathing. You place the key in your pocket.
*[Go around]
    #PLAY: click-off #EFFECT: flashlight_off
    You exit through the curtain, face the priest's door. You take a deep breath, and open it. The key sits on the bench, but more surprisingly, the divider is no longer splintered, and the separating grate is back in place.

    The church fixed itself. 
    
    You hesitate before stepping inside, quickly grabing the key and leaving the booth. You shove the key in your pocket, hoping it will be useful later.

- 
*[Return to your search]
    -> Confessional_Curtain.Leave_Progress

= Agree
~ stay += 0.5
You work everyday and for what?" 

#PLAY: liquid-drop #PLAY: 1, liquid-drop #PLAY: 1, liquid-drop #DELAY: 1.5
<i>Plink! Plink! Plink!</i>

The words get stuck in your throat{stay < 1:, but you're not sure why}.

#PLAY: liquid-drop #PLAY: 1, liquid-drop #PLAY: 1, liquid-drop #DELAY: 1.5
<i>Plink! Plink! Plink!</i>

"The church can feel... perplexing... at first, but it doesn't bring you here without reason. It wants to help- to heal the harm dealt to you out <i>there."</i> The voice is calming. It makes sense. Why else would you be here? "The church would never hurt you. Could never hurt you."

#PLAY: liquid-drop #PLAY: 1, liquid-drop #PLAY: 1, liquid-drop
<i>Plink! Plink! Plink!</i>

You clench and unclench your hands. {know or leave_light or object != "": You know shouldn't listen. You know its... it's another trick. After everything, you know this, but... | The voice is making sense. You were scared and rejected anything the church offered you. Maybe if you hadn't rejected it so strongly then... }

*["Maybe you're right..."]

* {stay <= 1} ["No..."]
    {know or leave_light: You need to stay strong. You didn't come here of your own will. You've wanted to leave from the start. | You shake the thought from your head. You can't let the voice's sweet words poison your mind.}
    
    The rapid drips from the leak stop. "You must be mistaken." The voice laughs, an angry and cruel laugh. "You <i>do</i> want to be here. You're just a bit confu-"
    ->Confessional_Curtain.Reject("how am I confused?")

-

#PLAY: liquid-drop #PLAY: 1, liquid-drop #PLAY: 1, liquid-drop #DELAY: 1.5
<i>Plink! Plink! Plink!</i>

The leak is dripping faster now. The bucket is spilling over. The viscous liquid contains small bubbles as it crawls over the floor. 

"Stop fighting. Has the church harmed you?" 

{
    - leave_light:
        *[The church was angry..."]
            "It screamed at me. It— It burned me..." You shutter at the memory. 
            
            The rapid drips from the leak stop. "Angry...?" The voice laughs. "You must just be <i>confused</i>. The church would never—"
            
            {stay <= 1: A sudden surge of anger coursed through you. Confused? How were you just confused when— | You shake your head in disbelief. }
        ->Confessional_Curtain.Reject("how am I confused?")
}

*["No.."]

*["When it brought me here..."]

- ~stay += 1
"When it brought you here, that must have been frightening. Change always is."

You nod.

#PLAY: liquid-drop #PLAY: 1, liquid-drop #PLAY: 1, liquid-drop #DELAY: 1.5
<i>Plink! Plink! Plink!</i>

The liquid crawls towards your shoes. You don't think it's water at all. 

"I am sorry for your, ah, <i>ill understanding</i>, but all the church wants is to give you more than the world out there." You nod. "The church only wants the best for you. So, just. Stop. Fighting."

*[You nod]

- #PLAY: key-thrown
<i>Plunk!</i>

A small key falls into the bucket, causing the bucket to fall over, and the liquid to spill onto the floor. You lift your feet to avoid your shoes from soaking through, and the liquid stretches like you stepped in gum. Is this...? You gag.

"A gift for you. An olive branch of sorts." You hear shuffling, then the door close, and you know you are alone.

*[Pick up the key]

- You grab it out of the pool of liquid. It's sticky and thick, almost like... Your stomach churns. Saliva?

You wipe the key off using the confessional curtain, and stick it in your pocket. You look at the grate the voice spoke to you through. 

You wonder if you'll meet him again.

*[Return to your search]
    -> Confessional_Curtain.Leave_Progress

= Personal_Confession
"I..." You don't know what to say.  The voice is patient.

*[Talk about lack of motivation]
    ~temp_bool = true
    -> Confessional_Curtain.Motivation

*[Talk about doing too much]
    ~temp_bool = false
    -> Confessional_Curtain.Too_much

= Motivation
"I have no drive to do... anything. Even the things I want to do." You tap your fingers against the cold, wood bench. "I pick up a hobby only to drop it after a week. I <i>want</i> to do things, but..."

#PLAY: liquid-drop #DELAY: 1.5
<i>Plink!</i>

The voice is silent.

*[Fill the silence.]
    "And I just... I just want to <i>finish</i> something, you know? To finally be done. It feels impossible." You let out a deep sigh. The words tumble out. "Nothing can hold my attention long enough for me to call it "complete," so I just move onto the next thing that catches my eye. Hoping that this time. <i>This time</i> things will be different."
    
    #PLAY: liquid-drop #PLAY: 1, liquid-drop #PLAY: 1, liquid-drop #DELAY: 1.5
    <i>Plink! Plink! Plink!</i>
    
    #DELAY: 2
    "I see..." The voice is quiet. 
    
    #DELAY: 3
    The silence is suffocating. 
    
    The voice finally continues, and you can breathe again. "So you are picking these up projects to make up for your inadequacy? You take as many as you can get so failure to finish is inevitable?"
    
    **[Agree] 
        You don't answer. You're inadequate? It's all inevitable? You bite you lip.

        #PLAY: liquid-drop #PLAY: 1, liquid-drop #PLAY: 1, liquid-drop #DELAY: 1.5
        <i>Plink! Plink! Plink!</i>
    
        "I think you are sabotaging yourself on purpose." The voice is gentle. Soft. " Something, out <i>there</i> is making you this way. So aren't you so glad you can stay?"
        
        -> Confessional_Curtain.TooMuch_Choice
    
    **[Disagree]
        #DELAY: 0.5
        You shake your head. "It's not that I'm—"
    
        #PLAY: liquid-drop #DELAY: 1.5
        <i>Pl....in.....k!</i>
        
        "This is not an attack on you." The voice cuts you off. "But more of an observation from the outside looking in."
        
        You sit with that knowledge. Is that how others see you? You feel smaller.
        
        ***[Agree]
            "There is a silver lining to all this." 
            
            You perk up immediately at it's words.
            -> Confessional_Curtain.Personal_End
        
        ***[Disagree]
            Not an attack? Just an observation? Does this "observation" have to be so cruel? "I don't think that—"
    
            It cuts you off again.
    
            "I think you are sabotaging yourself on purpose." The voice is stern, and cold. "Something, out <i>there</i> is making you this way. So aren't you so glad you can stay?"
            -> Confessional_Curtain.TooMuch_Choice

* {stay <= 1} [Wait]
    -> Confessional_Curtain.Wait_Personal

= Too_much
"I somehow am doing too much all the damn time." You stare up at the ceiling, focusing on a cobweb. "I can't commit to anything to completion, but I also can't stop picking up more things to do."

#PLAY: liquid-drop #DELAY: 1.5
<i>Plink!</i>

The voice is silent.

*[Fill the silence.]
        "And I just... I just want to <i>finish</i> something, you know? To finally be done. It feels impossible." You let out a deep sigh. The words tumble out. "Nothing can hold my attention long enough for me to call it "complete," so I just move onto the next thing that catches my eye. Hoping that this time. <i>This time</i> things will be different."
        ->Confessional_Curtain.Personal_TooMuch
{
    - stay <= 1:
        *[Wait]
        -> Confessional_Curtain.Wait_Personal
}

= Wait_Personal
*[Fill the silence.]
{
    - temp_bool:
        "And I just... I just want to <i>finish</i> something, you know? To finally be done. It feels impossible." You let out a deep sigh. The words tumble out. "Nothing can hold my attention long enough for me to call it "complete," so I just move onto the next thing that catches my eye. Hoping that this time. <i>This time</i> things will be different."
        ->Confessional_Curtain.Personal_TooMuch
    - else:
        "I want to do more, really I do." You let out a deep sigh. "But I just... can't..."
        ->Confessional_Curtain.Personal_Motivation
}

*[Continue waiting]
~stubborn = true

- Finally, the voice breaks the silence.

"You are more... stubborn than expected." The voice spits out the words. "But I can wait for as long as you need. I have <i>all</i> the time in the world."

Your skin crawls. The silence returns.

*[Fill the silence.]
{
    - temp_bool:
        "And I just... I just want to <i>finish</i> something, you know? To finally be done. It feels impossible." You let out a deep sigh. The words tumble out. "Nothing can hold my attention long enough for me to call it "complete," so I just move onto the next thing that catches my eye. Hoping that this time. <i>This time</i> things will be different."
        ->Confessional_Curtain.Personal_TooMuch
    - else:
        "I want to do more, really I do." You let out a deep sigh. "But I just... can't..."
        ->Confessional_Curtain.Personal_Motivation
}

*[Leave the booth]
    #PLAY: curtain
    You stand and leave the booth. You stare at the confessional. It's quiet. You're not sure what's in there, but you're at a stalemate with whatever was on the other side. If you're not going to talk, there's no reason to stick around.
        
    You should look for the heart elsewhere for now.
    ->Confessional_Curtain.Leave_NoProgress

= Personal_Motivation
#PLAY: liquid-drop #PLAY: 1, liquid-drop #PLAY: 1, liquid-drop #DELAY: 1.5
<i>Plink! Plink! Plink!</i>

"I see..." The voice was quiet for a moment before continuing, "Perhaps there's another reason for this? Is work too draining?"

*[Agree] 
    You feel yourself nodding. After work all you want to do is sleep. How is that you're fault?

    #PLAY: liquid-drop #PLAY: 1, liquid-drop #PLAY: 1, liquid-drop #DELAY: 1.5
    <i>Plink! Plink! Plink!</i>

    "It's not your fault that the outside world is unsympathetic." The voice is gentle. Soft. "So aren't you so glad you can stay?"

    -> Confessional_Curtain.TooMuch_Choice

*[Disagree] 
    "Maybe..." You chew on the voice's words. "Or maybe it's—"

    #PLAY: liquid-drop #DELAY: 1.5
    <i>Pl....in.....k!</i>

    "This is not an attack on you." The voice cuts you off. "But more of an observation from the outside looking in."

    You sit with that knowledge. Is that how others see you? You feel smaller.
        
    **[Agree]
        "There is a silver lining to all this." 
            
        You perk up immediately at it's words.
        -> Confessional_Curtain.Personal_End
    
    **[Disagree]
        Not an attack? Just an observation? Does this "observation" have to be so cruel? "I don't think that—"
    
        It cuts you off again.
    
        "I think you are sabotaging yourself on purpose." The voice is stern, and cold. "Something, out <i>there</i> is making you this way. So aren't you so glad you can stay?"
        -> Confessional_Curtain.TooMuch_Choice

= Personal_TooMuch

#PLAY: liquid-drop #PLAY: 1, liquid-drop #PLAY: 1, liquid-drop #DELAY: 1.5
<i>Plink! Plink! Plink!</i>

#DELAY: 2
"I see..." The voice is quiet. 

#DELAY: 3
The silence is suffocating. 

The voice finally continues, and you can breathe again. "So you are picking these up projects to make up for your inadequacy? You take as many as you can get so failure to finish is inevitable?"

*[Agree] 
    You don't answer. You're inadequate? It's all inevitable? You bite you lip.

    #PLAY: liquid-drop #PLAY: 1, liquid-drop #PLAY: 1, liquid-drop #DELAY: 1.5
    <i>Plink! Plink! Plink!</i>

    "I think you are sabotaging yourself on purpose." The voice is gentle. Soft. " Something, out <i>there</i> is making you this way. So aren't you so glad you can stay?"
    
    -> Confessional_Curtain.TooMuch_Choice

*[Disagree]
    #DELAY: 0.5
    You shake your head. "It's not that I'm—"
    
    #PLAY: liquid-drop #DELAY: 1.5
    <i>Pl....in.....k!</i>
    
    "This is not an attack on you." The voice cuts you off. "But more of an observation from the outside looking in."
    
    You sit with that knowledge. Is that how others see you? You feel smaller.
    
    **[Agree]
        "There is a silver lining to all this." 
        
        You perk up immediately at it's words.
        -> Confessional_Curtain.Personal_End
    
    **[Disagree]
        Not an attack? Just an observation? Does this "observation" have to be so cruel? "I don't think that—"

        It cuts you off again.

        "I think you are sabotaging yourself on purpose." The voice is stern, and cold. "Something, out <i>there</i> is making you this way. So aren't you so glad you can stay?"
        -> Confessional_Curtain.TooMuch_Choice  

= TooMuch_Choice
*[Nod]
    ~stay += 1
    You find yourself nodding. You are glad. You can stay and have all the time in the world. You can do it all, so long as you get to stay.
    -> Confessional_Curtain.Personal_End

*[Remain silent.]
    ~stay += 0.5
    You say nothing, the voice's words rolling around in your mind. It's... tempting. If the voice is right....
    -> Confessional_Curtain.Personal_End
        
*["Stay?"]

- 
#DELAY: 0.5
"What?" You're suddenly on edge. "Stay?"
        
#PLAY: liquid-drop 
<i>Pl....in.....k!</i>
        
The last water drop is much slower than the rest, the bucket almost full. You can see that the [liquid] seems... thicker than just water.
        
"Of course." The voice changes. "You'll have all the time in the world here. Doesn't that sound grand?"
        
*[liquid]
    ->Confessional_Curtain.liquid_2
    
*["No."]
    The drips from the leak stop. "No...?" The voice scoffts at you. "What do you mean, no?"
    ->Confessional_Curtain.Reject("what is so <i>grand</i> about that?")
    
*["I don't want to be here."]
    The rapid drips from the leak stop. "You must be mistaken." The voice laughs, an angry and cruel laugh. "You <i>do</i> want to be here. You're just a bit confu-"
    ->Confessional_Curtain.Reject("how am I confused?")
    
*[Remain silent.]
    ~stay += 0.5
    You say nothing, the voice's words rolling around in your mind. It's... tempting. If the voice is right....
    -> Confessional_Curtain.Personal_End

= Personal_End
#PLAY: liquid-drop #PLAY: 1, liquid-drop #PLAY: 1, liquid-drop #DELAY: 1.5
<i>Plink! Plink! Plink!</i>

The bucket is filling fast. You can see the [liquid] seems... thicker than just water.

"You'll have all the time in the world here. All you have to do is stay!" The voice is excited. "Doesn't that sound grand?" 

* [liquid]
    ->Confessional_Curtain.liquid_2

*["You're right..."]
    The voice is making sense. Imagine what you could do if...
    ->Confessional_Curtain.End_Confessional

*["No."]
    The drips from the leak stop. "No...?" The voice scoffts at you. "What do you mean, no?"
    ->Confessional_Curtain.Reject("what is so <i>grand</i> about that?")

= liquid_2 
You look closer. The liquid in the bucket is slightly viscous. It looks almost like—

"Well?" The voice is growing impatient.

*["You're right..."]
-> Confessional_Curtain.End_Confessional

*{stay < 1} ["I don't want to be here."]
    The rapid drips from the leak stop. "You must be mistaken." The voice laughs, an angry and cruel laugh. "You <i>do</i> want to be here. You're just a bit confu—"
    ->Confessional_Curtain.Reject("what is so <i>grand</i> about that?")

= No_Confession
~ temp Temp_Bool = false
#DELAY: 1
"Nothing. I have nothing to confess."

#PLAY: liquid-drop
<i>Plink!</i>

#DELAY: 1
"Nothing at all?" The voice on the other side chuckles. "Nothing at work? At home? You haven't hurt anyone? Done anything wrong?"

#PLAY: liquid-drop
<i>Plink!</i>

You hesitate before answering.

*["No."]
    The voice says nothing.
    
    **[Fill the silence.]
        "I wake up, go to work, come home, watch TV while eating dinner, and go to bed." You wring your hands together, suddenly embarrassed. "It's a routine. There's nothing to tell."
        ->Confessional_Curtain.No_Talk
    
    **{stay <= 1}[Wait]
        -> Confessional_Curtain.Wait

*[Recall a work event.]
    "Well, work is..." You wring your hands together, embarrassed. "It's a routine. There's nothing to tell...."
    
    "You don't sound very sure." The voice presses. "Nothing leaves this conversation. You can trust me."
    ~Temp_Bool = true

*[Recall a personal event.]
    "Life is..." You wring your hands together, embarrassed. "It's boring. There's not much to tell..."
    
    "You don't sound very sure." The voice presses. "Nothing leaves this conversation. You can trust me."
    ~Temp_Bool = false

- 

*[Talk about it]
    {
        - Temp_Bool:
            ->Confessional_Curtain.Work_Confession
        - else:
            ->Confessional_Curtain.Personal_Confession
    }
*[Don't talk about it]
    "No, nothing to tell. My life is a routine, and work is no different." You tap your fingers against the bench. "I wake up, go to work, come home, watch TV while eating dinner, and go to bed." 
    ->Confessional_Curtain.No_Talk

= Wait
You squirm uncomfortably in your seat. The quiet seems deafening. 

*[Fill the silence.]
    "I wake up, go to work, come home, watch TV while eating dinner, and go to bed." You wring your hands together, suddenly embarrassed. "It's a routine. There's nothing to tell."
    ->Confessional_Curtain.No_Talk

*[Continue waiting]
    ~stubborn = true
- Finally, the voice breaks the silence.

"You are more... stubborn than expected." The voice spits out the words. "But I can wait for as long as you need. I have <i>all</i> the time in the world."

    Your skin crawls. The silence returns.

*[Fill the silence.]
    "I wake up, go to work, come home, watch TV while eating dinner, and go to bed." You wring your hands together, suddenly embarrassed. "It's a routine. There's nothing to tell."
    ->Confessional_Curtain.No_Talk

*[Leave the booth]
    #PLAY: curtain
    You stand and leave the booth. You stare at the confessional. It's quiet. You're not sure what's in there, but you're at a stalemate with whatever was on the other side. If you're not going to talk, there's no reason to stick around.
        
    You should look for the heart elsewhere for now. You look...
    ->Confessional_Curtain.Leave_NoProgress
    
    

= No_Talk
~ temp Temp_String = ""
~ temp Temp_Bool = false
#PLAY: liquid-drop
<i>Plink!</i>

"A routine..." The voice trails off. "Would you say you become bored of this? That you wish for more than what you have?"

*[Agree]
    ~ Temp_Bool = true
    #DELAY: 1
    You feel yourself nodding. "I... My job is a means to an end. It's enought to keep me alive, but not enough to... do more..."
    
    #PLAY: liquid-drop #DELAY: 1.5
    <i>Plink!</i>
    
    "I see. So why {stay <= 1:do you fight it | don't you stay} then?"

*[Disagree]
    ~ Temp_Bool = false
    #DELAY: 1
    You feel yourself nodding. "I... My job is a means to an end. It's enought to keep me alive, but not enough to... do more..."
        
    #PLAY: liquid-drop #DELAY: 1.5
    <i>Plink!</i>
        
    "I see. So why {stay <= 1:do you fight it | don't you stay} then?"

- 

*["What?"]

*[Stay silent.]

- #PLAY: liquid-drop #DELAY: 1.5
<i>Plink!</i>


{
- Temp_Bool:
    "You complain of routine. You wish for more." The voice becomes softer as it speaks. "So <i>why</i> {stay <= 1: fight it? | don't you stay stay? } Choose the church."
    
- else:
    What is it talking about? {stay <= 1.5: Of course you fight the church. You want to <i>leave.</i> | Stay? When have you ever wished to...}

    "You can say you're content with your life <i>out there,</i> but we both know you want to stay <i>here"</i> The voice becomes harder as it speaks. "The church has so much to offer you, you know this. {stay <= 1.5: So, why is it you fight the church? | So why are you <i>fighting</i> to leave?}"

    #PLAY: liquid-drop #PLAY: 1, liquid-drop #PLAY: 1, liquid-drop #DELAY: 1.5
    <i>Plink! Plink! Plink!</i>

}

*["I don't know."]
    ~Temp_String = "I don't know..."

* {stay <= 1} ["I don't want to be here."]
    The rapid drips from the leak stop. "Hm...?" The voice laughs. "You think that now, but just wait—"
    ->Confessional_Curtain.Reject("how am I confused?")

*[Stay silent.]
~Temp_String = "..."
"Quiet, are we?" the voice chuckles.

You squirm in your seat. Clenching and unclenching your fists.

- #DELAY: 1
"Your life is a routine. A boring, worthless routine." You flinch at the words. "You struggle everyday and for what?"

#PLAY: liquid-drop #PLAY: 1, liquid-drop #PLAY: 1, liquid-drop #DELAY: 1.5
<i>Plink! Plink! Plink!</i>

#DELAY: 2
"{Temp_String}"

#PLAY: liquid-drop #PLAY: 1, liquid-drop #PLAY: 1, liquid-drop #DELAY: 1.5
<i>Plink! Plink! Plink!</i>

"The church is scary at first, but all change is. The church doesn't bring you here without reason." The voice is calming. It makes sense. Why else would you be here? "It would never hurt you."

*["Maybe you are right..."]

*["No..."]
    The rapid drips from the leak stop. "You must be mistaken." The voice laughs, an angry and cruel laugh. "You <i>do</i> want to be here. You're just a bit confu—"
    ->Confessional_Curtain.Reject("how am I confused?")

- The leak is dripping faster now. The bucket is spilling over. The viscous liquid contains small bubbles as it crawls over the floor.

"Tell me, has the church ever harmed you?" the voice envelops you. Has the church harmed you? You find yourself doubting your memory. "Hmm?"

"I..."

{
    - leave_light:
    *[The church was angry..."]
        "It screamed at me. It— It burned me..." You shutter at the memory. 
        
        The rapid drips from the leak stop. "Angry...?" The voice laughs. "You must just be <i>confused</i>. The church would never—"
            
        {stay <= 1: A sudden surge of anger coursed through you. Confused? How were you just confused when— | You shake your head in disbelief. }
        ->Confessional_Curtain.Reject("how am I confused?")
}

*["No.."]

*["When it brought me here..."]

- -> Confessional_Curtain.End_Confessional

= End_Confessional
"When it brought you here, that must have been frightening. Change always is."

You nod.

#PLAY: liquid-drop #PLAY: 1, liquid-drop #PLAY: 1, liquid-drop #DELAY: 1.5
<i>Plink! Plink! Plink!</i>

The liquid crawls towards your shoes. You don't think it's water at all. 

"All the church wants is to give you more than the world out there." You nod. "The church only wants the best for you. So, just. Stop. Fighting. It."

*You nod.

- 

#PLAY: key-thrown
<i>Plunk!</i>

A small key falls into the bucket, causing the bucket to fall over, and the liquid to spill onto the floor. You lift your feet to avoid your shoes from soaking through, and the liquid stretches like you stepped in gum. Is this...? You gag.

"A gift for you. An olive branch of sorts." You hear the door close, and you know you are alone.

*[Pick up the key]

- You grab it out of the pool of liquid. It's sticky and thick, almost like... Your stomach churns. Saliva?

You wipe the key off using the confessional curtain, and stick it in your pocket. You look at the grate the voice spoke to you through. 

You wonder if you'll meet it again.

*[Return to your search]
    -> Confessional_Curtain.Leave_Progress

= Know_Father
~ church_anger += 0.5
Something clicks into place. "I... know who you are..."

"Do you now?" he laughs coldly.

"You're the father of—"

"The church. I do not have all day, and there are others waiting their turn." His voice is short and strained. "So this is the last time I'll ask you this: What. Do. You. Wish. To. Confess?"

#REPLACE: push the matter
You frown, "No, that's not what—" A gutter growl cuts you off. You don't think you should [push the matter]. The voice is pushing you to confess, maybe you can learn more if you play along?

You take a deep breath. You need to confess something? Fine. {stay < 1: He never said you have to say anything useful. You'll say enough to satisfy him and then push for more answers. | It might help you get some things off your chest. This could be... theraputic. You can push for answers later. }

*[push the matter]

*[Talk about work]
    -> Confessional_Curtain.Work_Confession
*[Talk about something personal]
    -> Confessional_Curtain.Personal_Confession
*[Talk about nothing]
    -> Confessional_Curtain.No_Confession

*[Leave the booth]
    #PLAY: curtain
    Without a second thought, you rush out of the booth. You stare at the confessional. It's quiet. You're not sure what's in there, but you do know that you don't want to speak to it, let alone confess.
            
    There was nothing in there, anyway. You should look for the heart elsewhere for now. 
    ->Confessional_Curtain.Leave_NoProgress

- "No, the father of that girl."

#PLAY: groaning-angry, 2
The growl comes from the other side again. "I have no daughter." He says through gritted teeth.

"I talked to—"

"No one."

"She misses—"

"Who?"

{
    - know_name: "EMILY!"
    - else: "Your DAUGHTER!"
}

*[The voice is silent.]

- 


#DELAY: 0.75
~ church_anger += 1

#PLAY: screeching CLASS: Angry-Screeching #DELAY: 2.5
An ear piecing shriek fills the booth{leave_light:, much worse than the one from before. | .} You plug your ears, but it makes no difference.

#CLASS: Bang_Confessional #PLAY: bang_confessional #DELAY: 0.5
Bang!

The wood divider splinters a bit as whatever is on the other side slams into it. "Shut up shut up shut up SHUT UP" It's voice contorts and stretches as it changes from something human to something gutteral and monsterous.

*[Lunge for the curtain]

- #PLAY: thud #DELAY: 2.5
You slam into solid wood. The curtain's gone. The walls close in on you as you push yourself against them.

#CLASS: Bang_Confessional #PLAY: bang_confessional #DELAY: 0.5
Bang!

The divider between you is barely holding up. The wood is splinters while that- that <i>thing</i> shouts and curses you.

"I hate hate hate hate hate HATE you. You DARE speak of things you don't understand?!"

*[Throw yourself at the door.]

-
#DELAY: 0.75
~ church_anger += 1

#PLAY: screeching CLASS: Angry-Screeching #DELAY: 2.5
The thing shrieks again. "You will not escape this time.

#CLASS: Bang_Confessional #PLAY: bang_confessional #DELAY: 0.5
Bang!

The divider splits and falls, revealing the thing on the other side. You fall to the floor and push yourself against the wall, trying to get as far away as yuo possibly can.

*[You can't... What is...]

- It takes a step into your booth, impossibly tall. Impossibly long. It bends, folding in on itself in an attempt to fit in the small space. Your eyes can't accept what they're seeing. 

#CYCLE: hands, claws, tentacles, paws, fins
It has no legs except when it does. Deer hooves that disappear as soon as they touch the ground, only to be replaced with it's next step, like a cascading waterfall of hooves. It grabs the edge of the booth with its @. A human hand morphing into a infinitely splitting claw morphing into a feathered limb that curls and grabs anything within reach.

It says something that reverberates inside your brain. Words that hold meaning you understand, but can't explain. Changing your thoughts, your feelings. Something wet sharply forces your face up, and your eyes lock on it's face. It's true face.

*[A single tear rolls down your cheek.]

- 
#ENDING: 5, Bad Ending: Finding Solace
*You've never known solace like this.
->END

= Leave_NoProgress
~confessional_curtain_side = false
TODO: is the above variable needed?
~ current_area = Main_Body // set the current area
~ have_visited -= Confessional_CurtainSide //set that we have visisted the area
->Inside.Look_For_Heart

= Leave_Progress
~ confessional_curtain_side = true 
TODO: is the above variable needed?
~ previous_area = Confessional_CurtainSide
~ items_obtained += Key
~ current_area = Main_Body // set the current area
~ have_visited += Confessional_CurtainSide //set that we have visisted the area
~ visited_state += 1
{- visited_state:
    
    - 1:
    <b> This is I think about the 20 min mark! You can keep going but I have no idea what will/won't break! If you want more go back and choose the other confessional door :)</b>
        ->After_First.Confessional_After
    - 2:
        -> After_Second.Confessional_Sin_Second
    - else:
        -> Last_Stop.Confessional_Sin_Last
}







