=== Stairs ===

= Examine_Stairs
You walk deeper down the hallway {has_flashlight: to the stairs. Going up, is a spiral staircase. Going down, is a long set of stairs. You can't see the end of either.|, moving slowly and methodically through the darkness. At some point you feel a railing and a set of stairs that go both up and down.}

{has_flashlight: | A basement might have tools you can use to open the door, but a second floor? From the outside the building barely looked large enough to have one. Maybe it's an attic?}

*[Go upstairs]
    ->Stairs.Upstairs
    
*[Go downstairs]
    {
        - has_flashlight:
            #PLAY: click-on
            You approach the stairs shine your flashlight down. The walls on either side of the stairs are smooth, but damp. You cannot see the bottom. You take one step down, and deep groan wells up from below.
    
            You tense, every fiber of your being telling you to not continue down.
            ->Stairs.Downstairs
        - else:
            #IMAGE: Stairs Down
            You place one hand on the railing, and the other on the wall, but instantly recoil.
            
            "Ugh, what is-" You curse as you try to flick the substance off your hand. The wall is smooth, but damp and a bit sticky. 
            
            *[Use the wall to keep balance]
                ~touch_walls = true
                Grimacing, you place your hand back on the wall. You ignore the soft squelching sound as you take your first step down. A deep groan wells up from below. You tense, every fiber of your being telling you to not continue down.
                ->Stairs.Downstairs
            
            *[Take your chances in the dark]
                You decide to take your chances take one step down, and deep groan wells up from below. You tense, every fiber of your being telling you to not continue down.
                ->Stairs.Downstairs
    }
    
    

////////// DOWNSTAIRS INTERACTIONS ////////// 

= Downstairs

*[Continue down]

*[Turn back]
    You turn on your heel and {has_flashlight: It doesn't feel right. | You decide that searching a dark basement wouldn't be the best use of your time. }
    ->Stairs.Turn_Back
-
Cautiously, you take another step down{leg == "worst":, making sure to lean against the railing to take weight off your leg}. {has_flashlight: And then another. And another. | {touch_walls: Your hand on the wall has a thin layer of gunk sliding down it. and you continue down. | You stumble a few times, but always manage to catch yourself. }} With every step down, your body yells at you more and more to turn back. That something's wrong.

*[Push through]

*[Turn back]
    You hurry back up the stairs, glancing over your shoulder as you do.
    ->Stairs.Turn_Back
- 
~ went_downstairs = 2

About halfway down the steps, the smell of rot hits your nose, so strong you gag. {has_flashlight: {leg == "worst": You grab the railing with both hands, | You grab the railing to steady yourself,} | You crouch on the stairs,} and retch. The stench is unbareable. 

It smells of old, rotten meat left in the sun. Of putrid sour milk left out for too long. Of rancid fruit left to liquify in the fridge.

You cover your face with your shirt, and breathe through your mouth, but the pungent smell clings to you. 

*[Keep moving]
    

*[Turn back]
    You stumble back up the stairs to the hall, and take a deep refreshing breath of the clean air. Luckily, the smell doesn't seem to have stuck to your clothing.
    ->Stairs.Turn_Back
    
- <i>In for a penny, in for a pound.</i> You think as you plug your nose and keep going, only stopping to dry heave. <i>This better be worth it.</i> {has_flashlight: It isn't long before the steps change from wood to... to something you can't comprehend. You stop and shine the light. | {touch_walls: Before long the smooth, damp walls turn softer. Squishier. And pulsating. | Eventually, the stairs grow a thin sheen of wetness, and before softer. Squishier.}} 

#CYCLE: mold, fungus, flesh
{has_flashlight: The rest of the stairs are covered in pink, bulbous... flesh? You shake your head. It has to be some sort of mold or fungus. You poke the next step with your foot, and the @ shivers in response. | {touch_walls: You yank your hand from the wall. | You put a hand on the wall to see if it changed as well and yank it back in disgust. It was the same texture.} It has to be some sort of mold or fungus. You poke the next step with your foot, and the @ shivers in response.} 

{has_flashlight: You shine your light to the end of the staircase, and see a door at the end of the stairs. Walls and ceiling covered in the same disgusing substance.}

*[{has_flashlight: See what's behind the door | Get to the bottom}]

- 
#PLAY: squish-squash, true
{has_flashlight: <i>You've made it this far, might as well see it it toward the end,<i> you think, and take a deep breath through your mouth. Slowly, you make it to the bottom of the stairs. | You continue down the last few stairs and hope you're close to the bottom.}

<i>Squish</i>

#STOP: squish-squash, 3
The tissue is soft under your shoes, making a soft, wet sound with each step. {has_flashlight: A thick ooze sticks to the bottom of your shoes. | You can feel something thick stuck to the bottom of your shoes. A few steps later and you hit a door. Thankfully it was made of wood and the knob of metal, and not covered in the same material as the wall. }

<i>Squelch</i>

*[Open the door]

- The door opens, and you are assulted by the smell. Your eyes water and you clamp your hand over your nose and mouth. You take a few steps inside, trying to see what's the cause of this god awful smell.

{has_flashlight: The room is covered in the pink, buldging flesh, thick ooze drips from the ceiling. You pan your flash light around. The room is filled with furniture covered in tarps. | Something drips from the ceiling and onto your shoe. You can make out some shapes, but not much else. The smell is so overpowering it makes you lightheaded. You should find something to get the front door open and get out.}

*{has_flashlight} [Find the source of the smell]
    You walk deeper into the room. It is a maze of old furniture. Most of it is normal, chairs, tables. Some of the shapes confuse you. Some are too tall, or too wide to be anything recognizeable. 

    You pass by what you assume is a standing coat hanger, and stare at it. It is taller than you, and has multiple edges jutting out from it. You reach out to lift the canvas covering it, but stop just before touching it. 
    
    You're not sure why, but you retract your hand. You stare at the coat hanger a little longer before conitnuing on.
    
    **[You don't check under any of the tarps.]
    
    -- You continue deeper into the room, the smell getting stronger with each step. You pray that the smell won't linger after you leave, and follow your nose to the source.
    
        You find yourself in the far back corner, a tarp partially covering something scattered over the floor. It comes up to about your chest, a stacked pile of... something. Firewood? But you don't remember seeing a fireplace upstairs...
        ->Stairs.Investigate_Smell

* {has_flashlight} [Investigate the ooze]
    #DELAY: 1.5
    You walk deeper into the room, deeper into the maze, and approach a place where the ooze consistantly falls from the ceiling. You stick the end of the flashlight into the small pool of it. It's sticky and slippery, much more slime like than ooze.
    
    #PLAY: click-on #PLAY: click-off, false, 0, 1 #PLAY: click-on, false, 0, 2.5 #PLAY: 1, click-off, false, 0, 3.5
    The flashlight flickers, and turns offs. You hit it against the palm of your hand, trying to get it to turn back on, the slime getting on you in the process.
    ->Stairs.Melt
    
* {!has_flashlight} [Look at the thing closest to you]
    #CYCLE: crowbar, sledgehammer, screwdriver
    You wander to the closet object and start feeling for something useful. You're not sure what you're looking for, exactly. Maybe a @? Although right now a flashlight would be really-
    
    <i>Clunk!</i>
    
    You knock something over and it hits the ground before rolling into your foot. You pick it up and roll it over in your hands.
    
    #PLAY: click-on #EFFECT: flashlight_on
    "Well isn't that handy?" You say, turning the flashlight on and shining it around the room. "Oh what the-"
    
    The room is covered in the pink, buldging flesh, thick ooze drips from the ceiling. The room is filled with furniture covered in tarps. You freeze at the sight of the fleshy, pulsating walls, and wonder if that's what you had touched earlier. 
    
    **[Find something useful and get out]
        #CYCLE: crowbar, sledgehammer, screwdriver
        You rip the tarps off boxes and dig through them, looking for something, anything useful. The third box you find a @. 
        
        You don't hesitate as you turn and run back toard the door. You say a prayer of thanks that you didn't go too deep into the room. You slip on a puddle of goo and trip, hitting the ground hard, covering yourself in ooze. You lost your grip on the flashlight in the impact, and it rolls away.
        
       #PLAY: click-on #PLAY: click-off, false, 0, 1 #PLAY: click-on, false, 0, 2.5 #PLAY: 1, click-off, false, 0, 3.5
        The flashlight flickers, and turns offs, once again leaving you in the darkness. Your skin tingles and itches where the ooze clings to you, but you pay it no mind as you get back to your feet. <>
        ->Stairs.Melt
    
    **[Get out of there.]
        You don't hesitate as you turn and run back toard the door. You say a prayer of thanks that you didn't go too deep into the room. You slip on a puddle of goo and trip, hitting the ground hard, covering yourself in ooze. You lost your grip on the flashlight in the impact, and it rolls away.
        
        #PLAY: click-on #PLAY: click-off, false, 0, 1 #PLAY: click-on, false, 0, 2.5 #PLAY: 1, click-off, false, 0, 3.5
        The flashlight flickers, and turns offs, once again leaving you in the darkness. Your skin tingles and itches where the ooze clings to you, but you pay it no mind as you get back to your feet. <>
        ->Stairs.Melt
    

* {!has_flashlight} [Check the back of the room]
    #CYCLE: crowbar, sledgehammer, screwdriver
    You wander toward the back of the room, tripping over random debris on the ground. The smell gets stronger the deeper you go, and you decide to stop when run into a large item, and start feeling for something useful. You're not sure what you're looking for, exactly. Maybe a @? Although right now a flashlight would be really-
    
    <i>Clunk!</i>
    
    You knock something over and it hits the ground before rolling into your foot. You pick it up and roll it over in your hands.
    
    #PLAY: click-on #EFFECT: flashlight_on
    "Well isn't that handy?" You say, turning the flashlight on and shining it around the room. "Oh what the-"
    
    The room is covered in the pink, buldging flesh, thick ooze drips from the ceiling. The room is filled with furniture covered in tarps. To your right are more items covered in tarps, but to your left is a tarp partially covering something scattered over the floor. It comes up to about your chest, a stacked pile of... something. Firewood?
   ->Stairs.Investigate_Smell

=Investigate_Smell
Near the edge of the tarp you see scraps of wet cloth and... Is that... bone...? You swallow the lump in your throat.

*[Lift the tarp]

- #PLAY: click-off
You let out a shriek and fall backwards, dropping your flashlight in the process. It turns off and rolls away.

#CYCLE: mourn, pity, pray
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

- Blood rushes to your ears, so loud you can barely think. You need to get out of here- Out of this this slime{temp_bool: . You have the flashlight. |, flashlight be damned.} You blindly try to make your way back to the door. {has_flashlight: | You have to be close. You barely entered the room.}

The ooze falls faster from the ceiling. You step in puddles. It falls on you in fat globs. You cannot wipe it off fast enough. The more that touched you, the stronger it prickles your skin. {has_flashlight: | <i>Where is the damn door?</i>}

*[It's eating through you]

- You wipe off another blob off your shoulder, but something goes with it. Something wet. Something warm. You stop, and reach up to touch your shoulder. Your hand shakes. Your breathing is short and shallow.

*[You feel bone.]

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
#ENDING: 1, BAD ENDING-Melted #DELAY: 2
You keep going, desperatly trying to escape. 

#CLASS: Blur #DELAY: 2
You can't feel your hand anymore.

#DELAY: 2
You trip over yourself, and fall into puddle of the acidic ooze. 

#CLASS: Blur
You can't feel your legs.

*[You can't feel anything.]
->END_DEMO

= Turn_Back
*[Go upstairs]
->Stairs.Upstairs

////////// UPSTAIRS INTERACTIONS ////////// 

////////// UPSTAIRS INTERACTIONS ////////// 

= Upstairs
#IMAGE: Stairs Up
{
    - has_flashlight:
        #PLAY: flashlight_on
        You start up the stairs, holding the hand rail as you go.
    - else: 
        You place one hand on the railing, and begin slowly ascending. <>
}

You continue up the stairs for what feels like 5 or 6 flights, but they show no sign of stopping. Tighter and tighter they spiral, the hand rail shrinking lower and lower, and the stairs getting steeper and steeper. {has_flashlight: | Your progress slows to a crawl as you feel for the next step, terrified of slipping and falling back down.}

You end up climbing on all fours, treating the stairs as a ladder. {leg == "worst": The longer you climb, the harder it's getting with your leg.}

You stop to rest every 3 or 4 flights. If your count is right, you've stopped at least 12 times.

*[How tall is this church?]

- 
After countless flights of stairs, you make it to the landing, crawling your way onto solid ground.{leg == "worst": Any longer, and you think you may have fallen.} {has_flashlight: The landing is small and square, maybe only five feet by five feet.| You stay on all fours, unsure how large the landing is or if there were any guard rails.}

{has_flashlight: The only thing on the landing is a door. It's old and wooden, much like the rest of the church. It is covered in chains and locks. A metal bar is bolted across the door in a way where you could not pull or push it open, even without the chains. Soft, pulsing, red light peaks out from under it. | A few feet in front of you was a door.  Soft, pulsing, red light peaks out from under it. It gave off enough light for you to have a a destination, but not enough to illuminate the area.}

*[{has_flashlight: Look closer | Crawl to the door}]

- 

{
    - has_flashlight:
        #PLAY: lock_rattle
        You walk closer to the door, and tug at the door knob. The door jiggles, but doesn't budge. Through a small keyhole, the red light pours out.
    - else: 
        You make it to the door with little issue. It's old and wooden, much like the rest of the church. It is covered in chains and locks. A metal bar is bolted across the door in a way where you could not pull or push it open, even without the chains.
        
        #PLAY: lock_rattle
        You stand and tug at the door knob. The door jiggles, but doesn't budge. Through a small keyhole, the red light pours out.
}

*[Peak through the key hole]
-> END_DEMO

= Office
#PLAY: lock_rattle
You try the door only to find it locked.

*[Examine the stairs]
    -> Stairs.Examine_Stairs