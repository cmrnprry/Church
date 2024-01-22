INCLUDE Variables.ink
INCLUDE AfterFirstChoice.ink
INCLUDE Confessional_Door.ink
INCLUDE Confessional_Curtain.ink
INCLUDE Pews.ink
INCLUDE Stairs.ink
INCLUDE End_Game.ink

->Start
=== Start ====
There is a church at the end of the street- but there shouldn't be. You saw it when walking home from the bus stop after work. You grew up on this street. You have walked down this road daily. There is not a church at the end of the street.

It was dark when you passed, and you keep telling youself that your tired brain mistook a billboard for a church. They must be building one there.

*It's impossible for a church to spring up overnight.

- You pass by again, on your walk to the bus stop this morning, and stop dead in your tracks. There should not be a church, and yet, there it sits. A "FOR SALE" sign attached to its lawn.

*You don't like it.
*You feel drawn to it.
*You want nothing to do with it

- Your stomach churns.  You shove your hand in your pocket and rub your thumb over the worn polaroid picture inside.

* You quickly cross the street.

- You mess around on your phone, trying to ignore the building. You keep looking up at it, confiriming for yourself that the church is really there. 

It was not there on the walk to the bus stop yesterday, or the day before- you're sure of it. And a new building wouldn't look so... You glance up at it again, and something pulls at the back of your mind.

The church feels...

*Familiar
~feeling = "familiar"

*Uncomfortable
~feeling = "uncomfortable"

*Evocative
~feeling = "evocative"

- It is small, with white paint peeling, revealing sun-bleached brick underneath. It's windows are intact, but everything else is cracked or crumbling. You're surprised the building is still standing.

The bus arrives and you're no closer to understanding this {feeling} church that spontaneously appeared. Your stomach lurches.

*[Get on the bus]
#play: bus-sounds
-> Bus
*[Investigate the church]
-> Investigate

=== Investigate
You pat your pant pockets, pretending that you forgot your pass, and smile sheepishly. The driver rolls her eyes and drives off. It's still early enough where you can just catch the next one. You steel yourself and look back at the church.

*The church windows catch your eye.


-~window = true
The church's windows are of stained glass, which isn't uncommon for it to have. You squint trying to make the image out, but no matter how hard you focus, you can't explain what the glass was a picture of. 

*You take a step forward.

-The image swims in your vision. Just as you think you've got it, it changes. You make a mental note to get your eyes checked.

*You take another step forward.

-#delay: 1.25
Blood starts rushing in your ears and pressure builds behind your eyes as you strain to-

#style: tall #play: honk #delay: 2.5
HOOOOONNNKK!!

#play: bus-sounds
You stumble backwards as the bus swerves, narrowly avoiding you. The driver opens the door and asks if you're alright. You feel youself nodding, heart pounding. A knot forms in your stomach.

*Your eyes don't leave the church.

- You brush off the driver's questions and board the bus.

*[Take a seat]
    You drift to the back of the bus, and sit where you can look at the church through the window.
    -> Bus.Seat
    
*"Do you know when they built that church?"

- The bus driver gives you a look.

"Is that really important right now?" he says. "Are you alright?"

*"So it was here yesterday?"

- You grip his arm as you ask. Your nails dig into his arm and he winces.

"I'm going to need you to let go." He looks [perturbed, afraid, nervous, tense]. "Do I need to call someone?"

Your eyes dart from him to the church behind him and back. You're losing it. Over a building. You need to calm down.

"I'm sorry-" You release the bus driver. "I- I-'m sorry."

*You scurry to the back of the bus.
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
You watch the church through the window until it fades into a dot in the distance. Even after it's gone, you still feel on edge. A part of you wants to call out sick and go back [[home]].

*[home]
    ->Bus.home
*[You want to forget about the church.]
    You fear what what will happen if you can't.
    ->Job

= home
You watch the church through the window until it fades into a dot in the distance. Even after it's gone, you still feel on edge. A part of you wants to call out sick and go back to the church. It's waiting for you

*[You <i>need</i> to forget about the church.]
    You fear what what will happen if you can't.
    ->Job

=== Job ===
#play: office-sounds
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
*Maybe the monotony will take your mind off things.

