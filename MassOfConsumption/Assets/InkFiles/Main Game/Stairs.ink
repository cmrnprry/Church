=== Stairs ===

= Examine_Stairs
{Have_Visited !? (Stairs_Up) and Downstairs_State <= None: You walk deeper down the hallway to the stairs. Going up, is a spiral staircase. Going down, is a long set of stairs. You can't see the end of either. {Looked_For_Items and visited_state < 1: How did you miss this before?} | The stairs are still there, spiraling up into the sky and digging down into the earth.} #IMAGE: Defualt

+[Go upstairs]
    ->Stairs.Upstairs
    
+[Go downstairs]
    ->Stairs.Downstairs
    
+ {Room_State < Gone} [Enter office]
    You turn around are return to the office door. {Room_State == Half: You frown at the doorway. Was it always that short? } {Room_State == Crawl: You blink at the doorway. It was definitely not always that short. You think you would remember needing to army crawl to enter.}
        ->Office_Area.Office


////////// DOWNSTAIRS INTERACTIONS ////////// 

= Down_None(From_Mimic)
~ Downstairs_State = Stink
Cautiously, you take another step down{Leg_State >= Limping:, making sure to lean against the railing to take weight off your leg}. And then another. And another. With every step down, your body yells at you more and more to turn back. That something's wrong.

About halfway down the steps, the smell of rot hits your nose, so strong you gag. {Leg_State >= Limping: You grab the railing with both hands, | You grab the railing to steady yourself,} and retch. The stench is unbearable. 

It smells of old, rotten meat left in the sun. Of putrid sour milk left out for too long. Of rancid fruit left to liquify in the fridge. You cover your face with your shirt, and breathe through your mouth, but the pungent smell clings to you. 

*[Push through]
    ->->
*[Turn back]
    {From_Mimic: You pray the mimic is gone as y| Y}ou stumble back up the stairs to the hall, and take a deep refreshing breath of the clean air. Luckily, the smell doesn't seem to have stuck to your clothing. {From_Mimic: There's no sign of the creature anywhere, thankfully.}
    ->Stairs.Turn_Back
    

= Down_Stink(From_Mimic)
{Downstairs_State == Stink: You swallow your nausea| You plug your nose} and keep going, only stopping to occasionally dry heave. It isn't long before the steps change from wood to... to something you can't comprehend. You stop and shine the light. 

#CYCLE: Fidget, mold, fungus, flesh
The rest of the stairs are covered in pink, bulbous... flesh? You shake your head. It has to be some sort of mold or fungus. You poke the next step with your foot, and the @ shivers in response. 

You shine your light to the end of the staircase, and see a door at the end of the stairs. Walls and ceiling covered in the same disgusting substance.

~ Downstairs_State = Flesh

