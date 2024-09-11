=== Confessional_Door
#IMAGE: Default #PROP: curtain_full, true
You sit on the cold wooden bench. Just like the outside, the inside doesn't have many details. The grate that a priest would speak through has the same lattice work that the door does. 
        
You look around the crammed space and find nothing. The booth is empty. {confessional_sin: You already found a key earlier, what more could be in the booth?} { confessional_sin == false: You don't know what you were expecting. }
    
*[Exit the booth]
~temp_bool = false

*[Look again]
~temp_bool = true
    You check the space again, doing your best to check every nook and cranny. Under the bench, in the corners, anywhere you can think. You don't find anything.

    You sigh. {confessional_sin: Maybe the key was the only thing you could find.} {confessional_sin == false: You should look elsewhere.}

-

#PLAY: curtain
You stand to leave when you hear the curtain open and close from the other side of the divider. There are footsteps, then a soft thud of someone sitting on the bench.
~temp_bool = false

//false means no visit
//we can only visit 2 places
//set first visit to true

*[Wait]
-> Confessional_Door.Wait_Curtain

*[Leave the booth]
-> Confessional_Door.Leave_Booth

= Wait_Curtain
{
    - temp_bool:
        "I... I know someone's in there! Answer me!" You hear her sniff.
        
        You slowly sit back down. You don't think it's the same person that helped you. Why would she be calling you dad? You're not even...

        "Please..." her voice is barely audible.
        
        *[Say something]
            -> Confessional_Door.CallOut
        
        *[Leave the booth]
            -> Confessional_Door.Leave_Real
    - else:
        ~temp_bool = false
        "Um.. hello? Is anyone in there?"

        It's almost same voice from earlier. The one that gave you the flashlight and note. But her voice is softer? Younger...?

        *[Say something]
            -> Confessional_Door.CallOut

        *[Leave the booth]  
            -> Confessional_Door.Leave_Booth
}

= CallOut
{
    - temp_bool == false:
        "Hello?" You call out, tentatively.
        
        "Oh, it's not..." her voice tapers off. She's disappointed. "Are you still taking confessions...?"
        
        *["Yes, I am."]
            ->Confessional_Door.Yes_Confessions
        *["No, sorry."]
            ->Confessional_Door.No_Confessions
        *[Leave the booth]
            ->Confessional_Door.Leave_Real
    - else:
        ~temp_bool = true
        "I'm here?" It comes out more like a question. You clear your throat. "I'm here."
        
        "Oh, it's not... Are you still taking confessions...?" Her voice is sad, but hopeful. It's her, but... she sounds different. Her voice is softer, maybe? Younger...?

        *["Yes, I am."]
            ->Confessional_Door.Yes_Confessions
        *["No, sorry."]
            ->Confessional_Door.No_Confessions
        *[Leave the booth]
            -> Confessional_Door.Leave_Real
}

= No_Confessions
#DELAY: 4
~stay += 0.5
~ emily_hurt = true
#PLAY: curtain
{pressed_emily: The curtain opens. "I'm- Leaving-" Her voice is cut off by a massive coughing fit. "You- <i>You</i>" she wheezes between coughs. "Don't-"}{ pressed_emily == false: "Oh..." You hear a soft thud as she jumps off the bench. The curtain opens. "Thank-" Her voice is cut off by a massive coughing fit. "Thank- you-" she wheezes between coughs. }

#CLASS:  #DELAY: 2.5
​

#DELAY: 1.5
The sound of the curtain tearing-

#CLASS: Slide_Down #PLAY: door_thud #DELAY: 1.5
<i>THud</i>

Something, no <i>someone</i>, hits the ground. Hard.

*[Rush out of the booth]
->Confessional_Door.Rush_Out

*["Are you alright?!"]

- 
You can hear wheezing, but she does not answer. 

#CLASS: Fidget #CLASS: Blur
Your eyes find the doorknob, and you tell yourself to open it.

#CLASS: Fidget #CLASS: Blurrier
An invisible force presses down on you. You feel like you're moving in slow motion.

*["Are you okay?"]

- 
#CYCLE: Fidget, easy, smoothly, effortless, fluid 
The words come out @. Your hand is barely halfway to the door.

#CLASS: Fidget #CLASS: Blur
It seems like the harder you fight against the force, the slower you move.

You can hear scratching on the floor. 

#CLASS: Fidget #CLASS: Blurrier
You just need to turn the knob. Why can't you just turn the knob?

There is no answer from outside.

*["Hello...?"]

- 
#CYCLE: Fidget, frustrated, annoyed, afraid, anxious 
You feel @ as you continue to stare at the closed door. Your hand is so close.

#CLASS: Fidget #CLASS: Blur
What if it's too late?

You don't hear anything outside. 

#CLASS: Fidget #CLASS: Blur
You need to move.

There is no answer from outside.

#CLASS: Fidget #CLASS: Blur
Just move.

#CLASS: Fidget #CLASS: Blurrier
MOVE.

*[Exit the booth.]
You fall out of the booth, and check the other side. There's a splatter of blood just outside it, next to the ripped off piece of curtain. Scratch marks are etched into the wooden floor. Your flashlight shines on broken pieces of nail.
-> Confessional_Door.Exit_Booth

= Rush_Out
~ temp_num += 1
{    temp_num:
    
    - 1:
        You run to the door, trying to get out. Is she alright?
        *[The knob won't turn.]
            ->Confessional_Door.Rush_Out
    - 2:
        You hear the sound of scratching at the floor.
        *[The knob <i>won't</i> turn.]
            ->Confessional_Door.Rush_Out
    - 3:
        She says something between coughs that you can't make out.
        *[The <i>knob</i> won't <i>turn.</i>]
            ->Confessional_Door.Rush_Out
    - 4:
        ...
        It's quiet.
        *[Break down the door]
            ->Confessional_Door.Rush_Prt_2
}

= Rush_Prt_2
You back up as far as you can and throw yourself at the door.

The wood splinters.

*[Again]

- 
{ 
    - leg == "worst": ~temp_string = "Your leg tremble from the effort."
}

The wood around the lock is bent and warped. {temp_string}


*[Again]

- ~temp_bool = false
{ 
    - leg == "worst": ~temp_string = "Your leg screams from the the amount of weight you're putting on it."
}
There's a small hole you can see through. You see movement from outside. {temp_string}


*[One more time.]
You step back and throw yourself at the door one last time. It gives, and you fall onto the floor. You quickly get to your feet and go to where you saw the movement.

The ripped piece of curtain lays just outside of the booth. There's a splatter of blood and scratch marks etched into the wooden floor. Your flashlight shines on broken pieces of nail.
~temp_bool = false
-> Confessional_Door.Exit_Booth

*[Look through the hole]

- 

~temp_bool = true
You shine your flashlight through at the movement. What you assume to be the girl is writhing on the floor, covered by a ripped piece of the curtain.

*[You need to get to her.]
You step back and throw yourself at the door one last time. It gives, and you fall onto the floor. You quickly get to your feet and go to where you saw the movement.

The ripped piece of curtain lays just outside of the booth. There's a splatter of blood and scratch marks etched into the wooden floor. Your flashlight shines on broken pieces of nail.
-> Confessional_Door.Exit_Booth

= Yes_Confessions
"Oh!" She perks up immediately. "I kept miss-"

She is cut off by a coughing fit. Harsh, loud, wet coughs. 

*[Wait for her to stop]

*[Ask if she's alright]
    "Ye-" she tries to respond. "Ye-ah."

    "Deep breaths." You say. "We are in no rush."

    She tries to say something else, but the coughing fit persists.

- You wait, listening to the aggressive, wet coughs plaguing the girl on the other side. Eventually, she stops.

"Sorry," she wheezes. "I'm really sick... I was hoping that my dad was... He's a priest so..."

*[Say nothing]
    ~temp_bool = true
    You shift in your seat, unsure what to say. You are <i>not</i> a priest, and certainly not a replacement for her father...

*["You can talk to me?"]
    ~temp_bool = false
    You are <i>not</i> a priest, and certainly not a replacement for her father but... You want to be able to comfort her in some way.

- There's an uncomfortable silence before she speaks again.

"Since... Since I'm sick all time... sometimes I feel..." 

She's quiet for a moment. 

"I feel like a burden...." Your heart drops. "Mom is constantly praying, and Dad is always...."

She's quiet again. You don't know what to say. 

*[Let her continue]

*[Reassure her]
~temp_string = "Probably, but "
    "You are not a burden, and I'm sure your parents would be upset to here you say so." You try to keep your voice calm and comforting. "Everything they are doing is for you."

- "{temp_string}I wish... I wish we could all just be home and together again..."she mutters. "I always feel worse on days Mom brings me to church to see Dad. He's always <i>here.</i> I know he's a pastor, but I never see him anymore..."

Your stomach drops. Here? <i>This</i> church? {confessional_sin: If her father is a pastor... Was he...?} Your mind races. Is it possible that...

*["What do you mean?"]
"<i>This</i> church?" The question comes out harsher than you mean to.

*["He doesn't come home?"]
"He used to, but-" She coughs. "But he hasn't in a really long-"

"And you always feel worse when you come to the church?" The question comes out harsher than you mean to.


- "Oh, uhm, well I don't-" She fumbles over her words. "I'm sorry did I say something wrong?"

You have many questions, but she is still a child. A sick child.

*[Press her further]
~ temp_bool_3 = true
"No, no, of course not." You hear her sigh with relief. "But can you talk more about your dad not leaving the church?"

"You don't know? I don't wanna get in trouble..." 

"You won't."

"Promise?"
-> Confessional_Door.Promise

*[Let up]
    ~ temp_bool_3 = false
    "No, no, of course not." You hear her sigh with relief. "Only making sure I understood you."
    
    "Right, right. Uhm... yeah... Mom says I feel bad because I don't pray hard enough. So I was hoping that Dad would be here...." She sniffs. "I thought we could...I feel like I pray really hard... What am I doing wrong? Will he come back if I...?"

- 

* [Help her]
    -> Confessional_Door.help

* [Ask about the church]
"Before that, can you tell me more about your dad not leaving the church?" You keep your voice polite. "After that we can talk all about your prayer habits, okay?"

"But-" 

"It's just information I need before I can tell you."

"Promise?"
-> Confessional_Door.Promise

= Promise
*["Promise."]

-

"Well... He used to go once a week, to pray for me, at our old church. As I got sicker, he got recommended this one, and it was okay for a while. I got a little better, but he stopped coming home..." She sniffs. "I only see him if mom brings me here, but she only ever lets me talk to him from the gate. He didn't show up this time so I..." 

"You...?"

"I went inside."

A pit forms in your stomach. 

"I just want us to be together again! I pray for it all the time!" Her voice trembles with a mix of anger and misery. "How do I fix it? Please, tell me how to fix it!"

*[Help her]
->Confessional_Door.help

*[Your dad told me]
~ temp_bool_2 = true

*[You told me]
    ~ pressed_emily = true
    "No I didn't." You can hear her stand, and shuffle on the other side. "How do you-"
    -> Confessional_Door.No_Confessions

- "Why?" 

"He... thought you might visit! And... told me.... just in case!" It's pretty clear that you're lying, but you hope she buys it.

"Oh." Her voice is quiet. "I see..."

*[Did she buy it?]

- "Then... If I tell you-"

"Yes." you say, a little too fast.

"O-okay. I don't re-really know, but..." she clears her throat. "He told us he found it on his way home from our old church. It was new I think."

"It just showed up?" Your heart pounds.

"I guess it was newly built or something. The first time we went, I didn't remember it being in the area it was. It was on a road we would drive down sometimes to get to our old church."

You ball your fists. It's not the same as what happened to you, but it's similar enough.

*[They are also victims of the church.]

- "Thank you." You say, and lean back, closing your eyes. Your mind races as you process the information. What do you and this girl, no <i>family</i>, have in common? "That helps a lot."

"Mhm... Can you help me now...?" She is hopeful.

*[Help her]
->Confessional_Door.help

*[Don't help her]
    ~ pressed_emily = true
    
- You're not a priest, you don't know how to help her. So you do the only thing you can think of: tell her to leave.

"You don't need to do anymore than you do now. Just leave with your mom today, and don't come back."

"What?" You don't answer, instead, you stand up and open the door. She starts coughing. "But you said-"
-> Confessional_Door.No_Confessions

= help
You're not a priest, and you are not entirely sure what the correct thing to say is, but you give it your best shot. "You are doing really well okay? So don't think you're not." You try to comfort her. 

"All you need to do is....

*["pray your mom will join you and your dad here."]
~stay += 0.5

*["leave the church and go find your mom."]

- "Really? And that will be enough?" her voice warbles.

"Yes, really."

#PLAY: curtain
"Okay, I'll... I'll do that." She sniffs, and the curtain opens. "Thank you."

The curtain closes, and she is gone.

*[Leave the booth]

- You didn't find the heart, but at least you learned a bit more about the church. You hope it will help you later.

-> Confessional_Door.Return_to_Search

= Exit_Booth
#IMAGE: Confessional_CloseUp #PROP: curtain_torn, false
No sign of the girl. 

You kneel in front of the booth. 

You feel...

*[Angry]
~ priest_feeling = "anger"
~stay -= 0.5
~temp_string = "You grind your teeth"
#IMAGE: Default #PROP: curtain_torn, true
You slam your fist into the ground. {pressed_emily: <i>You</i> pressed her. <i>You</i> did this.} {pressed_emily == false: Was any of that real? Is this all just a sick game to the church? }

You grab the fabric and start pulling it apart. <i>Riiiippp</i> {pressed_emily: She's not here, was it real? } {pressed_emily == false: Is anything in here real? } <i>Riiiippp</i> {pressed_emily: If she isn't real, is it still your fault? } {pressed_emily == false: Can you trust your ears? Your eyes? } <i>Riiiippp</i>  {name: You know she was once a real person, but was that her? Or was that the church? } {pressed_emily == false: What can you trust in here if your own sense are compromised? } <i>Riiiippp</i> 

You stop and hold the scraps in your hand. You look at the blood splatter, then up at the confessional.

*[Guilty]
~ priest_feeling = "guilt"
~stay += 0.5
~temp_string = "You grimace"
#IMAGE: Default #PROP: curtain_torn, true
You gather up the fabric in your hands. You swallow back the lump growing in your throat. {pressed_emily: You... <i>You</i> pressed her. <i>You</i> did this. It's <i>your</i> fault. } {pressed_emily == false: Is this... your... fault? } 

You put your hand over the scratch marks, and feel the deep grooves left chipped in wood. How panicked would you need to be to leave such marks? You look at the blood splatter, then up at the confessional.

*[Dread]
~ priest_feeling = "dread"
{
- temp_bool:
    ~temp_string = "You saw her. You <i>SAW</i> her. The curtain is <i>ripped.</i>"
- else:
    ~temp_string = "You heard her. You- You can <i>see</i> the curtain was affected."
}
#IMAGE: Default #PROP: curtain_torn, true
You touch the ripped fabric. {pressed_emily: Would this still have happened if you didn't press her...? }{pressed_emily == false: Was any of that real...? }

{temp_string}

It <i>had</i> to be real. You trace a finger over the scratch marks and feel the chipped wood. What can you trust in here if your own sense are compromised? 

It <i>had</i> to be real, for your own sake. You grab the ripped fabric, and hesitantly, look back up at the confessional.
~temp_string = "Your hands tremble"
- 

#IMAGE: Confessional_CloseUp #PROP: curtain_full, false
What...?
*[{temp_string}]

- 
{
    - temp_string == "Your hands tremble":
        You stare at the intact curtain in front of you. You grip the fabric in your hands tightly, afraid it will disappear the moment you can no longer feel it.

        #IMAGE: Church_Inside #PROP: curtain_full, true
        "Why...?" you mutter as you try to stand, your legs shaky. You turn to face the main body of the church. "What is the point to any of this...? Are you trying to...?"

        Your voice is quiet, but you know the church heard you. Deep in your gut, you know, and you waited for its response. 
        
        Any response.
    
    - temp_string == "You grimace":
        Your eyes dart back and forth between the fabric in your hands, and the intact curtain in front of you. You can't understand it.

        #IMAGE: Church_Inside #PROP: curtain_full, true
        "What is this...?" your voice warbles, and you slowly stand. You turn to face the main body of the church. You throw out your hands, holding the fabric up like an offering. "What- what is this...?!"

        You let out a wet croak. You look around, looking for some response. 
        
        Any response.
    
    - temp_string == "You grind your teeth":
        #IMAGE: Church_Inside #PROP: curtain_full, true
        "What is this?" You stand and throw the scraps in your hands at the intact curtain. You turn to face the main body of the church. "What. is. THIS?!"

        You can't help but laugh. Laugh at the absurdity. At your stupidity. You remember the words on the note you were given. 
        
        <i>It will do anything to keep you here.</i>

        "Is this how you get me to stay? Huh?" You look around, looking for some response. Any response. 
        
        You spit on the ground.
}

*[The church is silent.]

- 

{
    - temp_string == "Your hands tremble":
        You fold the ripped fabric as best you can, and place it over the scarred wood and blood.

        "I'm sorry."
        
        You face the church, and close your eyes. "Please, was any of it real...?"
        
        When you open them, the fabric is gone, the wood floor is smooth, and there is no indication that blood was ever spilled.
        
        You nod, getting the answer you expected. <i>It will do anything to keep you here.</i> 
        
        You should keep that in mind. You do not want to become another victim of the church. You will make it out of here.
        
        {
            - stay >= 1.25:
                You hope.
            - else:
                You are sure of it.
        }
    
    - temp_string == "You grimace":
        You fold the ripped fabric as best you can, and place it over the scarred wood and blood.

        "I'm sorry."
        
        You place a hand over the make-shift grave, close your eyes, and say a prayer. "I- I'm so sorry."
    
        When you open them, the fabric is gone, the wood floor is smooth, and there is no indication that blood was ever spilled.
        
        You nod, getting the answer you expected. <i>It will do anything to keep you here.</i> 
        
        You should keep that in mind.
    
    - temp_string == "You grind your teeth":
        You scoff. Of course now the church has nothing to say. You don't give the confessional another glance. You will get out of here. You will not be just another victim.
        
        {
            - stay >= 2:
                You hope.
            - else:
                You are sure of it.
        }
        
}


*[Continue your search]
-> Confessional_Door.Return_to_Search

= Leave_Booth
You frantically grab at the the door, not wanting to face whatever is on the other side. It creaks as you turn the knob, and {temp_bool == false:a}{temp_bool: the} soft voice drifts in through the grate.

{temp_bool == false:"Dad?" You stop. It's the almost same voice from earlier. The one that gave you the flashlight and note. But it's... different. "....Dad...?"}{temp_bool: "I... I know someone's in there! Answer me!" You hear her sniff.}

~temp_bool = true

* {!temp_bool} [Wait]
-> Confessional_Door.Wait_Curtain

* [Call out]
-> Confessional_Door.CallOut

*[Leave the booth]
    ->Confessional_Door.Leave_Real

= Leave_Real
You quickly leave the booth, and stare at the confessional. It's quiet. You're not sure what's in there, but you don't think it's the same person that helped you before.

There was nothing in there, anyway. You should look for the heart elsewhere for now. You look...
->Inside.Look_For_Heart

= Return_to_Search
-> END_DEMO































