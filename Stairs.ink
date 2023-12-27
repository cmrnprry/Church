=== Stairs ===
{
    - leg == "worst":
        ~temp_string = "limp up"
    - else:
        ~temp_string = "climb"
}
{ - room:
    - 0: You {temp_string} the short set of stairs, and notice a door over the last few steps, rather than at the top of the landing. The hall extends to another set of stairs that go both up and down. 
    ~room += 1
    
    - 1: You {temp_string} the short set of stairs.The office door is still there, however, in a different place. Rather than it being at the end of the hall, it sits on wall adjacent to the stairs, hovering over the last few. The hall extends to another set of stairs that go both up and down. 
    
        This was not there last time you were here.

    - 2: You {temp_string} the short set of stairs.
    - 3:

}
~room += 1

*[Examine the stairs]
-> Stairs.Examine_Stairs
*[Enter the office]
->Stairs.Office
*[Return to the main body of the church]

= Office
{
    - object != "":
        ~temp_string = "The door seems shorter than  you remember."
    - else:
        ~temp_string = ""
}
{ - room:

    - 2: You duck through the doorway. {temp_string}
    - 3:
}

= Examine_Stairs
You walk deeper down the hallway to the stairs. Going up, is a spiral staircase. Going down, is a long set of stairs. You can't see the end of either.

*[Enter the office]
->Stairs.Office

*[Return to the main body of the church]
*[Go upstairs]
    ->Stairs.Upstairs
*[Go downstairs]
    ->Stairs.Downstairs
    

= Upstairs
#play: click-on
You start up the stairs, holding the hand rail as you go.

{
    - leg == "worst":
        ~temp_string="The longer you climb, the harder it's getting with your leg."
    - else:
        ~temp_string=""
}

You continue up for what feels like 5 or 6 flights, but they show ni sign of stopping. Tighter and tighter they spiral, the hand rail gets lower and lower, and the stairs get steeper and steeper. You end up climbing on all fours, almost treating the stairs as a ladder, they're so steep. {temp_string}

You stop to rest every 3 or 4 flights. If your count is right, you've stopped at least 12 times.

*[How tall is this church?]

- 
{
    - leg == "worst":
        ~temp_string=" Any longer, and you think you may have fallen."
    - else:
        ~temp_string=""
}

After countless flights of stairs, you make it to the landing, crawling your way onto solid ground.{temp_string} The landing is small and square, maybe only five feet by five feet.

The only thing on the landing is a door. It's old and wooden, much like the rest of the church. It is covered in chains and locks. A metal bar is bolted across the door in a way where you could not pull or push it open, even without the chains. Soft, pulsing, red light peaks out from under it.


*[Examine the locks]

*[Head back down]
-> Stairs.Return_Down

- 
{
- key or clippers:
    ~temp_string = "Maybe you could..."
- else:
    ~temp_string = ""
}


You take a closer look at the locks. There are three main ones, all are slightly different. 

The top lock looks almost like something you'd find in an antique shop, made of heavy iron. It has a small key hole, and looks to be holding the chains together. The chains themselves aren't very think, but are sturdy. {temp_string}

The middle lock seems to be slightly newer. It doesn't require a key, but a four digit number code. It is attched to the metal bar that keeps the knob from turning. Removing this lock would probably allow the door to be opened.

The last lock is a sliding chain door that appartments usually have inside to prevent people from forcing their way in. Sliding it all the way to the end makes a smaller deadbolt slide into place, keeping the door unopenable. There is no obvious keyhole.

{
    - key && key_lock:
        *[Try the key you have.]
            -> Stairs.Try_Key
}

{
    - clippers && !clippers_lock:
        *[Use the wire cutters.]
            -> Stairs.Use_Clippers
}

{
    - number_combo != "" && !number_lock:
        *[Enter {number_lock} into number lock.]
            -> Stairs.Enter_Number
}

*[Mess with the locks]
~ messed_locks = true

*[Head back down]
-> Stairs.Return_Down

- You try a few combinations on the number lock, thinking you can guess code. Trying to enter today's date, the year, your birthday- Anything meaningful set of four numbers you can think of. After a few minutes, you give up.

You pull at the chain lock, but it's tightly fastened to the door. You grab at the chain itself and pull, thinking the thinner chain might snap under the pressure, but it holds fast. You then try messing with the sliding lock as well, trying to see if there's a trick to it. If there is, you can't figure it out.

