=== Confessional_Curtain ===
~ current_area = Confessional_CurtainSide 
~ Have_Visited += (Confessional_CurtainSide)
{
    //if this is the first area we are visiting
    - visited_state <= 0:
        ~ PlaySFX("curtain", false, 0, 0)
        You push aside the curtain and find a small, mostly empty room. A slab of wood juts out from the far wall, creating an uncomfortable bench, and a small bucket sits in the corner by the divider. You assume the booth must leak, but the bucket is empty. #IMAGE: Default #PROP: [curtain_full false]
        
        You think you'd know if there were anything else in here.
        
        *[Search the area anyway]
            You don't know what the heart even is, so you may as well check every inch of this place. You sigh and hold the flashlight in your mouth while you lightly brush your hands across every surface. Under the bench, in the bucket, even wiping away the cobwebs gathered in the corners.
            
            You plop onto wooden bench, and rub your eyes. There's nothing here. Of course not. What did you expect? Why did you enter?
            
            -> Confessional_Curtain.Nothing_Here(true)
        
        *[What is the point of searching?]
            ~ Stay_Tracker += 0.5
            You plop onto wooden bench, and stare into dark abyss that is the church. If the heart is the church's weakness, it's not going to be left in the open or easy to find. There's no way to know if it even <i>exists.</i> There's no way of knowing if that voice was even really here to help you or just another trick of the church. #IMAGE: Default #PROP: [curtain_full false]
            
            Of course the confessional is empty. What did you expect? Why did you enter?
            -> Confessional_Curtain.Nothing_Here(false)
        
    - visited_state == 1:
        {
            - previous_area != Enter_Pews:
                While you wait for the service to be over, you look around the cramped space for something useful. #IMAGE: Default #PROP: [curtain_full false]
    
                A small bucket sits in the corner by the divider. You assume the booth must leak, but the bucket is empty.
            
                You find nothing. The booth is empty.
            
                The rumbling of the sound outside have gone quiet, and when you peak out again, the people and red light are gone. It's probably safe to leave now.
                
                You sigh in relief, and move to leave when you hear a voice float through the grate. 
                
                "Already leaving?" You freeze. The voice is deep. "Why did you enter only to leave? Aren't you looking for something?"
                ->Confessional_Curtain.Why_Enter
            - else:
                //We come here if it's after the pews 1st choice
                You decide to check the confessional. You saw the curtain move, someone <i>must</i> be in there. Carefully and quietly, you approach it. #IMAGE: Confessional_CloseUp #PROP: [curtain_full true]
                
                Once in front of it, you think you can hear shuffling from inside. You steel yourself, and rip the curtain open. #IMAGE: Default #PROP: [curtain_full false]
                
                It's empty. "Ha.. Hahaha..." you laugh and step inside. {Confessional_Encounters ? (Finished_Door_Side): It's almost identical to the other side. | The grate that a priest would speak through has the same lattice work that the door does. } A small bucket sits in the corner by the divider.
                
                You plop onto wooden bench, and rub your eyes. There's nothing here. There's no <i>one</i> here. Of course not. What did you expect? Why did you enter?
                -> Confessional_Curtain.Nothing_Here(true)
        }
    - else:
        You push aside the curtain, and sit on the cold, wooden bench. {Confessional_Encounters ? (Finished_Door_Side): The booth almost identical to the other side. A small bucket sits in the corner by the divider. You assume the booth must leak, but the bucket is empty.| The booth is small and empty, save for a small bucket sitting in the corner. You assume the booth must leak, but the bucket is empty. The grate that a priest would speak through has the same lattice work that the door does. } #IMAGE: Default #PROP: [curtain_full false]
    
        {Confessional_Encounters ? (Finished_Door_Side): What are you expecting to find here? Why did you enter? | There is nothing remotely resembling the heart in here. What were you expecting? Why did you enter?}
        -> Confessional_Curtain.Nothing_Here(true)
}

= Nothing_Here(checked_area)
*[To confess]
    #PLAY: curtain 
    ~ PlaySFX("curtain", false, 0, 0)
    ~temp_bool = true
    "What is it you have to confess?" The curtain zips closed and you jump at the deep voice coming from the other side of the screen. "I am here to listen."

* {checked_area} [To look for clues]
    ~temp_bool = false
    You look around the small space again, touching the smooth wood to find anything you may have missed.
    
    
    ~ PlaySFX("curtain", false, 0, 0)
    "Looking for something?" The curtain zips closed and you jump at the deep voice coming from the other side of the screen. "I may be able to help?"#PLAY: curtain 

