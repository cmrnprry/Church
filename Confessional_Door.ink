=== Confessional_Door
~ confessional_priest = true

{
- !temp_visited:
    You sit on the cold wooden bench. Just like the outside, the inside doesn't have many details. The grate that a priest would speak through has the same lattice work that the door does. 
    {
        - confessional_sin:
            ~temp_string = "You already found a key, what more could be in the booth?"
        - else:
            ~temp_string = "You don't know what you were expecting."
    }
    
    You look around the cramed space and find nothing. The booth is empty. {temp_string}
- else:
     ~ temp_visited = false
    While you wait for the service to be over, you look around the cramed space for something useful.
    
    {
        - confessional_sin:
            ~temp_string = "You already found a key earlier, what more could be in the booth?"
        - else:
            ~temp_string = "You don't know what you were expecting."
    }
    
    You find nothing. The booth is empty. {temp_string}

    The rumbling of the sound outside have gone quiet, and when you peak out again, the people and red light are gone. It's probably safe to leave now.
}


*[Exit the booth]
~temp_bool = false

*[Look again]
~temp_bool = true
    {
        - confessional_sin:
            ~temp_string = "Maybe the key was the only thing you could find."
        - else:
            ~temp_string = "You should go look elsewhere."
    }
    You check the space again, doing your best to check every nook and cranny. Under the bench, in the corners, anywhere you can think. You don't find anything.

    You sigh. {temp_string}

- ~temp_bool = false

#play: curtain
You stand to leave when you hear the curtain open and close from the other side of the divider. There are footsteps, then a soft thud of someone sitting on the bench.

*[Wait]
-> Confessional_Door.Wait_Curtain

*[Call out]
~temp_bool = true
-> Confessional_Door.CallOut

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
        "Um.. hello? Is anyone in there?"

        It's almost same voice from earlier. The one that gave you the flashlight and note. But her voice is softer? Younger...?

        *[Say something]
            -> Confessional_Door.CallOut

        *[Leave the booth]  
            -> Confessional_Door.Leave_Booth
}

= CallOut
{
    - temp_bool:
        "Hello?" You call out, tentatively.
        
        "Oh, it's not..." her voice tapers off. Shes disappointed. "Are you still taking confessions...?"
        
        *["Yes, I am."]
            ->Confessional_Door.Yes_Confessions
        *["No, sorry."]
            ->Confessional_Door.No_Confessions
        *[Leave the booth]
            ->Confessional_Door.Leave_Real
    - else:
        "I'm here?" It comes out more like a question. You clear your throat. "I'm here."
        
        "Oh, it's not... Are you still taking confessions...?" Her voice is sad, but hopeful. It's her, but... she sounds different. Her voice is softer, maybe? Younger...?

        *["Yes, I am."]
            ->Confessional_Door.Yes_Confessions
        *["No, sorry."]
            ->Confessional_Door.No_Confessions
        *[Leave the booth]
            -> Confessional_Door.Leave_Booth
}

= No_Confessions
#delay: 4
~stay += 0.5
"Oh..." You hear a soft thud as she jumps off the bench. The curtain opens. "Thank-" Her voice is cut off by a massive coughing fit. "Thank- you-" she wheezes between coughs. 

#effect: typewriter #style:slide-right #delay: 2
RRRRIIIPPPPPP

#style: fade-up #delay: 1.5
The sound or the curtain tearing-

#style:slide-down #delay: 1.5
_THud_

#style: fade-up
Something, no _someone_, hits the ground. Hard.

*[Rush out of the booth]
->Confessional_Door.Rush_Out

*["Are you alright?!"]

- 
You can hear wheezing, but she does not answer. 

#effect: fidget #style: blur
Your eyes find the doorknob, transfixed by it.

#effect: fidget #style: blurrier
You need get up, and help her.

*["Are you okay?"]

- You can hear scratching on the floor, but she does not answer.

#effect: fidget #style: blur
Your vision starts to blur, but you can't look away.

#effect: fidget #style: blurrier
Why aren't you moving?

*["Hello...?"]

- You don't hear anything. She does not answer.

#effect: fidget #style: blur
You blink and the spell is broken.