{
    - key && !key_lock:
        *[Try the key you have.]
            -> Stairs.Try_Key
}

*[Head back down]
-> Stairs.Return_Down

= Try_Key
~ locks += 1
~ key_lock = true
You fish the key out of your pocket, and try it on the only lock with a key hole. It resists slightly, but after messing with it, you're able to slot it in and turn it. 

#play: groaning-angry, 1 
The chains and lock fall to the ground. <>

#stop: groaning-angry, 2
The church groans angrily in response. 

{ - locks:
    - 1: One lock down, two more to go.
    - 2: Two locks down, one more to go.
    - 3: All the locks have been removed.
}

{
    - key_lock && number_lock && clippers_lock:
        *[Open the door.]
        ->Open_the_Door
    - else:
        {
            - clippers && !clippers_lock:
                *[Use the wire cutters.]
                    -> Stairs.Use_Clippers
        }
        
        {
            - number_combo != "" && !number_lock:
                *[Enter {number_lock} into number lock.]
                    -> Stairs.Enter_Number
        }
        
        
        {
            - !messed_locks && locks < 3 && (number_combo == "" || !clippers):
                *[Mess with the other locks]
                ~ messed_locks = true
                -> Stairs.Mess_With
        }
        
        *[Head back down]
        -> Stairs.Return_Down
}

= Mess_With
~temp_string = ""
{
    - number_combo != "":
        ~temp_string = "You try a few combinations on  the number lock, thinking you can guess code. Trying to enter today's date, the year, your birthday- Anything meaningful set of four numbers you can think of. After a few minutes, you give up."
}
{
    - !key:
        ~temp_string += "\nYou pull at the chain lock, but it's tightly fastened to the door. You grab at the chain itself and pull, thinking the thinner chain might snap under the pressure, but it holds fast."
}
{
    - clippers:
        ~temp_string += "You then try messing with the sliding lock as well, trying to see if there's a trick to it. If there is, you can't figure it out."
}
    
With one lock removed, you mess with the others. {temp_string}

= Use_Clippers
~ locks += 1
~ key_lock = true
~ temp_string = ""

{
 - finger_chopped:
    ~ temp_string = "You flinch at the sound out the chain snapping, reminded of the sound when you let them take your finger. A dull pain echos through your stump at the memory. "
}

{
 - !key_lock && key:
    ~ temp_string += "You look at the rest of the chains that are held together with the old looking lock. You try the key you found but... Instead, you cut around the lock and then some, until the lock falls."
 - !key_lock && !key:
    ~ temp_string += "You look at the rest of the chains that are held together with the old looking lock. You could look for a key, but... Instead, you cut around the lock and then some, until the lock falls."
}

You slide the chain lock to the the side, so the extra deadbolt is not blocking the door from opening, and use the small wire cutters you have to break the sliding chain.

#play: cut_chain
{temp_string}

{ - locks:
    - 2: With two locks removed, all that's left is the number lock.
    - 3: All the locks have been removed.
}

{
    - key_lock && number_lock && clippers_lock:
        *[Open the door.]
        ->Open_the_Door
    - else:
        {
            - number_combo != "" && !number_lock:
                *[Enter {number_lock} into number lock.]
                    -> Stairs.Enter_Number
        }
}



*[Head back down]
-> Stairs.Return_Down

//TODO

= Enter_Number
~locks += 1
~number_lock = true

(set:$code to true)(if:$name is true)[(if:$room is 5)[You pull the page from your pocket. You grab the combination lock and input the numbers. 0624.

The lock doesn't click. You pull it, thinking it might be stuck. Nothing. You re-read the page. The code is correct, so what could... You read a bit further on and... You feel sick.

Further down the page, it explains the number. Not a date or some random sequence, it's the number of people that have been trapped. With shaking hands, you turn the 4 up to a 5 and the lock clicks open.](else:)[You grab the combination lock try to remember the number. 062...5? You think it was that or similar. You input the number and the lock clicks open.]](else:)[You grab the combination lock, and input the number they were chanting, adding a leading zero. (if:$finger_chopped is "Oliver")[0624. The lock doesn't click. You pull it, thinking it might be stuck. Nothing.

You think back, you are sure that was the number they were saying. What else could it be... Then it dawns on you. The pastor had called you, 625. Their //latest// member.

It's not a date or some random, it's the number of people that have been trapped. With shaking hands, you turn the 4 up to a 5 and the lock clicks open.] (else:)[0625 You think it was that or similar. You input the number and the lock clicks open.]]

