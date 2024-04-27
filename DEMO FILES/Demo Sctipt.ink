INCLUDE Variables.ink
INCLUDE Confessional_Door.ink
INCLUDE Confessional_Curtain.ink

#IMAGE: Default
<i>This game will autosave your progress. Using the restart button will rest your game and ALL save data. <br><br> Closing the window will reset any progress.</i>

+ [Start Game] ->Start
+ [Credits] ->Credits
+ [Content Warnings] ->Content_Warnings
+[TESTING]
-> Walk_Up_Path

=== Start ====
There is a church at the end of the street- but there shouldn't be. You saw it when walking home from the bus stop after work. You grew up on this street. You have walked down this road daily. There is not a church at the end of the street.

It was dark when you passed, and you keep telling youself that your tired brain mistook a billboard for a church. They must be building one there.

*[It's impossible for a church to spring up overnight.]

- 
#IMAGE: BusStop
You pass by again, on your walk to the bus stop this morning, and stop dead in your tracks. There should not be a church, and yet, there it sits. A "FOR SALE" sign attached to its lawn.

*[You don't like it.]

*[You feel drawn to it.]

*[You want nothing to do with it]

- Your stomach churns.  You shove your hand in your pocket and rub your thumb over the worn polaroid picture inside.

*[You quickly cross the street.]

- You mess around on your phone, trying to ignore the building. You keep looking up at it, confiriming for yourself that the church is really there. 

It was not there on the walk to the bus stop yesterday, or the day before- you're sure of it. And a new building wouldn't look so... You glance up at it again, and something pulls at the back of your mind.

The church feels...

*[Familiar]
~feeling = "familiar"

*[Uncomfortable]
~feeling = "uncomfortable"

*[Evocative]
~feeling = "evocative"

- It is small, with white paint peeling, revealing sun-bleached brick underneath. It's windows are intact, but everything else is cracked or crumbling. You're surprised the building is still standing.

The bus arrives and you're no closer to understanding this {feeling} church that spontaneously appeared. Your stomach lurches.

*[Get on the bus]
#PLAY: bus_ambience, true
-> Bus
*[Investigate the church]
-> Investigate

=== Investigate

You pat your pant pockets, pretending that you forgot your pass, and smile sheepishly. The driver rolls her eyes and drives off. It's still early enough where you can just catch the next one. You steel yourself and look back at the church.

*[The church windows catch your eye.]

-~window = true
#ZOOM: scale(1.5) translate(-26%, 22%)|inset(0 0 32.5% 50%) #ICLASS: Background Image||Swimming
The church's windows are of stained glass, which isn't uncommon for it to have. You squint trying to make the image out, but no matter how hard you focus, you can't explain what the glass was a picture of. 

*[You take a step forward.]

#ZOOM: scale(2) translate(-26%, 35%)|inset(0 0 55.5% 50%) #ICLASS: Background Image|Swimming|Swimming-2
-The image swims in your vision. Just as you think you've got it, it changes. You make a mental note to get your eyes checked.

*[You take another step forward.]

-#DELAY: 1.25 #ZOOM: scale(3) translate(-30%, 35%)|inset(9% 9% 69.5% 67%) #ICLASS: Background Image|Swimming-2|Swimming-3
Blood starts rushing in your ears and pressure builds behind your eyes as you strain to-

#DELAY: 1.5
#CLASS: Bus_Honk #PLAY: honk 
HOOOOONNNKK!!

#PLAY: bus_ambience, true #ZOOM: unset|unset #ICLASS: Background Image|Swimming-3|
You stumble backwards as the bus swerves, narrowly avoiding you. The driver opens the door and asks if you're alright. You feel youself nodding, heart pounding. A knot forms in your stomach.

*[Your eyes don't leave the church.]

- You brush off the driver's questions and board the bus.

*[Take a seat]
    You drift to the back of the bus, and sit where you can look at the church through the window.
    -> Bus.Seat
    
*["Do you know when they built that church?"]

- The bus driver gives you a look.

"Is that really important right now?" he says. "Are you alright?"

*["So it was here yesterday?"]

- You grip his arm as you ask. Your nails dig into his arm and he winces.

#CYCLE: perturbed, afraid, nervous, tense
"I'm going to need you to let go." He looks @. "Do I need to call someone?"

Your eyes dart from him to the church behind him and back. You're losing it. Over a building. You need to calm down.

"I'm sorry-" You release the bus driver. "I- I-'m sorry."

*[You scurry to the back of the bus.]
    You find a seat where you can look at the church through the window.
    -> Bus.Seat

=== Bus ===
You board the the bus, and scan your ticket.

*[Take a seat]
-> Bus.Seat

*"Do you know when they built that church?"

- The bus driver looks over her shoulder, then back at you. She frowns.
"Looks older... Maybe 10, 20 years ago?"

*["So it was here yesterday?"]
"I assume as much." She closes the bus doors.

*["How long have you been working this bus route?"]
"Too long. You should know, I see you almost daily." She closes the bus doors.

- You nod and take a seat.
-> Bus.Seat

= Seat
#REPLACE: home
You watch the church through the window until it fades into a dot in the distance. Even after it's gone, you still feel on edge. A part of you wants to call out sick and go back [home].

*[home]
    ->Bus.home
    
*[You want to forget about the church.]
    You fear what what will happen if you can't.
    ->Job

= home
You watch the church through the window until it fades into a dot in the distance. Even after it's gone, you still feel on edge. A part of you wants to call out sick and go back to the church. It's waiting for you.

*[You <i>need</i> to forget about the church.]
    You fear what what will happen if you can't.
    ->Job

=== Job ===
#CHECKPOINT: 1, You arrive at work. #PLAY: office_ambience, true, 1 #IMAGE: Default
You get less done than usual at work. You find yourself absently doodling and scribbling on scrap paper. Typing nonsense, only to delete it after. Staring blankly into your computer screen.

There is only one thing on your mind, one thing that shouldn't exist but it does.

That {feeling} church.

You should do somthing to take your mind off it.

*[Scan some documents]
-> Job.Scan

*[Catch up on emails]
-> Job.Emails

= Scan
You choose to do something mindless and easy. You grab a stack of papers marketing needs sent out, and head to the machine.
~ work += 1
*[Maybe the monotony will take your mind off things.]

- #PLAY: scanner, false, 0.5
You enter a rhythm of placing a page, entering an email, and sending it off. You try to focus on only your actions to prevent your mind from wandering. 

Place page. Enter email. Send it off. Place page. Enter email. Send it off. Place page. Enter email. Send it off. Place page. Enter email. Send it off. Place-

*["Hey- What are you doing?"]

- #STOP: scanner, 1.5
You jump and look up to see a coworker from your departmenr. You don't talk to her often, but she's nice enough. She looks... concerned?

*["Just sending out some scans."]

*["Busy work until the next meeting. You know how it is."]

*["Trying to keep busy."]

- She nods slowly, and picks up one of the papers from your done pile. "And... <i>this</i> is what you're sending out?"

"Yeah, Marketing needed-"

She cuts you off as she starts to read off what's on the page. "'Do you know about the church at the end of the street?" 

The hairs on the back of your neck stand up.

*[<i>No</i>]

- "The church at the end of the street knows me but I don't know it." She continues. Your chest tightens, and you frantically go through the rest of the papers. You know these were marketing reports. "It waits and waits for me to come back. It has gotten impatient."

All the papers repeat what you coworker said. Over and over again. All in handwriting. <i>Your</i> handwriting. You clutch the papers tightly, until your knuckles go white and your nails pierce through. <i>When did they change?</i>

"Did you write this?" She purses her lips at you. "Is this your idea of a bad joke?"

*["I'm going home early today."]

*["I'm going to work from home for the rest of the day."]

*[Say nothing and leave.]

- ->Walk_Home

= Emails
#PLAY: ding, false, 0, 1
You pull up your email and scroll through the new ones, only reading the subject lines for anything important. Meeting invitation, spam, spam, client question, church inquiry, meeting- Wait. Church inquiry?

*[Open church inquiry email]
-> Job.Open
*[Delete the email]
-> Job.Delete

= Delete
#DELAY: 1.5
You quickly delete the "church inquiry" email, and go to reply to the client. 

#PLAY: ding, false, 0, 0.5 #DELAY: 1.5
Another email with the same subject quickly replaces it. You don't think and delete it again.

#PLAY: ding, false, 0, 0.5
But yet another takes it's place.

*[Delete it again]
-> Job.Delete_Again
*[Ignore it and reply to the client]

- You mark the church email as spam and respond to the client, making sure to CC the correct person they should speak to. You close your email and rub your eyes with the palm of your hands. 

#DELAY: 3
<i>Stop thinking about it.</i> You tell yourself. <i>It's nothing but a church, so why-</i>

#PLAY: knocking
"Knock knock, can I talk to you?" You look up to see your supervisor at your door, holding a few sheets of paper. They look upset.
~ work = 2

*["Yeah, come in."]
    They enter, and close the door, "I'll be quick. Can you explain what your last email meant?" They sound frustrated. "Is it a joke? A prank?"

*["Now's not a good time."]
    "Right..." they say, and enter anyway. "Can you explain what your last email meant? Our client is not happy."

- 

*["What?"]

*["They sent the email to the wrong department so..."]

- They roll their eyes and drop the papers on your desk. "You're about to lose us our best client!" You pick them up, and your stomach drops. In your hands is are print outs of emails from you to a client. They all say the same text over and over again:

"Do you know about the church at the end of the street? The church at the end of the street knows me but I don't know it. It waits and waits for me to come back. It has gotten impatient."

"Do you understand how this can hurt sales?" They hiss. You clutch the papers until your knuckles go white, and your nails pierce through. "You'd be <i>lucky</i> if I only suspend you for this!"

*["I'm going home early today."]

*["I'm going to work from home for the rest of the day."]

*[Say nothing and leave.]

- ->Walk_Home

= Delete_Again
#DELAY: 0.5
As you click the button to delete the email- <>

#PLAY: ding, true #STOP: ding, 0, 2 #DELAY: 1.5
you get a flurry of new emails. "Church Inquiry. It's waiting. It's impatient. Hurry up. Hurry up. Hurry up."

#PLAY: ding, true #STOP: ding, 0, 2.5
You try to delete them, but they just keep coming. "Where are you?" "Come home." "(No Subject. Image Attached)."

*[Open Email]
~ know = true
You give in, and click the latest email.
-> Job.Open

*[Continue Deleting]

- 
#PLAY: ding, true #DELAY: 1.5
You can't delete them fast enough.

#DELAY: 1.5
They just keep coming. You try to-

#STOP: ding
"Hey are you-" A hand grabs your shoulder, and you jump up from your chair, slaping the hand away. 

"Leave me ALONE!" you shout, breathing heavy.

"What's your problem?!" You realize all too late that this was not the church, but your coworker. You stumble over yourself trying to appologize. "We all have rought days but.... What the hell?!"
~work = 3

*["I'm- I'm going home early."]

*[Say nothing and leave.]

- ->Walk_Home

= Open
~ work = 3
{
    - know != true:
        You click the email.
        ~ know = true
}

- It shows an image of the church, but in a different place. Not at the end of your street, but near your grandparents house, several states away. You see a younger version of yourself standing outside and smiling. 

Your mouth goes dry.

*[Scroll down]

- Under the image is the text "Don't keep it waiting."

You slam the laptop shut. A fuzzy memory tickles the back of your mind, and suddenly it all clicks into place.

*[You know the church.]

- You don't know how, but you know it. You slam you fist against your desk. "Why can't I...?" You mutter.

The memory refuses to surface, only vague images and feelings. You see yourself inside. You're scared. You're trapped. But that's all you can remember. You hit the desk again, harder. 

"It's right there, so just..." You murmer to yourself. "I was...?"

You found something. It let you out? No. It wouldn't-

*["Everything... Okay...? In here?"]

- It's your coworker. You wave him away, and focus. You escaped. It wants you back. You can see the door opening, but the younger you didn't feel relief. No, they felt... afraid? Why...? You got out so why-

Your coworker grabs your sholder, "Hey what's-" You jump up from your chair and smack his hand away. You lean on the wall to support yourself, breathing heavy. "What's your problem?!"

Your coworker stares at you, waiting for an answer. You shove your hand into your pocket, searching for the poleroid inside, hoping to calm yourself.

"No no no, where...?" You franticly searching every pocket, only to find it all empty. You look to your desk and find small, ripped pieces of a once comforting memory. "Did I...?"

"Seriously, what's up with you?!" You gather the pieces in your hands, and begin trying to tape them together, but the pieces are too small. You swallow the lump in your throat, and face your coworker. "Uhhh... You alright?"
~ photo_ripped = true
*["I'm- I'm going home early."]

*[Say nothing and leave.]

- ->Walk_Home

=== Walk_Home ===
{ work:
    - 1:"Maybe you should take some sick days..." she says, her voice trails off. You nod, and return to your desk to gather your things.
    - 2: "I want an apology sent to them within the day, or don't come back at all." They say, as you gather your things. You nod, and they shake their head muttering curses, leaving you alone in the cubicle.
    - 3: "Yeah, whatever." He says as he leaves. You quickly start packing up your things.
        {
            - know:
            You lay out the pieces of the poleroid, all too small to really make anything out. You can't bring youurself to throw it away, instead placing each piece in the small drawer of your desk.
            
            You'll try to fix this tomorrow, after a good night's sleep.
        }
    
    - else:
        Error
}

{ 
    - know == true:
        You need to avoid the church. It wants you back, and everything in screams that you cannot go back. That if you do, you won't come out again.
}
#STOP: office_ambience, 1.5
The bus ride home is shorter than it's ever been. You get off at your regular stop.

The church is still there.

*[Take a different path home]
->Walk_Home.Different

*[Take the usual path home]
Tentatively, you walk your usual path home, and try not to look at the church.
->Walk_Home.Usual

= Different
~turn = "walking"
~avoid = true
#IMAGE: Stop_Sign
You get off at the same bus stop you normally do. You don't look at the church, and instead turn around and walk up the block. A burning creeps up the back of your neck, almost as if someone is staring you down.
*[Turn around]
->Walk_Home.Turn_Around

*[Walk faster]

- 
#ZOOM: skewX(15deg) scale(1.25)|inset(0px 0px 5% 5%)
#PLAY: walking_fast_pavement, true, 1
You shove your hand in your pocket and pick up the pace. The corner where you need to turn is so close. The burning sensation grows, and something grabs at your legs. The wind picks up around you.

*[Turn around]
->Walk_Home.Turn_Around

*[Go faster]

- 
~turn = "running"
#ZOOM: skewX(30deg) scale(1.5) translate(-12%, 16%)|inset(0px 0px 26% 17%)
#STOP: walking_fast_pavement, 0.5 #PLAY: running_pavement, true, 0.5, 1
You break out into a run. You can almost touch the stop sign on the corner. How have you not reached it yet? The burning sensation lessens, replaced with lead weights at your ankles. Your chest feels heavy, like someone has their arms wrapped tightly around you.

You hear something on the wind. A voice?

*[Turn. Around.]
->Walk_Home.Turn_Around

*[Almost. There.]

- 
#ZOOM: skewX(30deg) scale(2) translate(-12%, 21%)|inset(0px 0px 39% 21%)
#STOP: running_pavement #REPLACE: stop sign.
You reach out and grab the sign with both hands. The burning is gone. Nothing holds you back. Breathing heavily, you smile and look up at the [stop sign.]
    
*[stop sign.]
->Stop_Sign

= Turn_Around
#ZOOM: unset|unset #STOP: running_pavement #STOP: walking_fast_pavement
You stop {turn}, and ball your fists. All sensations stop.

*[Face the church]

- 
#IMAGE: Chuch_Looming #PROP: closed_gates, false
You spin around to face it, and find yourself.. in front... of the church? 

You look up and down the street. You're not any further from the corner, and the bus stop isn't any closer. Then...

{
    - know:
        It's following you. You wipe sweat from your brow.
        
        It can move.
    - else:
        Was it always this far down the road? This morning you were able to clearly see it from the bus stop...
        
        You take a breath, and reach into your pocket. The feeling of the worn poleroid calms you. You're being unreasonable. It's just a building. Just a church. A {feeling} church.
}


*[Continue walking the long way home]

*[Take your usual path]
    { - know: You know you shouldn't, but you can't stop yourself.} You try not to look at the church as you walk past. 
    ->Walk_Home.Usual
    
- 
#IMAGE: Stop_Sign #PROP: closed_gates, true
{
    - know:
        It wants you back, but you refuse to let it have you.
    - else:
        You decide to continue the long way home, hoping the fresh air will ease your mind.
}

As soon as you start walking again, the burning sensation flares up again, ten times worse than before, bleeding down your back. 

*[Ignore it]

*[Turn back]
#IMAGE: Chuch_Looming #PROP: closed_gates, false
You stop in your tracks and ball your hands into fists. You spin around to find yourself at the front of the church. Your hands tightly grip the front gates.
->Walk_Home.Stop_Sign

-
#PLAY: walking_fast_pavement, true, 1
#ZOOM: skewX(30deg) scale(1.5) translate(-12%, 16%)|inset(0px 0px 26% 17%)
You ignore it, and keep going. Each step feels like wading through thick jelly. You can almost touch the stop sign on the corner.

*[Almost. There.]

- 
#ZOOM: skewX(30deg) scale(2) translate(-12%, 21%)|inset(0px 0px 39% 21%)
#STOP: walking_fast_pavement #STOP: running_pavement #REPLACE: stop sign.
    You reach out and grab the sign with both hands. The burning is gone. Nothing holds you back. Breathing heavily, you smile and look up at the [stop sign.]
    
*[stop sign.]
    You reach out and grab the stop sign with both hands. The burning is gone. Nothing holds you back. Breathing heavily, you smile and look up at the church.
->Stop_Sign

= Stop_Sign
#ZOOM: unset|unset #IMAGE: Chuch_Looming #PROP: closed_gates, false
It looms over you, taller than you remember. Your hands tightly grip the front gates. The door is open. 

But how did it...? You were at...?

*[Open the gates]
#PLAY: gate_open #PROP: closed_gates, true #PROP: open_gates, false
You throw the gates open, and the edges of the dirt path to the church brighten, small lights lining the path. Motion activated maybe?

*[Let go]
#PLAY: gate_open #PROP: closed_gates, true #PROP: open_gates, false
You pull your hands from the gate and take a step back. The gate groans as it opens. The edges of the dirt path to the church brighten, small lights lining the path. Motion activated maybe?
- 

*[Take a closer look]

- You take a step onto the property. The ground is soft, but firm. You crouch down in front of the closest light. They have tiny solar panels on the top.

In this crouched position, the lawn is at eye level, but not a single weed crosses onto the soft dirt.

You stand up and trace the path with your eyes, looking for anything that disturbs it.

*[Walk up the path]
->Walk_Up_Path

= Usual
#IMAGE: Default #PROP: closed_gates, true
#PLAY: gate_open
As you pass the front gate, it creaks open. You reach for the image in your pocket. 

{- know: You should keep moving.}

*[Investigate]

//On mouse click, change to "investigate
*[(Continue walking home)Investigate]


- 
#IMAGE: Chuch_Looming #PROP: open_gates, false
Against your better judgement, you stop, and look at the church. The gate is open.
{
- know: 
    You should keep moving. It's waiting for you. It's making the choice easy.
- else: 
    Probably the wind.
    Probably.
}

*[Close the gate]

*[Continue walking home]
->Walk_Home.Lost

- You take a single step onto the property to reach the open gate, and the edges of the dirt path to the church brighten where you step. Small, shining lights line the path. 
{
- know: 
    A feeling of unnerving calm washes over you. You know you need to leave. You know you need to walk away. But you also know you should keep going. There's no harm in looking.
- else: 
    Motion activated maybe?
}

*[Take a closer look]

- You take a step onto the property. The ground is soft, but firm. You crouch down in front of the closest light. They have tiny solar panels on the top.

In this crouched position, the lawn is at eye level, but not a single weed crosses onto the soft dirt.

You stand up and trace the path with your eyes, looking for anything that disturbs it.

*Walk up the path.
->Walk_Up_Path

= Lost
You take a few steps before stopping, and looking back at the open gate. You want to go home. You do. But something tells you to close the gate before you do...

*[What if a kid gets lost?]
~ temp_bool = true
#PLAY: footsteps_child_grass, true #STOP: footsteps_child_grass, 3
No sooner than you think it, you hear the sound of little feet and laugher carried on the wind. 

*[Or an animal gets trapped.]
~ temp_bool = false
#PLAY: meow
No sooner than you think it, you hear the sound of growling and meowing on the property. 

- 
{ - know:It's the church. You know it's the church. It has to be, but what if- }

{ 
    -temp_bool:
    A child might be in there. You should get them out.
        *["Hey, this isn't a place to play!"]
        -> Walk_Home.Close

        *["That's tresspassing, come on out now."]
        -> Walk_Home.Close
    - else:
        A cat might be in there, and from the sound of it, in trouble. You should get them out.
        *["Pspspspspsps, here kitty kitty kitty."]
        -> Walk_Home.Close
}

= Close
You stick your head past the gates and look around. You don't see anything, the ground doesn't even look disturbed.

*[Close the gate]

- You take a single step onto the property to reach the open gate, and the edges of the dirt path to the church brighten where you step. Small, shining lights line the path. 
{
- know: 
    A feeling of unnerving calm washes over you. You know you need to leave. You know you need to walk away. But you also know you should keep going. There's no harm in looking.
- else: 
    Motion activated maybe?
}

*[Take a closer look]

- You take a step onto the property. The ground is soft, but firm. You crouch down in front of the closest light. They have tiny solar panels on the top.

In this crouched position, the lawn is at eye level, but not a single weed crosses onto the soft dirt.

You stand up and trace the path with your eyes, looking for anything that disturbs it.

*[Walk up the path]
->Walk_Up_Path

=== Walk_Up_Path ===
#PLAY: footsteps_player, true
You take one step forward.

*[And keep walking.]

-
#PLAY: footsteps_scary, true, 2
And walking.

-{- know: You're moving automatically. You want to go home. }

Around halfway up the path, you hear another set of footsteps.

The church door is open and inviting. You can't see inside. 

*[Stop]
~ temp_bool = true

*[Walk faster]
~ temp_bool = false
->Walk_Up_Path.Run

- #STOP: footsteps_player, 0.5 #STOP: footsteps_scary, 0.5, 1
Stopping in your tracks, you wait and listen. You hear nothing, but the hairs on the back of your neck stand up...

Someone is behind you, and they know you know. Your only option is the church or confrontation. Your heart pounds in your chest. { -know: It has to be another trick.}

*[Run to the church]
->Walk_Up_Path.Run

*[Confront them]

- You take a breath and quickly spin around, ready for whatever may await you, and see...

Nothing. No one's there. You laugh.
{ 
    -know: The church will do anything to lure you in.
    - else: It was probably the wind.
}

*[Return home]

- 
{ 
    - know: You decide that you've been too close for too long and start for the gate. You think you deserve a long, hot bath after today.
    
    - else: You decide that you've trespassed for long enough, and start for the gate. You think you deserve a long, hot bath after today. 
}

*[You walk to the gate.]

- You grab the gate with both hands, and look up at the church one last time. It's quiet and dark. { - know: It lost. }

*[Pull the gate closed.]

- 
#PLAY: gate_close #DELAY: 2 #PROP: open_gates, true
Just as it slams shut...

#TEXTBOX: text_container_Dark #IMAGE: Default 
Everything goes dark.

*[Wait for your eyes adjust]
#DELAY: 1.5 
You hold your eyes closed and count to five.

#DELAY: 1 #TEXTBOX: text_container_UsedTo
One.
#DELAY: 1
Two.
#DELAY: 1
Three.
#DELAY: 1
Four.
#DELAY: 1.25
Five.

You open your eyes, and slowly start to make out your surroundings. In front of you is an old wooden door, and not a metal fence.

*[Try to open the gate.]
You blindly feel for the latch of the gate, but instead of cool metal your hands meet damp wood, and eventually a knob. 

- Somehow you are inside the church.

#PLAY: lock_rattle
You try the knob.

*[It's locked.]
-> Locked

= Run
#PLAY: footsteps_player, true #PLAY: footsteps_scary, true
{ 
    - temp_bool: 
    Adreneline floods your veins, and you break into a sprint. You can't hear anything over the blood pounding in your ears, but you swear you can feel someone trying to grab at your clothing.
    - else:
    { 
    -know: Against your better instincts, you pick up the pace, and you hear the footseps getting closer. Adreneline floods your veins, and you can't think straight. You start running, and so do they.
    - else: You pick up the pace, and you hear the footseps getting closer. Adreneline floods your veins, and you can't think straight. You start running, and so do they.
    }
}

You still cannot see in church. 

*[You're so close to safety]

- #STOP: footsteps_player #STOP: footsteps_scary, 0, 1 #PLAY: door_slam, false, 0, 0.5,  #DELAY: 5 #TEXTBOX: text_container_Dark #IMAGE: Default #PROP: none
You slam the door closed and fall into the dark church. You quickly regain your balance, grab the door and slam it closed. You throw your full body weight against it, hoping to hold back whoever was chasing you.

#CLASS: Bang_Short #PLAY: bang_short #DELAY: 2
BANG

Whoever was out there is slamming themselves into the door. It takes all your strength to keep them from getting in.

*["GO AWAY"]
~ temp_bool = false

*[Stay silent]
~ temp_bool = true

- 
{ 
    - temp_bool:
        #DELAY: 1
        You wait, saying nothing. 

        #CLASS: Bang_Short #PLAY: bang_short #DELAY: 1.5
        BANG

        #DELAY: 1.5
        They can't keep this up forever.

        #CLASS: Bang_Short #PLAY: bang_short
        BANG
        
    - else:
        #DELAY: 1
        "I DON'T HAVE ANY MONEY!" 
    
        #CLASS: Bang_Short #PLAY: bang_short #DELAY: 1.5
        BANG
    
        #DELAY: 1
        "I DON'T HAVE ANYTHING!"
    
        #CLASS: Bang_Short #PLAY: bang_short
        BANG
}

*[Wait]

- 
You don't know how long you sit there, holding the door closed, body braced against it. Eventually the banging stops, but you wait longer, just in case.

#PLAY: lock_rattle, false, 0, 0.5
When you feel safe again, you try to open the knob.

*[It's locked.]
->Locked

=== Locked ===
Locked? { -know: The blood drains from your face as you realize what you've done.}

#PLAY: lock_rattle
You jiggle the handle again. 

*[The door won't budge.]

- You don't understand. It can't be locked. { -know != true: Maybe it got jammed?}

*[Look around for something to pry open the door]
->Locked.Look

*[Kick in the door]
->Locked.Kick

= Kick
You size up the door and kick at the latch.

#CLASS: Kick #PLAY: door_thud #DELAY: 1
Thud!

The door shutters, but stands firm.

*[Again.]

*[Stop.]
You stop, fall to the floor, and stare at the untouched door in front of you. Your leg throbs from effort. You let out a short, hysterical laugh that could be mistaken a sob as the realization hits you.
->Trapped

- ~ leg = "hurt"
You kick again in the same place.

#CLASS: Kick  #PLAY: door_thud
Thud!

*[How is the door this strong...?]

- #CLASS: Kick #PLAY: door_thud #DELAY: 1
Thud!

The door still stands.

*[Again.]

*[Stop.]
You stop, fall to the floor, and stare at the untouched door in front of you. Your leg throbs from effort. You let out a short, hysterical laugh that could be mistaken a sob as the realization hits you.
->Trapped

- ~ leg = "pain"
You keep kicking at it. You breathing starts to get heavy and your leg aches. It feels as if you are hitting steel.

#CLASS: Kick #PLAY: door_thud
Thud!

*[You want to leave.]

- #CLASS: Kick #PLAY: door_thud #DELAY: 1
Thud!

The door shows no signs of breaking.

*[Again.]

*[Stop.]
You stop, fall to the floor, and stare at the untouched door in front of you. Your leg throbs from effort. You let out a short, hysterical laugh that could be mistaken a sob as the realization hits you.
->Trapped

- ~ leg = "worst"
Something in you allows you to keep going, even as your leg throbs and it feels like you can barely take in anymore air. 

#CLASS: Kick  #PLAY: door_thud
Thud!

*[You need to get out.]

- #CLASS: Kick  #PLAY: door_thud
Thud!

*[Evey fiber of your being is telling you to get <i>out.</i>]

- #CLASS: Kick  #PLAY: door_thud
Thud!

*[But the church will not let you.]

- #CLASS: Kick  #PLAY: door_thud
Thud!

*[The door does not move.]

- You stop, fall to the floor, and stare at the untouched door in front of you. Your leg throbs from effort. You let out a short, hysterical laugh that could be mistaken a sob as the realization hits you.
->Trapped

= Look
#IMAGE: Church_Inside
It's dark, but you can make out vague shapes.

{ 
- know != true: You quickly glance around the church. It's small, but seemingly abandonded. There must be something that was left behind by preivous squatters or looters. 

- else: You know it's useless, but fear overtakes the rational part of your brain. There has to be SOMETHING.
}

You look everywhere, arms outstretched, blindly feeling around your surroundings. On and under what you imagine are pews, the floor, past the curtain? Into a... cupboard? Closet? As you search, you get the feeling of deja vu. You've done this before.

*[Nothing.]

- You go further into the church, up a few steps, feeling the walls as you do, and find a closed door at the end of the hall. It might have what you're looking for.

*[You hope for a crowbar.]
~ object = "crowbar"

*[You hope for a screwdriver.]
~ object = "screwdriver"

*[You hope for a sledgehammer.]
~ object = "sledgehammer"


-
{
- object == "crowbar": 
    You want to pry the door open with it
- object == "screwdriver":
    You want to take the door off it's hindges
- else:
    You want to smash the door down
}<>
{
    - know: . You hope it won't be able to survive that.
    - else: . You know it won't be able to survive that.
}

#IMAGE: Office_Final
You open the door to find a side office, entirely covered in dust and cobwebs. The adjacent walls were book shelfs full of books. The far wall has a desk with a stained glass window above it. You avoid looking at the window.

{
- object == "crowbar": 
    #PROP: crowbar, false
}
{
- object == "screwdriver":
    #PROP: screwdriver, false
}
{
- object == "sledgehammer":
    #PROP: sledgehammer, false
}
On the desk sits a {object}, illuminated by a red spotlight from the window. It's not covered in dust like rest of the room, as if it has been placed there just for you.

~ room = true

*[Pick up the {object}.]
~ temp_bool = false

*[Leave it.]
~ temp_bool = true

- 
#PROP: sledgehammer, true #PROP: screwdriver, true #PROP: crowbar, true #IMAGE: Default
{
    - temp_bool:
        { 
        - know: The church is playing with you now. It knows what you wanted, and gave it to you.
        - else: Something tells you that even if you take it, it wouldn't matter. That the door won't budge for you.
        }
    
        
        You return to the front door.
        
        You stare at it. It stares back.
        
        *[Kick in the door]
        ->Locked.Kick
        
    - else:
        You enter the room and pick up the {object}. It weighs heavy in your hands. You tighen your grip on the {object}, and return to the door. { - know: Hopeless or not, you need to try.}
        {
            - object == "crowbar": 
                *[Time to get out of here]
                -> Locked.Crowbar
            - object == "screwdriver":
                *[Time to get out of here]
                -> Locked.Screwdriver
            - else:
                *[Time to get out of here]
                -> Locked.Sledgehammer
        }
        
}

= Crowbar
You jam the crowbar in between the door and the wall, at the latch, and pull. 

*[The door groans.]

- #DELAY: 2  
You pull harder, putting all your weight into it. You lean back a bit further and-

#PLAY: crowbar_break #CLASS: Kick #DELAY: 1
Crack!

Half the crowbar is left in your hand. You drop it, but don't hear it hit the ground.

*[The door looks untouched.]
-> Trapped

= Screwdriver
#DELAY: 1.5
You get to work unscrewing the top hindges of the door.

#CLASS: Drop_Screw 0.75 #PLAY: screw_fall_1 
<i>Clink!</i>
#CLASS: Drop_Screw #DELAY: 0.75 #PLAY: screw_fall_2
<i>Clink!</i> 
#CLASS: Drop_Screw #DELAY: 1.5 #PLAY: screw_fall_1
<i>Clink!</i>

#DELAY: 1
The screws fall to the floor. You move to the bottom hindges.

#DELAY: 0.75 #PLAY: screw_fall_2 #CLASS: Drop_Screw
<i>Clink!</i> 
#DELAY: 0.75 #PLAY: screw_fall_1 #CLASS: Drop_Screw
<i>Clink!</i> 
#PLAY: screw_fall_2 #CLASS: Drop_Screw
<i>Clink!</i>

*[That should be the last of them.]

- You grab at the sides and try to lift the door, but it doesn't budge. You frown, and check the hindges. Did you miss one? Even if you did, it should still at least wiggle. 

You check the top.

*[All the screws are intact.]

- "No, no, no, nonononono." You mutter and check the bottom as well.

*[They are all there.]

You drop to the floor, and feel you the screws you heard fall.

You can't find them.
-> Trapped

= Sledgehammer
You lift up the large hammer and begin to smash it into the door.

#PLAY: door_thud #CLASS: Kick
Thud!

*[It's stronger than you anticipated.]


-#PLAY: door_thud #CLASS: Kick
Thud!

*[It's not working...?]

-#PLAY: thud #CLASS: Kick
Thud!

*[The door looks untouched.]
->Trapped

=== Trapped ===
{
    - object == "crowbar": 
        You stop, fall to the floor, and stare at the untouched door in front of you. You let out a short, hysterical laugh that could be mistaken a sob as the realization hits you.
    - object == "screwdriver":
        You stop searching, drop the screwdriver and stare at the untouched door in front of you. You let out a short, hysterical laugh that could be mistaken a sob as the realization hits you.
    - object == "sledgehammer":
        You stop and drop to the floor, sledgehammer falling to your side, and stare at the untouched door in front of you. You let out a short, hysterical laugh that could be mistaken a sob as the realization hits you.
}

*[You are trapped inside.]
~ stay = 1

- You pull your legs to your chest and sit with your back against the door. 

*[<i>You are trapped</i>]

- The thought bounces around you head. <i>You are trapped.</i>

{

    - leg == "worst":
        Your leg is throbbing from attempting to kick in the door. You hope you didn't sprain anything.
    - leg == "pain":
        Your leg aches from attempting to kick in the door.
    - leg == "hurt": Your leg is sore from attempting to kick in the door.
}

You can barely see, not a single drop of light shines through the windows. Your eyes have mostly adjusted, but not enough to make out meaningful details. You can't get out the way you came in, but there might be another way out.

//Click replace with new text
{
    - know == false:
    *[(Wait until morning) Remember]
        ->Trapped.Remember
    *[(Look for a different exit) Remember]
        ->Trapped.Remember
    *[(Accept the Church) Remember]
        ->Trapped.Remember
 - else:
    *[Wait until morning]
        ~ temp_bool = false
        ->Trapped.Wait_Morning
    *[Look for a different exit]
        ~ temp_bool = true
        ->Trapped.Wait_Morning
    *[Accept the Church]
        ->Trapped.Accept
}


= Remember
You pull the polaroid out from your pocket, hoping to think about better times. It's dark, but you can see enough to make out shapes. You trace the image of your younger self, and the gate behind them with your finger, then the church behind-

Church? 

*[Your mouth goes dry.]

- The image is different. It has changed. Insead of a comforting memory, it has morphed into one you don't know. Something that tickles the back of your brain, but you don't know why.

*[You grip the picture tightly in your hands.]

- The image isn't fake, somehow you know this. The church always felt {feeling} in a way you didn't understand why.

The memory refuses to surface, only vague images and feelings. If you close your eyes... You're scared. You're trapped. You're... inside? Inside where-?

Your nails peirce through the image, and your knuckles turn white. Your hands shake as you try to remember when- 

<i>Riiiiipppppp</i>
~ photo_ripped = true
The image rips in half.

And it all clicks into place. 

*[You have been here before.]

- <i>Riiiiipppppp</i>

You don't know how you could have forgotten. How you didn't realize it before. 

<i>Riiiiipppppp</i>

You have been here before. You found... something- No. Someone? You can't remember, but <i>you got out.</i>

<i>Riiiiipppppp</i>

There is a way out.

<i>Riiiiipppppp</i>

*[You just need to figure out how.]

- You blink rapidly, shaking yourself out of the memory, and look down at what's left of the image in your hand. Tiny pieces sit in a pile on the ground in front of you. Did you...?

You swallow the lump in your throat and carefully pick up pieces, ensuring you get every little piece. You delicately place them back in your pocket. Once you're out of here, you can fix it.

#TEXTBOX: text_container_UsedTo
It's still dark, but your eyes have adjusted a bit more. You can't get out the way you came in, but there might be another way out.

*[Wait until morning]
    ~ temp_bool = false
    ->Trapped.Wait_Morning
*[Look for a different exit]
    ~ temp_bool = true
    ->Trapped.Wait_Morning

*[Accept the Church]
->Trapped.Accept

= Accept
It was a simple thought. The only things you know are that you found something when you were young, and you escaped. 

A fleeting memory won't help you now. 

*[What if you accept it?]

- A low hum echos through the room, and a chill runs through you at the sudden sound. That's what the church wants but...

*[What's wrong with that?]

*[You can't let the church win]
-> Trapped.Refuse

- Why are you even trying to fight back? What has the church actually done to harm you? What are you trying to get back to? 

Maybe... Maybe you are supposed to be here.

The air around you grows a little warmer. 
~ trapped_reject = true
*[It's comfortable.]

*[The air smells sour.]
-> Trapped.Refuse

- ~ stay += 0.5
A light melody begins to play. A lullaby, you think. It was a comfort when you were young and alone. 

You hum along to it.

*[Is it really so <i>bad</i> to stay here?]

*[Why would you <i>want</i> to stay here?]
-> Trapped.Refuse

-
#ENDING: Why Shouldn't I stay?
Your eyelids grow heavy, and you think you understand why the church released you the first time. You were too young before, but you know better now. 

*[The church offers solace.]
-> Endings.Bad_End_1

= Refuse
{
    - stay >= 1.5:
    #PLAY: groaning_angry, true #STOP: groaning_angry, 2
    The melody harshly cuts out.

}
No. You rub your eyes. No. You can't stay. The church didn't just <i>let</i> you out last time. It did so for this moment. For after you let your guard down. 

You can't stay here. You can't get out the way you came in, but there might be another way out.

*[Wait until morning]
~ temp_bool = false

*[Look for a different exit]
~ temp_bool = true

- ->Trapped.Wait_Morning

= Wait_Morning

{
    - temp_bool:
        You attempt to stand, but your legs are like jelly, and you fall back to the floor. <>
}

 Everything suddenly hits you at once, and you realize how exhauseted you are. You can barely see anything. <>
 
 { 
    - object != "": You only found the {object} because the church wanted you to. 
 } { - !temp_bool: You think you should wait until there's some light- any light. } { - temp_bool: You think you should look around after regaining your strength. You don't want to stay in the church any longer than you need to, but pushing past your limits won't help you escape. } 

You rest your head on your knees.

*[Try to sleep]
~ sleep = "sleep"
You probably shouldn't, but it's the quickest way to pass time. And maybe your subconscious will remind you of things your conscious forgot. Or something your concious doesn't want to remember.

*[Stay awake]
~ sleep = "stay awake"
You refuse to sleep, and dig your nails into your arm. 

- 
{
    - sleep == "sleep":
        *[Go to sleep]
        -> Trapped.Lullaby
    - else:
        *[The slight pain will keep you aware.]
        -> Trapped.Lullaby
}

= Lullaby
-
{ 
    - stay >= 1.5: 
        ~ temp_string = "The hauntingly familiar melody starts again, and the room warms up." 
    - stay < 1.5: 
        ~ temp_string = "A light melody begins to play, and the room warms up. The lullaby is... familiar." 
}

You try to {sleep}. {temp_string} But it's... different than <>
{
    - stay >= 1.5: earlier.
    - else: you remember.
}

*[Listen closer]
-> Trapped.Listen

*[Ignore it]
-> Trapped.Ignore

= Listen
You focus on the sound underneath. You hear... words? Whispers?

*[Call out]

*[Continue listening]
You try to focus harder. You can just barely make it out.

"You... came back. Why... Why did you come back...?" over and over again.

- You slowly stand and look around for the source, taking a few steps into the church. You open your mouth, but before any words can leave your lips, cold, unseen hands covers your mouth. You freeze.

"Don't," is whispered into your ear, a woman's voice.

*[Nod]

*[Try to remove the hands]
You claw at your mouth, attempting to grab hands silencing you, and stand up. "Let GO!" 

"You don't... remember..." The hands fall away, and the room goes still. "This is all I can do."

The hands fall away. The voice goies quiet. A red light glows from above you.
-> Trapped.Light

- "Look up." The hands removes themselves from your mouth, and rest on your shoulder. You look where the voice told you to. The window above the door has morphed into a stained glass eye. It's pupil darts around, looking for something. "It looks for you."

You look back down, and the hands disappear behind you. You can feel something cold hovering near you.

You have so many questions.

*["What IS that?"]

*["Who, or what, are you?"]

*["How do I get out?"]

- The voice does not answer, but you know it's still there. You can feel it hovering by your ear.

"This is all I can do for you now. The rest is up to you."

Wind blows around you, and before you stop yourself you call out.

*["Wait!"]

*["The rest? What-!"]

- The room turns still. Silent. A red light glows from above you.
-> Trapped.Light

= Ignore
You pay it no attention. { sleep == "sleep": It is helping you to fall asleep.} { sleep != "sleep":It's comforting, but idlely listening will only make you more tired.}

It's a soothing sound, but there's something else there, just underneath, that you can't make out.

*[Listen closer]
-> Trapped.Listen

*[Ignore it]

- { 

    - sleep == "sleep": 
        That doesn't matter. The only thing that matters is this lullaby. It's so...
    - else:
        You don't want to admit it, but the sound comforts you in a way you can't describe. It's... reassuring... 
        And against your better judgement...
}

*[You fall asleep.]

- #ENDING: Sleeping Forever

*[But you don't wake up.]
->END_DEMO

= Light
*[Look at the light.]
- 
#Effect: glow
The light comes from the window above the door. The stained glass eye staring down at you.

You stagger backward, deeper into the church, an intense pressure pressing down on you. Your chest tightens, and your limbs fill with static. The air becomes heavier. Your mouth goes dry.

You feel...

*[Relief]
~ light_feeling = "relief"

*[Worry]
~ light_feeling = "worry"

*[Confused]
~ light_feeling = "confused"

- The back of your throat goes tight as you hold back tears, but you don't know why. 

{

    - light_feeling == "relief":
        Is some part of you... happy to be back? Reassured to be back in a place like this? Comforted to be bathed in this light?
    - light_feeling == "confused":
        Too many emotions you can't identify are swirling inside you. You know you need to escape this light, but you want to stay for just a bit longer. 
    - light_feeling == "worry":
        Something is wrong. Logically, you know you should feel something negative. Fear. Panic. Alarm. But the most you can muster up is worry. Worry that you will never be bathed in this light again.

}

*[But you don't want to feel like this.]
~temp_bool = true
~leave_light = true

*[But you are not ready to leave.]
~temp_bool = false
~leave_light = false

- 

{
    - light_feeling == "confused":
        ~temp_string = "confusion is the only thing you can trust."
        
    - light_feeling == "relief":
        ~temp_string = "relief is wrong."
        
    - light_feeling != "confused" and feeling != "relief":
        ~temp_string = "worry is a flag that something is very <i>wrong.</i>"
}

{

    - leave_light:
        ~ temp_bool = true
        ~ church_anger += 1
        ~ stay -= 0.5
        #DELAY: 6.5
        You take a heavy step back and pull away from the light. This feeling of { temp_string } This much you know. This much you trust. The rest is the church.
        
        #PLAY: screeching CLASS: Angry-Screeching
        An earsplitting shriek pierces through the building. You cover your ears, but it only gets louder and luder the more you block it out. The pressure builds until you can barely stand, the warm bath of the light burns your skin. 
        
        *[You can barely stand it.]
        -> Trapped.Light_Leave
        
    - else:
        #PLAY: groaning_happy, false, 0.25 #STOP: groaning_happy, 1.5
        ~ temp_bool = false
        ~ stay += 1
        A satisfied groan reverberates through the building. Slowly, the eye closes, and the red light with it. 

{
    - light_feeling == "confused":
        ~temp_string = "confused emotions go"
    - else:
        ~temp_string = "{light_feeling} goes"
}

        "N-no!" you scramble forward, chasing the last licks of the light before its gone. The pressure alleviates, and all the { temp_string } with it. The window returns to it's normal, swirling state. 

        With the light gone, you snap back to reality. "Why did I...?" you mutter to yourself. You dig your nails into your hand.


}

=Light_Leave
{ 
    - light_feeling == "confused":
        ~ temp_string = "confused emotions go"
    - else:
        ~ temp_string = "{light_feeling} goes"
}

    #STOP: screeching
    Just as suddenly as it all started, it stops. The eye snaps closed, and the red light disappears with it. The window returns to it's normal, swirling state. 

    The pressure alleviates, the burning stops, and all the { temp_string } with it.

    You dig your nails into your hand.

    *[Turn away from the window]
        ~ temp_bool = false
        -> Inside

=== Inside ===
On the ground in front of you sits a flashlight and a note.

*[Pick up the flashlight]
->Inside.Flashlight

*[Read the note]

- The paper feels thin. It's too dark to read.

*[Pick up the flashlight]
->Inside.Flashlight

= Flashlight
~ lanturn =  true
It looks battery operated, and gives off enough light to see around you. You should be able to explore with this.

*[Read the note]
->Inside.Note

= Note
#PLAY: flashlight_on #EFFECT: flashlight
The note is from an old piece of parchment. It feels like it could crumple into dust.

"Find the heart and destroy it.<br><br>The church will try to stop you.<br><br>It will do anything to keep you here. Stay out of it's sight.<br><br>Do not become it's next meal."

*[Meal...?]
#TEXTBOX: text_container_After
You shutter at the thought. You wonder how long you have until it fully digests you.

*[Sight...?]
#TEXTBOX: text_container_After
{ 
    - temp_bool_2:
        ~ temp_string = "How you had to pull yourself out."
    - else:
        ~ temp_string = "How you would have done anything to stay there a little longer."
}
Well.... You glance up at the swirling window.

You remember how the church's sight warped your thoughts and reasoning. { temp_string } You cannot let that happen again. If the church sees you again...

*[Heart...?]
#TEXTBOX: text_container_After
<i>Find and destroy the heart.</i> You think about what the "heart" of the church would be. A sacred artifact or...?

- 
*[You try not to think too hard about it.]

- 
{ 
    - object != "":
        ~ temp_string = ", which you know has a small office to the right"
    - else:
        ~ temp_string = ""
}


The flashlight gives off enough light for you to see what's near you. You can make out a podium facing some pews, a confessional off to the side, and a some stairs leading up into a longer hallway{temp_string}.

#CHECKPOINT: 2, You are told to find the heart.
You have a goal now. <i>Find and destroy the heart.</i> You don't know where the "heart" of the church is, but if you have to guess it would be....


*[In the confessional]
-> Confessional

*[Somewhere up the stairs]
-> Stairs

= Look_For_Heart
You have a goal now. <i>Find and destroy the heart.</i> You don't know where the "heart" of the church is, but if you have to guess it would be....

*[In the confessional]
-> Confessional

*[Somewhere up the stairs]
-> Stairs

=== Stairs ===
{
    - leg == "worst":
        ~temp_string = "limp up"
    - else:
        ~temp_string = "climb"
}
{ - !room:
        You {temp_string} the short set of stairs, and notice a door over the last few steps, rather than at the top of the landing. The hall extends to another set of stairs that go both up and down. 
    
    - else: 
        You {temp_string} the short set of stairs.The office door is still there, however, in a different place. Rather than it being at the end of the hall, it sits on wall adjacent to the stairs, hovering over the last few. The hall extends to another set of stairs that go both up and down. 
    
        This was not there last time you were here.
}

*[Examine the stairs]
-> Stairs.Examine_Stairs

*[Enter the office]
->Stairs.Office

*[Return to the main body of the church]
->Inside.Look_For_Heart

= Office
~ temp_bool_3 = true
You try the door only to find it locked.

*[Return to the main body of the church]
->Inside.Look_For_Heart

*[Examine the stairs]
-> Stairs.Examine_Stairs

= Examine_Stairs
You walk deeper down the hallway to the stairs. Going up, is a spiral staircase. Going down, is a long set of stairs. You can't see the end of either.

* { temp_bool_3 == false} [Go back to the office] ->Stairs.Office

*[Return to the main body of the church]
->Inside.Look_For_Heart

*[Go upstairs]
    ->Stairs.Upstairs
    
*[Go downstairs]
    ->Stairs.Downstairs

////////// STAIRS INTERACTIONS ////////// 

= Downstairs
~ temp_bool = false

{
    - went_downstairs == 0:
        #PLAY: flashlight_on
        You approach the stairs shine your flashlight down. The walls on either side of the stairs are smooth, but damp. You cannot see the bottom. You take one step down, and deep groan wells up from below.

        You tense, every fiber of your being telling you to not continue down.
    - else:
        #PLAY: flashlight_on
        You approach the stairs again, and swallow. A feeling in your gut is telling you not to go down and further.
}

~ went_downstairs = 1

*[Continue down]

*[Turn back]
    You turn back up the stairs. It doesn't feel right.
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
    You hurry back up the stairs, glancing over your shoulder as you do.
    ->Stairs.Turn_Back
- 

{
    - leg == "worst":
        ~temp_string = "You grab the railing with both hands,"
    - else:
        ~temp_string = "You grab the railing to steady yourself,"
}

~ went_downstairs = 2

About halfway down the steps, the smell of rot hits your nose, so strong you gag. {temp_string} and retch. The stench is unbareable. 

It smells of old, rotten meat left in the sun. Of putrid sour milk left out for too long. Of rancid fruit left to liquify in the fridge.

You cover your face with your shirt, and breathe through your mouth, but the pungent smell clings to you. 

*[Keep moving]

*[Turn back]
    You stumble back up the stairs to the hall, and take a deep refreshing breath of the clean air. Luckily, the smell doesn't seem to have stuck to your clothing.
    ->Stairs.Turn_Back
    
- You plug your nose and keep going, only stopping to dry heave. It isn't long before the steps change from wood to... to something you can't comprehend. You stop and shine the light. 

#CYCLE: Fidget, mold, fungus, flesh
The rest of the stairs are covered in pink, bulbous... flesh? You shake your head. It has to be some sort of mold or fungus. You poke the next step with your foot, and the @ shivers in response. 

You shine your light to the end of the staircase, and see a door at the end of the stairs. Walls and ceiling covered in the same disgusing substance.

*[See what's behind the door]

*[Turn. Back.]
    ~ went_downstairs = 3
    #PLAY: flashlight_off
    Without a second thought, you rush back up the stairs to the hall. You take a deep refreshing breath of the clean air at the top, and try to make sense of what you just saw. 

    The flesh, it- it <i>reacted</i> to your touch. Your skin crawls at the thought. You don't think you should go back down there.
    ->Stairs.Turn_Back

- 
#PLAY: footsteps_squishy, true, 1
<i>You've made it this far, might as well see it it toward the end,</i> you think, and take a deep breath through your mouth. Slowly, you make it to the bottom of the stairs.

<i>Squish</i>

#stop: footsteps_squishy, 0, 3
The tissue is soft under your shoes, making a soft, wet sound with each step. A thick ooze sticks to the bottom of your shoes.

<i>Squelch</i>

*[Open the door]

- The door opens, and you are assulted by the smell. Your eyes water and you clamp your hand over your nose and mouth. You take a few steps inside, trying to see what's the cause of this god awful smell.

The room is covered in the pink, buldging flesh, thick ooze drips from the ceiling. You pan your flash light around. The room is filled with furniture covered in tarps.

*[Find the source of the smell]

*[Investigate the ooze]
    #DELAY: 1.5
    You walk deeper into the room, deeper into the maze, and approach a place where the ooze consistantly falls from the ceiling. You stick the end of the flashlight into the small pool of it. It's sticky and slippery, much more slime like than ooze.
    
    #EFFECT: flashlight-flicker #PLAY: flashlight_on #PLAY: 1, flashlight_off #PLAY: 1, flashlight_on #PLAY: 1, flashlight_off
    The flashlight flickers, and turns offs. You hit it against the palm of your hand, trying to get it to turn back on, the slime getting on you in the process.
    ->Stairs.Melt

- You walk deeper into the room. It is a maze of old furniture. Most of it is normal, chairs, tables. Some of the shapes confuse you. Some are too tall, or too wide to be anything recognizeable. 

You pass by what you assume is a standing coat hanger, and stare at it. It is taller than you, and has multiple edges jutting out from it. You reach out to lift the canvas covering it, but stop just before touching it. 

You're not sure why, but you retract your hand. You stare at the coat hanger a little longer before conitnuing on.

*[You don't check under any of the tarps.]

- You continue deeper into the room, the smell getting stronger with each step. You pray that the smell won't linger after you leave, and follow your nose to the source.

You find yourself in the far back corner, a tarp partially covering something scattered over the floor. It come us to about your chest, a stacked pile of... something. Firewood? But you don't remember seeing a fireplace upstairs...

Near the edge of the tarp you see scraps of wet cloth and... Is that... bone...? You swallow the lump in your throat.

*[Lift the tarp]

- #PLAY: flashlight_off #EFFECT: flashlight-gone
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

- You can't breathe.

#CLASS: Blur
Your skin burns.

You can't think. Bone? How-? 

#CLASS: Blur
Your skin burns.

Your head swims. This can't be-

#CLASS: Blur
Your skin burns.

You can't get enough air in. Is this actually slime-?

*[Your skin burns.]

- 
#ENDING: Melted
You keep going, desperatly trying to escape. 

#CLASS: Blur
You can't feel your hand anymore.

You trip over yourself, and fall into puddle of the acidic ooze. 

#CLASS: Blur
You can't feel your legs.

*[You can't feel anything.]
-> END_DEMO

= Turn_Back
*[Go upstairs]
->Stairs.Upstairs

* { temp_bool_3 == false} [Enter the office.] ->Stairs.Office

*[Return to the main body of the church]
->Inside.Look_For_Heart


////////// UPSTAIRS INTERACTIONS ////////// 

= Upstairs
#PLAY: flashlight_on
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

*[Look closer]

- You walk closer to the door, and tug at the door knob. The door jigles, but doesn't budge. Ther is a small keyhole that red light pours out of.

*[Peak through the key hole]
-> END_DEMO

=== Confessional ===
{
 - !confessional_priest && !confessional_sin:
        You {leg == "worst": carefully} approach the confessional booth. It is a plain, wooden box. The most detail was the lattice work on the door the priest uses to enter and exit. A heavy, dark blue curtain covers the side a sinner would enter to confess.
    - else:
        You approach the confessional booth.
}

{

    - !confessional_priest:
        *[Enter through the door]
        ->Confessional_Door
}
{
    - !confessional_sin:
        *[Enter through the curtain]
        ~temp_bool = false
        ->Confessional_Curtain

}

=== Endings ===

= Bad_End_1
*[You close your eyes, and fall into a void of relief and comfort.]
-> END_DEMO

=== Credits
<h1>Credits</h1><br>Writing, Design and Code<br>Ren<br><br>Artists<br><a  href="https:\/\/www.instagram.com/clouddancing1995/", target="_blank">Sarah M Casas - @CloudDancing1995</a><br><a href="https:\/\/www.instagram.com/ninak_sketch/", target="_blank">Ninakupenda Gaillard - @ninak_sketch </a><br><a href="https:\/\/www.instagram.com/alma_abyss/", target="_blank">Jada Carey - @Alma_Abyss</a><br><br>Sound Design<br>Joe Bretz/ReverbInTheVoid

+ [Start Game] ->Start
+ [Content Warnings] ->Content_Warnings

=== Content_Warnings
<h1>Content Warnings</h1><br><ul><li>Mild gore / dead body descriptions</li><br><li>General Christan/Catholic discomfort</li><br><li>General violence towards player/blood/bodily fluids mention. All through text</li><br><li>Potential child harm/child in distress where player is unable to help</li><br><li>Some demeaning speech yelled at the player from a male character</li></ul>

+ [Start Game] ->Start
+ [Credits] ->Credits

=== END_DEMO
That is the end of the demo, thank you so much for playing! The full version is coming soon. <br><br>  Please rate the game if you enjoyed, it helps a lot, and make sure to add the game to your collection to get any updates!

+ [Restart Game] 
    #RESTART
    ->END