*[You don't know]
    
    ~temp_bool = false
    ~ PlaySFX("curtain", false, 0, 0)
    "Lost are we?" The curtain zips closed and you jump at the deep voice coming from the other side of the screen. "Maybe I can help?"#PLAY: curtain 


- ->Confessional_Curtain.Why_Enter

= Why_Enter
Your heart races and your body tenses. Another person? Will they help you? Can you trust them? {Confessional_Encounters ? (Killed_Girl):  ... Will it end the same way it did with {Book_Knowledge ? Read_Mom_Young_Book: the young Ophelia| the girl}?}

*["Have you seen a heart?"]
    "I cannot say I have." He chuckles. "Unless you mean your own? Maybe a confession would help you find it?"

*["Who are you?"]
    "That does not matter." He says. {temp_bool: "I will ask again: What is it you have to confess?" | "Do you have something to confess?"}

- 
~ PlaySFX("leak", false, 0, 0)
<i>Plink!</i> A drop of water falls into the bucket. {Stay_Tracker < 1.5: You frown and point your flashlight at the corner. You don't hear rain from outside.}

"Well?" He prods you. {Stay_Tracker < 1.5: You set the flashlight on the bench beside you and ignore the leak.}

*[Confess]
    ~ Stay_Tracker += 1
    You wring your hands together. A confession? Talking to someone might talk your mind off of things...
    
    You take a deep breath, suddenly nervous.
    
        **[Talk about work]
            -> Confessional_Curtain.Work_Confession
        **[Talk about something personal]
            -> Confessional_Curtain.Personal_Confession
            
*["Tell me who you are first."]
    {
        - Confessional_Encounters ? (Finished_Door_Side): 
            #REPLACE: I am a pastor here,
            "Hmm..." The voice grunts. "[I am a pastor here,] is that not obvious?"
        - else: "Hmm..." The voice grunts. "I am a pastor here, is that not obvious?"
    }

    -> Confessional_Curtain.Question(true)
            
*["Are you part of the church?"]
    {
        - Confessional_Encounters ? (Finished_Door_Side): 
            #REPLACE: As a man of cloth,
            "[As a man of cloth,] I assume I must be. What an odd question to ask."
        - else: "As a man of cloth, I assume I must be. What an odd question to ask."
    }

    ->Confessional_Curtain.Question(false)

= Question(replace)
#DELAY: 0.5
You frown, "No, that's not what-"

"I do not have all day, and there are others waiting their turn." The voice cuts you off. "So this is the last time I'll ask you this: What. Do. You. Wish. To. Confess?"

You don't think you'll get a straightforward answer. You take a deep breath. You need to confess something? Fine. {Stay_Tracker < 2: He never said you have to say anything useful. You'll say enough to satisfy him and then push for more answers. | It might help you get some things off your chest. This could be... therapeutic. You can push for answers later. }
{
    - Confessional_Encounters ? (Finished_Door_Side):
        
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
*{Stay_Tracker < 2} [Talk about nothing]
    -> Confessional_Curtain.No_Confession
            
* {Stay_Tracker < 1} [Leave the booth]
    You need to confess something? No. No, you won't play along. For all you know this is another attempt by the church to get you to stay.

~ PlaySFX("curtain", false, 0, 0)
You swiftly leave the booth, and stare at the confessional. It's quiet. Whatever is in there, it won't tell you anything important. And you don't like that it was pushing you to "confess."
    
There was nothing in there, anyway. You should look for the heart elsewhere for now. 
->Confessional_Curtain.Leave_NoProgress

= Work_Confession
~ temp Temp_String = ""
{
    - Work_Encounter == Scanner_Interaction:
        ~Temp_String = "\"I sent multiple wrong copies to a department. I only realized when a coworker called me out. She seemed worried about me, but... I don't know.\""
    - Work_Encounter == Wrong_Email:
        ~Temp_String = "\"I think I was fired.\" You laugh. \"I sent a nonsense email to our biggest client and they were very upset. My supervisor was really, really mad at me.\""
    - Work_Encounter == Attack_Coworker:
        ~Temp_String = "\"A coworker was trying to help me today, but I kinda hit him...\""
    - Work_Encounter == Fired:
        ~Temp_String = "\"I was fired today!\" You laugh. \"I stood up to my boss, and that's all it took!\""
    - Work_Encounter == Leave_Suddenly:
        ~Temp_String = "\"I... I just left!\" You laugh. \"I did something for me for once and left!\""
}

"Today was awful. I was never the best worker at my job, but today was particularly bad." You trace the wooden grooves of the wall with your finger. {Stay_Tracker < 2: Your face becomes warm at the memory, but keep your voice steady. | The words feel stuck in your throat as you recall your day. }

{Temp_String}

~ PlaySFX("leak", false, 0, 0)
<i>Plink!</i>#DELAY: 1

The voice is silent. You squirm uncomfortably in your seat. You press your lips firmly together and chew the inside of your cheek. #DELAY: 3

{Stay_Tracker < 2: <> You want to keep silent, but the silence feels too loud. | <> What you say next seems to just tumble out.}


{ 
- Stay_Tracker < 2: 
        #DELAY: 3
        You need to say something. There's an itch caught in your throat, begging you to speak. You chomp down onto a chunk of the inside of your bottom lip. Your mouth taste like copper.

        What you say next seems to just tumble out.
}

{
    - Work_Encounter == Scanner_Interaction:
        "I— We rarely talk, but her concern felt so foreign. I didn't know what to do with it, so I just... I just left."
        ~Temp_String = "often ignore or push away the ones who reach out first?\""
    -Work_Encounter == Wrong_Email:
        "My supervisor has always looked out for me even though I never meet their standards. I think this was the straw that broke the camel's back." You fidget with your nail. "The look they gave me..."
        ~Temp_String = "think you did all you could?\""
    - Work_Encounter == Attack_Coworker:
        "I had never spoken to him before— I— I mainly keep to myself at work. I didn't even realize he was there until... He wasn't too happy with me."
        ~Temp_String = "often ignore or push away the ones who reach out first?\""
    - Work_Encounter == Fired:
        "I can't say I'm too upset about it. She hated me and was looking for a way to get rid of me. No matter how hard I worked, nothing was enough."
        ~Temp_String = "often sabotage yourself?\""
    - Work_Encounter == Leave_Suddenly:
        "I think I regret it since... Well, since I ended up stuck here!"
         ~Temp_String = "think that maybe it was all for a reason? Coming here?\""
        
}

~ PlaySFX("leak", false, 0, 0)
~ PlaySFX("leak", false, 0, 0.25)
<i>Plink! Plink!</i> #DELAY: 1

"I see..." The voice is quiet for a moment{Work_Encounter == Leave_Suddenly:, and you wince, realizing how that would sound to a pastor. He continues, | before continuing,} "Do you {Temp_String}

~ temp Temp_Bool = false

*[Agree]
    ~Temp_Bool = true

*[Disagree] 
    ~Temp_Bool = false

- 

{
    - Temp_Bool:
        You nod. Your chest is tight.
        
        ~ PlaySFX("leak", false, 0, 0)
        ~ PlaySFX("leak", false, 0, 0.25)
        <i>Plink! Plink!</i>#DELAY: 1.5
        
        {
            -  Work_Encounter == Attack_Coworker or  Work_Encounter == Scanner_Interaction:
                "Do you feel unworthy of their concern?"
                ~Temp_String = "feel this way?"
            - Work_Encounter == Leave_Suddenly:
                "That's wonderful to hear!" The voice is smiling. Proud of you. "Are you sure you regret it then? Staying here?"
                ~Temp_String = "feel this way?"
            - else:
                {Work_Encounter == Wrong_Email: "But you keep working hard anyway? When they only focus on your failures?"| "And you work hard anyway?"}
                ~Temp_String = "do that?"
        }
    
    - else:
        {
            - Work_Encounter == Leave_Suddenly:
                ~Temp_String = "to how everything unfolded. Maybe. Maybe it was all meant to happen. Fate. Or maybe it was all the church."
            - Work_Encounter != Fired and Work_Encounter != Wrong_Email:
                ~Temp_String = "small talk in the kitchen. How your coworkers offer to let you join them for lunch, but you always turn them down. How you don't have many, if any, work friends. How anyone who reaches out first is met with a swift denial."
            - else:
                ~Temp_String = "overlooked promotions. When you finally felt you proved yourself on a project, and your efforts were met with a pat on the back. How even after pushing the issue, your emails didn't get a response. How no matter what you did, how hard you worked, you got nothing in return."
        }
        
        You shake your head. {Work_Encounter == Leave_Suddenly: "I don't think, so. It was-" | "I can't say that's the case. Today was—"}

        "A fluke? {Work_Encounter == Leave_Suddenly: A coincidence|A one off}?{Work_Encounter == Wrong_Email or Work_Encounter == Fired: You were <i>fired</i> over it.}" The voice sneers. "{Work_Encounter == Leave_Suddenly:How can you be so sure|Are you so sure}?"

        You flinch at it's tone,{Stay_Tracker < 2: and grip the bench. Was that because you disagreed with it? You let out a breath and rest your head against the wall. | and look at your shoes. Did you say something wrong? You mumble an apology and kick the floor.}
        
        "I'm not scolding you." The voice softens, and {Stay_Tracker < 2: you lessen your grip. Maybe you were overreacting? | some of your anxiety alleviates. You sit up a little straighter. } "But can you really {Work_Encounter == Leave_Suddenly:say this is all one big coincidence|say this was a one off event}?" 
        
        You think back to {Temp_String}
}

*[{Work_Encounter != Leave_Suddenly: {Temp_Bool: "I do." | "I can't."} | {Temp_Bool: "I don't." | "It isn't."}}]
    {
        - Temp_Bool: //agreed last time
            You hesitate, but nod. Why? Why do you {Temp_String} {Work_Encounter != Leave_Suddenly: What's the point?}
        - else: //disagreed last time
            You hesitate, but slowly, shake your head. The more you think, the more realize the voice is right.
        
    }
    ~Temp_Bool = true

*[{Work_Encounter != Leave_Suddenly: {Temp_Bool: "No... I don't." | "I can."} | {Temp_Bool: "I do". |"It is."}}]
    {
        - Temp_Bool: //agreed last time
            ~Temp_Bool = false
            {
                - Work_Encounter == Attack_Coworker or  Work_Encounter == Scanner_Interaction:
                   ~Temp_String = "Unworthy is a strong word. Can anyone be unworthy of another's time?"
                - Work_Encounter == Leave_Suddenly: 
                    ~Temp_String = "You think you do, but at the same time..."
                - else:
                   ~Temp_String = "You think you do, but at the same time..."
            }
            
            {Work_Encounter == Leave_Suddenly: You don't hesitate and the voice sneers, "I don't believe you."| You hesitate. Do you? {Temp_String}}
        - else: //disagreed last time
            ~Temp_Bool = false
            {
                - Work_Encounter == Attack_Coworker or Work_Encounter == Scanner_Interaction:
                    ~Temp_String = "<i>You</i> choose to push people away. It's not their fault if they decide to stop when all you do is push them away."
                - Work_Encounter == Leave_Suddenly:
                    ~Temp_String = ""
                - else:
                    ~Temp_String = "A job is just that. A job. They may not value you the way you wish they would, but maybe it's time to look for one that does."
            }
            {Work_Encounter == Leave_Suddenly: | It makes you angry, the way they treat you, but...} {Temp_String} 
    
    }
    
- 

{
    - Temp_Bool: //agreed last time
        ~ PlaySFX("leak", false, 0, 0)
        <i>Plink!</i> The bucket is half full.#DELAY: 1.5

        ~ PlayBGM("watched", true, 20, 0)
        ~ StopSFX("inside", 20, 0)
        "I understand. {Work_Encounter == Leave_Suddenly: It's that freeing? To say it out loud?" It is. You feel lighter. Freer.| Do you feel a sense of relief now?" You do. You feel a little lighter after someone saying it out loud.} You never understood the idea of confessionals, but you think you get it now. {Work_Encounter == Leave_Suddenly: Especially knowing |"Knowing} you don't have to go back?"

        Your stomach drops.
        
        *["What?"]
        ->Confessional_Curtain.Middle

        *["I don't...?"]
        ->Confessional_Curtain.Middle
    
    - else: //disagreed last time
        "I don't think—"
        
        ~ PlayBGM("watched", true, 20, 0)
        ~ StopSFX("inside", 20, 0)
        The voice cuts you off. "From what you told me, you are <i>miserable</i> out there!" The voice is loud, and you jump in your seat. "The church has so much to offer you. And you are <i>here</i> now, safe in the church's embrace. {Work_Encounter == Leave_Suddenly:It found you again, and brought you back. Back where you belong!|You <i>are</i> happier here, yes?}"
        
        #DELAY: 1.5
        Safe? Happy? You think about everything you've experienced up til now. {Church_Encounters !? (Leave_Light): Of the warmth you've felt. | Of the anger when you refused its light.} {RIPPED == (AT_WORK): Of your polaroid sitting in pieces in your desk. You | You touch the pocket that holds the pieces of your polaroid, and }look at the ceiling of the booth. {Stay_Tracker < 2.5: You chuckle to yourself. Is this what safety feels like? Happiness? | Is this any better or worse than your day to day? Worse than the struggle to stay in your boss' good graces so you can meet rent?}
    
        ~ PlaySFX("leak", false, 0, 0)
        <i>Plink!</i> The bucket is filling fast. You can see that the liquid seems... thicker than just water. #REPLACE: liquid
        
        *[liquid]
            ->Confessional_Curtain.liquid
        
        *["I don't want to be here."]
            The rapid drips from the leak stop. "You must be mistaken." The voice laughs, an angry and cruel laugh. "You <i>do</i> want to be here. You're just a bit confu—"
            ->Confessional_Curtain.Reject("how am I confused?")
    
        *[Stay silent]
            ->Confessional_Curtain.Agree
}

= liquid
You look closer. The liquid in the bucket is slightly viscous. It looks almost like— #DELAY: 0.25

"Well?" The voice is growing impatient. You tense. "You are happier here, yes?"

*["Maybe..."]
    ->Confessional_Curtain.Agree

* ["I don't want to be here."]
    The rapid drips from the leak stop. "You must be mistaken." The voice laughs, an angry and cruel laugh. "You <i>do</i> want to be here. You're just a bit confu-"
    ->Confessional_Curtain.Reject("how am I confused?")

*["I don't know.]
    ->Confessional_Curtain.Agree

= Middle
#PLAY: leak 
~ PlaySFX("leak", false, 0, 0)
<i>Plink!</i>#DELAY: 1.5

{
    - Work_Encounter == Attack_Coworker or  Work_Encounter == Scanner_Interaction:
        "You say you are not worthy of the concern of others and you keep to yourself." The voice is gentle. "But you are here now, safe in the church's embrace. You <i>are</i> happier here, yes?"
    - Work_Encounter == Leave_Suddenly:
        "It's like you said! It's fate that you came here. Aren't so <i>happy</i> that you're here now? Forever?"
    - else:
        "You don't think you could have done better, that you worked harder to make up for it. And yet, your efforts fell to deaf ears." The voice is gentle. "But you are here now, safe in the church's embrace. You <i>are</i> happier here, yes?"
}

#PLAY: leak 
~ PlaySFX("leak", false, 0, 0)
<i>Plink!</i>#DELAY: 1.5

#REPLACE: liquid
The bucket is filling fast. You can see that the liquid seems... thicker than just water.

*[liquid]
    ->Confessional_Curtain.liquid
    
*[Nod]
    ~Stay_Tracker += 0.5
    ->Confessional_Curtain.Agree
    
* ["I don't want to be here."]
    The rapid drips from the leak stop. "You must be mistaken." The voice laughs, an angry and cruel laugh. "You <i>do</i> want to be here. You're just a bit confu-"
    ->Confessional_Curtain.Reject("how am I confused?")

*[Stay silent]
    ->Confessional_Curtain.Agree

= Reject(reason)
~ Stay_Tracker -= 1
~ Confessional_Encounters += (Finished_Curtain_Side)
~ temp_string = "angry"

~ StopSFX("watched", 2.5, 0)
{reason != "": "{Walk_Home ? (Different_Path):When I tried to avoid the church, it pulled me back. }{Church_Encounters ? (Leave_Light):When I rejected it's sight, it burned me. }{Looked_For_Items:When I tried to escape, it <i>taunted</i> me with a {Object}. }When I wanted to <i>leave</i> the church <i>would not let me."</i> You clench your fists. "So tell me, {reason}"}

*[The voice is silent]

- 
~ Confessional_Encounters += (Angered_Priest)

~ PlaySFX("bang_confessional", false, 0, 0)
~ PlaySFX("climax_long", false, 0, 0)
~ PlayBGM("watched", true, 5, 0)
Bang!#CLASS: Bang_Confessional #DELAY: 1.75

The wood divider splinters as <s>the priest</s> whatever is on the other side slams into it. "HOW could you be so IGNORANT? So UNGRATEFUL? SO STUPID?" The calm softness <s>he</s> it used to speak to you before is gone. Its voice contorts and stretches as it changes from something human to something guttural and monstrous.

The bucket tips over, and the liquid spills out. It sticks to your shoes, much thicker than water.

*[Is that... saliva?]

- 
~ PlaySFX("bang_confessional", false, 0, 0)
Bang!#CLASS: Bang_Confessional #DELAY: 1.75

"It only want to HELP you. It LET you go, to SHOW you that. How UN-GRATE-FUL." With every syllable it slams into the wood. The grate it has been talking through falls onto your side of the confessional. It's voice screeches. "STUPID STUPID STUPID STUPID!"

The booth could come apart at any moment. You need to get out of here.

*[Get out of there]
    -> Confessional_Curtain.Get_Out

*[Look into the other side]
    -> Confessional_Curtain.Look_Other_Side

= Get_Out
~ PlaySFX("bang_confessional", false, 0, 0)
Bang!#CLASS: Bang_Confessional #DELAY: 1.75

You cover your face as tiny, stinging, wooden splinters fly toward you. You need to get OUT, before that... that THING gets IN.

~ PlaySFX("curtain", false, 0, 0)
You {Leg_State > Sore: hobble through the curtain as fast as you can | push through the curtain}, and turn to see the confessional shuttering under whatever inside continues banging on the walls. #IMAGE: Confessional_CloseUp #PROP: [curtain_full true]
~ temp Temp_Bool = false
~ temp Temp_String = ""

*[Open the confessional door]
    ~ Temp_Bool = true

*[Wait until it stops]
    ~ Temp_Bool = false

- 

~ PlaySFX("bang_confessional", false, 0, 0)
Bang!#CLASS: Bang_Confessional #DELAY: 1.75 #EFFECT: Shake_Confessional

{

- Temp_Bool:
    Warily, you approach the door. Whatever is inside has started to wail and scream. You place your hand on the knob. There's {Stay_Tracker >= 1.5:an unwanted | a} pang in your heart as you listen to it cry and beg you to stay. You steel yourself, ready to face whatever lies on the other side.

    ~Temp_String = "Turn the handle"
- else:
    You stand outside the confessional, waiting for whatever's inside to stop. Whatever is inside has continues to scream and curse at you. <i>How STUPID! How UNGRATEFUL!</i>

    The words echo throughout the space. You ignore it, and wait. 
    
    After a few moments, the screams turn to wails, to low moans, to quiet sobs. It begs you to reconsider. Begs you to understand. There's {Stay_Tracker >= 1.5:an unwanted | a} pang in your heart as you listen to it cry and beg you to stay.
    
    ~ StopSFX("watched", 5, 0)
    {Stay_Tracker >= 1.5: You dig your nails into your palms and stare at the floor. | You continue to ignore. Whatever is inside is made of the church. It would say anything to hurt you. To make you stay.}
    
    ~Temp_String = "It's quiet"
}

*[{Temp_String}]
    ~ StopSFX("watched", 0, 0)

- Inside, the booth is empty, and pristine. The divider is not splintered, and the separating grate is back in place. It looks almost identical to the side you had been on. 

#PROP: [skeleton_key true]
On the bench sits a small key. {Stay_Tracker >= 2: You pick it up and turn it over in your hands. Was this a gift? {Temp_Bool: | A peace offering from the creature that had once been here? } | You pick it up, and shove it in your pocket. You wonder why it gave it to you. If it was purposeful or not.} 

You offer the confessional one last look before moving on.

*[Return to your search]
    -> Confessional_Curtain.Leave_Progress

= Look_Other_Side
~ PlaySFX("bang_confessional", false, 0, 0)
Bang!#CLASS: Bang_Confessional #DELAY: 1.75

You cover your face as wooden splinters fly toward you as tiny, stinging flecks of wood. You take a step closer to the hole in the divider. You raise your flashlight, and peer through the hole.

*[Turn on the flashlight]

- 

~ PlaySFX("flashlight_on", false, 0, 0)
The flash light clicks on, and everything stops. #EFFECT: flashlight_on

The other side is pristine. It looks almost identical to the side you had been on. No one is inside.

On the bench sits a small key. 

*[Reach your arm through]
    ~ Confessional_Encounters += (Reached_Through)
    ~ PlaySFX("flashlight_off", false, 0, 0)
    ~ temp_string = "reach through"
    You place the flashlight back in your pocket, and reach your arm through. blindly feeling around.  Your fingertips just barely brush the bench it's sitting on. #EFFECT: flashlight_off

    You reach in deeper, your face pressing against the mangled wood. "Just a bit... more..." you mumble to yourself.
    
    ~ PlaySFX("climax_short", false, 0, 0)
    Your fingers brush against the key again when a cold hand grabs your arm. You jerk away, but it holds tight, fingers digging into your wrist.

    "The more you fight, the sweeter the meal you will be." The gruff voice growls. It's scratchy and low. "Don't mistake this for kindness."

    #PROP: [skeleton_key true]
    Something cold and metal is pressed into your palm, and you're released. You yank your arm back through the opening, falling into the opposite side. Your arm throbs where the thing grabbed you. In your hand is the key. The key is {items_obtained ? (Simple_Key): a bit more ornate than the one you found in the office.| ornate than you would expect.} It has tiny gems in the head of the key. Even the teeth have a design.
    
    The booth is quiet, save for your own breathing. You place the key in your pocket. You offer the confessional one last look before moving on. #PROP: [skeleton_key false]
    
*[Go around]
    ~ PlaySFX("flashlight_off", false, 0, 0)
    You exit through the curtain, face the priest's door. You take a deep breath, and open it. The key sits on the bench, but more surprisingly, the divider is no longer splintered, and the separating grate is back in place. #EFFECT: flashlight_off

    The church fixed itself. 
    
    #PROP: [skeleton_key true]
    You hesitate before stepping inside, quickly grabbing the key and leaving the booth. The key is {items_obtained ? (Simple_Key): a bit more ornate than the one you found in the office.| ornate than you would expect.} It has tiny gems in the head of the key. Even the teeth have a design. 
    
    You shove the key in your pocket and offer the confessional one last look before moving on. #PROP: [skeleton_key false]

- 
*[Return to your search]
    ~ StopSFX("watched", 5, 0)
    -> Confessional_Curtain.Leave_Progress

= Agree
~ Stay_Tracker += 0.5
"You work everyday and for what?" 

~ PlaySFX("leak", false, 0, 0)
~ PlaySFX("leak", false, 0, 0.25)
~ PlaySFX("leak", false, 0, 0.5)
<i>Plink! Plink! Plink!</i>#DELAY: 0.5

The words get stuck in your throat{Stay_Tracker < 2:, but you're not sure why}.

~ PlaySFX("leak", false, 0, 0)
~ PlaySFX("leak", false, 0, 0.25)
~ PlaySFX("leak", false, 0, 0.5)
<i>Plink! Plink! Plink!</i>#DELAY: 0.5

"The church can feel... perplexing... at first, but it doesn't bring you here without reason. It wants to help- to heal the harm dealt to you out <i>there."</i> The voice is calming. It makes sense. Why else would you be here? "The church would never hurt you. Could never hurt you."

~ PlaySFX("leak", false, 0, 0)
~ PlaySFX("leak", false, 0, 0.25)
~ PlaySFX("leak", false, 0, 0.5)
<i>Plink! Plink! Plink!</i> #DELAY: 0.5

You clench and unclench your hands. {Church_Encounters ? (Leave_Light) or !Took_Item: You know shouldn't listen. You know its... it's another deception. After everything, you know this, but... | The voice is making sense. You were scared and rejected anything the church offered you.} Maybe if you hadn't rejected it so strongly then... 

* ["Maybe you're right..."]

* ["No..."]
    {Remembered_Past or Church_Encounters ? (Leave_Light): You need to stay strong. You didn't come here of your own will. You've wanted to leave from the start. | You shake the thought from your head. You can't let the voice's sweet words poison your mind.}
    
    The rapid drips from the leak stop. "You must be mistaken." The voice laughs, an angry and cruel laugh. "You <i>do</i> want to be here. You're just a bit confu-"
    ->Confessional_Curtain.Reject("how am I mistaken?")

-

~ PlaySFX("leak", false, 0, 0)
~ PlaySFX("leak", false, 0, 0.25)
~ PlaySFX("leak", false, 0, 0.5)
<i>Plink! Plink! Plink!</i>#DELAY: 0.5

The leak is dripping faster now. The bucket is spilling over. The viscous liquid contains small bubbles as it crawls over the floor. 

"Stop fighting. Has the church harmed you?" 

{
    - Church_Encounters ? (Leave_Light):
        *["The church was angry."]
            "It screamed at me. It— It burned me..." You shutter at the memory. 
            
            The rapid drips from the leak stop. "Angry...?" The voice laughs. "You must just be <i>confused</i>. The church would never—"
                
            {Stay_Tracker <= 1: A sudden surge of anger coursed through you. Confused? How were you just confused when— | You shake your head in disbelief. }
            ->Confessional_Curtain.Reject("how am I confused?")
    - Confessional_Encounters ? (Killed_Girl):
        *["It wouldn't let me help her."]
            "It- it wouldn't let me out and then when it did she was already-" Your voice cracks. 
            
            The rapid drips from the leak stop. "Hmm...?" The voice laughs. "But that was all <i>your</i> fault, was it not? {Priest_Feeling == guilt: But let's forget about that, you have already been forgiven, yes? | } I understand your confusion, I also wouldn't want to have that on my conscious."
                
            {Stay_Tracker <= 1: A sudden surge of anger coursed through you. Confused? How were you just confused when— | You shake your head in disbelief. }
            ->Confessional_Curtain.Reject("how am I confused?")
}

*["No.."]

*["When it brought me here..."]
    "It followed me, warped my perception. {Church_Investigation ? (Called): It stole the voice of my grandparent- Or- Or their memory just to get me inside. {Church_Investigation ? (Teleported): And then when I did, it just spit me out to ruin my work life!} | {Church_Investigation ? (Entered): I tried to go in when it was calling me and all I was left with was {Church_Entered == 2: anxiety of what it would do next!| {Church_Entered == 0: disappointment that it wasn't something more!}}}}" You ball your fists. "My job already sucked before it ruined me further with its petty tricks. Tell me, how is that not <i>harm?</i>"
    ->Confessional_Curtain.Reject("")

- 
~ Stay_Tracker += 1
-> End_Confessional

= Personal_Confession
"I..." You don't know what to say.  The voice is patient.

*[Talk about lack of motivation]
    ~temp_bool = true
    -> Confessional_Curtain.Motivation

*[Talk about doing too much]
    ~temp_bool = false
    "I somehow am doing too much all the damn time." You stare up at the ceiling, focusing on a cobweb. "I can't commit to anything to completion, but I also can't stop picking up more things to do."

    #PLAY: leak 
    ~ PlaySFX("leak", false, 0, 0)
    <i>Plink!</i>#DELAY: 0.5
    
    The voice is silent.
    
    **[Fill the silence]
            "And I just... I just want to <i>finish</i> something, you know? To finally be done. It feels impossible." You let out a deep sigh. The words tumble out. "Nothing can hold my attention long enough for me to call it "complete," so I just move onto the next thing that catches my eye. Hoping that this time. <i>This time</i> things will be different."
            ->Confessional_Curtain.Personal_TooMuch
    **[Wait]
            -> Confessional_Curtain.Wait_Personal
    

= Motivation
"I have no drive to do... anything. Even the things I want to do." You tap your fingers against the cold, wood bench. "I pick up a hobby only to drop it after a week. I <i>want</i> to do things, but..."

#PLAY: leak 
~ PlaySFX("leak", false, 0, 0)
<i>Plink!</i>#DELAY: 1.5

The voice is silent.

*[Fill the silence]
    "And I just... I just want to <i>finish</i> something, you know? To finally be done. It feels impossible." You let out a deep sigh. The words tumble out. "Nothing can hold my attention long enough for me to call it "complete," so I just move onto the next thing that catches my eye. Hoping that this time. <i>This time</i> things will be different."
    
    ~ PlaySFX("leak", false, 0, 0)
    ~ PlaySFX("leak", false, 0, 0.25)
    ~ PlaySFX("leak", false, 0, 0.5)
    <i>Plink! Plink! Plink!</i>#DELAY: 0.5
    
    #DELAY: 2
    "I see..." The voice is quiet. 
    
    #DELAY: 3
    The silence is suffocating. 
    
    The voice finally continues, and you can breathe again. "So you are picking these up projects to make up for your inadequacy? You take as many as you can get so failure to finish is inevitable?"
    
    **[Agree] 
        You don't answer. You're inadequate? It's all inevitable? You bite you lip.

        ~ PlaySFX("leak", false, 0, 0)
        ~ PlaySFX("leak", false, 0, 0.25)
        ~ PlaySFX("leak", false, 0, 0.5)
        <i>Plink! Plink! Plink!</i>#DELAY: 0.5
    
        ~ PlayBGM("watched", true, 20, 0)
        ~ StopSFX("inside", 20, 0)
        "I think you are sabotaging yourself on purpose." The voice is gentle. Soft. " Something, out <i>there</i> is making you this way. So aren't you so glad you can stay?"
        
        -> Confessional_Curtain.TooMuch_Choice
    
    **[Disagree]
        #DELAY: 0.5
        You shake your head. "It's not that I'm—"
    
        ~ PlaySFX("leak", false, 0, 0)
        <i>Pl....in.....k!</i>#DELAY: 0.51
        
        "This is not an attack on you." The voice cuts you off. "But more of an observation from the outside looking in."
        
        You sit with that knowledge. Is that how others see you? You feel smaller.
        
        ***[Agree]
            "There is a silver lining to all this." 
            
            You perk up immediately at it's words.
            -> Confessional_Curtain.Personal_End
        
        ***[Disagree]
            Not an attack? Just an observation? Does this "observation" have to be so cruel? "I don't think that—" #DELAY: 0.5

            ~ PlayBGM("watched", true, 20, 0)
            ~ StopSFX("inside", 20, 0)
            "I think you are sabotaging yourself on purpose." The voice is stern, and cold. "Something, out <i>there</i> is making you this way. So aren't you so glad you can stay?"
            -> Confessional_Curtain.TooMuch_Choice

* {Stay_Tracker <= 1} [Wait]
    -> Confessional_Curtain.Wait_Personal

= Wait_Personal
You pick your nails and flinch when you peel your nail a little too close to the nailbed. You bite the nail off leaving it slanted and uneven.

*[Fill the silence]
    {
        - temp_bool:
            "And I just... I just want to <i>finish</i> something, you know? To finally be done. It feels impossible." You let out a deep sigh. The words tumble out. "Nothing can hold my attention long enough for me to call it "complete," so I just move onto the next thing that catches my eye. Hoping that this time. <i>This time</i> things will be different."
            ->Confessional_Curtain.Personal_TooMuch
        - else:
            "I want to do more, really I do." You let out a deep sigh. "But I just... can't..."
            ->Confessional_Curtain.Personal_Motivation
    }

*[Continue waiting]
    You continue to pick the nail, trying to straighten the nail but every touch to the nail feels like stabbing a knife into the nailbed.
    ~ Confessional_Encounters += (Stubborn_to_Priest)

- Finally, the voice breaks the silence.

"You are more... stubborn than expected." The voice spits out the words. "But I can wait for as long as you need. I have <i>all</i> the time in the world."

Your skin crawls. 

The silence returns.

*[Fill the silence]
{
    - temp_bool:
        "And I just... I just want to <i>finish</i> something, you know? To finally be done. It feels impossible." You let out a deep sigh. The words tumble out. "Nothing can hold my attention long enough for me to call it "complete," so I just move onto the next thing that catches my eye. Hoping that this time. <i>This time</i> things will be different."
        ->Confessional_Curtain.Personal_TooMuch
    - else:
        "I want to do more, really I do." You let out a deep sigh. "But I just... can't..."
        ->Confessional_Curtain.Personal_Motivation
}

= Personal_Motivation
~ PlaySFX("leak", false, 0, 0)
~ PlaySFX("leak", false, 0, 0.25)
~ PlaySFX("leak", false, 0, 0.5)
<i>Plink! Plink! Plink!</i>#DELAY: 0.5

"I see..." The voice was quiet for a moment before continuing, "Perhaps there's another reason for this? Is work too draining?"

*[Agree] 
    You feel yourself nodding. After work all you want to do is sleep. How is that you're fault?

    ~ PlaySFX("leak", false, 0, 0)
    ~ PlaySFX("leak", false, 0, 0.25)
    ~ PlaySFX("leak", false, 0, 0.5)
    <i>Plink! Plink! Plink!</i>#DELAY: 0.5

    ~ PlayBGM("watched", true, 20, 0)
    ~ StopSFX("inside", 20, 0)
    "It's not your fault that the outside world is unsympathetic." The voice is gentle. Soft. "So aren't you so glad you can stay?"

    -> Confessional_Curtain.TooMuch_Choice

*[Disagree] 
    "Maybe..." You chew on the voice's words. "Or maybe it's—"

    #PLAY: leak 
    ~ PlaySFX("leak", false, 0, 0)
    <i>Pl....in.....k!</i>#DELAY: 0.5

    "This is not an attack on you." The voice cuts you off. "But more of an observation from the outside looking in."

    You sit with that knowledge. Is that how others see you? You feel smaller.
        
    **[Agree]
        "There is a silver lining to all this." 
            
        You perk up immediately at it's words.
        -> Confessional_Curtain.Personal_End
    
    **[Disagree]
        Not an attack? Just an observation? Does this "observation" have to be so cruel? "I don't think that—"
    
        It cuts you off again.
    
        ~ PlayBGM("watched", true, 20, 0)
        ~ StopSFX("inside", 20, 0)
        "I think you are sabotaging yourself on purpose." The voice is stern, and cold. "Something, out <i>there</i> is making you this way. So aren't you so glad you can stay?"
        -> Confessional_Curtain.TooMuch_Choice

= Personal_TooMuch
#PLAY: leak #PLAY: 1, leak #PLAY: 1, leak 
~ PlaySFX("leak", false, 0, 0)
~ PlaySFX("leak", false, 0, 0.25)
~ PlaySFX("leak", false, 0, 0.5)
<i>Plink! Plink! Plink!</i>#DELAY: 1.5

#DELAY: 2
"I see..." The voice is quiet. 

#DELAY: 2
You pick at your nails, waiting. You peel a long piece of skin from your thumb. It stings.

#DELAY: 2
Did you sound too pathetic? The silence is suffocating. 

The voice finally continues, and you can breathe again. "So you are picking these up projects to make up for your own inadequacy? You take as many as you can get so failure to finish is inevitable?"

*[Agree] 
    You don't answer. You're inadequate? It's all inevitable? You chew you lip. You pull a chunk of dead skin with your teeth adn swallow it.

    ~ PlaySFX("leak", false, 0, 0)
    ~ PlaySFX("leak", false, 0, 0.25)
    ~ PlaySFX("leak", false, 0, 0.5)
    <i>Plink! Plink! Plink!</i>#DELAY: 0.5

    ~ PlayBGM("watched", true, 20, 0)
    ~ StopSFX("inside", 20, 0)
    "I think you are sabotaging yourself on purpose." The voice is gentle. Soft. "Something, out <i>there</i> is making you this way. So, aren't you so glad you can stay?"
    
    -> Confessional_Curtain.TooMuch_Choice

*[Disagree]
    #DELAY: 0.5
    You shake your head. "It's not that I'm—"
    
    ~ PlaySFX("leak", false, 0, 0)
    <i>Pl....in.....k!</i>#DELAY: 0.5
    
    "This is not an attack on you." The voice cuts you off. "But more of an observation from the outside looking in."
    
    You sit with that knowledge. Is that how others see you? You feel smaller.
    
    **[Agree]
        "But do not worry, there is a silver lining to all this." You perk up immediately at the words. The pastor is excited for you. You're not a lost cause.
        
        -> Confessional_Curtain.Personal_End
    
    **[Disagree]
        Not an attack? Just an observation? Does this "observation" have to be so cruel? "I don't think that—"

        It cuts you off again.

        ~ PlayBGM("watched", true, 20, 0)
        ~ StopSFX("inside", 20, 0)
        "I think you are sabotaging yourself on purpose." The voice is stern, and cold. "Something, out <i>there</i> is making you this way. So, aren't you so glad you can stay?"
        -> Confessional_Curtain.TooMuch_Choice  

= TooMuch_Choice
*[Nod]
    ~ Stay_Tracker += 1
    You find yourself nodding. You are glad. You can stay and have all the time in the world. You can do it all, and all you have to do is stay.
    -> Confessional_Curtain.Personal_End

*[Remain silent]
    ~ Stay_Tracker += 0.5
    You say nothing, the voice's words rolling around in your mind. It's... tempting. If the voice is right....
    -> Confessional_Curtain.Personal_End
        
*["Stay?"]
~ PlayBGM("watched", true, 20, 0)
~ StopSFX("inside", 20, 0)

- 
#DELAY: 0.5
"What?" You're suddenly on edge. "Stay?"

~ PlaySFX("leak", false, 0, 0)
<i>Pl....in.....k!</i> #DELAY: 0.5

The last water drop is much slower than the rest, the bucket almost full. You can see that the liquid seems... thicker than just water. #REPLACE: liquid

"Of course." The voice changes. "You'll have all the time in the world here. Doesn't that sound grand?"

*[liquid]
    ->Confessional_Curtain.liquid_2
    
*["No."]
    The drips from the leak stop. "No...?" The voice scoffs at you. "What do you mean, no?"
    ->Confessional_Curtain.Reject("what is so <i>grand</i> about that?")
    
    
*[Remain silent]
    ~ Stay_Tracker += 0.5
    You say nothing, the voice's words rolling around in your mind. It's... tempting. If the voice is right....
    -> Confessional_Curtain.Personal_End

= Personal_End
~ PlaySFX("leak", false, 0, 0)
~ PlaySFX("leak", false, 0, 0.25)
~ PlaySFX("leak", false, 0, 0.5)
<i>Plink! Plink! Plink!</i>#DELAY: 0.5

The bucket is filling fast. You can see the liquid seems... thicker than just water. #REPLACE: liquid

"You'll have all the time in the world here. All you have to do is stay!" The voice is excited. "Doesn't that sound grand?" 

* [liquid]
    ->Confessional_Curtain.liquid_2

*["You're right..."]
    The voice is making sense. Imagine what you could do if...
    ->Confessional_Curtain.End_Confessional

*["No."]
    The drips from the leak stop. "No...?" The voice scoffs at you. "What do you mean, no?"
    ->Confessional_Curtain.Reject("what is so <i>grand</i> about that?")

= liquid_2 
You look closer. The liquid in the bucket is slightly viscous. It looks almost like— #DELAY: 0.25

"Well?" The voice is growing impatient.

*["You're right..."]
    ~ Stay_Tracker += 0.5
    -> Confessional_Curtain.End_Confessional

*["I don't want to be here."]
    The rapid drips from the leak stop. "You must be mistaken." The voice laughs, an angry and cruel laugh. "You <i>do</i> want to be here. You're just a bit confu—"
    ->Confessional_Curtain.Reject("what is so <i>grand</i> about that?")

= No_Confession
~ temp Temp_Bool = false
#DELAY: 1
"Nothing. I have nothing to confess." You say flatly.

~ PlaySFX("leak", false, 0, 0)
<i>Plink!</i> #DELAY: 0.5

#DELAY: 1
"Nothing at all?" The voice on the other side chuckles. "Nothing at work? At home? You haven't hurt anyone? Done anything wrong?"

~ PlaySFX("leak", false, 0, 0)
<i>Plink!</i> #DELAY: 0.5

You hesitate before answering.

*["No."]
    The voice says nothing.
    
    **[Fill the silence]
        "I wake up, go to work, come home, watch TV while eating dinner, and go to bed." You wring your hands together, suddenly embarrassed. "It's a routine. There's nothing to tell."
        ->Confessional_Curtain.No_Talk
    
    **{Stay_Tracker <= 1.5}[Wait]
        -> Confessional_Curtain.Wait

*[Recall a work event]
    "Well, work is..." You wring your hands together, embarrassed. "It's a routine. There's nothing to tell...."
    
    "You don't sound very sure." The voice encourages. "Nothing leaves this conversation. You can trust me."
    ~Temp_Bool = true

*[Recall a personal event]
    "Life is..." You wring your hands together, embarrassed. "It's boring. There's not much to tell..."
    
    "You don't sound very sure." The voice encourages. "Nothing leaves this conversation. You can trust me."
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

*[Fill the silence]
    "I wake up, go to work, come home, watch TV while eating dinner, and go to bed." You wring your hands together, suddenly embarrassed. "It's a routine. There's nothing to tell."
    ->Confessional_Curtain.No_Talk

*[Continue waiting]
    ~ Confessional_Encounters += (Stubborn_to_Priest)
    
- Finally, the voice breaks the silence.

"You are more... stubborn than expected." The voice spits out the words. "But I can wait for as long as you need. I have <i>all</i> the time in the world."

Your skin crawls. 
    
The silence returns.

*[Fill the silence]
    "I wake up, go to work, come home, watch TV while eating dinner, and go to bed." You wring your hands together, suddenly embarrassed. "It's a routine. There's nothing to tell."
    ->Confessional_Curtain.No_Talk

*[Leave the booth]
    ~ PlaySFX("curtain", false, 0, 0)
    You stand and leave the booth. You stare at the confessional. It's quiet. You're not sure what's in there, but you're at a stalemate with whatever was on the other side. If you're not going to talk, there's no reason to stick around.
        
    You should look for the heart elsewhere for now. You look...
    ->Confessional_Curtain.Leave_NoProgress
    
    

= No_Talk
~ temp Temp_String = ""
~ temp Temp_Bool = false
~ PlaySFX("leak", false, 0, 0)
<i>Plink!</i> #DELAY: 0.5

"A routine..." The voice trails off. "Would you say you become bored of this? That you wish for more than what you have?"

*[Agree]
    ~ Temp_Bool = true
    You feel yourself nodding. "I... My job is a means to an end. It's enough to keep me alive, but not enough to... do more..."
    
    ~ PlaySFX("leak", false, 0, 0)
    <i>Plink!</i> #DELAY: 0.5
    
    "I see. So why {Stay_Tracker <= 1:do you fight it | don't you stay} then?"

*[Disagree]
    ~ Temp_Bool = false
    #DELAY: 1
    You feel yourself shake your head. "I... My job is a means to an end, but it keeps me alive. I'm saving so one day I'll be able to... do more."
        
    ~ PlaySFX("leak", false, 0, 0)
    <i>Plink!</i> #DELAY: 0.5
        
    "I see. So why {Stay_Tracker <= 1:fight it | don't you stay} then?"

- 

*["What?"]

*[Stay silent]

-
~ PlaySFX("leak", false, 0, 0)
<i>Plink!</i #DELAY: 0.5


{
- Temp_Bool:
    ~ PlayBGM("watched", true, 20, 0)
    ~ StopSFX("inside", 20, 0)
    "You complain of routine. You wish for more." The voice becomes softer as it speaks. "So <i>why</i> {Stay_Tracker <= 1: fight it? | don't you stay stay? } Choose the church. It can offer everything you want and more."
    
- else:
    What is it talking about? {Stay_Tracker <= 1.5: Of course you fight the church. You want to <i>leave.</i> | Stay? When have you ever wished to...}

    ~ PlayBGM("watched", true, 20, 0)
    ~ StopSFX("inside", 20, 0)
    "You can say you're content with your life <i>out there,</i> but we both know you want to stay <i>here"</i> The voice becomes harder as it speaks. "The church has so much to offer you, you know this. {Stay_Tracker <= 1.5: So, why is it you fight the church? | So why are you <i>fighting</i> to leave?}"

    ~ PlaySFX("leak", false, 0, 0)
    ~ PlaySFX("leak", false, 0, 0.25)
    ~ PlaySFX("leak", false, 0, 0.5)
    <i>Plink! Plink! Plink!</i> #DELAY: 0.5

}

*["I don't know."]
    ~Temp_String = "I don't know..."

* {Stay_Tracker < 2} ["I don't want to be here."]
    The rapid drips from the leak stop. "Hm...?" The voice laughs. "You think that now, but just wait—"
    ->Confessional_Curtain.Reject("how am I confused?")

*[Stay silent]
    ~Temp_String = "..."
    "Quiet, are we?" the voice chuckles. "Did I touch a nerve?"
    
    You squirm in your seat. Clenching and unclenching your fists.

- 
#DELAY: 1
"Your life is a routine. A boring, worthless routine." You flinch at the words. "You struggle everyday and for what?"

~ PlaySFX("leak", false, 0, 0)
~ PlaySFX("leak", false, 0, 0.25)
~ PlaySFX("leak", false, 0, 0.5)
<i>Plink! Plink! Plink!</i> #DELAY: 0.5

#DELAY: 2
"{Temp_String}"

~ PlaySFX("leak", false, 0, 0)
~ PlaySFX("leak", false, 0, 0.25)
~ PlaySFX("leak", false, 0, 0.5)
<i>Plink! Plink! Plink!</i> #DELAY: 0.5

"The church is scary at first, but all change is. The church doesn't bring you here without reason." The voice is calming. It makes sense. Why else would you be here? "It would never hurt you."

*["Maybe you are right..."]

*["No..."]
    The rapid drips from the leak stop. "You must be mistaken." The voice laughs, an angry and cruel laugh. "You <i>do</i> want to be here. You're just a bit confu—"
    ->Confessional_Curtain.Reject("how am I confused?")

- The leak is dripping faster now. The bucket is spilling over. The viscous liquid contains small bubbles as it crawls over the floor.

"Tell me, has the church ever harmed you?" the voice envelops you. Has the church harmed you? You find yourself doubting your memory. "Hmm?"

"I..."

{
    - Church_Encounters ? (Leave_Light):
        *["The church was angry."]
            "It screamed at me. It— It burned me..." You shutter at the memory. 
            
            The rapid drips from the leak stop. "Angry...?" The voice laughs. "You must just be <i>confused</i>. The church would never—"
                
            {Stay_Tracker <= 1: A sudden surge of anger coursed through you. Confused? How were you just confused when— | You shake your head in disbelief. }
            ->Confessional_Curtain.Reject("how am I confused?")
    - Confessional_Encounters ? (Killed_Girl):
        *["It wouldn't let me help her."]
            "It- it wouldn't let me out and then when it did she was already-" Your voice cracks. 
            
            The rapid drips from the leak stop. "Hmm...?" The voice laughs. "But that was all <i>your</i> fault, was it not? {Priest_Feeling == guilt: But let's forget about that, you have already been forgiven, yes? | } I understand your confusion, I also wouldn't want to have that on my conscious."
                
            {Stay_Tracker <= 1: A sudden surge of anger coursed through you. Confused? How were you just confused when— | You shake your head in disbelief. }
            ->Confessional_Curtain.Reject("how am I confused?")
    
}

*["No.."]

*["When it brought me here..."]
    "It followed me, warped my perception. {Church_Investigation ? (Called): It stole the voice of my grandparent- Or- Or their memory just to get me inside. {Church_Investigation ? (Teleported): And then when I did, it just spit me out to ruin my work life!} | {Church_Investigation ? (Entered): I tried to go in when it was calling me and all I was left with was {Church_Entered == 2: anxiety of what it would do next!| {Church_Entered == 0: disappointment that it wasn't something more!}}}}" You ball your fists. "My job already sucked before it ruined me further with its petty tricks. Tell me, how is that not <i>harm?</i>"
    ->Confessional_Curtain.Reject("")

- -> Confessional_Curtain.End_Confessional

= End_Confessional
~ Confessional_Encounters += (Finished_Curtain_Side)
~ Confessional_Encounters += (Accepted_Priest)
~ temp_string = "accept"
"When it brought you here, that must have been frightening. Change always is."

You nod.

~ PlaySFX("leak", false, 0, 0)
~ PlaySFX("leak", false, 0, 0.25)
~ PlaySFX("leak", false, 0, 0.5)
<i>Plink! Plink! Plink!</i>#DELAY: 1.5

The liquid crawls towards your shoes. You don't think it's water at all.

"All the church wants is to give you more than the world out there." You nod. "The church only wants the best for you. So, just. Stop. Fighting. It."

*[You nod]
    ~ StopSFX("watched", 15, 0)

- 

~ PlaySFX("key-thrown", false, 0, 0)
<i>Plunk!</i>

A small key falls into the bucket, causing the bucket to fall over, and the liquid to spill onto the floor. You lift your feet to avoid your shoes from soaking through, and the liquid stretches like you stepped in gum. Is this...? You gag.

"A gift for you. An olive branch of sorts." You hear the door open. {broke_key or Explore_Office_Bookshelf ? (Broke_Chest): "Although, it looks like you may not need it." | "I hope you like the gift."} He laughs, and the door closes and you know you are alone. {Book_Knowledge ? (Branded): Your branding stings. }

*[Pick up the key]
    ~ items_obtained += (Skeleton_Key)

- You grab it out of the pool of liquid. It's sticky and thick, almost like... Your stomach churns. Saliva?

#PROP: [skeleton_key true]
You wipe the key off using the confessional curtain. The key is {items_obtained ? (Simple_Key): a bit more ornate than the one you found in the office.| ornate than you would expect.} It has tiny gems in the head of the key. Even the teeth have a design. You stick it in your pocket and look at the grate the pastor spoke to you through. 

You wonder if you'll meet it again. #PROP: [skeleton_key false]

*[Return to your search]
    -> Confessional_Curtain.Leave_Progress

= Know_Father
Oh. "I... I know who you are."

"Do you now?" he laughs coldly.

"You're the father of—"

"The church. I do not have all day, and there are others waiting their turn." His voice is short and strained. "So this is the last time I'll ask you this: What. Do. You. Wish. To. Confess?"

#REPLACE: push the matter
"No, I think that you—" A gutter growl cuts you off. You don't think you should [push the matter]. The voice is pushing you to confess, maybe you can learn more if you play along? {Stay_Tracker < 1: He never said you have to say anything useful. You'll say just enough to satisfy him. | It might help you get some things off your chest. This could be... therapeutic. }

*[push the matter]

*[Talk about work]
    -> Confessional_Curtain.Work_Confession
*[Talk about something personal]
    -> Confessional_Curtain.Personal_Confession
*{Stay_Tracker < 2}[Talk about nothing]
    -> Confessional_Curtain.No_Confession

- "No, the father of that girl."

#PLAY: groaning-angry, 2
~ PlaySFX("groaning-angry", false, 0, 0)
The growl comes from the other side again. "I have no daughter." He says through gritted teeth.

"I talked to—"

"No one."

"She misses—"

"Who?"

{Book_Knowledge ? (Read_Mom_Young_Book): "OPHELIA!"} You shout, banging your hand against the bench{Church_Encounters ? (Finger_Chopped):, and wince, the wound on your hand reopening}. "Your DAUGHTER!"

*[The voice is silent]

- 
#DELAY: 1
"Do you even care about her? {Confessional_Encounters ? (Killed_Girl): She die-" | "She came here for you-"}

#PLAY: screeching 
~ PlaySFX("screeching", false, 0, 0)
An ear piecing shriek fills the booth{Church_Encounters ? (Leave_Light):, much worse than the one from before}. You plug your ears, but it makes no difference. $CLASS: Angry-Screeching #DELAY: 2.5


~ PlaySFX("bang_confessional", false, 0, 0)
Bang!#CLASS: Bang_Confessional #DELAY: 1.75

The wood divider splinters as the pastor slams the other side. "Shut up shut up shut up SHUT UP" It's voice contorts and stretches as it changes from something human to something guttural and monstrous.

*[Lunge for the curtain]

- 
~ PlaySFX("thud", false, 0, 0)
#DELAY: 2.5
You slam into solid wood. The curtain's gone. The walls close in on you as you push yourself against them.


~ PlaySFX("bang_confessional", false, 0, 0)
Bang!#CLASS: Bang_Confessional #PLAY: bang_confessional #DELAY: 1.75

The divider between you is barely holding up. The wood is splinters while that- that <i>thing</i> shouts and curses you.

"I hate hate hate hate hate HATE you. You DARE to speak of things you don't understand?!"

*[Throw yourself at the wall]

- 
#PLAY: thud
~ PlaySFX("thud", false, 0, 0)
You throw your shoulder into the wall where the curtain used to be. It doesn't even shudder. The walls continue to close in on you pressing you closer and closer to the split divider. 

*[Try to stop the walls]
    You press yourself against the far way and kick out your legs to stop it, but all you do is delay the inevitable. Your knees buckle and pop under the pressure. You howl in pain and collapse, the walls pinning you into place.
    
*[Slam the flashlight into the wall]
    You smash the butt of the flashlight into the wall, and manage to chip the wood. Hope rises in your chest as you hit it again and again and again, but you are only able to make a small hole before the walls pin you in place.
- 

~ PlaySFX("screeching", false, 0, 0)
"YoOOouu wILl noT eSCApe this TIME!" #PLAY: screeching CLASS: Angry-Screeching #DELAY: 1.5


~ PlaySFX("bang_confessional", false, 0, 0)
Bang! #CLASS: Bang_Confessional #DELAY: 1.75

The divider splits and falls, revealing the thing on the other side. You push yourself against the wall to get away but the wall only pushes you closer.

*[You can't comprehend it]

*[It's not human]

*[You can't look away]

- It takes a step into your booth, impossibly tall. Impossibly long. It bends, folding in on itself in an attempt to fit in the small space. Your eyes can't accept what they're seeing. 

#CYCLE: hands, claws, tentacles, paws, fins
It has no legs except when it does. Deer hooves that disappear as soon as they touch the ground, only to be replaced with its next step, like a cascading waterfall of feet. It grabs the edge of the booth with its @. A human hand morphing into a infinitely splitting claw morphing into a feathered limb that curls and grabs anything within reach.

It says something that reverberates in your brain, but not said aloud. Blood leaks from your ears and nose as it speaks. Words you understand, but can't repeat. They change your thoughts, your feelings. Something wet sharply forces your face up, and your eyes lock on it's face. It's true face.

*[A single tear rolls down your cheek.]

- 
#ENDING: 5, Bad Ending - Finding Solace
*[You've never known solace like this.]
    ->Endings.Bad_End_5

= Leave_NoProgress
~ PlayBGM("inside", true, 5, 0)
~ current_area = Main_Body // set the current area
~ Have_Visited -= Confessional_CurtainSide //set that we have visited the area
->Inside.Look_For_Heart

= Leave_Progress
~ Confessional_Encounters += (Finished_Curtain_Side)
~ Have_Visited += (Confessional_CurtainSide)

~ previous_area = Confessional_CurtainSide
~ items_obtained += (Skeleton_Key)
~ current_area = Main_Body 
~ PlayBGM("inside", true, 30, 0)

~ visited_state += 1
{
    
    - visited_state == 1:
        #PROP: [skeleton_key false, curtain_full false]
        ->After_First.Confessional_After
    - visited_state == 2:
        #PROP: [skeleton_key false, curtain_full false]
        -> After_Second.Confessional_Sin_Second
    - else:
        #PROP: [skeleton_key false, curtain_full false]
        -> Last_Stop.Confessional_Sin_Last
}







