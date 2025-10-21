=== Stairs ===

= Examine_Stairs
{(Have_Visited ? (Stairs_Up) or Have_Visited ? (Stairs_Down)) == false: You walk deeper down the hallway to the stairs. Going up, is a spiral staircase. Going down, is a long set of stairs. You can't see the end of either. {Looked_For_Items: How did you miss this before?} | The stairs are still there, spiraling up into the sky and digging down into the earth.}

+[Go upstairs]
    ->Stairs.Upstairs
    
+[Go downstairs]
    ->Stairs.Downstairs
    
+[Go back]
    You turn around are return to the office door. {Room_State == 3: You frown at the doorway. Was it always that short? } {Room_State == 4: You blink at the doorway. It was definitely not always that shot. You think you would remember needing to army crawl to enter.}

    ++[Enter office]
        ->Office_Area.Office
        
    ++[Return to the main body of the church]
        -> Stairs.Exit_Stairs_Area
    

= Unsure
Confused, you leave the room, and wander numbly back into the main body of the church. You find yourself back by the front door. It creaks open, showing off the moonlit sidewalk of the outside world. 

*[You reach out a hand.]

But the church looks at you again, bathing you in the wonderfully comfortable red light. The door stay open. You feel like...

*[Laughing]
~ Church_Feeling = "laugh"

*[Crying]
~ Church_Feeling = "cry"

- You're hysterical. Your whole body is heavy and tingling. You take a heavy step toward the door. <i>Is this really what you want?</i> Freedom is only one more step away. <i>To leave?</i> Your legs are glued to your spot on the floor. <i>Are you sure?</i> You grab your leg, pulling it forward.

{
    - Confessional_Encounters ? (Finished_Door_Side):
        "You're leaving me?" You stop. It's the little girl{Book_Knowledge ? (Read_Mom_Young_Book): , Emily |.} She's crying. "You're leaving me all alone? Again?"
        
        You clench your fists, and feel something in your hand. You look down. It's the piece of ripped curtain.
        {
            - Priest_Feeling == guilt:
                Tears well in your eyes, and you fall to your knees, bowing your head, holding the fabric to your face. <Guilt, Shame, Remorse> bubbles up inside you. 
                
                {
                    - Stay_Tracker >= 1.5:
                        "No." you croak. How could you leave her again? After all she's been through?

                        "Thank goodness." she says, and you feel someone hug you from behind. You turn to hug her back.
                
                        *[No one is there.]
                        ->Stairs.Sit_Pews
                    - else:
                        But the guilt is misplaced. You didn't hurt her. You don't even know if she's real.
                        
                        "Yes." You say and fall forward.
                        
                        There's a short shriek of anger, before you hit the cold pavement of the sidewalk. Then it's quiet. You look back, and the church is gone, if it was ever even there.
        
                        *[You stand, dust yourself off, and walk home.]
                        ->Stairs.Leave
                }
                
            - Priest_Feeling == dread:
                You drop the fabric, and watch it fall to the floor. You can feel the crisp outside wind blowing into the church, but the fabric does not react to it.
                
                "It's not real." You mummer, and fix your gaze on the outside. "It's not real."
                
                "But <i>I</i> am." the little girl wails, and something warm slams into your back. "<i>I'm</i> real, so <i>promise</i> you won't leave me alone again!"
                
                You look down to see small hands gripping your waist. Not barely visible, ghostly hands, but real ones. Pigmented skin, warm and alive. You feel your resolve weakening the longer you look at her hands. Real hands. Human hands.
                        
                "I...." you croak. It's real this time. It's not a trick. 
                
                {
                    - Stay_Tracker >= 2:
                        "I won't." you whimper. If it is real, how could you leave her again? "I promise"

                        "Thank goodness." she says, and squeezes you tighter. You turn to hug her back.
                
                        *[No one is there.]
                        ->Stairs.Sit_Pews
                        
                    - else:
                        You steel yourself.  You don't even know if she's real.
                        
                        "No." You say and fall forward.
                        
                        There's a short shriek of anger, before you hit the cold pavement of the sidewalk. Then it's quiet. You look back, and the church is gone, if it was ever even there.
        
                        *[You stand, dust yourself off, and walk home.]
                        ->Stairs.Leave
                }
            
            - Priest_Feeling == anger:
                You throw the fabric to the ground. "Do you think this will work the second time?" You {Church_Feeling}.
                
                "Don't leave me. <i>Please</i> don't leave me!" she sobs, and something warm slams into your back. "Promise you won't leave!"
                
                You look down to see small hands gripping your waist. Not barely visible, ghostly hands, but real ones. Pigmented skin, warm and alive. You feel your resolve weakening the longer you look at her hands. Real hands. Human hands.
                        
                "I...." you croak. It's real this time. It's not a trick. 
                
                {
                    - Stay_Tracker >= 2:
                        Your resolve breaks, "I won't." 

                        "Thank goodness." she says, and squeezes you tighter. You turn to hug her back.
                        
                        *[No one is there.]
                        ->Stairs.Sit_Pews
                    - else:
                        You steel yourself.
                        
                        "No." You say and fall forward.
                        
                        There's a short shriek of anger, before you hit the cold pavement of the sidewalk. Then it's quiet. You look back, and the church is gone, if it was ever even there.
        
                        *[You stand, dust yourself off, and walk home.]
                        ->Stairs.Leave
                }
        }
        
    - Church_Encounters ? (Was_Coward):
        "Coward." You stop. It's the woman who helped you{Book_Knowledge ? (Read_Mom_Old_Book):, Ophelia." |.} "You're just going to leave?"
        
        {
            - Stay_Tracker >= 2.5:
                "I..." You don't know how to answer. You look down at your hands, they're intact. You still have all ten. You ball them into fists. "I..."

                "You don't deserve to leave."
                
                *[Maybe she's right...]
                ->Stairs.Sit_Pews
            - else:
            "Yes." You say and fall forward.
                        
            There's a short shriek of anger, before you hit the cold pavement of the sidewalk. Then it's quiet. You look back, and the church is gone, if it was ever even there.
        
            *[You stand, dust yourself off, and walk home.]
            ->Stairs.Leave
        }
        
    - else:
        The red light intensifies, a comforting pressure. You fall to the floor, and begin to crawl. Your body is heavy. Each movement harder than the last. 
        
        The way out is within your reach. It's just a bit further. The light grows brighter. Your limbs shake.
        
        {
            - Church_Encounters ? (Leave_Light):
                You don't want to leave it, but you know you have to. You want to. You want...
            
                What do you want?
            
                You stop, and sit back. You stare up at the church window, and it looks back at you.
                
            {
                - Stay_Tracker >= 2.5:
                    What are you fighting so hard for?
                    
                    {finger_pain_pass: You look down at the hand that's missing a finger. | You think about all you've been through. }
                    
                    *[You've already given up so much.]
                        ->Stairs.Sit_Pews
                - else:
                    You didn't leave this light until the church decided you could last time, but this time... Your finger tips escape the light, reaching out through the church door. 
                
                    That taste of freedom is all you need. With one last push, you throw yourself out out the door. There's a short shriek of anger, before you hit the cold pavement of the sidewalk. Then it's quiet. You look back, and the church is gone, if it was ever even there.
        
                    *[You stand, dust yourself off, and walk home.]
                        ->Stairs.Leave
            }
            - else:
                You've escaped this light before, and you'll do it again. Your finger tips escape the light, reaching out through the church door. 
                
                That taste of freedom is all you need. With one last push, you throw yourself out out the door. There's a short shriek of anger, before you hit the cold pavement of the sidewalk. Then it's quiet. You look back, and the church is gone, if it was ever even there.
        
                *[You stand, dust yourself off, and walk home.]
                ->Stairs.Leave
        }
}

= Sit_Pews
The front door closes, and you drift deeper into the church. Organ music begins to play.

You end up in the pews, just like your book said you would. You sit down, and close your eyes, taking in the church music. When you open them, the pews are filled with people, all turned towards you. It's people you've read about, smiling at you. Welcoming you.

They begin to sing, hands out stretched for you to take. The music flows through you, and you feel a smile come to your face.

*[Take their hands.]

- #ENDING: 7, Bad? Ending: Finding Peace
*[And find peace.]
->END

= Leave
*[It has been a long night.]

- #ENDING: 9, Good Ending: It Has Been a Long, Long Night
*[And you deserve a very long, vey hot, bath.]
->END


////////// DOWNSTAIRS INTERACTIONS ////////// 

= Down_None
~ Downstairs_State = Stink

Cautiously, you take another step down{Leg_State >= Limping:, making sure to lean against the railing to take weight off your leg}. And then another. And another. With every step down, your body yells at you more and more to turn back. That something's wrong.

About halfway down the steps, the smell of rot hits your nose, so strong you gag. {Leg_State >= Limping: You grab the railing with both hands, | You grab the railing to steady yourself,} and retch. The stench is unbearable. 

It smells of old, rotten meat left in the sun. Of putrid sour milk left out for too long. Of rancid fruit left to liquify in the fridge. You cover your face with your shirt, and breathe through your mouth, but the pungent smell clings to you. 

*[Push through]
    ->->
*[Turn back]
    You stumble back up the stairs to the hall, and take a deep refreshing breath of the clean air. Luckily, the smell doesn't seem to have stuck to your clothing.
    ->Stairs.Turn_Back
    

= Down_Stink
{Downstairs_State == Stink: You swallow your nausea| You plug your nose} and keep going, only stopping to occasionally dry heave. It isn't long before the steps change from wood to... to something you can't comprehend. You stop and shine the light. 

#CYCLE: Fidget, mold, fungus, flesh
The rest of the stairs are covered in pink, bulbous... flesh? You shake your head. It has to be some sort of mold or fungus. You poke the next step with your foot, and the @ shivers in response. 

You shine your light to the end of the staircase, and see a door at the end of the stairs. Walls and ceiling covered in the same disgusting substance.

~ Downstairs_State = Flesh

*[See what's behind the door]

*[Turn. Back.]
    
    #PLAY: click-off
    Without a second thought, you rush back up the stairs to the hall. You take a deep refreshing breath of the clean air at the top, and try to make sense of what you just saw. 

    The flesh, it— it <i>reacted</i> to your touch. Your skin crawls at the thought. You don't think you should go back down there.
    ->Stairs.Turn_Back

- 
#PLAY: 1, squish-squash
<i>You've made it this far, might as well see it it toward the end,</i> you think, and take another deep breath through your mouth. Slowly, you make it to the bottom of the stairs.

<i>Squish</i>

#stop: 3, squish-squash
The tissue is soft under your shoes, making a soft, wet sound with each step. A thick ooze sticks to the bottom of your shoes.

<i>Squelch</i>

*[Open the door]
    ->Stairs.In_Basement

= Downstairs
~ Have_Visited += (Stairs_Down)
{
    - Downstairs_State <= Bad_Vibes:
        ~ Downstairs_State = Bad_Vibes
        
        #PLAY: click-on
        You approach the stairs shine your flashlight down. The walls on either side of the stairs are smooth, but damp. You cannot see the bottom. You take one step down, and deep groan wells up from below.

        You tense, every fiber of your being telling you to not continue down.
    - Downstairs_State == Stink:
        #PLAY: click-on
        You approach the stairs again, and plug your nose. You breath through your mouth as you quickly descend. The stench punches you in the face, hanging heavy in the air. You take deep, deliberate breaths, as you continue.
        
    - else:
        #PLAY: click-on
        You approach the stairs again, and swallow. A feeling in your gut is telling you not to go down and further.
}

*[{Downstairs_State <= Bad_Vibes: Continue down | Push through}]

*[Turn back]
   {Downstairs_State <= Bad_Vibes: You turn back up the stairs. It doesn't feel right. |  You stumble back up the stairs to the hall, and take a deep refreshing breath of the clean air. You can try again later.}
    ->Stairs.Turn_Back
-

{
    -Downstairs_State <= Bad_Vibes: -> Down_None -> 
    - else: -> Down_Stink
}

-

<- Down_Stink

= In_Basement
The door opens, and you are assaulted by the stench. Your eyes water and you pull your shirt over your nose and mouth, not that it does much. You take a few steps inside, trying to see what's the cause of this god awful smell.

The room is covered in the pink, bulging flesh, thick ooze drips from the ceiling. You pan your flash light around. The room is filled with furniture covered in tarps.

*[Find the source of the smell]

*[Investigate the ooze]
    #DELAY: 1.5
    You walk deeper into the room, deeper into the maze, and approach a place where the ooze consistently falls from the ceiling. You stick the end of the flashlight into the small pool of it. It's sticky and slippery, much more slime like than ooze.
    
    #PLAY: click-on #PLAY: 1, click-off #PLAY: 1, click-on #PLAY: 1, click-off
    The flashlight flickers, and turns offs. You hit it against the palm of your hand, trying to get it to turn back on, the slime getting on you in the process.
    ->Stairs.Melt

- You walk deeper into the room. It is a maze of old furniture. Most of it is normal, chairs, tables. Some of the shapes confuse you. Some are too tall, or too wide to be anything recognizable. 

You pass by what you assume is a standing coat hanger, and stare at it. It is taller than you, and has multiple edges jutting out from it. You reach out to lift the canvas covering it, but stop just before touching it. 

*[Rip off the tarp]
    You grab the canvas and rip it off the coat hanger.
    
    #IMAGE: Default #CYCLE: person, animal, zombie, creature, beast #DELAY: 3.5
    You scream and fall backward, landing in a puddle. You fix your flashlight on the @, trying to make sense of it all. It's fused into the coat rack, limbs sewn into wrong places and the metal forced into flesh so it keeps its shape. And its face? Its face was a writhing mass of-
    
    TODO: sound
    #CYCLE: person, animal, zombie, creature, beast #PLAY: click-on #PLAY: 1, click-off #PLAY: 1, click-on #PLAY: 1, click-off
    The @ twitches, snapping bones and warping metal to look at you. A squeak escapes you and you drop your flashlight. It flickers as it rolls away, and turns offs. The thing groans as more bones snap and it falls, landing on top of you.
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

- #PLAY: click-off
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

{temp_bool != 0:The ooze falls from the ceiling. The puddles splash with each step. | Something falls on you from the celing, and it burns the same. You splash in puddles of more of the same.} You cannot wipe it off fast enough. 

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
#ENDING: 1, Bad Ending: Digested #DELAY: 2
You keep going, desperately trying to escape. 

#CLASS: Blur #DELAY: 2
You can't feel your hand anymore.

#DELAY: 2
You trip over yourself, and fall into puddle of the acidic ooze. 

#CLASS: Blur
You can't feel your legs.

*[You can't feel anything.]
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
    Taking a deep breath through your mouth, you start back up the stairs. {Downstairs_State >= Stink: There's no way you just walked right past the landing like that. There's a gap between the sets of stairs. <i>I would have noticed.<i/>| You could have sworn there was a gap between the set of stairs spiraling up and the set digging down. At least enough to notice when one starts and the other ends.} 
    
    After climbing the stairs for a few minutes you notice the rail sink and the incline turn sharp. <i>What in the?</i> Shining your flash light up, you see the stairs twist into a tight coil. {Looked_For_Items or Church_Investigation ? (Teleported): <i>Is the church messing with me?</i> | <i>How did...?</i>} 
    ~ Downstairs_State = Stink
    TODO: Check what other variables I should be checking for here and down below
    
    **[Continue to the top]
        <i>Screw it.</i> You think and decide to reach the top. At this point, either the landing never existed or the church is messing with your sense of direction. Either way, you would rather take your chances with whatever the attic has in store for you rather than the basement. {Downstairs_State >= Flesh: Your skin crawls at the memory of the flesh covering the staircase. | {Downstairs_State >= Stink: You gag at the thought of the stench.}} 
        
        You power through the rest of the stairs, only stopping to rest when your limbs refuse to cooperate. At some point, you end up almost fully vertical, treating the stairs as a ladder. Your finger tips burn from gripping the ground so tightly{Leg_State >= Limping:, your injured leg screaming from the exertion}. Resting became a risk, fearing that losing any momentum, even for a moment, would cause you to fall back and tumble back to the start.
        
            ->Stairs.Upstairs_Landing(false)
    
    **[Turn around and try again]
        "Third time's the charm," You mutter, turning back down the stairs, methodically checking for the landing after each step. 

- A flight or two later, you barely make out a flat platform at the edge of your flashlight's range. You don't think, you rush down the rest of the stairs, running face first into a door. {Temp_Can_Smell: The smell ten times stronger than before. | The scent of rotting flesh hits you a second later.}
        
#CYCLE: mold, flesh, meat, fungus
In frustration you kick the door{Leg_State >= Limping:, then suppress a curse as a sharp pain shoots up your leg}. You step back and slip on something leaking from the under door, landing on a squishy mass. You yelp, jumping away{Downstairs_State >= Flesh:, eyes fixed on the quivering @. |, and see the walls and stairs covered in the same bulbous @.}

~ temp Temp_Touched_Mass = false
~ Downstairs_State = Flesh
*[Touch the mass]
    ~ Temp_Touched_Mass = true
    Curiosity gets the best of you and you reast out and poke the squishy mass. It shivers in response to your touch, and it retains an indent from where you poked it. The mass sticks to your hand slightly and feels wet, but isn't. It feels similar to warm, chewed gum, but less soft and more... meaty?
    
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
    ~ Downstairs_State = 3
    ~ Have_Visited -= (Stairs_Up)
    -> Stairs.Exit_Stairs_Area
    

= Upstairs
~ Have_Visited += (Stairs_Up)
#IMAGE: Stairs_Up #PLAY: click-on #EFFECT: Flash-On
You start up the stairs, holding the hand rail as you go. You take a break after about 5 or 6 flights, but the top doesn't look any closer. With a huff, you continue up.

Tighter and tighter the stairs spiral. The hand rail sinking lower and lower. The incline becoming steeper and steeper. After a count of 14 flights, you wonder if this is a fruitless effort. Sweat runs down your back, and your legs quiver from effort. {Leg_State > Tense: The leg you used to kick the door in feels particularly weak.}

*[Give up]
    Shaking your head, you make the journey back down the stairs. Thankfully, going down is much easier than going up. As the hand rail once again rises to sit at a reasonable height and the spiral gradually straightens out, you know you made the correct choice.
        -> Stairs.Downstairs_Trick

*[Power through]
    
- You power through, only stopping to rest when your limbs refuse to cooperate. 

At some point, you end up almost fully vertical, treating the stairs as a ladder. Your finger tips burn from gripping the ground so tightly{Leg_State >= Limping:, your injured leg screaming from the exertion}. Resting became a risk, fearing that losing any momentum, even for a moment, would cause you to fall back and tumble back to the start.

*[<i>How tall is this church?</i>]
    ->Stairs.Upstairs_Landing(false)

= Upstairs_Landing(from_trick)
~ Have_Visited += (Stairs_Up)
{
    - !from_trick:
        After countless flights of stairs, you make it to the landing, crawling your way onto solid ground.{Leg_State >= Sore: Any longer, and you think you may have fallen.} The landing is small and square, maybe only five feet by five feet.
        
        The only thing on the landing is a door. It's old and wooden, much like the rest of the church. It is covered in chains and locks. A metal bar is bolted across the door in a way where you could not pull or push it open, even without the chains. Soft, pulsing, red light peaks out from under it.
    - from_trick:
        You skid across a wooden floor and crash into a door. You blink rapidly and slowly uncurl yourself, trying to understand where you are and what just happened. That voice sounded similar to the one that gave you your flashlight. You don't know why she did that, but she must have brought you here for a reason.
        
        You find yourself on a small landing, maybe only five feet by five feet. It sharply drops off on the edges. You crawl forward to the edge and look down. You find yourself staring down the spiral staircase, it's coils wound much tighter and steeper than you thought possible. You back up from the edge.
        
        Behind you is the door you crashed into. It's old and wooden, much like the rest of the church. It is covered in chains and locks. A metal bar is bolted across the door in a way where you could not pull or push it open, even without the chains. Soft, pulsing, red light peaks out from under it.
}


*[Examine the locks]
    {Saw_Locks: You take a closer look at the locks. From what you can tell, there are three main ones, and they all vary slightly | You approach the door, taking a closer look at the various locks and chains blocking it. } <>
    ~ Saw_Locks = true
    
*[Peek through the keyhole]
    TODO: maybe are here if i wanna be crazy
    You approach the door and peek through the keyhole. You can't make out much, but you can see a small table and something placed upon it. That looks to be the source of the glowing.
    
    #CYCLE: anxiety, excitement, fear, unease, hope
    Whatever it is, you assume it's important. Your @ fills your chest. The heart, maybe? {from_trick: Is this why she sent you here?}
    
    **[Examine the locks]
        {Saw_Locks: You take a closer look at the locks. From what you can tell, there are three main ones, and they all vary slightly | You approach the door, taking a closer look at the various locks and chains blocking it. } <>
        ~ Saw_Locks = true
    
*{Have_Visited ? (Stairs_Up)}[Head back down]
    -> Stairs.Return_Down

- The top lock looks like something you'd find in an antique shop, made of heavy metal. It has a small key hole, and is holding the majority of chains together. The chains themselves aren't very think, but they are sturdy. {broke_key: You mentally kick yourself for snapping the key earlier, and hope it wasn't for this.}
TODO: maybe more here, but i think it's fine

The middle lock looks slightly newer. It doesn't require a key, but a four digit number code. It is attached to the metal bar that keeps the knob from turning. Removing this lock would probably allow the door to be opened.
TODO: add bit here about seeing 4 numbers around

The last lock is a sliding chain door lock. Sliding it all the way to the end causes a smaller deadbolt slide into place, keeping the door locked. There is no obvious keyhole.

*{(items_obtained ? (Skeleton_Key) or items_obtained ? (Simple_Key)) and Locks_Undone !? (Key_Lock)}[Try the key]
    -> Stairs.Try_Key

*{items_obtained ? (Clippers) && Locks_Undone !? (Clippers_lock)}[Use the wire cutters]
   -> Stairs.Use_Clippers

*{items_obtained ? (Combo) && Locks_Undone !? (Combo_Lock)}[Enter code]
    -> Stairs.Enter_Number

*[Try to break the locks]
    ~ Investigated_Locks = true

*[Head back down]
    -> Stairs.Return_Down

- You try a few combinations on the number lock, thinking you can guess code. You try today's date, the current year, your birthday— Any meaningful set of four numbers you can think of. After a few minutes, you give up.

You tug at the chain lock, but it's tightly fastened to the door. You grab at the chain itself and pull, thinking the thinner chain might snap under the pressure, but it holds fast. You then try messing with the sliding lock as well, looking to see if there's a trick to it. If there is, you can't figure it out.

*{items_obtained ? (Skeleton_Key) && Locks_Undone !? (Key_Lock)}[Try the key you have.]
    -> Stairs.Try_Key
    
*{items_obtained ? (Clippers) && Locks_Undone !? (Clippers_lock)}[Use the wire cutters.]
   -> Stairs.Use_Clippers

*{items_obtained ? (Combo) && Locks_Undone !? (Combo_Lock)}[Enter code into number lock.]
    -> Stairs.Enter_Number
TODO: this is dupepd a few times
*[Head back down]
    -> Stairs.Return_Down

= Try_Key
~ Locks_Undone += (Key_Lock)
You fish the key out of your pocket, and try it on the only lock with a key hole. It resists slightly, but after messing with it, you're able to slot it in and turn it. 

#PLAY: groaning-angry, 1 
The chains and lock fall to the ground. <>

#stop: groaning-angry, 2
The church groans angrily in response. 

{ - LIST_COUNT(Locks_Undone):
    - 1: One lock down, two more to go.
    - 2: Two locks down, one more to go.
    - 3: All the locks have been removed.
}

{
    - Locks_Undone ? (Key_Lock, Clippers_lock, Combo_Lock):
        *[Open the door.]
        ->Open_the_Door
    - else:
        {
            - items_obtained ? (Clippers) && Locks_Undone !? (Clippers_lock):
                *[Use the wire cutters.]
                    -> Stairs.Use_Clippers
        }
        
        {
            - items_obtained ? (Combo) && Locks_Undone !? (Combo_Lock):
                *[Enter code into number lock.]
                    -> Stairs.Enter_Number
        }
        
        
        {
            - !Investigated_Locks && LIST_COUNT(Locks_Undone) < 3 && !(items_obtained ? (Combo) || items_obtained ? (Clippers)):
                *[Mess with the other locks]
                ~ Investigated_Locks = true
                -> Stairs.Mess_With
        }
        
        *[Head back down]
        -> Stairs.Return_Down
}

= Mess_With
~temp_string = ""
{
    - items_obtained ? (Combo):
        ~temp_string = "You try a few combinations on  the number lock, thinking you can guess code. Trying to enter today's date, the year, your birthday- Anything meaningful set of four numbers you can think of. After a few minutes, you give up. \n"
}
{
    - items_obtained ? Skeleton_Key:
        ~temp_string += "You pull at the chain lock, but it's tightly fastened to the door. You grab at the chain itself and pull, thinking the thinner chain might snap under the pressure, but it holds fast."
}
{
    - items_obtained ? (Clippers):
        ~temp_string += "You then try messing with the sliding lock as well, trying to see if there's a trick to it. If there is, you can't figure it out."
}
    
{temp_string}

{
    - items_obtained ? (Skeleton_Key) && Locks_Undone ? (Key_Lock):
        *[Try the key you have.]
            -> Stairs.Try_Key
}

{
    - items_obtained ? (Clippers) && Locks_Undone !? (Clippers_lock):
        *[Use the wire cutters.]
            -> Stairs.Use_Clippers
}

{
    - items_obtained ? (Combo) && Locks_Undone !? (Combo_Lock):
        *[Enter code into number lock.]
            -> Stairs.Enter_Number
}


*[Head back down]
-> Stairs.Return_Down

= Use_Clippers
~ Locks_Undone += (Key_Lock)
~ temp_string = ""

{
 - Church_Encounters ? (Finger_Chopped):
    ~ temp_string = "You flinch at the sound out the chain snapping, reminded of the sound when you let them take your finger. A dull pain echos through your stump at the memory. "
}

{
 - Locks_Undone !? (Key_Lock) && items_obtained ? (Skeleton_Key):
    ~ temp_string += "You look at the rest of the chains that are held together with the old looking lock. You try the key you found but... Instead, you cut around the lock and then some, until the lock falls."
 - Locks_Undone !? (Key_Lock) && items_obtained ? Skeleton_Key:
    ~ temp_string += "You look at the rest of the chains that are held together with the old looking lock. You could look for a key, but... Instead, you cut around the lock and then some, until the lock falls."
}

You slide the chain lock to the the side, so the extra deadbolt is not blocking the door from opening, and use the small wire cutters you have to break the sliding chain.

#PLAY: cut_chain
{temp_string}

{ - LIST_COUNT(Locks_Undone):
    - 2: With two locks removed, all that's left is the number lock.
    - 3: All the locks have been removed.
}

{
    - Locks_Undone ? (Key_Lock, Clippers_lock, Combo_Lock):
        *[Open the door.]
            ->Open_the_Door
    - else:
        {
            - items_obtained ? (Combo) && Locks_Undone !? (Combo_Lock):
                *[Enter code into number lock.]
                    -> Stairs.Enter_Number
        }
}



*[Head back down]
-> Stairs.Return_Down

= Enter_Number
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

TODO: This is duplicated
{
    - Locks_Undone ? (Key_Lock, Clippers_lock, Combo_Lock):
        *[Open the door.]
        ->Open_the_Door
    - else:
        {
            - items_obtained ? (Skeleton_Key) && Locks_Undone ? (Key_Lock):
                *[Try the key you have.]
                    -> Stairs.Try_Key
        }
        
        {
            - items_obtained ? (Clippers) && Locks_Undone !? (Clippers_lock):
                *[Use the wire cutters.]
                    -> Stairs.Use_Clippers
        }

        *[Head back down]
        -> Stairs.Return_Down
}

= Return_Down
{LIST_COUNT(Locks_Undone) == 1: With one lock down, | {LIST_COUNT(Locks_Undone) == 2: With two locks down,| Unsure of what more you can do,}} you head back down. Hopefully you'll find something able to open the {LIST_COUNT(Locks_Undone) > 0: remaing} locks somewhere else in the church. You mentally prepare yourself, dreading the climb, only to find the staircase has transformed from a dizzying steep spiral staircase into a normal single flight of stairs. Short enough that you can see the bottom of the landing.

Tentatively, you descend the stairs, ready for it to warp or change at any moment. When you reach the bottom and look back, the stairs are once again a giant spiral acending into darkness. 

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
{- Gameplay_Event:
    - 1:
        ->After_First.Side_Room_After
    - 2:
        -> After_Second.Stairs_Second
    - temp_bool_3:
        ->Inside.Look_For_Heart
    - 3:
        -> Last_Stop.Stairs_Last
} 
TODO: waht ^^