- #play: scanning
You enter a rhythm of placing a page, entering an email, and sending it off. You try to focus on only your actions to prevent your mind from wandering. 

Place page. Enter email. Send it off. Place page. Enter email. Send it off. Place page. Enter email. Send it off. Place page. Enter email. Send it off. Place-

*"Hey- What are you doing?"

- #stop: scanning, 3
You jump and look up to see a coworker from your departmenr. You don't talk to her often, but she's nice enough. She looks... concerned?

*"Just sending out some scans."

*"Busy work until the next meeting. You know how it is."

*"Trying to keep busy."

- She nods slowly, and picks up one of the papers from your done pile. "And... _this_ is what you're sending?"

"Yeah, Marketing needed-"

She cuts you off as she starts to read off what's on the page. "'Do you know about the church at the end of the street?" 

The hairs on the back of your neck stand up.

*_No_

- "The church at the end of the street knows me but I don't know it." She continues. Your chest tightens, and you frantically go through the rest of the papers. You know these were marketing reports. "It waits and waits for me to come back. It has gotten impatient."

All the papers repeat what you coworker said. Over and over again. All in handwriting. _Your_ handwriting. You clutch the papers tightly, until your knuckles go white and your nails pierce through. _When did they change?_

"Did you write this?" She purses her lips at you. "Is this your idea of a bad joke?"

*"I'm going home early today."

*"I'm going to work from home for the rest of the day."

*Say nothing and leave.

- ->Walk_Home

= Emails
#play: ding
You pull up your email and scroll through the new ones, only reading the subject lines for anything important. Meeting invitation, spam, spam, client question, church inquiry, meeting- Wait. Church inquiry?

*[Open church inquiry email]
-> Job.Open
*[Delete the email]
-> Job.Delete

= Delete
#delay: 1
You quickly delete the "church inquiry" email, and go to reply to the client. 

#play: ding #delay: 2.75
Another email with the same subject. You don't think and delete it again.
#play: ding
But yet another takes it's place.

*[Delete it again]
-> Job.Delete_Again
*[Ignore it and reply to the client]

- You mark the church email as spam and respond to the client, making sure to CC the correct person they should speak to. You close your email and rub your eyes with the palm of your hands. 

<i>Stop thinking about it.</i> You tell yourself. <i>It's nothing but a church, so why-</i>

#delay: 6 #play: knock-knock
"Knock knock, can I talk to you?" You look up to see your supervisor at your door, holding a few sheets of paper. They look upset.
~ work = 2

*"Yeah, come in."
    They enter, and close the door, "I'll be quick. Can you explain what your last email meant?" They sound frustrated. "Is it a joke? A prank?"

*"Now's not a good time."
    "Right..." they say, and enter anyway. "Can you explain what your last email meant? Our client is not happy."

- 

*"What?"

*"They sent the email to the wrong department so..."

- They roll their eyes and drop the papers on your desk. "You're about to lose us our best client!" You pick them up, and your stomach drops. In your hands is are print outs of emails from you to a client. They all say the same text over and over again:

"Do you know about the church at the end of the street? The church at the end of the street knows me but I don't know it. It waits and waits for me to come back. It has gotten impatient."

"Do you understand how this can hurt sales?" They hiss. You clutch the papers until your knuckles go white, and your nails pierce through. "You'd be _lucky_ if I only suspend you for this!"

*"I'm going home early today."

*"I'm going to work from home for the rest of the day."

*Say nothing and leave.

- ->Walk_Home

= Delete_Again
#delay: 0.5
As you click the button to delete the email- <>

#play: ding #play: 0.25, ding #play: 0.25, ding #play: 0.25, ding #delay: 1.5
you get a flurry of new emails. "Church Inquiry. It's waiting. It's impatient. Hurry up. Hurry up. Hurry up."

#play: ding #play: 0.25, ding #play: 0.25, ding #play: 0.25, ding
You try to delete them, but they just keep coming. "Where are you?" "Come home." "(No Subject. Image Attached)."

*[Open Email]
~ know = true
You give in, and click the latest email.
-> Job.Open

*[Continue Deleting]

- #play: ding #play: 0.25, ding #play: 0.25, ding #play: 0.25, ding #delay: 0.5
You can't delete them fast enough.

