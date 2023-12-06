=== Confessional ===
{
 - !confessional_priest || !confessional_sin:
        {
            - leg == "worst":
                ~temp_string = "carefully"
            - else: 
                ~temp_string = ""
        }
        You {temp_string} approach the confessional booth. It is a plain, wooden box. The most detail was the lattice work on the door the priest uses to enter and exit. A heavy, dark blue curtain covers the side a sinner would enter to confess.
    - else:
        You approach the confessional booth.

}

{

    - !confessional_priest:
        *[Enter through the door]
        ->Confessional.Door
    - !confessional_sin:
        *[Enter through the curtain]
        ->Confessional.Curtain

}


= Door
~ confessional_priest = true
You sit on the cold wooden bench. Just like the outside, the inside doesn't have many details. The grate that a priest would speak through has the same lattice work that the door does. 

You look around the cramed space and find nothing. The booth is empty. (if: $confessional_sin)[You already found a key, what more could be in the booth?](else:)[You don't know what you were expecting.]

[[Exit the booth]]

[[Look again]]
-> END

= Curtain
~ confessional_sin = true
#play: curtain
You sit on the cold wooden bench. Just like the outside, the inside doesn't have many details. The grate that a priest would speak through has the same lattice work that the door does. 

A small bucket sits in the corner by the divider. You assume the booth must leak, but the bucket is empty.

There is nothing remotely resembling the heart in here. What were you expecting? Why did you enter?

*[To Confess]
~temp_bool = true
"What is it you have to confess?" You jump at the deep voice comes from the other side of the screen. "I am here to listen."

*[To Look for Clues]
~temp_bool = false
You look around the small space again, touching the smooth wood to find anything your eyes might miss.

"Looking for something?" You jump at the deep voice comes from the other side of the screen. "I may be able to help?"

*[You Don't Know]
~temp_bool = false
"Lost are we?" You jump at the deep voice comes from the other side of the screen. "Maybe I can help?"

- Your heart races, and your entire body tenses. Another person? Here? Do they know about the heart? Can you trust them? 

*["Have you seen a heart?"]
#delay: 1
"I cannot say I have." he chuckles. "Unless you mean your own? Maybe a confession would help you find it?"

*["Who are you?"]
#delay: 1
"Does that matter?" he asks. <>
{
    - temp_bool: "I will ask again: What is it you have to confess?"
    - else: "Do you have something to confess?"
}

*[Leave the booth]
#play: curtain
You quickly leave the booth, and stare at the confessional. It's quiet. You're not sure what's in there, but you do know that you don't want to speak to it.
    
There was nothing in there, anyway. You should look for the heart elsewhere for now. You look...
-> Confessional.Leave

- 
#play: liquid-drop
_Plink!_ A drop of water falls into the bucket.

{
    - stay >= 1.5:
    You wring your hands together. A confession? Talking to someone might talk your mind off of things...
    
    You take a deep breath, suddenly nervous.
    
        *[Talk about work]
            -> Confessional.Work_Confession
        *[Talk about something personal]
            -> Confessional.Personal_Confession
        *[Talk about nothing]
            -> Confessional.No_Confession
    - else:
        *["Tell me who you are first."]
            ~temp_bool = true
            {
                - confessional_priest: "Hmm..." The voice grunts. "[[I am a pastor here,]] is that not obvious?"
                - else: "Hmm..." The voice grunts. "I am a pastor here, is that not obvious?"
            }
            
            You frown, "No, that's not what-"

            "I do not have all day, and there are others waiting their turn." The voice cuts you off. "So this is the last time I'll ask you this: What. Do. You. Wish. To. Confess?"

            -> Confessional.Question
            
        *["Are you part of the church?"]
            ~temp_bool = false
            {
                - confessional_priest: "[[As a man of cloth,]] I assume I must be. What an odd question to ask."
                - else: "As a man of cloth, I assume I must be. What an odd question to ask."
            }
            

            You frown, "No, that's not what-"

            "I do not have all day, and there are others waiting their turn." The voice cuts you off. "So this is the last time I'll ask you this: What. Do. You. Wish. To. Confess?"

            ->Confessional.Question

        *[Leave the booth]
        #play: curtain
        You don't care to find out and quickly leave the booth. You stare at the confessional. It's quiet. You're not sure what's in there, but you do know that you don't want to speak to it.
        
        There was nothing in there, anyway. You should look for the heart elsewhere for now. You look...
        -> Confessional.Leave
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

#delay: 1.5
{temp_string}

#play: liquid-drop
_Plink!_

#delay: 3
The voice is silent. You squirm uncomfortably in your seat. The next words you seem to just tumble out.

- #delay: 1
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

#play: liquid-drop #play: 2, liquid-drop
_Plink! Plink!_

"I see..." The voice is quiet for a moment before continuing, "Do you {temp_string}

*[Agree with the voice]
~temp_bool = true

*[Disagree with the voice] 
~temp_bool = false

- 

{
    - temp_bool:
        #delay: 1
        You nod. Your chest is tight.
        
        #play: liquid-drop #play: 1, liquid-drop
        _Plink! Plink!_
        
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
        #delay: 1
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
        #delay: 1
        You hesitate. Do you? {temp_string}
    - else:
        {
            - work == 1 or work == 2:
                ~temp_string = "_You_ choose to push people away. It's not their fault if they decide to stop when all you do is push them away."
            - work == 3:
                ~temp_string = "A job is just that. A job. They may not value you the way you wish they would, but maybe it's time to look for one that does."
        }
        It makes you angry, the way they treat you, but... {temp_string} 
    
}
~temp_bool = false

- 

{
    - temp_bool:
        #play: liquid-drop
        _Plink!_ The bucket is half full.

        "I understand. Do you feel a sense of relief now?" You do. You feel a little lighter after saying it out loud. "Knowing you don't have to go back to that?"

        Your stomach drops.
        
        *["What?"]
        ->Confessional.Middle

        *["I don't...?"]
        ->Confessional.Middle
    
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
    
    The voice cuts you off. "From what you told me, you are _miserable_ out there!" The voice is loud, andyou jump in your seat. "The church has so much to offer you. And you are _here_ now, safe in the church's embrace. Aren't you happier here?"
    
    #delay: 1.5
    Safe? Happy? You think about everything you've experienced up til now. {temp_string}look at the ceiling of the booth. Is this any better or worse than your day to day? You're not sure how to feel.

    #play: liquid-drop
    _Plink!_ The bucket is filling fast. You can see that the [[liquid]] seems... thicker than just water.
    
    *[liquid]
    ->Confessional.liquid
    
    *["I don't want to be here."]
    The rapid drips from the leak stop. "You must be mistaken." The voice laughs, an angry and cruel laugh. "You don't _want_ to be here? How dare you-"
    ->Confessional.Reject

    *[Stay silent.]
    ->Confessional.Agree
}

= liquid
You look closer. The liquid in the bucket is slightly viscous. It looks almsot like-

"Well?" The voice is growing impatient. You tense. "Aren't you happier here?"

*["Maybe..."]
->Confessional.Agree
*["I don't want to be here."]
The rapid drips from the leak stop. "You must be mistaken." The voice laughs, an angry and cruel laugh. "You don't _want_ to be here? How dare you-"
->Confessional.Reject

*["I don't know.]
->Confessional.Agree

= Middle
#play: liquid-drop
_Plink!_

{
    - work == 1 or work == 3:
        #delay: 1.5
        "You say you are not worthy of the concern of others. You keep to yourself, so your work." The voice is gentle. "But you are here now, safe in the church's embrace. Aren't you happier here?"
    - work == 2:
        #delay: 1.5
        "You don't think you could have done better, that you worked harder to make up for it. And yet, your efforts fell to deaf ears." The voice is gentle. "But you are here now, safe in the church's embrace. Aren't you happier here?"
}

#play: liquid-drop
_Plink!_

The bucket is filling fast. You can see that the [[liquid]] seems... thicker than just water.

*[liquid]
->Confessional.liquid
    
*["I don't want to be here."]
The rapid drips from the leak stop. "You must be mistaken." The voice laughs, an angry and cruel laugh. "You don't _want_ to be here? How dare you-"
->Confessional.Reject

*[Stay silent.]
->Confessional.Agree

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
        ~temp_string += "When I tried to escape, it _taunted_ me with a {object}. "
}

"{temp_string}When I wanted to _leave_ the church _would not let me."_ You clench your fists. "So tell me, how I am mistaken?"

*[The voice is silent.]

-

#style: shudder #play: banging-confession #delay: 0.5
Bang! <>
#play: banging-confession #delay: 0.5
Bang! <>
#play: banging-confession #delay: 2
Bang!

The wood divider splinters as whatever is on the otherside slams into it. "HOW could you be so IGNORANT? So UNGRATFUL? SO STUPID?" The calm softness it used to speak to you before is gone. It's angry.

The bucket tips over, and the liquid spills out. It sticks to your shoes, much thicker than water.

*[Is that... saliva?]

- #style: shudder #play: banging-confession #delay: 0.5
Bang! <>
#play: banging-confession #delay: 0.5
Bang! <>
#play: banging-confession #delay: 2
Bang!

"It only want to HELP you. It LET you go, to SHOW you that. How UN-GRATE-FUL." With enery sylable it slams into the wood. The grate it has been talking through falls onto your side of the conessional. It's voice screetches. "STUPID STUPID STUPID STUPID!"

The booth could come apart at any moment. You need to get out of here.

*[Get out of the confessional]
-> Confessional.Get_Out
*[Look into the other side]
-> Confessional.Look

= Get_Out
#style: shudder #play: banging-confession #delay: 0.5
Bang! <>
#play: banging-confession #delay: 0.5
Bang! <>
#play: banging-confession #delay: 2
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

    #style: shudder #play: banging-confession #delay: 0.5
    Bang! <>
    #play: banging-confession #delay: 0.5
    Bang! <>
    #play: banging-confession #delay: 2
    Bang!


{

- temp_bool:
    Carefully, you approach the door. Whatever is inside has started to wail and scream. You place your hand on the knob.

    ~temp_string = "Turn the handle"
- else:
    You stand outside the confessional, waiting for whatever's inside to stop. Whatever is inside has continues to scream and curse at you. _How STUPID! How UNGRATEFUL!_

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

~ confessional_priest = true
*[Exit the confessional booth.]
->After_First

= Look
#style: shudder #play: banging-confession #delay: 0.5
Bang! <>
#play: banging-confession #delay: 0.5
Bang! <>
#play: banging-confession #delay: 2
Bang!

You cover your face as wooden splinters fly toward you, and take a step closer to the hole in the divider. You raise your flashlight, and peer through the hole.

*[Turn on the flashlight]

- 
#play: click-on #effect: flashlight, true
The flash light clicks on, and everything stops.

Tthe otherside is pristine. It looks almost identical to the side you had been on. No one is insdie.

On the bench sits a small key. 

*[Reach your arm through]
~temp_bool = true
*[Go around]
~temp_bool = false

- 

{

- temp_bool:
    #play: click-off #effect: flashlight, false
    You place the flashlight back in your pocket, and reach your arm through. blindly feeling around.  Your fingertips just barely brush the bench it's sitting on. 

    You reach in deeper, your face pressing against the mangled wood. "Just a bit... more..." you mumble to yourself. 
    
    Your fingers brush against the key again when a cold hand grabs your arm. You jerk away, but it holds tight, fingers digging into your wrist.

    "Making the church angry will not help you." It's the gruff voice from earlier. "Fighting against it is meaningless."

    Something cold and metal is placed into your palm, and you're released. You yank your arm back through the opening, falling into the opposite side. In your hand is the key.
    
    The booth is quiet, save for your own breathing. You place the key in your pocket.


- else:
    #play: click-off #effect: flashlight, false
    You exit through the curtain, face the priest's door. You take a deep breath, and open it. The key sits on the bench, but more surprisingly, the divider is no longer splintered, and the seperating grate is back in place.

    The church fixed itself. 
    
    You quickly step inside, grab the key, and leave the booth. You shove the key in your pocket, hoping it will be useful later.
}

~ confessional_priest = true
*[Exit the confessional booth.]
->After_First

= Agree
#delay: 1
You work everyday and for what?" 

#play: liquid-drop #play: 1, liquid-drop #play: 1, liquid-drop
_Plink! Plink! Plink!_

#delay: 1
The words get stuck in your throat.

#play: liquid-drop #play: 1, liquid-drop #play: 1, liquid-drop
_Plink! Plink! Plink!_

#delay: 2
"The church can feel... perplexing... at first, but it doesn't bring you here without reason. It wants to help- to heal the harm dealt to you out _there."_ The voice is calming. It makes sense. Why else would you be here? "The church would never hurt you. Could never hurt you."
{
    - know or leave_light or object != "":
        ~temp_string = "You know shouldn't listen. You know its... it's another trick. After everything, you know this, but..."
    -else:
        ~temp_string = "The voice is making sense. You were scared and rejected anything the church offered you. Maybe if you hadn't rejected it so strongly then..."
}

#play: liquid-drop #play: 1, liquid-drop #play: 1, liquid-drop
_Plink! Plink! Plink!_

You clench and unclench your hands. {temp_string}

*["Maybe you are right..."]

*["No..."]
{
    - know or leave_light:
       You need to stay strong. You didn't come here of your own will. You've wanted to leave from the start.
    -else:
       You shake the thought from your head. You can't let the voice's sweet words posin your mind.
}

->Confessional.Reject_Version_2

-
#play: liquid-drop #play: 1, liquid-drop #play: 1, liquid-drop
_Plink! Plink! Plink!_

The leak is dripping faster now. The bucket is spilling over. The viscous liquid contains small bubbles as it crawls over the floor. 

"Stop fighting. Has the church harmed you?" 

{
    - leave_light:
    *[The church was angry..."]
    "It screamed at me. It- It burned me..." You shutter at the memory. 
    
    The rapid drips from the leak stop. "Angry...?" The voice laughs. "You must be mistaken. The church would never-"
    ->Confessional.Reject
}

*["No..".]

*["When it brought me here..."]

- ~stay += 1
"When it brought you here, that must have been frightening. Change always is."

#delay: 1
You nod.

#play: liquid-drop #play: 1, liquid-drop #play: 1, liquid-drop
_Plink! Plink! Plink!_

The liquid crawls towards your shoes. You don't think it's water at all. 

"I am sorry, but all the church wants is to give you more than the world out there." You nod. "The church only wants the best for you. So, just. Stop. Fighting."

*You nod.

- 

#play: key-thrown
_Plunk!_

A small key falls into the bucket, causing the bucket to fall over, and the liquid to spill onto the floor. You lift your feet to avoid your shoes from soaking through, and the liquid streches like you stepped in gum. Is this...? You gag.

"A gift for you. An olive branch of sorts." You hear the door close, and you know you are alone.

*[Pick up the key]

- You grab it out of the pool of liquid. It's sticky and thick, almost like... Your stomach churns. Saliva?

You wipe the key off using the confessional curtain, and stick it in your pocket. You look at the grate the voice spoke to you through. 

You wonder if you'll meet it again.

~ confessional_priest = true
*[Exit the confessional booth.]
->After_First

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
        ~temp_string += "When I tried to escape, it _taunted_ me with a {object}. "
}

"{temp_string}When I wanted to _leave_ the church _would not let me."_ You clench your fists. "So tell me, how is that not _harm?"_

*[The voice is silent.]

-

#style: shudder #play: banging-confession #delay: 0.5
Bang! <>
#play: banging-confession #delay: 0.5
Bang! <>
#play: banging-confession #delay: 2
Bang!

The wood divider splinters as whatever is on the otherside slams into it. "HOW could you be so IGNORANT? So UNGRATFUL? SO STUPID?" The calm softness it used to speak to you before is gone. It's angry.

The bucket tips over, and the liquid spills out. It sticks to your shoes, much thicker than water.

*[Is that... saliva?]

- #style: shudder #play: banging-confession #delay: 0.5
Bang! <>
#play: banging-confession #delay: 0.5
Bang! <>
#play: banging-confession #delay: 2
Bang!

"It only want to HELP you. It LET you go, to SHOW you that. How UN-GRATE-FUL." With enery sylable it slams into the wood. The grate it has been talking through falls onto your side of the conessional. It's voice screetches. "STUPID STUPID STUPID STUPID!"

The booth could come apart at any moment. You need to get out of here.

*[Get out of the confessional]
-> Confessional.Get_Out
*[Look into the other side]
-> Confessional.Look

->END

= Personal_Confession
->END

= No_Confession
#delay: 1
"Nothing. I have nothing to confess."

#play: liquid-drop
_Plink!_

#delay: 1
"Nothing at all?" The voice on the other side chuckles. "Nothing at work? At home? You haven't hurt anyone? Done anything wrong?"

#play: liquid-drop
_Plink!_

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
        ->Confessional.No_Talk
    {
        - stay <= 1:
            *[Wait]
            -> Confessional.Wait
    }
- else:
    *[Talk about it]
        {
            - temp_bool_2:
                ->Confessional.Work_Confession
            - else:
                ->Confessional.Personal_Confession
        }
    *[Don't talk about it]
        "No, nothing to tell. My life is a routine, and work is no different." You tap your fingers against the bench. "I wake up, go to work, come home, watch TV while eating dinner, and go to bed." 
        ->Confessional.No_Talk


}
= Wait
You squirm uncomfortably in your seat. The quiet seems deafening. 

*[Fill the silence.]
    "I wake up, go to work, come home, watch TV while eating dinner, and go to bed." You wring your hands together, suddenly embarrassed. "It's a routine. There's nothing to tell."
    ->Confessional.No_Talk

*[Continue waiting]
    ~stubborn = true
- Finally, the voice breaks the silence.

"You are more... stuborn than expected." The voice spits out the words. "But I can wait for as long as you need. I have _all_ the time in the world."

    Your skin crawls. The silence returns.

*[Fill the silence.]
    "I wake up, go to work, come home, watch TV while eating dinner, and go to bed." You wring your hands together, suddenly embarrassed. "It's a routine. There's nothing to tell."
    ->Confessional.No_Talk

*[Leave the booth]
    #play: curtain
    You stand and leave the booth. You stare at the confessional. It's quiet. You're not sure what's in there, but you're at a stalemate with whatever was on the other side. If you're not going to talk, there's no reason to stick around.
        
    You should look for the heart elsewhere for now. You look...
    -> Confessional.Leave
    
    
= No_Talk
#play: liquid-drop
_Plink!_

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
        #delay: 1
        You feel yourself nodding. "I... My job is a means to an end. It's enought to keep me alive, but not enough to... do more..."
        
        #play: liquid-drop
        _Plink!_
        
        "I see. So why {temp_string} then?"
    - else:
        {
            - stay <= 1:
                ~temp_string = "So, is this why fight the church?"
            - else:
                ~temp_string = "And yet you wish to stay? To choose the church?"
        }
        #delay: 1
        "No, I..." You shake your head. "My life is still mine. This is what I chose." You clench your fists.
    
        #play: liquid-drop
        _Plink!_
        
        {temp_string}

}

*["What?"]

*[Stay silent.]

- #play: liquid-drop
_Plink!_

        {
            - stay <= 1:
                ~temp_string = "Of course you fight the church. You want to _leave._"
            - else:
                ~temp_string = "Stay? When have you ever wished to..."
        }

What is it talking about? {temp_string}

        {
            - stay <= 1:
                ~temp_string = "So, this is why fight the church?"
            - else:
                ~temp_string = "And yet you wish to stay?"
        }

"You can say you're content with your life _out there,_ but we both know you want to stay _here"_ The voice becomes harder as it speaks. "The church has so much to offer you, you know this. {temp_string}"

#play: liquid-drop #play: 1, liquid-drop #play: 1, liquid-drop
_Plink! Plink! Plink!_

*["What?"]

*[Stay silent.]


- 





->END

= Question
You don't think you will get an answer. The voice is pushing you to confess.

You take a deep breath. You need to confess something? Fine.
{
    - confessional_priest:
        
        {
            - temp_bool:
                *[I am a pastor here,]
                    ->Confessional.Know_Father
            - else: 
                *[As a man of cloth,]
                ->Confessional.Know_Father
        }
        
}

*[Talk about work]
    -> Confessional.Work_Confession
*[Talk about personal]
    -> Confessional.Personal_Confession
*[Talk about nothing]
    -> Confessional.No_Confession
            
*[Leave the booth]
#play: curtain
You quickly leave the booth, and stare at the confessional. It's quiet. Whatever is in there, it won't tell you anything important. And you don't like that it was pushing you to "confess."
    
There was nothing in there, anyway. You should look for the heart elsewhere for now. You look...
-> Confessional.Leave

= Know_Father
~ church_anger += 0.5
Something clicks into place. "I... know who you are..."

"Do you now?" he laughs coldly.

"You're the father of-"

"The church. I do not have all day, and there are others waiting their turn." His voice is short. "So this is the last time I'll ask you this: What. Do. You. Wish. To. Confess?"

You frown, "No, that's not what-" A gutter growl cuts you off. You don't think you should [[push the matter]]. The voice is pushing you to confess, maybe you can learn more if you play along?

You take a deep breath. You need to confess something? Fine.

*[push the matter]

*[Talk about work]
    -> Confessional.Work_Confession
*[Talk about personal]
    -> Confessional.Personal_Confession
*[Talk about nothing]
    -> Confessional.No_Confession

*[Leave the booth]
#play: curtain
Without a second thought, you rush out of the booth. You stare at the confessional. It's quiet. You're not sure what's in there, but you do know that you don't want to speak to it, let alone confess.
        
There was nothing in there, anyway. You should look for the heart elsewhere for now. You look...
-> Confessional.Leave

- "No, the father of that girl."

#plau: groaning-angry, 2
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
#delay: 0.75
~ church_anger += 1

#play: screeching #style: shudder #delay: 2.5
An earpiecing shriek fills the booth{temp_string} You plug your ears to no avail.

#style: shudder #play: banging-confession #delay: 0.5
Bang! 
#play: banging-confession #delay: 0.5
Bang!
#play: banging-confession #delay: 2
Bang!

#style: dissolve
The wood divider splinters a bit as whatever is on the otherside slams into it. "Shut up shut up shut up SHUT UP" His voice warms and contorts into something non-human.

*[Lunge for the door]

- #play: lock-rattle #delay: 2.5
It won't open. It's locked.

#style: shudder #play: banging-confession #delay: 0.5
Bang! 
#play: banging-confession #delay: 0.5
Bang!
#play: banging-confession #delay: 2
Bang!

#style: dissolve
The divider between you is barely holding up. The wood is splinters while that- that _thing_ shouts and curses you.

"I hate hate hate hate hate HATE you. You DARE speak of things you don't understand?!"

*[Throw yourself at the door.]

-
#delay: 0.75
~ church_anger += 1

#play: screeching #style: shudder #delay: 2.5
The thing shrieks again. "You will not escape this time.

#style: shudder #play: banging-confession #delay: 0.5
Bang! 
#play: banging-confession #delay: 0.5
Bang!
#play: banging-confession #delay: 2
Bang!

#style: dissolve
The divder splits and falls, revealing the thing on the other side. You fall to the floor and push yourself against the wall, trying to get as far away as yuo possibly can.

*[You can't... What is...]

- It takes a step into your booth, impossibly tall. Impossibly long. Your eyes can't accept what they're seeing. 

It has no legs except when it does. Deer hooves that disappear as soon as they step down, only to replaced with a newer one with it's next step, like a cascading waterfall of legs. It grabs the edge of the booth with its  <hands, claws, tentacles, paws, wings>. A human hand morphing into a infinitiely splitting claw morphing into a featherd limb that curls and grabs anything within reach.

It says something that reverberates inside your brain. Words that hold meaning you understand in a way that you can't explain. Changing your thoughts, your feelings. Something wet sharply forces your face up, and your eyes lock on it's face. It's true face.

*A single tear rolls down your cheek.

- 

*You've never known solace like this.
->Credits

= Leave
~confessional_sin = false

*[In the pews]
-> Pews

*[Somewhere up the stairs]
-> Stairs