#effect: fidget #style: blurrier
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
        *[The knob _won't_ turn.]
            ->Confessional_Door.Rush_Out
    - 3:
        She says something between coughs that you can't make out.
        *[The _knob_ won't _turn._]
            ->Confessional_Door.Rush_Out
    - 4:
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

//TODO

= Yes_Confessions
"Oh!" She perks up immediately. "I kept miss-"

She is cut off by a coughing fit. Harsh, loud, wet coughs. 

*[Wait for her to stop]

*[Ask if she's alright]
    "Ye-" she tries to respond. "Ye-ah."

    "Deep breaths." You say. "We are in no rush."

    She tries to say something else, but the coughing fit persists.

- You wait, listening to the aggressive, wet coughs plaguing the girl on the other side. Eventually, she stops.

"Sorry," she weezes. "I'm really sick... I was hoping that my dad was... He's a priest so..."

*[Say nothing]
    ~temp_bool = true
    You shift in your seat, unsure what to say. You are _not_ a priest, and certainly not a replacement for her father...

*["You can talk to me?"]
    ~temp_bool = false
    You are _not_ a priest, and certainly not a replacement for her father but... You want to be able to comfort her in some way.

- There's an uncomfortable silence before she speaks again.

"Since... Since I'm sick all time... sometimes I feel..." 

She's quiet for a moment. 

"I feel like a burden...." Your heart drops. "Mom is constantly praying, and Dad is always...."

She's quiet again. You don't know what to say. 

*[Let her continue]
{
    - confessional_sin:
        ~temp_string = "If her father is a pastor... Was he...? "
    - else:
        ~temp_string = ""
}
"I wish... I wish we could all just be home and together again..."she mutters. "I always feel worse on days Mom brings me to church to see Dad. He's always _here._ I know he's a pastor, but I never see him anymore..."

Your stomach drops. Here? _This_ church? {temp_string}Your mind races. [[Is it possible that...]]

*["What do you mean?"]

*["He doesn't come home?"]

*[Reassure her]

= Exit_Booth
No sign of the girl. 

You kneel in front of the booth. 

You feel...

*[Angry]
~ priest_feeling = "anger"
~stay -= 0.5
~temp_string = "You grind your teeth"

You slam your fist into the ground. Was any of that real? Is this all just a sick game to the church?

You grab the fabric and start pulling it apart. _Riiiippp_ Is anything in here real? _Riiiippp_ Can you trust your ears? Your eyes? _Riiiippp_  What can you trust in here if your own sense are compromised? _Riiiippp_ 

You stop and hold the scraps in your hand. You look at the blood splatter, then up at the confessional.

*[Guilty]
~ priest_feeling = "guilt"
~stay += 0.5
~temp_string = "You grimce"

You gather up the fabric in your hands. You swallow back the lump growing in your throat. Is this... your... fault? 

You put your hand over the scratch marks, and feel the deep grooves left chipped in wood. How panicked would you need to be to leave such marks? You look at the blood splatter, then up at the confessional.

*[Dread]
~ priest_feeling = "dread"
{
- temp_bool:
    ~temp_string = "You saw her. You _SAW_ her. The curtain is _ripped._"
- else:
    ~temp_string = "You heard her. You- You can _see_ the curtain was affected."
}
You touch the ripped fabric. Was any of that real...? 

{temp_string}

It _had_ to be real. You trace a finger over the scratch marks and feel the chipped wood. What can you trust in here if your own sense are compromised? 

It _had_ to be real, for your own sake. You grab the ripped fabric, and hesitantly, look back up at the confessional.
~temp_string = "Your hands tremble"
- 

*[{temp_string}]

- 
{
    - temp_string == "Your hands tremble":
        You stare at the intact curtain in front of you. You grip the fabric in your hands tightly, afraid it will disappear the moment you can no longer feel it.

        "Why...?" you mutter as you try to stand, your legs shakey. You turn to face the main body of the church. "What is the point to any of this...? Are you trying to...?"

        Your voice is quiet, but you know the church heard you. Deep in your gut, you know, and you waited for its response. 
        
        Any response.
    
    - temp_string == "You grimce":
        Your eyes dart back and forth between the fabric in your hands, and the intact curtain in front of you. You can't understand it.

        "What is this...?" your voice warbles, and you slowly stand. You turn to face the main body of the church. You throw out your hands, holding the fabric up like an offering. "What- what is this...?!"

        You let out a wet croak. You look around, looking for some response. 
        
        Any response.
    
    - temp_string == "You grind your teeth":
        "What is this?" You stand and throw the scaps in your hands at the intact curtain. You turn to face the main body of the church. "What. is. THIS?!"

        You can't help but laugh. Laugh at the absurdity. At your stupidity. You remember the words on the note you were given. 
        
        _It will do anything to keep you here._

        "Is this how you get me to stay? Huh?" You look around, looking for some response. Any response. 
        
        You spit on the ground.
}

*The church is slient.

- 

{
    - temp_string == "Your hands tremble":
        You fold the ripped fabric as best you can, and place it over the scarred wood and blood.

        "I'm sorry."
        
        You face the church, and close your eyes. "Please, was any of it real...?"
        
        When you open them, the fabric is gone, the wood floor is smooth, and there is no indication that blood was ever spilled.
    
    - temp_string == "You grimce":
        You fold the ripped fabric as best you can, and place it over the scarred wood and blood.

        "I'm sorry."
        
        You place a hand over the make-shift grave, close your eyes, and say a prayer. "I- I'm so sorry."]
    
        When you open them, the fabric is gone, the wood floor is smooth, and there is no indication that blood was ever spilled.
    
    - temp_string == "You grind your teeth":
        You scoft. Of course now the church has nothing to say. You don't give the confessional another glance. You will get out of here. You will not be just another victim.
        
        {
            - stay >= 2:
                You hope.
            - else:
                You are sure of it.
        }
        
}

* [Return to your search]
-> Confessional_Door.Return_to_Search

= Leave_Booth
~temp_bool = true
You frantically grab at the the door, not wanting to face whatever is on the other side. It creaks as you turn the knob, and a soft voice drifts in through the grate.

"Dad?" You stop. It's the almost same voice from earlier. The one that gave you the flashlight and note. But it's... different. "....Dad...?"

*[Wait]
-> Confessional_Door.Wait_Curtain

*[Call out]
-> Confessional_Door.CallOut

*[Leave the booth]
    ->Confessional_Door.Leave_Real

= Leave_Real
You quickly leave the booth, and stare at the confessional. It's quiet. You're not sure what's in there, but you don't think it's the same person that helped you before.

There was nothing in there, anyway. You should look for the heart elsewhere for now. You look...
~confessional_priest = false

*[In the pews]
-> Pews

*[Somewhere up the stairs]
-> Stairs

= Return_to_Search
{
    - visited_first:
        ->After_First.Confessional_After
    - else:
        -> After_Second
}