#play: ding #play: 0.25, ding #play: 0.25, ding #play: 0.25, ding #delay: 0.5
They just keep coming. You try to-

"Hey are you-" A hand grabs your shoulder, and you jump up from your chair, slaping the hand away. 

"Leave me ALONE!" you shout, breathing heavy.

"What's your problem?!" You realize all too late that this was not the church, but your coworker. You stumble over yourself trying to appologize. "We all have rought days but.... What the hell?!"
~work = 3

*"I'm- I'm going home early."

*Say nothing and leave.

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

*"Everything... Okay...? In here?"

- It's your coworker. You wave him away, and focus. You escaped. It wants you back. You can see the door opening, but the younger you didn't feel relief. No, they felt... afraid? Why...? You got out so why-

Your coworker grabs your sholder, "Hey what's-" You jump up from your chair and smack his hand away. You lean on the wall to support yourself, breathing heavy. "What's your problem?!"

Your coworker stares at you, waiting for an answer. You shove your hand into your pocket, searching for the poleroid inside, hoping to calm yourself.

"No no no, where...?" You franticly searching every pocket, only to find it all empty. You look to your desk and find small, ripped pieces of a once comforting memory. "Did I...?"

"Seriously, what's up with you?!" You gather the pieces in your hands, and begin trying to tape them together, but the pieces are too small. You swallow the lump in your throat, and face your coworker. "Uhhh... You alright?"
~ photo_ripped = true
*"I'm- I'm going home early."

*Say nothing and leave.

- ->Walk_Home

=== Walk_Home ===
#stop: office-sounds 10

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

The bus ride home is shorter than it's ever been. You get off at your regular stop.
#stop: office-sounds
The church is still there.

*[Take a different path home]
->Walk_Home.Different

*[Take the usual path home]
Tentatively, you walk your usual path home, and try not to look at the church.
->Walk_Home.Usual

= Different
~turn = "walking"
~avoid = true

You get off at the same bus stop you normally do. You don't look at the church, and instead turn around and walk up the block. A burning creeps up the back of your neck, almost as if someone is staring you down.
*[Turn around]
->Walk_Home.Turn_Around

*[Walk faster]

- 
#play: walking-quickly, 1
You shove your hand in your pocket and pick up the pace. The corner where you need to turn is so close. The burning sensation grows, and something grabs at your legs. The wind picks up around you.

*[Turn around]
->Walk_Home.Turn_Around

*[Go faster]

- 
~turn = "running"
#stop: walking-quickly, 0.5 #play: running-stop, 1
You break out into a run. You can almost touch the stop sign on the corner. How have you not reached it yet? The burning sensation lessens, replaced with lead weights at your ankles. Your chest feels heavy, like someone has their arms wrapped tightly around you.

You hear something on the wind. A voice?

*[Turn. Around.]
->Walk_Home.Turn_Around

*[Almost. There.]

- #stop: running-stop
    You reach out and grab the sign with both hands. The burning is gone. Nothing holds you back. Breathing heavily, you smile and look up at the [stop sign.]
    
*[ignore]
->Stop_Sign

= Turn_Around
#stop: running-stop #stop: walking-quickly
You stop {turn}, and face the church. All sensations stop. There is nothing strange about the church. It's dark. It's quiet. 

It's just another building.

{
    - know:
        But you know it's more than that.
    - else:
        You take a breath, and reach into your pocket. The feeling of the worn poleroid calms you. You're being unreasonable. It's just a building. Just a church. A {feeling} church.
}

*[Continue walking the long way home]

*[Take your usual path]
    { - know: You know you shouldn't, but you can't stop yourself.} You try not to look at the church as you walk past. 
    ->Walk_Home.Usual
    
- 

{
    - know:
        It wants you back, but you refuse to let it have you.
    - else:
        You decide to continue the long way home, hoping the fresh air will ease your mind.
}

As soon as you start walking again, the burning sensation flares up again, ten times worse than before, bleeding down your back. 

*[Ignore it]

*[Turn back]
You stop in your tracks and ball your hands into fists. You spin around to find yourself at the front of the church. Your hands tightly grip the front gates.
->Walk_Home.Stop_Sign

-
#play: walking-quickly, 1
You ignore it, and keep going. Each step feels like wading through thick jelly. You can almost touch the stop sign on the corner.