*[See what's behind the door]

*[Turn. Back.]
    #PLAY: flashlight_off
    ~ PlaySFX("flashlight_off", false, 0, 0)
    Without a second thought, you rush back up the stairs to the hall. You take a deep refreshing breath of the clean air at the top, and try to make sense of what you just saw. 

    The flesh, it— it <i>reacted</i> to your touch. Your skin crawls at the thought. You don't think you should go back down there.
    ->Stairs.Turn_Back

- 
#PLAY: 1, squish-squash
~ PlaySFX("squish-squash", true, 1, 0)
<i>You've made it this far, might as well see it it toward the end,</i> you think, and take another deep breath through your mouth. Slowly, you make it to the bottom of the stairs.

<i>Squish</i>

#stop: 3, squish-squash
~ StopSFX("squish-squash", 3, 0)
The tissue is soft under your shoes, making a soft, wet sound with each step. A thick ooze sticks to the bottom of your shoes.

<i>Squelch</i>

*[Open the door]
    ->Stairs.In_Basement

= Downstairs
{
    - Downstairs_State <= Bad_Vibes:
        ~ Downstairs_State = Bad_Vibes
        
        ~ PlaySFX("flashlight_on", false, 0, 0)
        You approach the stairs shine your flashlight down. The walls on either side of the stairs are smooth, but damp. You cannot see the bottom. You take one step down, and deep groan wells up from below. #IMAGE: Stairs_Down

        You tense, every fiber of your being telling you to not continue down.
    - Downstairs_State == Stink:
        ~ PlaySFX("flashlight_on", false, 0, 0)
        You approach the stairs again, and plug your nose. You breath through your mouth as you quickly descend. The stench punches you in the face, hanging heavy in the air. You take deep, deliberate breaths, as you continue.
        
    - else:
        #PLAY: flashlight_on
        ~ PlaySFX("flashlight_on", false, 0, 0)
        You approach the stairs again, and swallow. A feeling in your gut is telling you not to go down and further.
}

*[{Downstairs_State <= Bad_Vibes: Continue down | Push through}]

*[Turn back]
   {Downstairs_State <= Bad_Vibes: You turn back up the stairs. It doesn't feel right. |  You stumble back up the stairs to the hall, and take a deep refreshing breath of the clean air. You can try again later.}
    ->Stairs.Turn_Back
-

{
    -Downstairs_State <= Bad_Vibes: -> Down_None(false) -> 
    - else: -> Down_Stink(false)
}

-

-> Down_Stink(false)

= In_Basement
The door opens, and you are assaulted by the stench. Your eyes water and you pull your shirt over your nose and mouth, not that it does much. You take a few steps inside, trying to see what's the cause of this god awful smell. #IMAGE: Basement

The room is covered in the pink, bulging flesh, thick ooze drips from the ceiling. You pan your flash light around. The room is filled with furniture covered in tarps.

*[Find the source of the smell]

*[Investigate the ooze]
    #DELAY: 1.5
    You walk deeper into the room, deeper into the maze, and approach a place where the ooze consistently falls from the ceiling. You stick the end of the flashlight into the small pool of it. It's sticky and slippery, much more slime like than ooze.
    
    ~ PlaySFX("flashlight_on", false, 0, 0)
    ~ PlaySFX("flashlight_off", false, 0, 0.25)
    ~ PlaySFX("flashlight_on", false, 0, 0.5)
    ~ PlaySFX("flashlight_off", false, 0, 0.75)
    The flashlight flickers, and turns offs. You hit it against the palm of your hand, trying to get it to turn back on, the slime getting on you in the process.
    ->Stairs.Melt

- You walk deeper into the room. It is a maze of old furniture. Most of it is normal, chairs, tables. Some of the shapes confuse you. Some are too tall, or too wide to be anything recognizable. 

You pass by what you assume is a standing coat hanger, and stare at it. It is taller than you, and has multiple edges jutting out from it. You reach out to lift the canvas covering it, but stop just before touching it. 

*[Rip off the tarp]
    You grab the canvas and rip it off the coat hanger.
    
    #IMAGE: Default #CYCLE: person, animal, zombie, creature, beast #DELAY: 3.5
    You scream and fall backward, landing in a puddle. You fix your flashlight on the @, trying to make sense of it all. It's fused into the coat rack, limbs sewn into wrong places and the metal forced into flesh so it keeps its shape. And its face? Its face was a writhing mass of-
    
    ~ PlaySFX("flashlight_on", false, 0, 0)
    ~ PlaySFX("flashlight_off", false, 0, 0.25)
    ~ PlaySFX("flashlight_on", false, 0, 0.5)
    ~ PlaySFX("flashlight_off", false, 0, 0.75)
    The @ twitches, snapping bones and warping metal to look at you. A squeak escapes you and you drop your flashlight. It flickers as it rolls away, and turns offs. The thing groans as more bones snap and it falls, landing on top of you.#CYCLE: person, animal, zombie, creature, beast 
    ~temp_bool = 0
    
    **[Get it off]
    
    **[Get it off]
    
    **[Get it off]
    
    -- You screech kicking your legs and attempting to shove it off. It wails and grabs your shirt, vomiting something all over your face and body. You hold in a scream to avoid anything getting in your mouth, and rip the thing's hands off you and hurl it away from you. You clamber backwards and to your feet, wiping the vomit and ooze off your face the best you can. You blindly run away from the the thing, the only thought you have is to <i>get away.</i>
    
        It's thick and sticky. Your skin itches where it touched, the feeling stronger where the ooze clings to your shirt. <>
    ->Stairs.Melt

*[Leave it alone]

- You retract your hand. You stare at the coat hanger a little longer before continuing on. You continue deeper into the room, the smell getting stronger with each step. You pray that the smell won't linger after you leave, and follow your nose to the source.

You find yourself in the far back corner, a tarp partially covering something scattered over the floor. It come us to about your chest, a stacked pile of... something. Firewood? But you don't remember seeing a fireplace upstairs...

Near the edge of the tarp you see scraps of wet cloth and... Is that... bone...? You swallow the lump in your throat.

*[Lift the tarp]

- #PLAY: flashlight_off
~ PlaySFX("flashlight_off", false, 0, 0)
You let out a shriek and fall backwards, dropping your flashlight in the process. It turns off and rolls away.

#CYCLE: Fidget, mourn, pity, pray
Underneath the tarp lies a pile of bodies, covered in rotten flesh. Clumps of hair stuck to skulls. An amalgamation of bones fused together. You don't have time to @ for them, your only thought is to get <i>out.</i> On your hands and knees, you search the floor for your light. 

*[Search left]
~temp_bool = false
You feel to your left. The ground feels like you're touching chewed gum covered in slime. Your skin crawls with each touch of the ground, but you keep searching.

You feel a slight divot in the ground, and reach further in, hoping the flashlight rolled there. Instead, you end up shoving your hand into a pool of whatever ooze is dripping from the ceiling.

*[Search right]
~temp_bool = true
You feel to your right. The ground feels like you're touching chewed gum covered in slime. Your skin crawls with each touch of the ground, and keep searching.

Eventually, your hand bumps into something hard and metal. The flashlight. You grab it. It's covered in the same ooze that drips from the ceiling. You wipe it off with your hand, and try to turn it back on.

- 

*[Your hand starts to itch]
->Stairs.Melt

= Melt
You wipe off any remaining ooze on your shirt, but that only causes the itching to spread. 

*[It burns]

- Blood rushes to your ears, so loud you can barely think. You need to get out of here- Out of this this slime{temp_bool:. You have the flashlight. |{temp_bool != 0:, flashlight be damned. |, away from that <i>thing.</i>}} You blindly try to make your way back to the door.

{temp_bool != 0:The ooze falls from the ceiling. The puddles splash with each step. | Something falls on you from the ceiling, and it burns the same. You splash in puddles of more of the same.} You cannot wipe it off fast enough. 

*[It's eating through you]

- You wipe off another blob off your shoulder, but something goes with it. Something wet. Something warm. You stop, and reach up to touch your shoulder. Your hand shakes. Your breathing becomes short and shallow.

*[You feel bone]

- 
#DELAY: 2
You can't think. Bone? How—? 

#CLASS: Blur #DELAY: 2
Your skin burns.

#DELAY: 2
Your head swims. This can't be—

#CLASS: Blur #DELAY: 2
Your skin burns.

#DELAY: 2
You can't get enough air in. Is this actually slime—?

*[Your skin burns.]

- 
#DELAY: 2
You keep going, desperately trying to escape. 

#CLASS: Blur #DELAY: 2
You can't feel your hand anymore.

#DELAY: 2
You trip over yourself, and fall into puddle of the acidic ooze. 

#CLASS: Blur
You can't feel your legs.

*[You can't feel anything.]
#ENDING: 1, Bad Ending: Digested
->Endings.Bad_End_1

= Turn_Back
*[Go upstairs]
    ->Stairs.Upstairs

*[Enter the office]
    ->Office_Area.Office

*[Return to the main body of the church]
    -> Stairs.Exit_Stairs_Area


////////// UPSTAIRS INTERACTIONS ////////// 

= Downstairs_Trick
~ temp Temp_Can_Smell = false
At least until the smell hits you. The smell of rot hits your nose, so strong you gag. {Leg_State >= Limping: You grab the railing with both hands, | You grab the railing to steady yourself,} and retch. <>

{Downstairs_State >= Stink: It was the same ripe smell from before. Possibly worse than before. | The stench is unbearable. It smells of old, rotten meat left in the sun. Of putrid sour milk left out for too long. Of rancid fruit left to liquify in the fridge.} You swing around to look behind you only to be met with inky blackness. You know you didn't miss the landing, that's impossible.

*[Continue down]
    ~ Temp_Can_Smell = true
    "Whatever," you mutter and continue down the stairs. Maybe you stepped in something. Or something died in the stairs and you didn't notice the first time around.

*[Retrace your steps]
    Taking a deep breath through your mouth, you start back up the stairs. {Downstairs_State >= Stink: There's no way you just walked right past the landing like that. There's a gap between the sets of stairs. <i>I would have noticed.<i/>| You could have sworn there was a gap between the set of stairs spiraling up and the set digging down. At least enough to notice when one starts and the other ends.} #IMAGE: Stairs_Up
    
    After climbing the stairs for a few minutes you notice the rail sink and the incline turn sharp. <i>What in the?</i> Shining your flash light up, you see the stairs twist into a tight coil. {Looked_For_Items or Church_Investigation ? (Teleported): <i>Is the church messing with me?</i> | <i>How did...?</i>} 
    ~ Downstairs_State = Stink
    TODO: Check what other variables I should be checking for here and down below
    
    **[Continue to the top]
        <i>Screw it.</i> You think and decide to reach the top. At this point, either the landing never existed or the church is messing with your sense of direction. Either way, you would rather take your chances with whatever the attic has in store for you rather than the basement. {Downstairs_State >= Flesh: Your skin crawls at the memory of the flesh covering the staircase. | {Downstairs_State >= Stink: You gag at the thought of the stench.}} 
        
        You power through the rest of the stairs, only stopping to rest when your limbs refuse to cooperate. At some point, you end up almost fully vertical, treating the stairs as a ladder. Your finger tips burn from gripping the ground so tightly{Leg_State >= Limping:, your injured leg screaming from the exertion}. Resting became a risk, fearing that losing any momentum, even for a moment, would cause you to fall back and tumble back to the start.
        
            ->Stairs.Upstairs_Landing(false)
    
    **[Turn around and try again]
        "Third time's the charm," You mutter, turning back down the stairs, methodically checking for the landing after each step. #IMAGE: Stairs_Down

- A flight or two later, you barely make out a flat platform at the edge of your flashlight's range. You don't think, you rush down the rest of the stairs, running face first into a door. {Temp_Can_Smell: The smell ten times stronger than before. | The scent of rotting flesh hits you a second later.}
        
#CYCLE: mold, flesh, meat, fungus
In frustration you kick the door{Leg_State >= Limping:, then suppress a curse as a sharp pain shoots up your leg}. You step back and slip on something leaking from the under door, landing on a squishy mass. You yelp, jumping away{Downstairs_State >= Flesh:, eyes fixed on the quivering @. |, and see the walls and stairs covered in the same bulbous @.}

~ temp Temp_Touched_Mass = false
~ Downstairs_State = Flesh
*[Touch the mass]
    ~ Temp_Touched_Mass = true
    Curiosity gets the best of you and you poke the squishy mass. It shivers in response to your touch, and it retains an indent from where you poked it. The mass sticks to your hand slightly and feels wet, but isn't. It feels similar to warm, chewed gum, but less soft and more... meaty?
    
    You wipe your hand on your pants. That was gross.
    
    **[Enter the basement]
        You cover your face with your shirt, and slowly turn open the door. <>
        -> Stairs.In_Basement

    **[Climb the stairs]

    
*[Take your chances with the basement]
    You cover your face with your shirt, and slowly turn open the door. <>
    -> Stairs.In_Basement

*[Take your chances with the stairs]

- 
#CYCLE: mold, meat, fungus, flesh #PLAY: 1, squish-squash
~ PlaySFX("squish-squash", false, 1, 0)
You don't think anything could be worse than the smell emanating from the door in front of you and decide to try climbing the stairs one last time. The @ sticks to your shoes as you step on it{Temp_Touched_Mass:.|, like warm gum.} Your lip curls.

The stench fades and the substance coating the walls dissipates as you reach the top. You pull yourself out of the stairwell, finding yourself at the landing you were desperately searching for. You could almost kiss the ground.

*[Rest for a bit]
    #DELAY: 3
    You collapse to the floor and massage your thighs. You close your eyes and lean against the wall between the stairs. Your body welcomes the much needed break, as you feel some tension release.
    
    "There's no time for this!" A woman's voice, soft but full of anger, rips through the quiet and freezing hands shove you over the edge of the stairs.
    
    #DELAY: 2
    Your eyes snap open as you pull yourself into a ball, covering your head with your arms. Your whole body tenses as you brace for impact—
    ->Stairs.Upstairs_Landing(true)

*[Enter the office]
    ->Office_Area.Office

*[Return to the main body of the church]
    ~ Downstairs_State = Flesh
    ~ Have_Visited -= (Stairs_Up)
    -> Stairs.Exit_Stairs_Area
    

= Upstairs
~ Have_Visited += (Stairs_Up)
~ PlaySFX("flashlight_on", false, 0, 0)
You start up the stairs, holding the hand rail as you go. You take a break after about 5 or 6 flights, but the top doesn't look any closer. With a huff, you continue up. #IMAGE: Stairs_Up #EFFECT: Flash-On

Tighter and tighter the stairs spiral. The hand rail sinking lower and lower. The incline becoming steeper and steeper. After a count of 14 flights, you wonder if this is a fruitless effort. Sweat runs down your back, and your legs quiver from effort. {Leg_State > Tense: The leg you used to kick the door in feels particularly weak.}

*[Give up]
    Shaking your head, you make the journey back down the stairs. Thankfully, going down is much easier than going up. As the hand rail once again rises to sit at a reasonable height and the spiral gradually straightens out, you know you made the correct choice. #IMAGE: Stairs_Down
        -> Stairs.Downstairs_Trick

*[Power through]
    
- You push through, only stopping to rest when your limbs refuse to cooperate. 
At some point, you end up almost fully vertical, treating the stairs as a ladder. Your finger tips burn from gripping the ground so tightly{Leg_State >= Limping:, your injured leg screaming from the exertion}. Resting became a risk, fearing that losing any momentum, even for a moment, would cause you to fall back and tumble back to the start.

*[<i>How tall is this church?</i>]
    ->Stairs.Upstairs_Landing(false)

= Upstairs_Landing(from_trick)
~ Have_Visited += (Stairs_Up)
{
    - from_trick:
        You skid across a wooden floor and crash into a door. You blink rapidly and slowly uncurl yourself, trying to understand where you are and what just happened. {Met_Mimic: You look around, looking for the mimic, but find yourself alone. The sound of it's enraged screeching echos in your head. She saved you, and you hope you can pay her back one day. | That voice sounded similar to the one that gave you your flashlight. You don't know why she did that, but she must have brought you here for a reason.} #IMAGE: Default
        
        You find yourself on a small landing, maybe only five feet by five feet. It sharply drops off on the edges. You crawl forward to the edge and look down. You find yourself staring down the spiral staircase, it's coils wound much tighter and steeper than you thought possible. You back up from the edge.
        
        Behind you is the door you crashed into. It's old and wooden, much like the rest of the church. It is covered in chains and locks. A metal bar is bolted across the door in a way where you could not pull or push it open, even without the chains. Soft, pulsing, red light peaks out from under it.
        
    - else:
        After countless flights of stairs, you make it to a landing, crawling your way onto solid ground. You lay flat on your back, catching your breath. {Leg_State >= Sore: Any longer on the stairs, and you think you may have fallen.}
        
        The only thing on the landing is a door. It's old and wooden, much like the rest of the church. It is covered in chains and locks. A metal bar is bolted across the door in a way where you could not pull or push it open, even without the chains. Soft, pulsing, red light peaks out from under it.
}

*[Examine the locks]
    
*[Peek through the keyhole]
    TODO: maybe art here if i wanna be crazy
    You approach the door and peek through the keyhole. You can't make out much, but you can see a small table and something placed upon it. That looks to be the source of the glowing.
    
    #CYCLE: anxiety, excitement, fear, unease, hope
    Whatever it is, you assume it's important. Your @ fills your chest. The heart, maybe? {from_trick: Is this why she sent you here?}
    
    **[Examine the locks]

- 
{Saw_Locks: The locks look the same as you remember. {LIST_COUNT(items_obtained) <= 0: You don't have anything new to try with them, so you're not sure why you came back up.}| You approach the door, taking a closer look at the various locks and chains blocking it. There are three main locks from what you can tell. One that needs a code, one that needs a key and a sliding lock. Look closer at the...}

{
    - Saw_Locks == false:
        ->Stairs.Look_Close_Locks(0)->
}

- 
~ Saw_Locks = true
    -> Stairs.Locks

= Look_Close_Locks(visited)
*[Lock that needs a key]
    The top lock looks like something you'd find in an antique shop, made of heavy metal. It has a small key hole, and is holding the majority of chains together. The chains themselves aren't very think, but they are sturdy. {broke_key: You mentally kick yourself for snapping the key earlier, and hope it wasn't for this.}

*[Lock that needs a code]
    The middle lock looks slightly newer. It doesn't require a key, but a four digit number code. It is attached to the metal bar that keeps the knob from turning. Removing this lock would probably allow the door to be opened.
    TODO: add bit here about seeing 4 numbers around

*[Lock that needs to be cut]
    The last lock is a sliding chain door lock. Sliding it all the way to the end causes a smaller deadbolt slide into place, keeping the door locked. There is no obvious keyhole.

- 
{visited < 2: -> Look_Close_Locks(visited + 1) | ->->}

= Locks
+{Locks_Undone !? (Key_Lock) and (!broke_key or !broke_key_lock)}[{(items_obtained ? (Skeleton_Key) or items_obtained ? (Simple_Key)): Try your key | Look closer at the lock}]
    -> Stairs.Try_Key

+{Locks_Undone !? (Clippers_lock)}[{items_obtained ? (Clippers): Use the wire cutters | Mess with the sliding lock}]
   -> Stairs.Use_Clippers

+{Locks_Undone !? (Combo_Lock)}[{items_obtained ? (Combo): Enter code | Fiddle with the combination}]
    -> Stairs.Enter_Number

+{visited_state < 4} [Head back down]
    -> Stairs.Return_Down
    
*{Locks_Undone ? (Clippers_lock, Combo_Lock, Key_Lock)}[Open the door]
        ->Open_the_Door

= Try_Key
{(items_obtained !? (Skeleton_Key, Simple_Key)): You grab the pad lock and pull. The chains rattle slightly. The key hole looks average. There's nothing that indicates they type of key needed. -> Stairs.Locks }

{
    - items_obtained ? (Skeleton_Key, Simple_Key):
    
        *{!broke_key}[Try the simple key]
            ~ Locks_Undone += (Key_Lock)
            ~ PlaySFX("groaning-angry", false, 1, 0)
            ~ StopSFX("groaning-angry", 2, 1)
            You pull out the key you found in the office try it on the lock. It resists slightly, but after jiggling it, you're able to slot it in and turn it. You sigh with relief as <>
            
            #PLAY: groaning-angry, 1 #stop: groaning-angry, 2
            
            the chains and lock fall to the ground. The church groans angrily in response. 
            
            { - LIST_COUNT(Locks_Undone):
                - 1: One lock down, two more to go.
                - 2: Two locks down, one more to go.
                - 3: That was the last of them.
            }
            
            -> Stairs.Locks
            
        *{!broke_key_lock} [Try the ornate key]
            ~ broke_key_lock = true
            You pull out the key the priest {Confessional_Encounters ? (Accepted_Priest): gifted | left } you. It resists slightly, but you push the key harder in the lock. It starts to turn before snapping in your hands. You shout in frustration and throw the broken key to the ground. {broke_key == false: Thank god you found the other key. Hopefully this one will work. You pull out the second key and pray it'll work. | {items_obtained ? (Clippers): You'll need to use the wire cutters on the chain and hope they don't break until you're done. | You'll need to find the right key downstairs or something to break the chains.}}
            
            {broke_key: -> Stairs.Locks }
            
            **{!broke_key}[Try the simple key]
                ~ Locks_Undone += (Key_Lock)
                ~ PlaySFX("groaning-angry", false, 1, 0)
                ~ StopSFX("groaning-angry", 2, 1)
                The key refuses to turn, but you jiggle it in the lock, careful to not force it, and it turns. You sigh with relief as <>
            
                #PLAY: groaning-angry, 1 #stop: groaning-angry, 2
                
                the chains and lock fall to the ground. The church groans angrily in response. 
                
                { - LIST_COUNT(Locks_Undone):
                    - 1: One lock down, two more to go.
                    - 2: Two locks down, one more to go.
                    - 3: That was the last of them.
                }
                
                -> Stairs.Locks
    
    - items_obtained ? (Simple_Key) and !broke_key: 
        ~ Locks_Undone += (Key_Lock)
        ~ PlaySFX("groaning-angry", false, 1, 0)
        ~ StopSFX("groaning-angry", 2, 1)
        You pull out the key you found in the office try it on the lock. It resists slightly, but after jiggling it, you're able to slot it in and turn it. You sigh with relief as <>
            
        #PLAY: groaning-angry, 1 #stop: groaning-angry, 2
        the chains and lock fall to the ground. The church groans angrily in response. 
        
        { - LIST_COUNT(Locks_Undone):
            - 1: One lock down, two more to go.
            - 2: Two locks down, one more to go.
            - 3: That was the last of them.
        }
        -> Stairs.Locks
    
    - items_obtained ? (Skeleton_Key) and !broke_key_lock:
        ~ broke_key_lock = true
        You pull out the key the priest {Confessional_Encounters ? (Accepted_Priest): gifted | left } you. It resists slightly, but you push the key harder in the lock. It starts to turn before snapping in your hands. You shout in frustration and throw the broken key to the ground. {items_obtained ? (Clippers): You'll need to use the wire cutters on the chain and hope they don't break until you're done. | You'll need to find the right key downstairs or something to break the chains.}
        
        -> Stairs.Locks
}

= Use_Clippers
{items_obtained !? (Clippers):  You tug at the chain lock, but it's tightly fastened to the door. You grab at the chain itself and pull, thinking the thinner chain might snap under the pressure, but it holds fast. You then try messing with the sliding lock as well, looking to see if there's a trick to it. If there is, you can't figure it out. -> Stairs.Locks}

~ Locks_Undone += (Clippers_lock)

#PLAY: cut_chain
~ PlaySFX("cut_chain", false, 0, 0)
You slide the chain lock to the the side, so the extra deadbolt is not blocking the door from opening, and use the small wire cutters you have to break the sliding chain. {Church_Encounters ? (Finger_Chopped): You flinch at the sound out the chain snapping, reminded of the sound when you let them take your finger. A dull pain echos through your stump.}

#PLAY: cut_chain
~ PlaySFX("cut_chain", false, 0, 0)
{Locks_Undone !? (Key_Lock): You look at the rest of the chains that are held together with the old looking lock. {items_obtained ? (Skeleton_Key) or items_obtained ? (Simple_Key): You try the key you found but...}}

*[Cut the chains]
    ~ Locks_Undone += (Key_Lock)
    #PLAY: cut_chain
    ~ PlaySFX("cut_chain", false, 0, 0)
    You cut the chain close to the lock, and it falls to the ground along with the chains it was holding up. 

*[Use the key]
    -> Stairs.Try_Key
    
- {LIST_COUNT(Locks_Undone) == 2: With two locks removed, all that's left is the number lock. | {LIST_COUNT(Locks_Undone) == 3:That was the last of them. | One lock down, two more to go.}}

-> Stairs.Locks

= Enter_Number
{items_obtained !? (Combo): You try a few combinations on the number lock, thinking you can guess code. You try today's date, the current year, your birthday— Any meaningful set of four numbers you can think of. {Book_Knowledge ? (Kept_Book) or Book_Knowledge ? (Saw_Your_Book): Your run out of four digit numbers before you remember the numbers on your book. | After a few minutes, you give up. -> Stairs.Locks}}
{
    - items_obtained !? (Combo) and (Book_Knowledge ? (Kept_Book) or Book_Knowledge ? (Saw_Your_Book)):
        +[Try your book number]
            You can only properly remember your own book number. With no other options, you use your book number as the code, and the lock pops open. You remove the lock from the metal bar, and slide it out of place.  
            
            { - LIST_COUNT(Locks_Undone):
                - 1: One lock down, two more to go.
                - 2: Two locks down, one more to go.
                - 3: That's the last of them.
            }
            
            -> Stairs.Locks
        *[Ignore it for now]
            #CYCLE: wrong, sinister, uncomfortable
            You elect to not try your book number. You're not 100% sure why, but something feels @ about your book number being the code.
            -> Stairs.Locks
}
~ Locks_Undone += (Combo_Lock)

{
    - Book_Knowledge ? (Ripped_Pages):
        You pull the page from your pocket. You grab the combination lock and input the numbers, and pull on the lock.
        
        TODO: Maybe little "game" to input the numbers?
        
        It doesn't open.
        
        You pull harder, thinking it might be stuck. Nothing. You re-read the page. The code is correct, so what could... You read a bit further on and... You feel sick.

        Further down the page, it explains the number. Not a date or some random sequence, the code is different for everyone. To open it, you have to use your own number. The number that the church assigned you.
        {
            - Book_Knowledge ? (Kept_Book):
                 You check the cover of your book. 2758. With shaking hands, you input the code, and the lock pops open. You remove the lock from the metal bar, and slide it out of place. 
            -  Book_Knowledge ? (Saw_Your_Book):
                Your book. Of course. The one you left in the office. even without it, you clearly remember the number. With shaking hands, you input the code, and the lock pops open. You remove the lock from the metal bar, and slide it out of place. 
            - else:
                *[Try a few more combinations]
                    ->Random_Locks(0)
                    
                *[Leave to search for your book]
                    ~ Need_Find_Book = true
                    {LIST_COUNT(Locks_Undone) == 1: With one lock down, | {LIST_COUNT(Locks_Undone) == 2: With two locks down,| Unsure of what more you can do,}} you head back down. {LIST_COUNT(Locks_Undone) == 2: Once you find your book, and learn its number, you'll finally be able to open the door. | After you find your book, you'll have to thoroughly search to find things to open the remaining lock{LIST_COUNT(Locks_Undone) == 0:s}.}
                    
                    You mentally prepare yourself, dreading the climb, only to find the staircase has transformed from a dizzying steep spiral staircase into a normal single flight of stairs. Short enough that you can see the bottom of the landing.

                    Tentatively, you descend the stairs, ready for it to warp or change at any moment. When you reach the bottom and look back, the stairs are once again a giant spiral ascending into darkness. You beeline for the office, ready to search for your book.
                    
                    ->Office_Area.Office
        }
        
    - Book_Knowledge ? (Read_Mom_Old_Book):
        You grab the combination lock and input the numbers 2572...?, and pull on the lock. It doesn't open. Did you forget? You rearrange the numbers. 2754...? No. 7255? 2755?
        
        TODO: Maybe little "game" to input the numbers?
        
        It doesn't open.
        
        You pull harder, thinking it might be stuck. Nothing. You're almost positive the correct number was some combination of those numbers. You groan and wish you brought the page with you.
        {
            - Book_Knowledge ? (Kept_Book):
                "Come on... Think!" You squeeze your eyes shut and try to remember the exact number from Ophelia's book, but your mind stays blank. You try a few more similar number combinations. 2575? 5275? 2755?
                
                None of them work. There's only one other 4-digit code you can think of...
                
                *[Try your book number]
                    You can only properly remember your own book number. With no other options, you input your book number, and the lock pops open. You remove the lock from the metal bar, and slide it out of place. 
                    
                    You nod and take a deep breath through your nose. Right. Of course it's <i>your</i> number. {Finish_ophelia: You should have read her ending closer. Then you would've known that you'd need your number, not hers. | Maybe you would have realized that earlier if you finished her book.} Good thing you brought your book with you.
                    
                    { - LIST_COUNT(Locks_Undone):
                        - 1: One lock down, two more to go.
                        - 2: Two locks down, one more to go.
                        - 3: That's the last of them.
                    }
                    
                    -> Stairs.Locks 
            -  Book_Knowledge ? (Saw_Your_Book):
                "Come on.. Think!" You squeeze your eyes shut and try to remember the number from Ophelia's book, but your mind stays blank. You try a few more similar number combinations. 2575? 5275? 2755?
                
                None of them work. There's only one other 4-digit code you can think of...
                
                *[Try your book number]
                    You can only properly remember your own book number. With no other options, you input your book number, and the lock pops open. You remove the lock from the metal bar, and slide it out of place. 
                    
                    You nod and take a deep breath through your nose. Right. Of course it's <i>your</i> number. {Finish_ophelia: You should have read her ending closer. Then you would've known that you'd need your number, not hers. | Maybe you would have realized that earlier if you finished her book.} At least you remembered your number.
                    
                    { - LIST_COUNT(Locks_Undone):
                        - 1: One lock down, two more to go.
                        - 2: Two locks down, one more to go.
                        - 3: That's the last of them.
                    }
                    
                    -> Stairs.Locks
            - else:
                *[Try a few more combinations]
                    ->Random_Locks(0)
                    
                *[Leave to double-check the books]
                    ~Need_Double_Check = true
                    {LIST_COUNT(Locks_Undone) == 1: With one lock down, | {LIST_COUNT(Locks_Undone) == 2: With two locks down,| Unsure of what more you can do,}} you head back down. {LIST_COUNT(Locks_Undone) == 2: Once you find Ophelia's book, and re-learn its number, you'll finally be able to open the door. | After you find her book, you'll have to thoroughly search to find things to open the remaining lock{LIST_COUNT(Locks_Undone) == 0:s}.}
                    
                    You mentally prepare yourself, dreading the climb, only to find the staircase has transformed from a dizzying steep spiral staircase into a normal single flight of stairs. Short enough that you can see the bottom of the landing.

                    Tentatively, you descend the stairs, ready for it to warp or change at any moment. When you reach the bottom and look back, the stairs are once again a giant spiral ascending into darkness. You beeline for the office, ready to search for her book.
                    
                    ->Office_Area.Office
                
                
        }
}

= Random_Locks(Count)
{Count <= 0: You pick a few random numbers, not really thinking.}

{Count > 3: You drop the lock and kick the door. This isn't working. }
*[{Book_Knowledge ? (Ripped_Pages): Leave to search for your book | Leave to double-check the books}]
    ~Need_Double_Check = true
    {LIST_COUNT(Locks_Undone) == 1: With one lock down, | {LIST_COUNT(Locks_Undone) == 2: With two locks down,| Unsure of what more you can do,}} you head back down. {LIST_COUNT(Locks_Undone) == 2: Once you find {Book_Knowledge ? (Ripped_Pages): your| Ophelia's} book, and re-learn its number, you'll finally be able to open the door. | After you find {Book_Knowledge ? (Ripped_Pages): your| her} book, you'll have to thoroughly search to find things to open the remaining lock{LIST_COUNT(Locks_Undone) == 0:s}.}
    
    You mentally prepare yourself, dreading the climb, only to find the staircase has transformed from a dizzying steep spiral staircase into a normal single flight of stairs. Short enough that you can see the bottom of the landing.

    Tentatively, you descend the stairs, ready for it to warp or change at any moment. When you reach the bottom and look back, the stairs are once again a giant spiral ascending into darkness. You beeline for the office, ready to search for {Book_Knowledge ? (Ripped_Pages): your| her} book.
    
    ->Office_Area.Office

*{Count <= 3} [2575]
    Nope.
    ->Random_Locks(Count + 1)

*{Count <= 3}[2758]
    The lock pulls a bit, but doesn't come undone.
    ->Random_Locks(Count + 1)
    

*{Count <= 3}[5275]
    Not that one.
    ->Random_Locks(Count + 1)
    
*{Count <= 3}[2785]
    The lock slides off. {Book_Knowledge ? (Ripped_Pages):  Oh. 2785. That must be your number. You don't know how you feel about that. | Oh! You're surprised you were able to figure it out through chance. 2785. You frown. You feel like that wasn't her number, but if it opened the lock, it must ahve been.}
    
    { - LIST_COUNT(Locks_Undone):
        - 1: One lock down, two more to go.
        - 2: Two locks down, one more to go.
        - 3: That's the last of them.
    }
    
    -> Stairs.Locks

*{Count <= 3}[2754]
    The lock pulls a bit, but doesn't come undone.
    ->Random_Locks(Count + 1)


= Return_Down
{LIST_COUNT(Locks_Undone) == 1: With one lock down, | {LIST_COUNT(Locks_Undone) == 2: With two locks down,| Unsure of what more you can do,}} you head back down. Hopefully you'll find something able to open the {LIST_COUNT(Locks_Undone) > 0: remaining} locks somewhere else in the church. You mentally prepare yourself, dreading the climb, only to find the staircase has transformed from a dizzying steep spiral staircase into a normal single flight of stairs. Short enough that you can see the bottom of the landing.

Tentatively, you descend the stairs, ready for it to warp or change at any moment. When you reach the bottom and look back, the stairs are once again a giant spiral ascending into darkness. 

If you weren't sure before, you are now: Behind that door lies the heart.

*[Enter the office]
    ->Office_Area.Office

*[Return to the main body of the church]
    -> Stairs.Exit_Stairs_Area

= Upstairs_End
{temp_bool == false: The locked door and soft light from under it are the same. You think you have all the pieces to open it now. {Stay_Tracker >= 2.5: You bounce on the balls of your feet. This is it. You'll be... able to leave soon. Go back to your... normal... life. } {Stay_Tracker < 2.5: You're so close to being free. } }

+ { items_obtained ? (Skeleton_Key) && Locks_Undone ? (Key_Lock) } [Use the key.]
    ~ temp_bool = true
    ~ Locks_Undone += (Key_Lock)
    {Stay_Tracker >= 2.5: You fish the key out of your pocket. Your hand shakes as you try to slide it into the hole. You miss a few times before dropping the key to the floor. "Get it together..." You mutter, shaking out your hands before picking up the key and putting it into the lock. }{Stay_Tracker < 2.5: You fish the key out of your pocket, and try it on the only lock with a key hole. } It resists slightly, but with a little force, you're able to turn it. 
    
    #PLAY: groaning-angry, 1 #stop: groaning-angry, 2
    ~ PlaySFX("groaning-angry", false, 0, 0.25)
    ~ StopSFX("groaning-angry", 2, 1)
    The chains and lock fall to the ground. The church groans angrily in response. 
    
    { - LIST_COUNT(Locks_Undone):
        - 1: One lock down, two more to go.
        - 2: Two locks down, one more to go.
        - 3: All the locks have been removed.
    }

+ { items_obtained ? (Clippers) && Locks_Undone !? (Clippers_lock)} [Use the wire cutters.]
    ~ temp_bool = true
    ~ Locks_Undone += (Key_Lock, Clippers_lock)

    {
     - Locks_Undone !? (Key_Lock) && items_obtained ? (Skeleton_Key):
        ~ temp_string = "you look at the rest of the chains that are held together with the old looking lock. You try the key you found but... Instead, you cut around the lock and then some, until the lock falls."
     - Locks_Undone !? (Key_Lock) && items_obtained ? Skeleton_Key:
        ~ temp_string = "you look at the rest of the chains that are held together with the old looking lock. You could look for a key, but... Instead, you cut around the lock and then some, until the lock falls."
    }
    
    You slide the chain lock to the the side, so the extra deadbolt is not blocking the door from opening, and use the small wire cutters you have to break the sliding chain.

    #PLAY: cut_chain
    ~ PlaySFX("cut_chain", false, 0, 0)
    {Church_Encounters ? (Finger_Chopped) and !finger_pain_pass: You flinch at the sound out the chain snapping, reminding you of the sound when you let them take your finger. A dull pain echos through your stump at the memory.} {Church_Encounters ? (Finger_Chopped) and finger_pain_pass: You don't flinch at the sound out the chain snapping, but feel a slight smile come to your lips. The stump on your hand aches at the memory, but it's a soothing pain. } {Church_Encounters ? (Was_Coward): You flinch at the sound out the chain snapping, reminding you of the sound when you let them take her finger. Her cries echo in your ears. }
    
    You shake the memory from your head and {temp_string}

    { 
        - Locks_Undone ? (Combo_Lock):
            With two locks removed, all that's left is the number lock.
        - else:
            All the locks have been removed.
    }

+ { items_obtained ? (Combo) && Locks_Undone !? (Combo_Lock)} [Enter code into number lock.]
    ~ temp_bool = true
    ~ Locks_Undone += (Combo_Lock)

    {
        - Book_Knowledge ? (Ripped_Pages):
            You pull the page from your pocket. You grab the combination lock and input the numbers 2755, and pull on the lock.
            
            //TODO: Maybe little "game" to input the numbers?
            
            It doesn't open.
            
            You pull it again, thinking it might be stuck. Nothing. You re-read the page. The code is correct, so what could... You read a bit further on and... You feel sick.
    
            Further down the page, it explains the number. Not a date or some random sequence, the code is different for everyone. To open it, you have to use your own number. The number that the church assigned you.
            
            
        - Book_Knowledge ? (Read_Mom_Old_Book):
            You pull the page from your pocket. You grab the combination lock and input the numbers 27... 55...? 54...?, and pull on the lock.
            
            //TODO: Maybe little "game" to input the numbers?
            
            It doesn't open.
            
            You pull it again, thinking it might be stuck. Nothing. You're almost positive that was the correct number.
    }
    
    {
        - Book_Knowledge ? (Kept_Book):
            {
                - Book_Knowledge ? (Ripped_Pages):
                    You check the cover of your book again. 2758. With shaking hands, you input the code, and the lock pops open.
                
                    You remove the lock from the metal bar, and slide it out of place. 
                - Book_Knowledge ? (Read_Mom_Old_Book):
                    "Come on.. Think!" You squeeze your eyes shut and try to remember the number from Ophelia's book, but your mind stays blank. You try a few more similar number combinations. 2575? 5275? 2755?
                    
                    None of them work.
                    
                    You check the cover of your book again. 2758. With no other options, you use your book number as the code, and the lock pops open.
                
                    You remove the lock from the metal bar, and slide it out of place. 
            }
        
        
        - else:
            {
                - Book_Knowledge ? (Ripped_Pages):
                    Your book. Of course. The one you left in the office. even without it, you clearly remember the number. 2758. With shaking hands, you input the code, and the lock pops open.
                
                    You remove the lock from the metal bar, and slide it out of place. 
                - Book_Knowledge ? (Read_Mom_Old_Book):
                    "Come on.. Think!" You squeeze your eyes shut and try to remember the number from Ophelia's book, but your mind stays blank. You try a few more similar number combinations. 2575? 5275? 2755?
                    
                    None of them work.
                    
                    You can only properly remember your own book number. 2758. With no other options, you use your book number as the code, and the lock pops open.
                
                    You remove the lock from the metal bar, and slide it out of place. 
            }
    }
    
    { - LIST_COUNT(Locks_Undone):
        - 1: One lock down, two more to go.
        - 2: Two locks down, one more to go.
        - 3: All the locks have been removed.
    }


- 
{ 
    - LIST_COUNT(Locks_Undone) >= 3:
        *[Open the door.]
        ->Open_the_Door
        
    - else:
        ->Stairs.Upstairs_End
}

= Exit_Stairs_Area
~ previous_area = Stairs
~ current_area = Main_Body
~ visited_state += 1

{
    - visited_state == 1:
        ->After_First.Side_Room_After
    - visited_state == 2:
        -> After_Second.Stairs_Second
    - else:
        -> Last_Stop.Stairs_Last
}