You remove the lock from the metal bar, and slide it out of place. 
(if:$cutters is true and $code is true and $locks is 1)[

{ - locks:
    - 1: One lock down, two more to go.
    - 2: Two locks down, one more to go.
    - 3: All the locks have been removed.
}

{
    - key_lock && number_lock && clippers_lock:
        *[Open the door.]
        ->Open_the_Door
    - else:
        {
            - key && key_lock:
                *[Try the key you have.]
                    -> Stairs.Try_Key
        }
        
        {
            - clippers && !clippers_lock:
                *[Use the wire cutters.]
                    -> Stairs.Use_Clippers
        }

        *[Head back down]
        -> Stairs.Return_Down
}

= Downstairs
~ temp_bool = false
#play: click-on
You approach the stairs shine your flashlight down. There are smooth walls on either side of the stairs. You cannot see the bottom. You take one step down, and deep groan wells up from below.

You tense, every fiber of your being telling you to not continue down.

*[Continue down]

*[Turn back]
    You stumble back up the stairs to the hall, and take a deep refreshing breath of the clean air. Luckily, the smell doesn't seem to have stuck to your clothing.
    ->Stairs.Turn_Back
- 
{
    - leg == "worst":
        ~temp_string = ", making sure to lean against the railing to take weight off your leg"
    - else:
        ~temp_string = ""
}

Cautiously, you take another step down{temp_string}. And then another. And another. With every step down, your body yells at you more and more to turn back. That something's wrong.

*[Push through]

*[Turn back]
    You stumble back up the stairs to the hall, and take a deep refreshing breath of the clean air. Luckily, the smell doesn't seem to have stuck to your clothing.
    ->Stairs.Turn_Back
- 

{
    - leg == "worst":
        ~temp_string = "You grab the railing with both hands,"
    - else:
        ~temp_string = "You grab the railing to steady yourself,"
}

About halfway down the steps, the smell of rot hits your nose, so strong you gag. {temp_string} and retch. The stench is unbareable. 

It smells of old, rotten meat left in the sun. Of putrid sour milk left out for too long. Of rancid fruit left to liquify in the fridge.

You cover your face with your shirt, and breathe through your mouth, but the pungent smell clings to you. 

*[Keep moving]

*[Turn back]
    You decide to explore downstairs at a later point in time, and return to the hall.
    ->Stairs.Turn_Back
    
- You plug your nose and keep going, only stopping to dry heave. It isn't long before the steps change from wood to... to something you can't comprehend. You stop and shine the light. 

#style: fidget, <mold, fungus, flesh>
The rest of the stairs are covered in pink, bulbous... flesh? You shake your head. It has to be some sort of mold or fungus. You poke the next step with your foot, and the (text-style: "condense", "fidget")[<mold, fungus, flesh> shivers in response. 

You shine your light to the end of the staircase, and see a door at the end of the stairs. Walls and ceiling covered in the same disgusing substance.

*[See what's behind the door]

*[Turn. Back.]
    #play: click-off
    Without a second thought, you rush back up the stairs to the hall. You take a deep refreshing breath of the clean air at the top, and try to make sense of what you just saw. 

    The flesh, it- it _reacted_ to your touch. Your skin crawls at the thought. You don't think you should go back down there.
    ->Stairs.Turn_Back

- 
#play: 1, squish-squash
_You've made it this far, might as well see it it toward the end,_ you think, and take a deep breath through your mouth. Slowly, you make it to the bottom of the stairs.

_Squish_

#stop: 3, squish-squash
The tissue is soft under your shoes, making a soft, wet sound with each step. A thick ooze sticks to the bottom of your shoes.

_Squelch_

*[Open the door]

-The door opens, and you are assulted by the smell. Your eyes water and you clamp your hand over your nose and mouth. You take a few steps inside, trying to see what's the cause of this god awful smell.

The room is covered in the pink, buldging flesh, thick ooze drips from the ceiling. You pan your flash light around. The room is filled with furniture covered in tarps.

*[Find the source of the smell]

*[Investigate the ooze]
#delay: 1.5
You walk deeper into the room, deeper into the maze, and approach a place where the ooze consistantly falls from the ceiling. You stick the end of the flashlight into the small pool of it. It's sticky and slippery, much more slime like than ooze.

#play: click-on #play: 1, click-off #play: 1, click-on #play: 1, click-off
The flashlight flickers, and turns offs. You hit it against the palm of your hand, trying to get it to turn back on, the slime getting on you in the process.
->Stairs.Melt

*[Your hand starts to itch]

- You walk deeper into the room. It is a maze of old furniture. Most of it is normal, chairs, tables. Some of the shapes confuse you. Some are too tall, or too wide to be anything recognizeable. 

You pass by what you assume is a standing coat hanger, and stare at it. It is taller than you, and has multiple edges jutting out from it. You reach out to lift the canvas covering it, but stop just before touching it. 

You're not sure why, but you retract your hand. You stare at the coat hanger a little longer before conitnuing on.

*[You don't check under any of the tarps.]

- You continue deeper into the room, the smell getting stronger with each step. You pray that the smell won't linger after you leave, and follow your nose to the source.

You find yourself in the far back corner, a tarp partially covering something scattered over the floor. It come us to about your chest, a stacked pile of... something. Firewood? But you don't remember seeing a fireplace upstairs...

Near the edge of the tarp you see scraps of wet cloth and... Is that... bone...? You swallow the lump in your throat.

*[Lift the tarp]

- #play: click-off
You let out a shriek and fall backwards, dropping your flashlight in the process. It turns off and rolls away.

#style: fidget, <mourn, pity, pray>
Underneath the tarp lies a pile of bodies, covered in rotten flesh. Clumps of hair stuck to skulls. An amalgamation of bones fused together. You don't have time to <mourn, pity, pray> for them, your only thought is to get _out._ On your hands and knees, you search the floor for your light. 

*[Search left]
~temp_bool = false
You feel to your left. The ground feels like you're touching chewed gum covered in slime. Your skin crawls with each touch of the ground, but you keep searching.

You feel a slight divot in the ground, and reach further in, hoping the flashlight rolled there. Instead, you end up shoving your hand into a pool of whatever ooze is dripping from the ceiling.

*[Search right]
~temp_bool = true
You feel to your right. The ground feels like you're touching chewed gum covered in slime. Your skin crawls with each touch of the ground, and keep searching.

Eventually, your hand bumps into something hard and metal. The flashlight. You grab it. It's covered in the same ooze that drips from the ceiling. You wipe it off with your hand, and try to turn it back on.

*[Your hand starts to itch]
->Stairs.Melt

= Melt
You wipe off any remaining ooze on your shirt, but that only causes the itching to spread. 

*[It burns]

- 
{
    - temp_bool:
        ~temp_string = ". You have the flashlight."
    - else:
        ~temp_string = ", flashlight be damned."
}

Blood rushes to your ears, so loud you can barely think. You need to get out of here- Out of this this slime{temp_string} You blindly try to make your way back to the door.

The ooze being to fall faster. You step in puddles. It falls on you from the ceiling. You cannot wipe it off fast enough. 

*[It's eating through you]

- You wipe off another blob off your shoulder, but something goes with it. Something wet. Something warm. You stop, and reach up to touch your shoulder. Your hand shakes. Your breathing becomes short and shallow.

*[You feel bone.]

- You can't breathe.$[Your skin burns.] You can't think. Bone? How-? $[Your skin burns.] Your head swims. $[Your skin burns.]You can't get enough air in. $[Your skin burns.] Is this slime-?

*[Your skin burns.]

- You keep going, desperatly trying to escape. $[You can't feel your hand anymore.] You trip over yourself, and fall into puddle of the acidic ooze. $[You can't feel your legs.]

*[You can't feel anything.]
->Credits

= Turn_Back
*[Go upstairs]
->Stairs.Upstairs

*[Enter the office]
->Stairs.Office

*[Return to the main body of the church]

=  Return_Down
{
- locks == 1:
    ~temp_string = "With one lock down,"
- locks == 2:
    ~temp_string = "With two locks down,"
- else:
    ~temp_string = "Unsure of what more you can do,"
}

{temp_string} you decide to head back down, assuming you can find a way to unlock them down in the church's main body.

When you turn to go back down, dreading the climb, the staircase has changed into one normal flight of stairs. You can see the bottom of the landing. 

Tentatively, you go down the stairs, ready for it to warp or change at any moment. When you reach the bottom and look back, the stairs are once again a spiral stair case. Shining your flashlight back up, you only see darkness. 

If you weren't sure before, you are now: Behind that door lies the heart.

*[Go upstairs]
->Stairs.Upstairs

*[Enter the office]
->Stairs.Office

*[Return to the main body of the church]





