*[Almost. There.]

- #stop: walking-quickly #stop: running-stop
    You reach out and grab the sign with both hands. The burning is gone. Nothing holds you back. Breathing heavily, you smile and look up at the [stop sign.]
    
*[ignore]
    You reach out and grab the stop sign with both hands. The burning is gone. Nothing holds you back. Breathing heavily, you smile and look up at the church.
->Stop_Sign

= Stop_Sign
It looms over you, taller than you remember. Your hands tightly grip the front gates. The door is open. 

But how did it...? You were at...?

*[Open the gates]
#play: gate-open
You throw the gates open, and the edges of the dirt path to the church brighten, small lights lining the path. Motion activated maybe?

*[Let go]
#play: gate-open
You pull your hands from the gate and take a step back. The gate groans as it opens. The edges of the dirt path to the church brighten, small lights lining the path. Motion activated maybe?
- 

*[Take a closer look]

- You take a step onto the property. The ground is soft, but firm. You crouch down in front of the closest light. They have tiny solar panels on the top.

In this crouched position, the lawn is at eye level, but not a single weed crosses onto the soft dirt.

You stand up and trace the path with your eyes, looking for anything that disturbs it.

*[Walk up the path]
->Walk_Up_Path

= Usual

#play: gate-open
As you pass the front gate, it creaks open. You reach for the image in your pocket. 

{- know: You should keep moving.}

*[Investigate]

//On mouse click, change to "investigate
*[<Continue walking home> Investigate]

- Against your better judgement, you stop, and look at the church. The gate is open.
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

*[Walk up the path]
->Walk_Up_Path

= Lost
You take a few steps before stopping, and looking back at the open gate. You want to go home. You do. But something tells you to close the gate before you do...

*What if a kid gets lost? 
~ temp_bool = true
#play: child-running #stop: child-running 3
No sooner than you think it, you hear the sound of little feet and laugher carried on the wind. 

*Or an animal gets trapped.
~ temp_bool = false
#play: meow
No sooner than you think it, you hear the sound of growling and meowing on the property. 

- 
{ - know:It's the church. You know it's the church. It has to be, but what if- }

