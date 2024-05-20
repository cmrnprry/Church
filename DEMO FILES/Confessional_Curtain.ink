=== Confessional_Curtain ===
~ confessional_sin = true

#PLAY: curtain #IMAGE: Default #PROP: curtain_full, true
You sit on the cold wooden bench. {confessional_priest: It's almost identical to the other side.}{confessional_priest == false: The grate that a priest would speak through has the same lattice work that the door does. }

A small bucket sits in the corner by the divider. You assume the booth must leak, but the bucket is empty.

{confessional_priest == false: There is nothing remotely resembling the heart in here. What were you expecting? Why did you enter? }{confessional_priest: What are you expecting to find here? Why did you enter? }
    
*[To Confess]
~temp_bool = true
"What is it you have to confess?" You jump at the deep voice comes from the other side of the screen. "I am here to listen."
->Confessional_Curtain.Why_Enter

*[To Look for Clues]
~temp_bool = false
You look around the small space again, touching the smooth wood to find anything your eyes might miss.

"Looking for something?" You jump at the deep voice comes from the other side of the screen. "I may be able to help?"
->Confessional_Curtain.Why_Enter

*[You Don't Know]
~temp_bool = false
"Lost are we?" You jump at the deep voice comes from the other side of the screen. "Maybe I can help?"
->Confessional_Curtain.Why_Enter

= Why_Enter
Your heart races, and your entire body tenses. Another person? Here? Do they know about the heart? Can you trust them? 

*["Have you seen a heart?"]
#DELAY: 1
"I cannot say I have." he chuckles. "Unless you mean your own? Maybe a confession would help you find it?"

*["Who are you?"]
#DELAY: 1
"Does that matter?" he asks. {temp_bool: "I will ask again: What is it you have to confess?"} {temp_bool == false: "Do you have something to confess?"}

*[Leave the booth]
#PLAY: curtain
You quickly leave the booth, and stare at the confessional. It's quiet. You're not sure what's in there, but you do know that you don't want to speak to it.
    
There was nothing in there, anyway. You should return to your search.
-> Confessional_Curtain.Leave

- 
#PLAY: liquid-drop
<i>Plink!</i> A drop of water falls into the bucket.

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
            ~temp_bool = true
            {
                - confessional_priest: 
                    #REPLACE: I am a pastor here,
                    "Hmm..." The voice grunts. "[I am a pastor here,] is that not obvious?"
                - else: "Hmm..." The voice grunts. "I am a pastor here, is that not obvious?"
            }
            
            You frown, "No, that's not what-"

            "I do not have all day, and there are others waiting their turn." The voice cuts you off. "So this is the last time I'll ask you this: What. Do. You. Wish. To. Confess?"

            -> Confessional_Curtain.Question
            
        *["Are you part of the church?"]
            ~temp_bool = false
            {
                - confessional_priest: 
                    #REPLACE: As a man of cloth,
                    "[As a man of cloth,] I assume I must be. What an odd question to ask."
                - else: "As a man of cloth, I assume I must be. What an odd question to ask."
            }
            

            You frown, "No, that's not what-"

            "I do not have all day, and there are others waiting their turn." The voice cuts you off. "So this is the last time I'll ask you this: What. Do. You. Wish. To. Confess?"

            ->Confessional_Curtain.Question

        *[Leave the booth]
        #PLAY: curtain
        You don't care to find out and quickly leave the booth. You stare at the confessional. It's quiet. You're not sure what's in there, but you do know that you don't want to speak to it.
        
        There was nothing in there, anyway. You should look for the heart elsewhere for now. You look...
        -> Confessional_Curtain.Leave
}

= Work_Confession
{
    - work == 1:
        ~temp_string = "\"I sent multiple wrong copies to a department. I only realized when a coworker called me out. She seemed worried about me, but... I don't know.\""
    - work == 2:
        ~temp_string = "\"I think I was fired.\" You laugh. \"I sent a nonsense email to our biggest client and they were very upset. My supervisor is really, really mad at me.\""
    - work == 3:
        ~temp_string = "\"A coworker was trying to help me today, but I pushed him away.\""
}


"Today, I was... a little strange. I was never the best worker at my job, but today was particularly bad." You trace the wooden grooves of the wall with your finger. The words feel stuck in your throat as you recall your day. 

#DELAY: 1.5
{temp_string}

#PLAY: liquid-drop
<i>Plink!</i>

#DELAY: 3
The voice is silent. You squirm uncomfortably in your seat. The next words you seem to just tumble out.

- #DELAY: 1
{
    - work == 1:
        "I-We rarely talk, but her concern felt so foreign. I didn't know what to do with it, so I just... I just left."
        ~temp_string = "often ignore or push away the ones who reach out first?\""
    - work == 2:
        "My supervisor has always looked out for me even though I never meet their standards. I think this was the straw that broke the camel's back."
        ~temp_string = "think you did all you could?\""
    - work == 3:
        "I had never spoken to him before, I mianly keep to myself at work. I didn't know how to handle his help, so I pushed him away and left."
        ~temp_string = "often ignore or push away the ones who reach out first?\""
}

#PLAY: liquid-drop #PLAY: 2, liquid-drop
<i>Plink! Plink!</i>

"I see..." The voice is quiet for a moment before continuing, "Do you {temp_string}

*[Agree with the voice]
~temp_bool = true

*[Disagree with the voice] 
~temp_bool = false

- 

{
    - temp_bool:
        #DELAY: 1
        You nod. Your chest is tight.
        
        #PLAY: liquid-drop #PLAY: 1, liquid-drop
        <i>Plink! Plink!</i>
        
        {
            - work == 1 or work == 3:
                "Do you feel unworthy of their concern?"
                ~temp_string = "feel this way?"
            - work == 2:
                "And you work hard anyway?"
                ~temp_string = "do that?"
        }
    
    - else:
        {
            - work == 1 or work == 2:
                ~temp_string = "small talk in the kitchen. How your coworkers offer to let you join them for lunch, but you always turn them down. How you don't have many, if any, work friends. How anyone who reaches out first is met with a swift denial."
            - work == 3:
                ~temp_string = "overlooked promotions. When you finally felt you proved yourself on a project, and your efforts were met with a pat on the back. How even after pushing the issue, your emails didn't get a response. How no matter what you did, how hard you worked, you got nothing in return."
        }
        You shake your head. "I can't say that's the case. Today was-"

        "A fluke? A one off?" The voice sneers. "Are you so sure about that?"

        You flinch at it's tone, and look at your shoes. Did you say something wrong? You mumble an appology and kick the floor.
        
        "I'm not scolding you." The voice softens, and some of your anxiety alleviates. "But can you really say this was a one off event?" 
        
        You think back to {temp_string}
}

*[Agree with the voice]
{
    - temp_bool:
        #DELAY: 1
        You hesitate, but nod. Why? Why do you {temp_string} What's the point?
    - else:
        You hesitate, but slowly, shake your head. The more you think, the more realize the voice is right.
    
}
~temp_bool = true

*[Disagree with the voice]
{
    - temp_bool:
        {
            - work == 1 or work == 3:
               ~temp_string = "Unworthy is a strong word. Can anyone be unworthy of another's time?"
            - work == 2:
               ~temp_string = "You think you do, but at the same time..."
        }
        #DELAY: 1
        You hesitate. Do you? {temp_string}
    - else:
        {
            - work == 1 or work == 2:
                ~temp_string = "<i>You</i> choose to push people away. It's not their fault if they decide to stop when all you do is push them away."
            - work == 3:
                ~temp_string = "A job is just that. A job. They may not value you the way you wish they would, but maybe it's time to look for one that does."
        }
        It makes you angry, the way they treat you, but... {temp_string} 
    
}
~temp_bool = false

- 

{
    - temp_bool:
        #PLAY: liquid-drop
        <i>Plink!</i> The bucket is half full.

        "I understand. Do you feel a sense of relief now?" You do. You feel a little lighter after saying it out loud. "Knowing you don't have to go back to that?"

        Your stomach drops.
        
        *["What?"]
        ->Confessional_Curtain.Middle

        *["I don't...?"]
        ->Confessional_Curtain.Middle
    
    - else:
    {
        - leave_light:
            ~temp_string = "Of the warmth you've felt."
        - else:
        {
            - know: 
                ~temp_string = "Of your poleroid sitting in pieces in your desk. You "
            - else:
                ~temp_string = "You touch the pocket that holds the pieces of your poleroid, and"
        }
    }
    "I don't think-"
    
    The voice cuts you off. "From what you told me, you are <i>miserable</i> out there!" The voice is loud, andyou jump in your seat. "The church has so much to offer you. And you are <i>here</i> now, safe in the church's embrace. Aren't you happier here?"
    
    #DELAY: 1.5
    Safe? Happy? You think about everything you've experienced up til now. {temp_string}look at the ceiling of the booth. Is this any better or worse than your day to day? You're not sure how to feel.

    #PLAY: liquid-drop #REPLACE: liquid
    <i>Plink!</i> The bucket is filling fast. You can see that the [liquid] seems... thicker than just water.
    
    *[liquid]
    ->Confessional_Curtain.liquid
    
    *["I don't want to be here."]
    The rapid drips from the leak stop. "You must be mistaken." The voice laughs, an angry and cruel laugh. "You don't <i>want</i> to be here? How dare you-"
    ->Confessional_Curtain.Reject

    *[Stay silent.]
    ->Confessional_Curtain.Agree
}

= liquid
You look closer. The liquid in the bucket is slightly viscous. It looks almsot like-

"Well?" The voice is growing impatient. You tense. "Aren't you happier here?"

*["Maybe..."]
->Confessional_Curtain.Agree
*["I don't want to be here."]
The rapid drips from the leak stop. "You must be mistaken." The voice laughs, an angry and cruel laugh. "You don't <i>want</i> to be here? How dare you-"
->Confessional_Curtain.Reject

*["I don't know.]
->Confessional_Curtain.Agree

= Middle
#PLAY: liquid-drop
<i>Plink!</i>

{
    - work == 1 or work == 3:
        #DELAY: 1.5
        "You say you are not worthy of the concern of others. You keep to yourself, so your work." The voice is gentle. "But you are here now, safe in the church's embrace. Aren't you happier here?"
    - work == 2:
        #DELAY: 1.5
        "You don't think you could have done better, that you worked harder to make up for it. And yet, your efforts fell to deaf ears." The voice is gentle. "But you are here now, safe in the church's embrace. Aren't you happier here?"
}

#PLAY: liquid-drop
<i>Plink!</i>

#REPLACE: liquid
The bucket is filling fast. You can see that the [liquid] seems... thicker than just water.

*[liquid]
->Confessional_Curtain.liquid
    
*["I don't want to be here."]
The rapid drips from the leak stop. "You must be mistaken." The voice laughs, an angry and cruel laugh. "You don't <i>want</i> to be here? How dare you-"
->Confessional_Curtain.Reject

*[Stay silent.]
->Confessional_Curtain.Agree

= Reject
~temp_string = ""
{
    - avoid: 
        ~temp_string += "When I tried to avoid the church, it pulled me back. "
}

{
    - leave_light: 
        ~temp_string += "When I rejected it's sight, it burned me. "
}

{
    - object != "": 
        ~temp_string += "When I tried to escape, it <i>taunted</i> me with a {object}. "
}

"{temp_string}When I wanted to <i>leave</i> the church <i>would not let me."</i> You clench your fists. "So tell me, how I am mistaken?"

*[The voice is silent.]

-

#CLASS: Bang_Confessional #PLAY: banging-confession #DELAY: 0.5
Bang!

The wood divider splinters as whatever is on the otherside slams into it. "HOW could you be so IGNORANT? So UNGRATFUL? SO STUPID?" The calm softness it used to speak to you before is gone. It's angry.

The bucket tips over, and the liquid spills out. It sticks to your shoes, much thicker than water.

*[Is that... saliva?]

- #CLASS: Bang_Confessional #PLAY: banging-confession #DELAY: 0.5
Bang! <>

"It only want to HELP you. It LET you go, to SHOW you that. How UN-GRATE-FUL." With enery sylable it slams into the wood. The grate it has been talking through falls onto your side of the conessional. It's voice screetches. "STUPID STUPID STUPID STUPID!"

The booth could come apart at any moment. You need to get out of here.

*[Get out of the confessional]
-> Confessional_Curtain.Get_Out
*[Look into the other side]
-> Confessional_Curtain.Look

= Get_Out
#CLASS: Bang_Confessional #PLAY: banging-confession #DELAY: 0.5
Bang!

You cover your face as wooden splinters fly toward you. You need to get OUT, before that... that THING gets IN.

{
    - leg == "worst": 
        ~temp_string = "hobble through the curtain as fast as you can"
    - else:
        ~temp_string = "run through the curtain"
}

You {temp_string}, and turn to see the confessional shuttering under whatever inside continues banging on the walls.

*[Open the priest-side door]
~temp_bool = true
*[Wait until it stops]
~temp_bool = false

- 
#CLASS: Bang_Confessional #PLAY: banging-confession #DELAY: 0.5
Bang!


{

- temp_bool:
    Carefully, you approach the door. Whatever is inside has started to wail and scream. You place your hand on the knob.

    ~temp_string = "Turn the handle"
- else:
    You stand outside the confessional, waiting for whatever's inside to stop. Whatever is inside has continues to scream and curse at you. <i>How STUPID! How UNGRATEFUL!</i>

    The words echo throughout the space. You ignore it, and wait. 
    
    After a few moments, the screams turn to wails, to low moans, to quiet sobs. It begs you to reconsider. Begs you to understand.
    
    {
        - stay >= 1:
            There's an unwanted pang in your heart as you listen to cry. 
        - else:
            You continue to ignore. Whatever is inside is made of the church. It would say anything to hurt you. To make you stay.
    }
    
    ~temp_string = "Eventually it goes quiet"
}

*[{temp_string}]

-

Inside, the booth is empty, and pristine. The divider is not splintered, and the seperating grate is back in place. It looks almost identical to the side you had been on. 

On the bench sits a small key. You pick it up, and put in your pocket, hoping it will be useful later.
~ key = true
~ confessional_priest = true
*[Exit the confessional booth.]
-> END_DEMO

= Look
#CLASS: Bang_Confessional #PLAY: banging-confession #DELAY: 0.5
Bang!

You cover your face as wooden splinters fly toward you, and take a step closer to the hole in the divider. You raise your flashlight, and peer through the hole.

*[Turn on the flashlight]

- 
#PLAY: click-on #EFFECT: flashlight
The flash light clicks on, and everything stops.

Tthe otherside is pristine. It looks almost identical to the side you had been on. No one is insdie.

On the bench sits a small key. 
~ key = true
*[Reach your arm through]
~temp_bool = true
*[Go around]
~temp_bool = false

- 

{

- temp_bool:
    ~ temp_string = "reach through"
    #PLAY: click-off #EFFECT: flashlight
    You place the flashlight back in your pocket, and reach your arm through. blindly feeling around.  Your fingertips just barely brush the bench it's sitting on. 

    You reach in deeper, your face pressing against the mangled wood. "Just a bit... more..." you mumble to yourself.
    
    Your fingers brush against the key again when a cold hand grabs your arm. You jerk away, but it holds tight, fingers digging into your wrist.

    "Making the church angry will not help you." It's the gruff voice from earlier. "Fighting against it is meaningless."

    Something cold and metal is placed into your palm, and you're released. You yank your arm back through the opening, falling into the opposite side. In your hand is the key.
    
    The booth is quiet, save for your own breathing. You place the key in your pocket.


- else:
    ~ temp_string = "angry"
    #PLAY: click-off #EFFECT: flashlight
    You exit through the curtain, face the priest's door. You take a deep breath, and open it. The key sits on the bench, but more surprisingly, the divider is no longer splintered, and the seperating grate is back in place.

    The church fixed itself. 
    
    You quickly step inside, grab the key, and leave the booth. You shove the key in your pocket, hoping it will be useful later.
}

~ confessional_priest = true
*[Exit the confessional booth.]
-> END_DEMO

= Agree
#DELAY: 1
You work everyday and for what?" 

#PLAY: liquid-drop #PLAY: 1, liquid-drop #PLAY: 1, liquid-drop
<i>Plink! Plink! Plink!</i>

#DELAY: 1
The words get stuck in your throat.

#PLAY: liquid-drop #PLAY: 1, liquid-drop #PLAY: 1, liquid-drop
<i>Plink! Plink! Plink!</i>

#DELAY: 2
"The church can feel... perplexing... at first, but it doesn't bring you here without reason. It wants to help- to heal the harm dealt to you out <i>there."</i> The voice is calming. It makes sense. Why else would you be here? "The church would never hurt you. Could never hurt you."
{
    - know or leave_light or object != "":
        ~temp_string = "You know shouldn't listen. You know its... it's another trick. After everything, you know this, but..."
    -else:
        ~temp_string = "The voice is making sense. You were scared and rejected anything the church offered you. Maybe if you hadn't rejected it so strongly then..."
}

#PLAY: liquid-drop #PLAY: 1, liquid-drop #PLAY: 1, liquid-drop
<i>Plink! Plink! Plink!</i>

You clench and unclench your hands. {temp_string}

*["Maybe you are right..."]

*["No..."]
{
    - know or leave_light:
       You need to stay strong. You didn't come here of your own will. You've wanted to leave from the start.
    -else:
       You shake the thought from your head. You can't let the voice's sweet words posin your mind.
}

->Confessional_Curtain.Reject_Version_2

-
#PLAY: liquid-drop #PLAY: 1, liquid-drop #PLAY: 1, liquid-drop
<i>Plink! Plink! Plink!</i>

The leak is dripping faster now. The bucket is spilling over. The viscous liquid contains small bubbles as it crawls over the floor. 

"Stop fighting. Has the church harmed you?" 

{
    - leave_light:
    *[The church was angry..."]
    "It screamed at me. It- It burned me..." You shutter at the memory. 
    
    The rapid drips from the leak stop. "Angry...?" The voice laughs. "You must be mistaken. The church would never-"
    ->Confessional_Curtain.Reject
}

*["No.."]

*["When it brought me here..."]

- ~stay += 1
"When it brought you here, that must have been frightening. Change always is."

#DELAY: 1
You nod.

#PLAY: liquid-drop #PLAY: 1, liquid-drop #PLAY: 1, liquid-drop
<i>Plink! Plink! Plink!</i>

The liquid crawls towards your shoes. You don't think it's water at all. 

"I am sorry, but all the church wants is to give you more than the world out there." You nod. "The church only wants the best for you. So, just. Stop. Fighting."

*You nod.

- 

#PLAY: key-thrown
<i>Plunk!</i>

A small key falls into the bucket, causing the bucket to fall over, and the liquid to spill onto the floor. You lift your feet to avoid your shoes from soaking through, and the liquid streches like you stepped in gum. Is this...? You gag.

"A gift for you. An olive branch of sorts." You hear the door close, and you know you are alone.
~ key = true
*[Pick up the key]

- You grab it out of the pool of liquid. It's sticky and thick, almost like... Your stomach churns. Saliva?

You wipe the key off using the confessional curtain, and stick it in your pocket. You look at the grate the voice spoke to you through. 

You wonder if you'll meet it again.

~ confessional_priest = true
*[Exit the confessional booth.]
-> END_DEMO

= Reject_Version_2
The rapid drips from the leak stop. "No...?" The voice is hard now. The calm, softness it used to speak to you before is gone. "What do you mean, no?"
~temp_string = ""
{
    - avoid: 
        ~temp_string += "When I tried to avoid the church, it pulled me back. "
}

{
    - leave_light: 
        ~temp_string += "When I rejected it's sight, it burned me. "
}

{
    - object != "": 
        ~temp_string += "When I tried to escape, it <i>taunted</i> me with a {object}. "
}

"{temp_string}When I wanted to <i>leave</i> the church <i>would not let me."</i> You clench your fists. "So tell me, how is that not <i>harm?"</i>

*[The voice is silent.]

-

#CLASS: Bang_Confessional #PLAY: banging-confession #DELAY: 0.5
Bang!

The wood divider splinters as whatever is on the otherside slams into it. "HOW could you be so IGNORANT? So UNGRATFUL? SO STUPID?" The calm softness it used to speak to you before is gone. It's angry.

The bucket tips over, and the liquid spills out. It sticks to your shoes, much thicker than water.

*[Is that... saliva?]

- 
#CLASS: Bang_Confessional #PLAY: banging-confession #DELAY: 0.5
Bang!

"It only want to HELP you. It LET you go, to SHOW you that. How UN-GRATE-FUL." With enery sylable it slams into the wood. The grate it has been talking through falls onto your side of the conessional. It's voice screetches. "STUPID STUPID STUPID STUPID!"

The booth could come apart at any moment. You need to get out of here.

*[Get out of the confessional]
-> Confessional_Curtain.Get_Out
*[Look into the other side]
-> Confessional_Curtain.Look

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

#PLAY: liquid-drop
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

= Too_much
"I somehow am doing too much all the damn time." You stare up at the celing, focusing on a cobweb. "I can't commit to anything to completion, but I also can't stop picking up more things to do."

#PLAY: liquid-drop
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
        
    You should look for the heart elsewhere for now. You look...
    -> Confessional_Curtain.Leave

= Personal_Motivation
#PLAY: liquid-drop #PLAY: 1, liquid-drop #PLAY: 1, liquid-drop
<i>Plink! Plink! Plink!</i>

"I see..." The voice was quiet for a moment before continuing, "Perhaps there's another reason for this? Is work too draining?"

*[Agree with the voice] 
~temp_bool = true

*[Disagree with the voice] 
~temp_bool = false

- 
{
    - temp_bool:
        You feel yourself nodding. After work all you want to do is sleep. How is that you're fault?

        #PLAY: liquid-drop #PLAY: 1, liquid-drop #PLAY: 1, liquid-drop
        <i>Plink! Plink! Plink!</i>
    
        "It's not your fault that the outside world is unsympathetic." The voice is gentle. Soft. "So aren't you so glad you can stay?"
    
        -> Confessional_Curtain.TooMuch_Choice
    - else:
        "Maybe..." You chew on the voice's words. "Or maybe it's-"

        #PLAY: liquid-drop 
        <i>Pl....in.....k!</i>

        "This is not an attack on you." The voice cuts you off. "But more of an observation from the outside looking in."

        You sit with that knowledge. Is that how others see you? You feel smaller.
        
        *[Agree with the voice]
            "There is a silver lining to all this." 
            
            You perk up immediately at it's words.
            -> Confessional_Curtain.Personal_End
    
        *[Disagree with the voice]
            Not an attack? Just an observation? Does this "observation" have to be so cruel? "I don't think that-"
    
            It cuts you off again.
    
            "I think you are sabotaging yourself on purpose." The voice is stern, and cold. "Something, out <i>there</i> is making you this way. So aren't you so glad you can stay?"
            -> Confessional_Curtain.TooMuch_Choice
}

= Personal_TooMuch
#PLAY: liquid-drop #PLAY: 1, liquid-drop #PLAY: 1, liquid-drop
<i>Plink! Plink! Plink!</i>

#DELAY: 1
"I see..." The voice is quiet. 

#DELAY: 2
The silence is suffocating. 

The voice finally continues, and you can breathe again. "So you are picking these up projects to make up for your inadequacy? You take as many as you can get so failure to finish is inevitable?"

*[Agree with the voice] 
~temp_bool = true

*[Disagree with the voice]
~temp_bool = false

- 

{
- temp_bool:
    You don't answer. You're inadequate? It's all inevitable? You bite you lip.

    #PLAY: liquid-drop #PLAY: 1, liquid-drop #PLAY: 1, liquid-drop
    <i>Plink! Plink! Plink!</i>

    "I think you are sabotaging yourself on purpose." The voice is gentle. Soft. " Something, out <i>there</i> is making you this way. So aren't you so glad you can stay?"
    
    -> Confessional_Curtain.TooMuch_Choice

- else:
    #DELAY: 0.5
    You shake your head. "It's not that I'm-"
    
    #PLAY: liquid-drop 
    <i>Pl....in.....k!</i>
    
    "This is not an attack on you." The voice cuts you off. "But more of an observation from the outside looking in."
    
    You sit with that knowledge. Is that how others see you? You feel smaller.
    
    *[Agree with the voice]
        "There is a silver lining to all this." 
        
        You perk up immediately at it's words.
        -> Confessional_Curtain.Personal_End
    
    *[Disagree with the voice]
        Not an attack? Just an observation? Does this "observation" have to be so cruel? "I don't think that-"

        It cuts you off again.

        "I think you are sabotaging yourself on purpose." The voice is stern, and cold. "Something, out <i>there</i> is making you this way. So aren't you so glad you can stay?"
        -> Confessional_Curtain.TooMuch_Choice
}   

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
    
*["I don't want to be here."]
    The rapid drips from the leak stop. "You must be mistaken." The voice laughs, an angry and cruel laugh. "You don't <i>want</i> to be here? How dare you-"
    ->Confessional_Curtain.Reject
    
*[Remain silent.]
    ~stay += 0.5
    You say nothing, the voice's words rolling around in your mind. It's... tempting. If the voice is right....
    -> Confessional_Curtain.Personal_End

- - The drips from the leak stop. "No...?" The voice scofts at you. "What do you mean, no?"
~temp_string = ""
{
    - avoid: 
        ~temp_string += "When I tried to avoid the church, it pulled me back. "
}

{
    - leave_light: 
        ~temp_string += "When I rejected it's sight, it burned me. "
}

{
    - object != "": 
        ~temp_string += "When I tried to escape, it <i>taunted</i> me with a {object}. "
}

"{temp_string}When I wanted to <i>leave</i> the church <i>would not let me."</i> You clench your fists. "What is so <i>grand</i> about that?"

*[The voice is silent.]

- 
#CLASS: Bang_Confessional #PLAY: banging-confession #DELAY: 0.5
Bang!

The wood divider splinters as whatever is on the otherside slams into it. "HOW could you be so IGNORANT? So UNGRATFUL? SO STUPID?" The calm softness it used to speak to you before is gone. It's angry.

The bucket tips over, and the liquid spills out. It sticks to your shoes, much thicker than water.

*[Is that... saliva?]

- 
#CLASS: Bang_Confessional #PLAY: banging-confession #DELAY: 0.5
Bang!

"It only want to HELP you. It LET you go, to SHOW you that. How UN-GRATE-FUL." With enery sylable it slams into the wood. The grate it has been talking through falls onto your side of the conessional. It's voice screetches. "STUPID STUPID STUPID STUPID!"

The booth could come apart at any moment. You need to get out of here.

*[Get out of the confessional]
-> Confessional_Curtain.Get_Out
*[Look into the other side]
-> Confessional_Curtain.Look

= Personal_End
#PLAY: liquid-drop #PLAY: 1, liquid-drop #PLAY: 1, liquid-drop
<i>Plink! Plink! Plink!</i>

The bucket is filling fast. You can see the [liquid] seems... thicker than just water.

"You'll have all the time in the world here. All you have to do is stay!" The voice is excited. "Doesn't that sound grand?" 

* [liquid]
    ->Confessional_Curtain.liquid_2

*["You're right..."]
    The voice is making sense. Imagine what you could fo if...
    ->Confessional_Curtain.End_Confessional

*["No."]

- The drips from the leak stop. "No...?" The voice scofts at you. "What do you mean, no?"
~temp_string = ""
{
    - avoid: 
        ~temp_string += "When I tried to avoid the church, it pulled me back. "
}

{
    - leave_light: 
        ~temp_string += "When I rejected it's sight, it burned me. "
}

{
    - object != "": 
        ~temp_string += "When I tried to escape, it <i>taunted</i> me with a {object}. "
}

"{temp_string}When I wanted to <i>leave</i> the church <i>would not let me."</i> You clench your fists. "What is so <i>grand</i>_ about that?"

*[The voice is silent.]

- 
#CLASS: Bang_Confessional #PLAY: banging-confession #DELAY: 0.5
Bang!
The wood divider splinters as whatever is on the otherside slams into it. "HOW could you be so IGNORANT? So UNGRATFUL? SO STUPID?" The calm softness it used to speak to you before is gone. It's angry.

The bucket tips over, and the liquid spills out. It sticks to your shoes, much thicker than water.

*[Is that... saliva?]

- 
#CLASS: Bang_Confessional #PLAY: banging-confession #DELAY: 0.5
Bang!

"It only want to HELP you. It LET you go, to SHOW you that. How UN-GRATE-FUL." With enery sylable it slams into the wood. The grate it has been talking through falls onto your side of the conessional. It's voice screetches. "STUPID STUPID STUPID STUPID!"

The booth could come apart at any moment. You need to get out of here.

*[Get out of the confessional]
-> Confessional_Curtain.Get_Out
*[Look into the other side]
-> Confessional_Curtain.Look

= liquid_2 
You look closer. The liquid in the bucket is slightly viscous. It looks almsot like-

"Well?" The voice is growing impatient.

*["You're right..."]
-> Confessional_Curtain.End_Confessional

*["I don't want to be here."]

- The drips from the leak stop. "You don't...?" The voice scofts at you. "What do you mean, you don't want to be here? How could-"
~temp_string = ""
{
    - avoid: 
        ~temp_string += "When I tried to avoid the church, it pulled me back. "
}

{
    - leave_light: 
        ~temp_string += "When I rejected it's sight, it burned me. "
}

{
    - object != "": 
        ~temp_string += "When I tried to escape, it <i>taunted</i> me with a {object}. "
}

"{temp_string}When I wanted to _leave_ the church <i>would not let me."</i> You clench your fists. "What is so <i>grand</i> about that?"

*[The voice is silent.]

- 
#CLASS: Bang_Confessional #PLAY: banging-confession #DELAY: 0.5
Bang!

The wood divider splinters as whatever is on the otherside slams into it. "HOW could you be so IGNORANT? So UNGRATFUL? SO STUPID?" The calm softness it used to speak to you before is gone. It's angry.

The bucket tips over, and the liquid spills out. It sticks to your shoes, much thicker than water.

*[Is that... saliva?]

- 
#CLASS: Bang_Confessional #PLAY: banging-confession #DELAY: 0.5
Bang!

"It only want to HELP you. It LET you go, to SHOW you that. How UN-GRATE-FUL." With enery sylable it slams into the wood. The grate it has been talking through falls onto your side of the conessional. It's voice screetches. "STUPID STUPID STUPID STUPID!"

The booth could come apart at any moment. You need to get out of here.

*[Get out of the confessional]
-> Confessional_Curtain.Get_Out
*[Look into the other side]
-> Confessional_Curtain.Look

= No_Confession
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
~temp_bool = true

*[Recall a work event.]
"Well, work is..." You wring your hands together, embaressed. "It's a routine. There's nothing to tell...."

"You don't sound very sure." The voice presses. "Nothing leaves this conversation. You can trust me."
~temp_bool = false
~temp_bool_2 = true

*[Recall a personal event.]
"Life is..." You wring your hands together, embarrassed. "It's boring. There's not much to tell..."

"You don't sound very sure." The voice presses. "Nothing leaves this conversation. You can trust me."
~temp_bool = false
~temp_bool_2 = false

- 

{
- temp_bool:
    *[Fill the silence.]
        "I wake up, go to work, come home, watch TV while eating dinner, and go to bed." You wring your hands together, suddenly embarrassed. "It's a routine. There's nothing to tell."
        ->Confessional_Curtain.No_Talk
    {
        - stay <= 1:
            *[Wait]
            -> Confessional_Curtain.Wait
    }
- else:
    *[Talk about it]
        {
            - temp_bool_2:
                ->Confessional_Curtain.Work_Confession
            - else:
                ->Confessional_Curtain.Personal_Confession
        }
    *[Don't talk about it]
        "No, nothing to tell. My life is a routine, and work is no different." You tap your fingers against the bench. "I wake up, go to work, come home, watch TV while eating dinner, and go to bed." 
        ->Confessional_Curtain.No_Talk
}

= Wait
You squirm uncomfortably in your seat. The quiet seems deafening. 

*[Fill the silence.]
    "I wake up, go to work, come home, watch TV while eating dinner, and go to bed." You wring your hands together, suddenly embarrassed. "It's a routine. There's nothing to tell."
    ->Confessional_Curtain.No_Talk

*[Continue waiting]
    ~stubborn = true
- Finally, the voice breaks the silence.

"You are more... stuborn than expected." The voice spits out the words. "But I can wait for as long as you need. I have <i>all</i> the time in the world."

    Your skin crawls. The silence returns.

*[Fill the silence.]
    "I wake up, go to work, come home, watch TV while eating dinner, and go to bed." You wring your hands together, suddenly embarrassed. "It's a routine. There's nothing to tell."
    ->Confessional_Curtain.No_Talk

*[Leave the booth]
    #PLAY: curtain
    You stand and leave the booth. You stare at the confessional. It's quiet. You're not sure what's in there, but you're at a stalemate with whatever was on the other side. If you're not going to talk, there's no reason to stick around.
        
    You should look for the heart elsewhere for now. You look...
    -> Confessional_Curtain.Leave
    
    

= No_Talk
#PLAY: liquid-drop
<i>Plink!</i>

"A routine..." The voice trails off. "Would you say you become bored of this? That you wish for more than what you have?"

*[Agree with the voice]
    ~temp_bool = true

*[Disagree with the voice]
    ~temp_bool = false

- 

{
    - temp_bool:
        {
            - stay <= 1:
                ~temp_string = "do you fight it"
            - else:
                ~temp_string = "don't you stay"
        }
        #DELAY: 1
        You feel yourself nodding. "I... My job is a means to an end. It's enought to keep me alive, but not enough to... do more..."
        
        #PLAY: liquid-drop
        <i>Plink!</i>
        
        "I see. So why {temp_string} then?"
    - else:
        {
            - stay <= 1:
                ~temp_string = "So, is this why fight the church?"
            - else:
                ~temp_string = "And yet you wish to stay? To choose the church?"
        }
        #DELAY: 1
        "No, I..." You shake your head. "My life is still mine. This is what I chose." You clench your fists.
    
        #PLAY: liquid-drop
        <i>Plink!</i>
        
        {temp_string}

}

*["What?"]

*[Stay silent.]
~ temp_bool_2 = true

- #PLAY: liquid-drop
<i>Plink!</i>


{

- temp_bool:
        {
            - stay <= 1:
                ~temp_string = "fight it?"
            - else:
                ~temp_string = "don't you stay stay? Choose the church."
        }
    "You complain of routine. You wish for more." The voice becomes softer as it speaks. "So <i>why</i> {temp_string} The church has so much to offer you."
    
- else:

    {
        - stay <= 1.5:
            ~temp_string = "Of course you fight the church. You want to <i>_leave.</i>"
        - else:
            ~temp_string = "Stay? When have you ever wished to..."
    }

    What is it talking about? {temp_string}

    {
        - stay <= 1.5:
            ~temp_string = "So, why is it you fight the church?"
        - else:
            ~temp_string = "So why are you <i>fighting</i> to leave?"
    }

    "You can say you're content with your life <i>out there,</i> but we both know you want to stay <i>here"</i> The voice becomes harder as it speaks. "The church has so much to offer you, you know this. {temp_string}"

    #PLAY: liquid-drop #PLAY: 1, liquid-drop #PLAY: 1, liquid-drop
    <i>Plink! Plink! Plink!</i>

}

*["I don't know."]
    ~temp_string = "I don't know..."

*["I don't want to be here."]
The rapid drips from the leak stop. "Hm...?" The voice laughs. "You think that now, but just wait-"
->Confessional_Curtain.Reject

*[Stay silent.]
~temp_string = "..."
"Quiet, are we?" the voice chuckles.

You squirm in your seat. Clenching and unclenching your fists.


- #DELAY: 1
"Your life is a routine. A boring, worthless routine." You flinch at the words. "You struggle everyday and for what?"

#PLAY: liquid-drop #PLAY: 1, liquid-drop #PLAY: 1, liquid-drop
<i>Plink! Plink! Plink!</i>

#DELAY: 2
"{temp_string}"

#PLAY: liquid-drop #PLAY: 1, liquid-drop #PLAY: 1, liquid-drop
<i>Plink! Plink! Plink!</i>

"The church is scary at first, but all change is. The church doesn't bring you here without reason." The voice is calming. It makes sense. Why else would you be here? "It would never hurt you."

*["Maybe you are right..."]

*["No..."]
-> Confessional_Curtain.Reject_Version_2


- The leak is dripping faster now. The bucket is spilling over. The viscous liquid contains small bubbles as it crawls over the floor.

"Tell me, has the church ever harmed you?" the voice envlops you. Has the church harmed you? You find yourself doubting your memory. "Hmm?"

"I..."

{
    - leave_light:
    *[The church was angry..."]
    "It screamed at me. It- It burned me..." You shutter at the memory. 
    
    The rapid drips from the leak stop. "Angry...?" The voice laughs. "You must be mistaken. The church would never-"
    ->Confessional_Curtain.Reject
}

*["No.."]

*["When it brought me here..."]

- -> Confessional_Curtain.End_Confessional

= End_Confessional
~ key = true
"When it brought you here, that must have been frightening. Change always is."

#DELAY: 1
You nod.

#PLAY: liquid-drop #PLAY: 1, liquid-drop #PLAY: 1, liquid-drop
<i>Plink! Plink! Plink!</i>

The liquid crawls towards your shoes. You don't think it's water at all. 

"All the church wants is to give you more than the world out there." You nod. "The church only wants the best for you. So, just. Stop. Fighting. It."

*You nod.

- 

#PLAY: key-thrown
<i>Plunk!</i>

A small key falls into the bucket, causing the bucket to fall over, and the liquid to spill onto the floor. You lift your feet to avoid your shoes from soaking through, and the liquid streches like you stepped in gum. Is this...? You gag.

"A gift for you. An olive branch of sorts." You hear the door close, and you know you are alone.

*[Pick up the key]

- You grab it out of the pool of liquid. It's sticky and thick, almost like... Your stomach churns. Saliva?

You wipe the key off using the confessional curtain, and stick it in your pocket. You look at the grate the voice spoke to you through. 

You wonder if you'll meet it again.

~ confessional_priest = true
*[Exit the confessional booth.]
-> END_DEMO

= Question
You don't think you will get an answer. The voice is pushing you to confess.

You take a deep breath. You need to confess something? Fine.
{
    - confessional_priest:
        
        {
            - temp_bool:
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
            
*[Leave the booth]
#PLAY: curtain
You quickly leave the booth, and stare at the confessional. It's quiet. Whatever is in there, it won't tell you anything important. And you don't like that it was pushing you to "confess."
    
There was nothing in there, anyway. You should look for the heart elsewhere for now. You look...
-> Confessional_Curtain.Leave

= Know_Father
~ church_anger += 0.5
Something clicks into place. "I... know who you are..."

"Do you now?" he laughs coldly.

"You're the father of-"

"The church. I do not have all day, and there are others waiting their turn." His voice is short. "So this is the last time I'll ask you this: What. Do. You. Wish. To. Confess?"

#REPLACE: push the matter
You frown, "No, that's not what-" A gutter growl cuts you off. You don't think you should [push the matter]. The voice is pushing you to confess, maybe you can learn more if you play along?

You take a deep breath. You need to confess something? Fine.

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
        
There was nothing in there, anyway. You should look for the heart elsewhere for now. You look...
-> Confessional_Curtain.Leave

- "No, the father of that girl."

#PLAY: groaning-angry, 2
The growl comes from the otherside again. "I have no daughter." He says through gritted teeth.

"I talked to-"

"No one."

"She misses-"

"Who?"

{
    - name: "EMILY!"
    - else: "Your DAUGHTER!"
}

*[The voice is silent.]

- 

{
    - leave_light:
        ~temp_string = ", much worse than the one from before."
    - else:
        ~temp_string = "."
}
#DELAY: 0.75
~ church_anger += 1

#PLAY: screeching CLASS: Angry-Screeching #DELAY: 2.5
An earpiecing shriek fills the booth{temp_string} You plug your ears to no avail.

#CLASS: Bang_Confessional #PLAY: banging-confession #DELAY: 0.5
Bang!

The wood divider splinters a bit as whatever is on the otherside slams into it. "Shut up shut up shut up SHUT UP" His voice warms and contorts into something non-human.

*[Lunge for the door]

- #PLAY: lock-rattle #DELAY: 2.5
It won't open. It's locked.

#CLASS: Bang_Confessional #PLAY: banging-confession #DELAY: 0.5
Bang!

The divider between you is barely holding up. The wood is splinters while that- that <i>thing</i> shouts and curses you.

"I hate hate hate hate hate HATE you. You DARE speak of things you don't understand?!"

*[Throw yourself at the door.]

-
#DELAY: 0.75
~ church_anger += 1

#PLAY: screeching CLASS: Angry-Screeching #DELAY: 2.5
The thing shrieks again. "You will not escape this time.

#CLASS: Bang_Confessional #PLAY: banging-confession #DELAY: 0.5
Bang!

The divder splits and falls, revealing the thing on the other side. You fall to the floor and push yourself against the wall, trying to get as far away as yuo possibly can.

*[You can't... What is...]

- It takes a step into your booth, impossibly tall. Impossibly long. Your eyes can't accept what they're seeing. 

#CYCLE: hands, claws, tentacles, paws, wings
It has no legs except when it does. Deer hooves that disappear as soon as they step down, only to replaced with a newer one with it's next step, like a cascading waterfall of legs. It grabs the edge of the booth with its @. A human hand morphing into a infinitiely splitting claw morphing into a featherd limb that curls and grabs anything within reach.

It says something that reverberates inside your brain. Words that hold meaning you understand in a way that you can't explain. Changing your thoughts, your feelings. Something wet sharply forces your face up, and your eyes lock on it's face. It's true face.

*A single tear rolls down your cheek.

- 
#ENDING: Finding Solace
*You've never known solace like this.
-> END_DEMO

= Leave
~confessional_sin = false

*[Somewhere up the stairs]
-> Stairs