=== Confessional_Door
TODO: Beef up this section a LOT. it's shorter and shit just happens
//As we enter the curtain side, set all variables. 
~ current_area = Confessional_DoorSide // set the current area

# IMAGE: Default #PROP: curtain_full
{
    //if this is the first area we are visiting
    - Have_Visited !? (Confessional_DoorSide):
        ~ Have_Visited += Confessional_DoorSide //set that we have visisted the area
        You open the door to find a small, mostly empty room. A slab of wood juts out from the far wall, creating an uncomfortable looking bench. A lumpy looking red cushion sits on top.
        
        You think you'd know if there were anything else in here.
        
        *[Search the area anyway]
            You don't know what the heart even is, so you may as well check every inch of this place. You sigh and hold the flashlight in your mouth while you lightly brush your hands across every surface. Under the bench, in the bucket, even wipeing away the cobwebs gathered in the corners.
            
            You plop onto lumpy cushion, and rub your eyes. The door closes behind you. There's nothing here. Of course not. What did you expect? Why did you enter?
            -> Confessional_Door.Searched_Area(true)
        
        *[What is the point of searching?]
            ~ Stay_Tracker += 0.5
            You plop onto lumpy cushion, and the door closes behind you. You stare at the intricate pattern on the door. If the heart is the church's weakness, it's not going to be left in the open or easy to find. There's no way to know if it even <i>exists.</i> There's no way of knowing if that voice was even really here to help you or just another trick of the church.
            
            Of course the confessional is empty. What did you expect? Why did you enter?
            -> Confessional_Door.Searched_Area(false)
 
        
    - previous_area != Enter_Pews: 
        TODO: figure out this nonsense
        While you wait for the service to be over, you look around the cramed space for something useful.
        
        You look around the crammed space and find nothing. The booth is empty. {Confessional_Encounters ? (Finished_Curtain_Side): You already found a key earlier, what more could be in the booth? | You don't know what you were expecting. }
    
        The rumbling of the sound outside have gone quiet, and when you peak out again, the people and red light are gone. It's probably safe to leave now.
        -> Confessional_Door.Searched_Area(false)
        
    - else:
        You sit on the cold wooden bench. Just like the outside, the inside doesn't have many details. The grate that a priest would speak through has the same lattice work that the door does. 
        
        You look around the cramed space and find nothing. The booth is empty. {Confessional_Encounters ? (Finished_Curtain_Side): You already found a key earlier, what more could be in the booth? | You don't know what you were expecting.}
        -> Confessional_Door.Searched_Area(false)
}


= Searched_Area(searched)
*[Exit the booth]

* [{searched:Look again | Check the space anyway}]
    You check the space{searched: again}, doing your best to check every nook and cranny. Under the bench, in the corners, anywhere you can think. You don't find anything.

    You sigh. {Confessional_Encounters ? (Finished_Curtain_Side): Maybe the key was the only thing you could find. | You should look elsewhere.}

-

#PLAY: curtain
You stand to leave when you hear the curtain open and close from the other side of the divider. There are footsteps, then a soft thud of someone sitting on the bench.

*[Wait]
    -> Confessional_Door.Wait_Curtain

*[Leave]
    -> Confessional_Door.Leave_Booth(false)

= Leave_Booth(hasVisited)
You frantically grab at the the door, not wanting to face whatever is on the other side. It creaks as you turn the knob, and {hasVisited: the | a} soft voice drifts in through the grate.

{hasVisited: "I... I know someone's in there! Answer me!" You hear her sniff. | "Daddy?" You stop. It's the almost same voice from earlier. The one that gave you the flashlight and note. But it's... higher pitched, and stuffier. More unsure of itself. "....Daddy...?"}


* [Say something]
    -> Confessional_Door.CallOut(!hasVisited)

*[Leave]
    ->Confessional_Door.Leave_Real

= Wait_Curtain
You hold your breath and freeze. There's a rustling from the other side, then, "Um.. hello? Is anyone in there?"

It's the almost same voice from earlier- The one that gave you the flashlight and note. But it's... higher pitched, and stuffier. More unsure of itself.

*[Say something]
    -> Confessional_Door.CallOut(true)

*[Leave the booth]  
    -> Confessional_Door.Leave_Booth(true)

= CallOut(hasVisited)
{hasVisited: "I'm here?" It comes out more like a question. You clear your throat. "I'm here." | "Hello?" You call out, tentatively.}

"Oh, you're not... Are you still taking confessions...?" Her voice is sad, but hopeful. It's not the same, you realize. This voice is that of someone much younger.

*["Yes, I am."]
    ->Confessional_Door.Yes_Confessions

*["No, sorry."]
    ->Confessional_Door.No_Confessions

= No_Confessions
~ Stay_Tracker += 0.5
#DELAY: 4 #PLAY: curtain
~ Confessional_Encounters += (Killed_Girl)

{Confessional_Encounters ? (Tell_Her_Leave): | {Confessional_Encounters ? (Pressed_Emily): The curtain opens. "I'm— Leaving—" Her voice is cut off by a massive coughing fit. "You— <i>You</i>" she wheezes between coughs. "Don't—" | {Confessional_Encounters ? (Talked_to_Girl): "You're lying!" The curtain opens. "I'm— Leaving—" Her voice is cut off by a massive coughing fit. "You— <i>You</i>" she wheezes between coughs. "Don't—" | You shake your head and apologize again. "They, uh, ended just a few moments ago. They restart tomorrow morning." You clear your throat and hope that sounded priestly enough. }}}

{Confessional_Encounters ? (Pressed_Emily) or Confessional_Encounters ? (Talked_to_Girl): | "Oh..." You hear a soft thud as she jumps off the bench. The curtain opens. "Thank—" Her voice is cut off by a massive coughing fit. "Thank— you—" she wheezes between coughs. }

#DELAY: 2.5
​

#DELAY: 1.5
The sound of the curtain tearing—

#CLASS: Slide_Down #PLAY: door_thud #DELAY: 1.5
<i>THud</i>

Something, no <i>someone</i>, hits the ground. Hard. You feel a pit form in your stomach.

*[Rush out of the booth]
    ->Confessional_Door.Rush_Out(0)

*["Are you alright?!"]

- 
TODO: using the intrusive thought here would be great
You can hear wheezing, but she does not answer. You squeeze your hands together, your inaction causing the panic living in your chest to grow. You need to act.

#CLASS: Fidget
Your eyes find the doorknob, and your vision tunnels. Your hand moves in slow motion toward it. You hear uneven breathing and gasping from outside.

*["Are you okay?"]

*["I'm coming!"]

*["What's going on?"]

- 
#CYCLE: easy, smoothly, effortlessly, fluid 
The words come out too @. You can hear scratching on the floor. Your hand finally finds the knob. It's freezing cold, and sends a shock through your nerves. You turn the knob and it creaks, the sound echoing in your ears, louder than it should have been. 

#CLASS: Fidget
It is deathly quiet outside.

<i>What if it's too late?</i> You think, and tighten your grip on the door. <i>It's all your fault. If you had just moved faster, then maybe she might still be—</i>

*[<i><b>Open the door</b></i>]
    #REMOVE: intrusive
- 

You throw the door open and fall onto the ground outside the booth. You crawl on your hands and feet looking for her. "I'm- Say something if you can hear me!" 

TODO: more intrusive 
#PLAY: flashlight 
Your voice hangs in the air, but you don't stop looking. You stumble into fabric, and your hands graze deep grooves in the wood. You fumble with your flashlight. You wave your flashlight over the scene, searching for the girl, but find nothing. What you do instead makes your stomach lurch.

There's a splatter of blood just outside it, next to the ripped off piece of curtain. Scratch marks are etched into the wooden floor. Your flashlight shines on broken pieces of nail.
-> Confessional_Door.End_Booth_Encounter("Sat_There")

TODO: I think ink can track this??

= Rush_Out (visit_Count)
~ visit_Count += 1
{
    - visit_Count == 1:
        You run to the door. Is she alright?
        *[The knob won't turn.]
            ->Confessional_Door.Rush_Out(visit_Count)
    - visit_Count == 2:
        You hear the sound of scratching at the floor.
        *[It's stuck.]
            ->Confessional_Door.Rush_Out(visit_Count)
    - visit_Count == 3:
        She says something between coughs that you can't make out.
        *[You need to hurry.]
            ->Confessional_Door.Rush_Out(visit_Count)
    - visit_Count == 4:
        ...
        It's quiet.
        *[Break down the door]
            ->Confessional_Door.Rush_Prt_2
}

= Rush_Prt_2
You back up as far as you can and throw yourself at the door.

The wood splinters.

*[Again]

- The wood around the lock is bent and warped. {Leg_State >= Sore: Your leg tremble from the effort.}


*[Again]

- ~temp_bool = false

There's a small hole you can see through. You see movement from outside. {Leg_State >= Sore: Your leg screams from the the amount of weight you're putting on it. }


*[One more time]
    You step back and throw yourself at the door one last time. It gives, and you fall onto the floor. You quickly get to your feet and go to where you saw the movement.
    
    The ripped piece of curtain lays just outside of the booth. There's a splatter of blood and scratch marks etched into the wooden floor. Your flashlight shines on broken pieces of nail.
    ~temp_bool = false
    -> Confessional_Door.End_Booth_Encounter("Broke_Door")

*[Look through the hole]

- 

~Confessional_Encounters += (Saw_Her_Struggle)
You shine your flashlight through at the movement. What you assume to be the girl is writhing on the floor, covered by a ripped piece of curtain.

*[<i>Move!</i>]
    You step back and throw yourself at the door one last time. It gives, and you fall onto the floor. You quickly get to your feet and go to where you saw the movement.

    The ripped piece of curtain lays just outside of the booth. There's a splatter of blood and scratch marks etched into the wooden floor. Your flashlight shines on broken pieces of nail.
-> Confessional_Door.End_Booth_Encounter("Watched")

= End_Booth_Encounter(Reaction)
# IMAGE: Confessional_CloseUp #PROP: curtain_torn
~ Confessional_Encounters += (Finished_Door_Side, Killed_Girl)
<i>This is your fault.</i>

There's no sign of the girl. 

<i>This is <b>your</b> fault.</i>

You kneel in front of the booth. 

You feel...

*[Angry] 
    ~ Priest_Feeling = (anger)
    ~ Stay_Tracker -= 0.5
    ~temp_string = "You grind your teeth"
    #IMAGE: Default #PROP: curtain_torn
    You slam your fist into the ground. Again and again until the skin splits and splintes stick inside. {Confessional_Encounters ? (Pressed_Emily): <i>You</i> pressed her. <i>You</i> did this. | {Reaction == "Sat_There": You just- You just <i>sat</i> there. Sat there and did <i>nothing.</i>| {Reaction == "Watched": You watched her writher and writhe on the ground. Did that make you feel better? To see her in pain like that? | You should have moved faster. Pushed harder. Why can't you do anything right? }}} But what did it even matter? <i>There's no one here.</i>
    
    You grab the fabric from the ground and start ripping it apart. <i>Riiiippp!</i> {Confessional_Encounters ? (Lie_to_Her): She's not here, was it real? | Is anything in here real? } <i>Riiiippp!</i> { Confessional_Encounters ? (Lie_to_Her): If she isn't real, is it still your fault? | Can you trust your ears? Your eyes? } <i>Riiiippp!</i>  {Book_Knowledge ? (Read_Mom_Old_Book): You know she was once a real person, but was that her? Or was that the church? | What can you trust if your own sense are compromised?} <i>Riiiippp!</i> 
    
    The fabric sits in tiny scraps in your hands. You throw them away from you and they land uncerimoniously on the blood splatter in front of you. You stare vacently at it, then up at the confessional.

*[Guilty]
    ~ Priest_Feeling = (guilt)
    ~ Stay_Tracker += 0.5
    ~temp_string = "You grimace"
    # IMAGE: Default #PROP: curtain_torn
    You gather up the fabric in your hands. You swallow back the lump ever growing in your throat. {Confessional_Encounters ? (Pressed_Emily): You... <i>You</i> pressed her. <i>You</i> did this. It's <i>your</i> fault. | This is... your... fault? } {Reaction == "Sat_There": You... did you even try? Why... why didn't you get up? Move faster? Do something? | {Reaction == "Watched": You were so close, but instead you <i>stopped  to watch?</i> Why? Just to confirm what your ears and gut already knew? | You took so long playing with the door. It came down so easily when you put your back into it. If you had done that sooner then- }}
    
    You put your hand over the scratch marks, and feel the deep grooves left chipped in wood. How panicked would you need to be to leave such marks? 
    
    "I'm sorry." You hold the fabric close. You clasp your hands together, grasping the fabric tightly. You bow your head and shut your eyes. "Forgive me."
    
	You feel a hand rest on the top of their head. A deep, gruff voice. {Confessional_Encounters ? (Finished_Curtain_Side): Your body shutters, realizing who it was.} "For what, my child?"
	
	**[Your inaction]
	    "My inaction. I need her to know—"
	    
	**[Your selfishness]
	    "I didn't stop to think, I- I just asked what I wanted. I need her to know—"
	
	-- "Who?" {Confessional_Encounters ? (Finished_Curtain_Side): He | It} asks. 
	
	"The girl. The one who—" You bite your tongue. You can't bring yourself to say it. Your head sinks lower. "Who was... in there."
	
	"Tell me, how did she die? How was it your fault?" The word "die" sends a jolt through your being, but the voice is calm, soft. {Confessional_Encounters ? (Finished_Curtain_Side): He | It} doesn't blame you.
	
	***["She was sick."]
	    "And I {Reaction == "Watched": just watched| {Reaction == "Sat_There": did nothing|didn't do enough}}!" You all but yell. "She needed my help and I wasn't there!"
	
    ***["She hurt herself."]
        "And I {Reaction == "Watched": just watched| {Reaction == "Sat_There": did nothing|didn't do enough}}!" You all but yell. "She needed my help and I wasn't there!"
    
    ***["It was an accident."]
        "You have you believe me!" You all but yell. "I never wanted..."
	
	--- "I see." The voice is quiet, and {Confessional_Encounters ? (Finished_Curtain_Side): he | it} removes {Confessional_Encounters ? (Finished_Curtain_Side): his | its} hand from your head. "Inaction in such a situation is quite a large sin."
	
	    ****["Is there anything I can do?"]
	        "I'll do anything to repent." You bow until your head touches the floor. "Please, <i>please</i> forgive me, father."
	
            "The forgivenees is not mine to give. But lucky for you," The voice morphs and it's hers. "I forgive you. You were scared too."
            Your head snaps up. She's okay? She's here? She forgives—
            
	    ****["I can't forgive myself."]
	        "Why not, child?" {Confessional_Encounters ? (Finished_Curtain_Side): he | it} asks. You tilt your head up and open your eyes. {Confessional_Encounters ? (Finished_Curtain_Side): He | It} tilts {Confessional_Encounters ? (Finished_Curtain_Side): his | its} head. "Am I not here to absolve your sins? Close yout eyes and bow your head."
	        
	        You bow until your head touches the floor. "Please, <i>please</i> forgive me, father."
	
            "The forgivenees is not mine to give. But lucky for you," The voice morphs and it's hers. "I forgive you. You were scared too."
            Your head snaps up. She's okay? She's here? She forgives—


*[Dread]
    ~ Priest_Feeling = (dread)
    
    # IMAGE: Default #PROP: curtain_torn
    You touch the ripped fabric. {Confessional_Encounters ? (Pressed_Emily): Would this still have happened if you didn't press her...? Does it make a difference if you did or not? | Was any of that real...? }
    
    {Confessional_Encounters ? (Saw_Her_Struggle): You saw her. You <i>SAW</i> her. The curtain is <i>ripped.</i> | You heard her. You— You can <i>see</i> the curtain was affected.}
    
    It <i>had</i> to be real. You trace a finger over the scratch marks and feel the chipped wood. What can you trust in here if your own sense are compromised? 
    
    It <i>had</i> to be real, for your own sake. You grab the ripped fabric, and hesitantly, look back up at the confessional.
    ~temp_string = "Your hands tremble"
- 

# IMAGE: Confessional_CloseUp #PROP: curtain_full
What...?
*[{temp_string}]

- 
{
    - temp_string == "Your hands tremble":
        You stare at the intact curtain in front of you. You grip the fabric in your hands tightly, afraid it will disappear the moment you can no longer feel it.

        # IMAGE: Church_Inside #PROP: curtain_full
        "Why...?" you mutter as you try to stand, your legs shaky. You turn to face the main body of the church. "What is the point to any of this...? Are you trying to...?"

        Your voice is quiet, but you know the church heard you. Deep in your gut, you know, and you waited for its response. 
        
        Any response.
    
    - temp_string == "You grimace":
        Your head is still warm from where the pastor touched it. Your ears still ring from the words that were said. But your eyes do not meet the pastor or the girl. Instead, they meet the intact curtain. You grip the fabric tightly in your hands, only to find your nails digging into your flesh. The fabric is gone.
        
        Your eyes dart back and forth between your empty hands, and the intact curtain in front of you. You can't understand it.

        # IMAGE: Church_Inside #PROP: curtain_full
        "What is this...?" your voice warbles, and you slowly stand. You turn to face the main body of the church. You throw out your hands, holding the fabric up like an offering. "What— what is this...?!"

        You let out a wet croak. You look around, looking for some response. 
        
        Any response.
    
    - temp_string == "You grind your teeth":
        # IMAGE: Church_Inside #PROP: curtain_full
        "What is this?" You stand and throw a fist at the intact curtain. You turn to face the main body of the church. "What. is. THIS?!"

        You can't help but laugh. Laugh at the absurdity. At your stupidity. You remember the words on the note you were given. 
        
        <i>It will do anything to keep you here.</i>

        "Is this how you get me to stay? Huh?" You look around, looking for some response. Any response. You spit on the ground.
}

*[The church is silent.]

- 

{
    - temp_string == "Your hands tremble":
        You fold the ripped fabric as best you can, and place it over the scarred wood and blood.

        "I'm sorry."
        
        You face the church, and close your eyes. "Please, was any of it...? Is she...?"
        
        When you open them, the fabric is gone, the wood floor is smooth, and there is no indication that blood was ever spilled.
        
        You nod, getting the answer you expected. <i>It will do anything to keep you here.</i> 
        
        You should keep that in mind. You do not want to become another victim of the church. You will make it out of here. {Stay_Tracker >= 1.25: You hope. | You are sure of it. }
    
    - temp_string == "You grimace":
        You laugh. A harsh, absurd laugh. You place a hand over the scarred wood, close your eyes, and say a prayer. "I— I'm so sorry."
    
        When you open them, the wood floor is smooth, and there is no indication that blood was ever spilled.
        
        You nod, and laugh again, getting the answer you expected. <i>It will do anything to keep you here.</i> 
        
        You should keep that in mind. You can't become another victim of the church. You will make it out of here. {Stay_Tracker >= 1.25: You hope. | You are sure of it. }
    
    - temp_string == "You grind your teeth":
        You scoff. Of course. Your eyes scan the windows. They are frustratingly still. You don't give the confessional another glance. You will get out of here. You will not become just another victim. {Stay_Tracker >= 1.25: You hope. | You are sure of it. }
        
}

*[Continue your search]
    -> Confessional_Door.Return_to_Search


= Yes_Confessions
The words tumble yout before you fully realize what you're agreeing to. You chew your cheek wondering if you should take it back.

"Oh!" She perks up immediately. "I kept miss—" She is cut off by a coughing fit. Harsh, loud, wet coughs. 

*[Wait for her to stop]

*[Ask if she's alright]
    "Ye—" she tries to respond. "Ye—ah."

    "Deep breaths." You say. "We are in no rush."

    She tries to say something else, but the coughing fit persists.

- You wait, listening to the aggressive, wet coughs plaguing the girl on the other side. Each raspy inhale twists your insides into a tighter knot. You want to dash to the otherside to comfort her, but you stay glued to your seat. {Stay_Tracker < 1: You don't think she'll be there once you get there. You pick at your nails. | You know the best way to comfort her is to stay where you are. To stay in this moment where she exists at the same time you do. You lean against the divider. } Eventually, she stops.

"Sorry," she wheezes. "I'm really sick... I was hoping that Daddy was... He's a priest so... Anyway!" She claps her hands together and clears her throat. "Forgive me father, for I have sinned."

<i>In for a penny, in for a pound.</i> You think. You say your own prayer hoping you don't mess this up.

~ temp Temp_Bool = false
*[Wait for her to continue]
    ~Temp_Bool = true
    You shift in your seat. You are <i>not</i> a priest, and certainly not a replacement for her father... You flounder over what you could possibly say.

*["I'm listening?"]
    You are <i>not</i> a priest, and certainly not a replacement for her father but... You want to be able to comfort her in some way. Priests mostly listen right? So you should be able to...

- There's an bloated silence. Your mind reels as you try to recall anything you know about confessions. {Temp_Bool: Are you supposed to say something? | Why did you say anything?}

"Since... Since I'm sick all time... sometimes I feel..." She's quiet for a moment. "I feel like a burden...." Your heart drops. "Mommy is constantly praying, and Daddy is always...."

~Temp_Bool = false
*[Let her continue]
    
*[Reassure her]
    ~Temp_Bool = true
    "You are not a burden, and I'm sure your parents would be upset to here you say so." You try to keep your voice calm and comforting. "Everything they are doing is for you."

- "{Temp_Bool:Probably, but }I wish... I wish we could all just be home and together again..." she mutters. "When Mommy brings me, they just argue the <i>entire time.</i>"

Your stomach drops. Here? <i>This</i> church? {Confessional_Encounters ? (Finished_Curtain_Side): If her father is a priest... Was he...?} Your mind races.

*["What do you mean?"]
    "<i>This</i> church?" The question comes out harsher than you mean to.

*["He doesn't come home?"]
    "He used to, but—" She coughs. "But he hasn't in a really long—"
    
    "And come to <i>this</i> church?" The question comes out harsher than you mean to.

- "Oh, uhm, well I don't—" She fumbles over her words. "I'm sorry did I say something wrong?"

You have many questions, but she is still a child. You rub your hands over your face. This might be the only way you can get any kind of answers.

*[Press her further]
    "No, no, of course not." You hear her sigh with relief. "But can you talk more about your dad not leaving the church?"
    
    "You don't know? I don't wanna get in trouble..."
        
    "You won't."
        
        "Promise?"
        -> Confessional_Door.Promise

*[Let up]
    "No, no, of course not." You hear her sigh with relief. You close your eyes and lean your head back until it hits the wall of the booth. "Only making sure I understood you."
    
    "Oh, okay. Uhm... yeah... Daddy just stopped calling all of a sudden so, I was hoping that Daddy would be here...." She sniffs. "I thought if I visited... But it's really, really dark in here."
    
- You wipe your hands on your pants. You feel sick. The church used the shell of her father to lure her in? {Book_Knowledge ? (Read_Oldin_Book): And based on his book, it wasn't him, not really. | {Church_Investigation ? (Called): Like how they used your grandparents?}}

"I just wanted things to go back the way they were!" she croaks, her voice tight and strained. Where's my dad? How do I get out?! Please, tell me how to leave!"

-> Confessional_Door.Press_Her

= Promise
*["Promise."]
    ~ Confessional_Encounters += (Talked_to_Girl)

- "Well... I don't really know. He used to come homw, but then one day he just stopped! He would always tell Mommy to bring me here over the phone." She sniffs. "I only see him if Mommy brings me here, but she only ever lets me talk to him from the gate. I went by myself this time, but Daddy didn't show up this time so..." 

"So...?" You wipe your hands on your pants. You feel sick. The church used the shell of her father to lure her in? {Book_Knowledge ? (Read_Oldin_Book): And based on his book, it wasn't him, not really. | {Church_Investigation ? (Called): Like how they used your grandparents?}}

"I went inside."

*["Your mom is going to be-"]

*[Why would-?"]

- "You promised I wouldn't get in trouble!" She yells, and her voice warbles. From her outburst, you assume she knew she did something wrong. "But now the door won't open and I can't find anyone! Where's my dad? How do I get out?! Please, tell me how to leave!"

-> Confessional_Door.Press_Her

= Press_Her

*[Ask her about the church]

*[Apologize]
    "I'm sorry." You say, and she stops crying. "You're not in trouble, but..." You bite your lip.
    
    She coughs heavily before asking, "But what? Did I do something wrong? I- I just wanted to-"
    
    "You can't leave, not easily." You say, your voice quiet. You parrot back the same words that were said to you earlier. "{Confessional_Encounters ? (Finished_Curtain_Side): Your dad probably isn't here, or if he is, it's not him anymore.} Maybe together, we can-"
    
    -> Confessional_Door.No_Confessions
    

- "{Book_Knowledge ? (Read_Oldin_Book):Emily|Listen}, you need to tell me everything you know about the church. It's very important. {Book_Knowledge ? (Read_Oldin_Book): |I'll tell you how to find your dad if you do.}"

{Book_Knowledge ? (Read_Oldin_Book): "How do you know my name?" | "I thought you said he left?" }

You freeze. {Book_Knowledge ? (Read_Oldin_Book): Did she not say it earlier? | Why did you say that?} You think quickly on your feet. {Book_Knowledge ? (Read_Oldin_Book): You can't exactly tell her you read it in a book. }

*{Book_Knowledge !? (Read_Oldin_Book)} ["I... forgot!"]

*{Book_Knowledge !? (Read_Oldin_Book)} ["I... was mistaken!"]
    ~ Confessional_Encounters += (Pressed_Emily)
    "No..." You can hear her stand, and shuffle on the other side. "Why did you—"
    -> Confessional_Door.No_Confessions

*{Book_Knowledge ? (Read_Oldin_Book)} ["Your dad told me."]

*{Book_Knowledge ? (Read_Oldin_Book)} ["You told me."]
    ~ Confessional_Encounters += (Pressed_Emily)
    "No I didn't." You can hear her stand, and shuffle on the other side. "How do you—"
    -> Confessional_Door.No_Confessions

- {Book_Knowledge ? (Read_Oldin_Book): "Why?" | "You forgot?"}

{Book_Knowledge ? (Read_Oldin_Book): "He... thought you might visit! And... told me.... just in case!" | "He did... but told me where he went... just in case you visited!} It's pretty clear that you're lying, but you hope she buys it. 

"Oh." Her voice is quiet. "I see..."

*[Did she buy it?]

- "Then... If I tell you about—"

"Yes." you say, a little too fast.

"O—okay. I don't re—really know, but..." she clears her throat. "Daddy said one day he found a new job close to home. He wanted me to come visit so they could pray for me."

"They?" Your heart pounds.

"I dunno. Other people who come here? But after he went for the first time, he didn't come back. But he called a lot! He just really wanted me to come visit."

You ball your fists. It's not the same as what happened to you, but it's similar enough.

*[They are also victims of the church.]

- "Thank you." You say, and lean back, closing your eyes. Your mind races as you process the information. What do you and this girl, no <i>family</i>, have in common? "That helps a lot."

"Mhm... Where's my dad?" She is hopeful.

*[Lie to her]
    You don't think it matters. You know she's already gone, but it still feels bad to lie. You hope she forgives you. "He went to his office to finish a few things. If you wait by the door, he'll come find you."
    
    #PLAY: curtain
    "Okay, I'll... I'll do that." She sniffs, and the curtain opens. "Thank you."
    
    The curtain closes, and she is gone.
    
    **[Leave the booth]
    
    -- You didn't find the heart, but at least you learned a bit more about the church. You hope it will help you later.

        -> Confessional_Door.Return_to_Search

*[Tell her to leave]
    ~ Confessional_Encounters += (Tell_Her_Leave)
    
    
- You don't think it matters, but you can't leave this girl to be digested, even if she's already gone. You think back to how you got out as a child, though it's still fuzzy.

"Your dad's gone, and you need to leave as well. Stay by the door, and it might let you out."

"What?" You don't answer, instead, you stand up and open the door. She starts coughing. "But you said-"
-> Confessional_Door.No_Confessions

= Leave_Real
You don't hesitate and leave the booth. You stare at the confessional. It's quiet. You're not sure what's in there, but you don't think it's the same person that helped you before.

There was nothing in there, anyway. You should look for the heart elsewhere for now. You look...

~ previous_area = Confessional_DoorSide
~ current_area = Main_Body
~ Have_Visited -= Confessional_DoorSide
->Inside.Look_For_Heart

= Return_to_Search
~ Confessional_Encounters += (Finished_Door_Side)

~ previous_area = Confessional_DoorSide
~ current_area = Main_Body 
~ Have_Visited += Confessional_DoorSide
~ visited_state += 1

{visited_state:
    
    - 1:
        ->After_First.Confessional_After
    - 2:
        -> After_Second.Confessional_Sin_Second
    - else:
        -> Last_Stop.Confessional_Sin_Last
}






