{ 
    -temp_bool:
    A child might be in there. You should get them out.
        *"Hey, this isn't a place to play!"
        -> Walk_Home.Close

        *"That's tresspassing, come on out now."
        -> Walk_Home.Close
    - else:
        A cat might be in there, and from the sound of it, in trouble. You should get them out.
        *"Pspspspspsps, here kitty kitty kitty."
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
#play: player-walking
*You take one step forward.

- 
*And keep walking.

-
#play: spooky-walking
*And walking.

-{- know: You're moving automatically. You want to go home. }

Around halfway up the path, you hear another set of footsteps.

The church door is open and inviting. You can't see inside. 

*[Stop]
~ temp_bool = true

*[Walk faster]
~ temp_bool = false
->Walk_Up_Path.Run

- #stop: player-walking, 0.5 #stop: 1, spooky-walking
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

*You walk to the gate.

- You grab the gate with both hands, and look up at the church one last time. It's quiet and dark. { - know: It lost. }

*Pull the gate closed.

- #play: gate-closed
Just as it slams shut, everything goes dark...

*[Wait for your eyes adjust]
#delay: 1.5
You hold your eyes closed and count to five.

#delay: 1
One.
#delay: 1
Two.
#delay: 1
Three.
#delay: 1
Four.
#delay: 1.25
Five.
You open your eyes, and slowly start to make out your surroundings. In front of you is an old wooden door, and not a metal fence.

*[Try to open the gate.]
You blindly feel for the latch of the gate, but instead of cool metal your hands meet damp wood, and eventually a knob. 

- Somehow you are inside the church.

#play: lock-rattle
You try the knob.

*It's locked.
-> Locked

= Run
#play: player-walking #play:spooky-walking
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

- #stop: player-walking #stop: 1, spooky-walking #play: 0.5, door-slam #delay: 2
You fall into the dark church. You quickly regain your balance, grab the door and slam it closed. You throw your full body weight against it, hoping to hold back whoever was chasing you.

#play: banging-short #style: rumble, tall #delay: 1
BANG BANG BANG

Whoever was out there is slamming themselves into the door. It takes all your strength to keep them from getting in.

*"GO AWAY"
~ temp_bool = false

*[Stay silent]
~ temp_bool = true

- 
{ 
    - temp_bool:
        #delay: 1
        You wait, saying nothing. 

        #play: banging-short #style: rumble, tall
        BANG BANG BANG

        #delay: 1.5
        They can't keep this up forever.

        #play:banging-short #style: rumble, tall
        BANG BANG BANG
        
    - else:
        #delay: 1
        "I DON'T HAVE ANY MONEY!" 
    
        #play:banging-short #style: rumble, tall
        BANG BANG BANG
    
        #delay: 1
        "I DON'T HAVE ANYTHING!"
    
        #play:banging-short #style: rumble, tall
        BANG BANG BANG
}

*[Wait]

- You don't know how long you sit there, holding the door closed, body braced against it. Eventually the banging stops, but you wait longer, just in case.

When you feel safe again, you try to open the knob.

*It's locked.
->Locked

=== Locked ===
Locked? { -know: The blood drains from your face as you realize what you've done.}

#play: lock-rattle
You jiggle the handle again. 

*The door won't budge.

- You don't understand. It can't be locked. { -know != true:Maybe it got jammed?}

*[Look around for something to pry open the door]
->Locked.Look

*[Kick in the door]
->Locked.Kick

= Kick
You size up the door and kick at the latch.

#style: shudder #play: thud
Thud!

The door shutters, but stands firm.

*[Again.]

*[Stop.]
You stop, fall to the floor, and stare at the untouched door in front of you. Your leg throbs from effort. You let out a short, hysterical laugh that could be mistaken a sob as the realization hits you.
->Trapped

- ~ leg = "hurt"
You kick again in the same place.

#style: shudder #play: thud
Thud!

*How is the door this strong...?

- #style: shudder #play: thud
Thud!

The door still stands.

*[Again.]

*[Stop.]
You stop, fall to the floor, and stare at the untouched door in front of you. Your leg throbs from effort. You let out a short, hysterical laugh that could be mistaken a sob as the realization hits you.
->Trapped

- ~ leg = "pain"
You keep kicking at it. You breathing starts to get heavy and your leg aches. It feels as if you are hitting steel.

#style: shudder #play: thud
Thud!

*You want to leave.

- #style: shudder #play: thud
Thud!

The door shows no signs of breaking.

*[Again.]

*[Stop.]
You stop, fall to the floor, and stare at the untouched door in front of you. Your leg throbs from effort. You let out a short, hysterical laugh that could be mistaken a sob as the realization hits you.
->Trapped

- ~ leg = "worst"
Something in you allows you to keep going, even as your leg throbs and it feels like you can barely take in anymore air. 

#style: shudder #play: thud
Thud!

*You need to get out.

- #style: shudder #play: thud
Thud!

*Evey fiber of your being is telling you to get _out._

- #style: shudder #play: thud
Thud!

*But the church will not let you.

- #style: shudder #play: thud
Thud!

*The door does not move.
You stop, fall to the floor, and stare at the untouched door in front of you. Your leg throbs from effort. You let out a short, hysterical laugh that could be mistaken a sob as the realization hits you.
->Trapped

= Look
It's dark, but you can make out vague shapes.

{ 
- know != true: You quickly glance around the church. It's small, but seemingly abandonded. There must be something that was left behind by preivous squatters or looters. 

- else: You know it's useless, but fear overtakes the rational part of your brain. There has to be SOMETHING.
}

You look everywhere, arms outstretched, blindly feeling around your surroundings. On and under what you imagine are pews, the floor, past the curtain? Into a... cupboard? Closet? As you search, you get the feeling of deja vu. You've done this before.

*[Nothing.]

- You go further into the church, up a few steps, feeling the walls as you do, and find a closed door at the end of the hall. It might have what you're looking for.

*You hope for a crowbar.
~ object = "crowbar"

*You hope for a screwdriver.
~ object = "screwdriver"

*You hope for a sledgehammer.
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

You open the door to find a side office, entirely covered in dust and cobwebs. The adjacent walls were book shelfs full of books. The far wall has a desk with a stained glass window above it. You avoid looking at the window.

On the desk sits a {object}, illuminated by a red spotlight from the window. It's not covered in dust like rest of the room, as if it has been placed there just for you.

~ room += 1

*[Pick up the {object}.]
~ temp_bool = false

*[Leave it.]
~ temp_bool = true

- 

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

*The door groans.

- #delay: 2  
You pull harder, putting all your weight into it. You lean back a bit further and-

#play: crowbar-snap #style: shudder, 0.5 #delay: 1
Crack!

Half the crowbar is left in your hand. You drop it, but don't hear it hit the ground.

*The door looks untouched.
-> Trapped

= Screwdriver
#delay: 1.5
You get to work unscrewing the top hindges of the door.

#delay: 0.5 #play:clink-1 #style: slide-down
_Clink!_
#delay: 0.5 #play:clink-2 #style: slide-down
_Clink!_ 
#delay: 1.5 #play:clink-1 #style: slide-down
_Clink!_

#delay: 1
The screws fall to the floor. You move to the bottom hindges.

#delay: 0.5 #play:clink-2 #style: slide-down
_Clink!_ 
#delay: 0.5 #play:clink-1 #style: slide-down
_Clink!_ 
#delay: 1.5 #play:clink-2 #style: slide-down
_Clink!_

*That should be the last of them.

- You grab at the sides and try to lift the door, but it doesn't budge. You frown, and check the hindges. Did you miss one? Even if you did, it should still at least wiggle. 

You check the top.

*All the screws are intact.

- "No, no, no, nonononono." You mutter and check the bottom as well.

*They are all there.

You drop to the floor, and feel you the screws you heard fall.

You can't find them.
-> Trapped

= Sledgehammer
You lift up the large hammer and begin to smash it into the door.

#play: thud #style: shudder
Thud!

*It's stronger than you anticipated.


-#play: thud #style: shudder
Thud!

*It's not working...?

-#play: thud #style: shudder
Thud!

*The door looks untouched.
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

*You are trapped inside.
~ stay = 1

- You pull your legs to your chest and sit with your back against the door. 

*<i>You are trapped</i>

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
    *[<Wait until morning> Remember]
        ->Trapped.Remember
    *[<Look for a different exit> Remember]
        ->Trapped.Remember
    *[<Accept the Church> Remember]
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

*You have been here before.

- <i>Riiiiipppppp</i>

You don't know how you could have forgotten. How you didn't realize it before. 

<i>Riiiiipppppp</i>

You have been here before. You found... something- No. Someone? You can't remember, but <i>you got out.</i>

<i>Riiiiipppppp</i>

There is a way out.

<i>Riiiiipppppp</i>

*You just need to figure out how.

- You blink rapidly, shaking yourself out of the memory, and look down at what's left of the image in your hand. Tiny pieces sit in a pile on the ground in front of you. Did you...?

You swallow th elump in your throat and carefully pick up pieces, ensuring you get every little piece. You delicately place them back in your pocket. Once you're out of here, you can fix it.

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

*What if you accept it?

- A low hum echos through the room, and a chill runs through you at the sudden sound. That's what the church wants but...

*What's wrong with that?

*You can't let the church win
-> Trapped.Refuse

- Why are you even trying to fight back? What has the church actually done to harm you? What are you trying to get back to? 

Maybe... Maybe you are supposed to be here.

The air around you grows a little warmer. 
~ trapped_reject = true
*It's comfortable.

*The air smells sour.
-> Trapped.Refuse

- ~ stay += 0.5
A light melody begins to play. A lullaby, you think. It was a comfort when you were young and alone. 

You hum along to it.

*Is it really so <i>bad</i> to stay here?

*Why would you <i>want</i> to stay here?
-> Trapped.Refuse

-Your eyelids grow heavy, and you think you understand why the church released you the first time. You were too young before, but you know better now. 

*The church offers solace.
-> Endings.Bad_End_1

= Refuse
{
    - stay >= 1.5:
    #play: groaning-angry #stop: groaning-angry, 2
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

*"What IS that?"

*"Who, or what, are you?"

*"How do I get out?"

- The voice does not answer, but you know it's still there. You can feel it hovering by your ear.

"This is all I can do for you now. The rest is up to you."

Wind blows around you, and before you stop yourself you call out.

*"Wait!"

*"The rest? What-!"

- The room turns still. Silent. A red light glows from above you.
-> Trapped.Light

= Ignore
You pay it no attention. { - sleep == "sleep": It is helping you to fall asleep.} { - sleep != "sleep":It's comforting, but idlely listening will only make you more tired.}

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

- 

*But you don't wake up.
->Credits

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

*But you don't want to feel like this.
~temp_bool = true
~leave_light = true

*But you are not ready to leave.
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
        #delay: 6.5
        You take a heavy step back and pull away from the light. This feeling of { temp_string } This much you know. This much you trust. The rest is the church.
        
        #play: screeching 
        An earsplitting shriek pierces through the building. You cover your ears, but it only gets louder and luder the more you block it out. The pressure builds until you can barely stand, the warm bath of the light burns your skin. 
        
        *You can barely stand it.
        -> Inside
        
    - else:
        #play: groaning-happy, 0.25 #stop: groaning-happy, 1.5
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

        *[Tear your eyes from the window]
        -> Inside
}

=== Inside ===

{ 
    - feeling == "confused":
        ~ temp_string = "confused emotions go"
    - else:
        ~ temp_string = "{feeling} goes"
}

{ 
- temp_bool:
    #stop: screeching
    Just as suddenly as it all started, it stops. The eye snaps closed, and the red light disappears with it. The window returns to it's normal, swirling state. 

    The pressure alleviates, the burning stops, and all the { temp_string } with it.

    You dig your nails into your hand.

    *[Turn away from the window]
    ~ temp_bool = false
    -> Inside
}

- On the ground in front of you sits a flashlight and a note.

*[Pick up the flashlight]
->Inside.Flashlight

*[Read the note]
->Inside.Dark

= Dark
The paper feels thin. It's too dark to read.

*[Pick up the flashlight]
->Inside.Flashlight

= Flashlight
 ~ lanturn =  true
It looks battery operated, and gives off enough light to see around you. You should be able to explore with this.

*[Read the note]
->Inside.Note

= Note
#play: click-on #effect: flashlight
The note is from an old piece of parchment. It feels like it could crumple into dust.

#effect: dark
"Find the heart and destroy it./nThe church will try to stop you./nIt will do anything to keep you here. Stay out of it's sight./n Do not become it's next meal."

#effect: dark
*[Meal...?]
You shutter at the thought. You wonder how long you have until it fully digests you.

#effect: dark
*[Sight...?]
{ 
    - temp_bool_2:
        ~ temp_string = "How you had to pull yourself out."
    - else:
        ~ temp_string = "How you would have done anything to stay there a little longer."
}
Well.... You glance up at the swirling window.

You remember how the church's sight warped your thoughts and reasoning. { temp_string } You cannot let that happen again. If the church sees you again...

#effect: dark
*[Heart...?]
<i>Find and destroy the heart.</i> You think about what the "heart" of the church would be. A sacred artifact or...?

- 

*You try not to think too hard about it.

- 
{ 
    - object != "":
        ~ temp_string = ", which you know has a small office to the right"
    - else:
        ~ temp_string = ""
}


The flashlight gives off enough light for you to see what's near you. You can make out a podium facing some pews, a confessional off to the side, and a some stairs leading up into a longer hallway{temp_string}.

You have a goal now. <i>Find and destroy the heart.</i> You don't know where the "heart" of the church is, but if you have to guess it would be....

*[In the pews]
-> Pews

*[In the confessional]
-> Confessional

*[Somewhere up the stairs]
-> Stairs

= Look_For_Heart
You have a goal now. <i>Find and destroy the heart.</i> You don't know where the "heart" of the church is, but if you have to guess it would be....

*[In the pews]
-> Pews

*[In the confessional]
-> Confessional

*[Somewhere up the stairs]
-> Stairs

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
*You close your eyes, and fall into a void of relief and comfort.
-> Credits

=== Credits

*The Church at the End of the Street
->Start

Writing - Ren

Art - <a Sarah M Casas <a  href="https://www.instagram.com/clouddancing1995/", tagrget="_blank">@CloudDancing1995</a>

Sound Design - Joe Bretz/ReverbInTheVoid

Used HAL for audio support






->END

















