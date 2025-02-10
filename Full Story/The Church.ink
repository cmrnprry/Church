INCLUDE Variables.ink
INCLUDE AfterFirstChoice.ink
INCLUDE Confessional_Door.ink
INCLUDE Confessional_Curtain.ink
INCLUDE Pews.ink
INCLUDE Stairs.ink
INCLUDE End_Game.ink

#IMAGE: Title
<i>This game will autosave your progress. Use the restart button will rest your game and ALL save data. Use the checkpoints button to jump to previous points of the story. <br><br> Closing the window may reset any progress.</i>

+ [Start Game] ->Start
+ [Credits] ->Credits
+ [Content Warnings] ->Content_Warnings

=== Start ====
#PLAY: background, true, 1.5
There is a church at the end of the street- but there shouldn't be. You saw it when walking home from the bus stop after work. You grew up on this street. You have walked down this road daily. There is not a church at the end of the street.

It was dark when you passed, and you keep telling yourself that your tired brain mistook a billboard for a church. They must be building one there.

*[It's impossible for a church to spring up overnight.]

- 
#IMAGE: BusStop
You pass by again, on your walk to the bus stop this morning, and stop dead in your tracks. There should not be a church, and yet, there it sits. A "FOR SALE" sign attached to its lawn.

*[You don't like it.]
    ~church_interest = "like"
    #CYCLE: uncomfortable, interesting, awkward, rough
    The feeling isn't strong, you just know you don't like that there's a church there. You've always had a... @ relationship with religion and you haven't step foot in a church since you were a kid. You've seen other churches, but none have made you feel so...
    
*[You feel drawn to it.]
    ~church_interest = "drawn"
    #CYCLE: uncomfortable, interesting, awkward, rough
    It's a slight tugging in your gut that pulls you to it. You've always had a... @ relationship with religion, so this attraction puzzles, and to an extent, disturbs, you. You've seen other churches, but none have made you feel so...

*[You want nothing to do with it]
    ~church_interest = "nothing"
    #CYCLE: uncomfortable, interesting, awkward, rough
    You've never been so repulsed by a building before. You've always had a... @ relationship with religion, but this church makes you want to get in a car and keep driving until the tank runs dry. You've seen other churches, but none have made you feel so...
    
- Your stomach churns. You shove your hand in your pocket and rub your thumb over the worn polaroid picture inside. <>

{   church_interest:

    - "like":
    You hope it disappears as quickly a it appeared.
    
    - "drawn":
    You wonder if you should call the number on the sign.
    
    - "nothing":
    You kick yourself for leaving the house earlier than usual and pray the bus comes quickly.
}

*[You quickly cross the street.]

- You mess around on your phone, { church_interest == "drawn": keeping your hands busy and trying to keep yourself from staring at the church. It keeps pulling your eye, like it's always somehow in your periphery. | looking for any information about the church while trying to ignore it. You keep looking up at it, confirming for yourself that it is really there. }

It was not there on the walk to the bus stop yesterday, or the day before- you're sure of it. And a new building wouldn't look so... You glance up at it again, and something pulls at the back of your mind.

The church feels...

*[Familiar]
    ~church_feeling = "familiar"

*[Uncomfortable]
    ~church_feeling = "uncomfortable"

*[Evocative]
    ~church_feeling = "evocative"

- It is small, with white paint peeling, revealing sun-bleached brick underneath. It's windows are intact, but everything else is cracked or crumbling. You're surprised the building is still standing.

#PLAY: bus_ambience, true, 2
{   church_interest:

    - "like":
    The bus arrives and you're no closer to understanding this {church_feeling} church that spontaneously appeared. You give it one last glance and you wrinkle your nose.
    
    - "drawn":
    The bus arrives and you feel a pang of disappointment now that you can't spend more time with the {church_feeling} church. You give it one last glance and you bite your lip.
    
    - "nothing":
    The bus arrives late and you jump to your feet. You found nothing online about this {church_feeling} church that spontaneously appeared. You give it one last glance and your mouth taste like pennies.
}

*[Get on the bus]
    -> Bus
    
* {church_interest != "nothing"}[Investigate the church]
    You need to know more. You don't know if it will still be here after work. You don't know what you're going to do, but you need to do <i>something.</i>
    -> Investigate
    
* {church_interest == "nothing"}[Confront the church]
    You should just go to work, but this church feels like it's taunting you by just sitting there. You don't know what you're going to do, but you need to do <i>something.</i>
    -> Investigate

=== Investigate
#STOP: bus_ambience, 2
You pat your pant pockets, pretending that you forgot your pass, and smile sheepishly. The driver rolls her eyes and drives off. It's still early enough where you can just catch the next one. You steel yourself and look back at the church.

*[The church windows catch your eye]
    -> Investigate.Window

*[Call the number on the sign]
    -> Investigate.Call

*[Break in]
    -> Investigate.Break_in

= Call
~ called_number = true
You cross the street and type the number into your phone. {church_interest == "drawn": You hang on the gate as the phone rings. | You turn your back to the church and pace as the phone rings.} It rings and rings, and just when you think better of it, someone picks up.

A bored voice, obnoxiously chewing gum answers. "Can I help you?"

*["I'm calling about the church on Grant Street?"]
    You tap your fingers against your thigh. Should you be doing this?

*{church_interest == "drawn"}["I'm looking to tour the church on Grant Street?"]
    Your heart beats hard and slow. You stare at the church.

- "The what?" she snorts. "The hell you talking about?"

*["I need to know more about it."]

*{church_interest == "drawn"}["Please. I just-"]

*[Hang up.]

- "I don't know who you think you're calling, but you got the wrong number."

* ["But-"]

- The call goes dead.

*[Call the number again]

*[The church windows catch your eye]
    -> Investigate.Window

*[Break in]
    -> Investigate.Break_in

- You dial the number again, prepared to ask better questions, but you're sent staright to voicemail.

"You've reached the voicemail box of 555-555-5555. Please leave a message after the tone. Beeeep!"

*[Leave a message]
    You leave a quick message asking about the church, with your name and callback number.<>

*[Hang up]
    Annoyed, you hang up the phone.<>
    
- You learned nothing from that and now you're late for work. {church_interest == "drawn": You want to investigate further, but y | Y}ou should get going.

*[The church windows catch your eye]
    -> Investigate.Window

* {church_interest == "drawn"} [Call again]
    
*[Wait for the bus]
    {church_interest == "drawn": Dejected, you| You} walk back to the bus stop and wait for the next bus. It comes {church_interest == "drawn": all too } quickly{church_interest 1= "drawn": , and you are thankful you won't be too late.| .} <>
    ->Bus

- 
->Job
= Break_in
five


= Window
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

#PLAY: bus_ambience, true, 1 #ZOOM: unset|unset #ICLASS: Background Image|Swimming-3|
You stumble backwards as the bus swerves, narrowly avoiding you. The driver opens the door and asks if you're alright. You feel yourself nodding, heart pounding. A knot forms in your stomach.

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
    #IMAGE: Default #CHECKPOINT: 1, You arrive at work.
    You fear what what will happen if you can't.
    ->Job

= home
You watch the church through the window until it fades into a dot in the distance. Even after it's gone, you still feel on edge. A part of you wants to call out sick and go back to the church. It's waiting for you.

*[You <i>need</i> to forget about the church.]
    #IMAGE: Default #CHECKPOINT: 1, You arrive at work.
    You fear what what will happen if you can't.
    ->Job

=== Job ===
#STOP: bus_ambience, 1 #PLAY: office_ambience, true, 1
You get less done than usual at work. You find yourself absently doodling and scribbling on scrap paper. Typing nonsense, only to delete it after. Staring blankly into your computer screen.

There is only one thing on your mind, one thing that shouldn't exist but it does.
That {church_feeling} church.

You should do something to take your mind off it.

*[Scan some documents]
-> Job.Scan

*[Catch up on emails]
-> Job.Emails

= Scan
You choose to do something mindless and easy. You grab a stack of papers marketing needs sent out, and head to the machine.
~ work += 1
*[Maybe the monotony will take your mind off things.]

- 
#PLAY: scanner, false, 0.5
You enter a rhythm of placing a page, entering an email, and sending it off. You try to focus on only your actions to prevent your mind from wandering. 

Place page. Enter email. Send it off. Place page. Enter email. Send it off. Place page. Enter email. Send it off. Place page. Enter email. Send it off. Place-

*["Hey- What are you doing?"]

- #STOP: scanner, 1.5
You jump and look up to see a coworker from your department. You don't talk to her often, but she's nice enough. She looks... concerned?

*["Just sending out some scans."]

*["Busy work until the next meeting. You know how it is."]

*["Trying to keep busy."]

- She nods slowly, and picks up one of the papers from your done pile. "And... <i>this</i> is what you're sending out?"

"Yeah, Marketing needed-"

She cuts you off as she starts to read off what's on the page. "'Do you know about the church at the end of the street?" 

The hairs on the back of your neck stand up.

*[<i>No.</i>]

- "The church at the end of the street knows me but I don't know it." She continues. Your chest tightens, and you frantically go through the rest of the papers. You know these were marketing reports. "It waits and waits for me to come back. It has gotten impatient."

All the papers repeat what you coworker said. Over and over again. All in neat handwriting. <i>Your</i> handwriting. You clutch the papers tightly, until your knuckles go white and your nails pierce through. <i>When did they change?</i>

"Did you write this?" She purses her lips at you. "Is this your idea of a bad joke?"

*["I'm going home early today."]

*["I'm going to work from home for the rest of the day."]

*[Say nothing and leave.]

- ->Walk_Home

= Emails
#PLAY: email_ding, false, 0, 1
You pull up your email and scroll through the new ones, only reading the subject lines for anything important. Meeting invitation, spam, spam, client question, church inquiry, meeting- Wait. Church inquiry?

*[Open church inquiry email]
-> Job.Open
*[Delete the email]
-> Job.Delete

= Delete
#DELAY: 1.5
You quickly delete the "church inquiry" email, and go to reply to the client. 

#PLAY: email_ding, false, 0, 0.5 #DELAY: 2.5
Another email with the same subject quickly replaces it. You don't think and delete it again.

#PLAY: email_ding, false, 0, 0.5
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

#PLAY: email_ding, true #STOP: email_ding, 0, 2 #DELAY: 2.5
you get a flurry of new emails. "Church Inquiry. It's waiting. It's impatient. Hurry up. Hurry up. Hurry up."

#PLAY: email_ding, true #STOP: email_ding, 0, 3
You try to delete them, but they just keep coming. "Where are you?" "Come home." "(No Subject. Image Attached)."

*[Open Email]
~ know = true
You give in, and click the latest email.
-> Job.Open

*[Continue Deleting]

- 
#PLAY: email_ding, true #DELAY: 1.5
You can't delete them fast enough.

#DELAY: 1.5
They just keep coming. You try to-

#STOP: email_ding
"Hey are you-" A hand grabs your shoulder, and you jump up from your chair, slapping the hand away. 

"Leave me ALONE!" you shout, breathing heavy.

"What's your problem?!" You realize all too late that this was not the church, but your coworker. You stumble over yourself trying to apologize. "We all have rough days but.... What the hell?!"
~work = 3

*["I'm- I'm going home early."]

*[Say nothing and leave.]

- ->Walk_Home

= Open
~ work = 3

- {know: You click the email.} It shows an image of the church, but in a different place. Not at the end of your street, but near your grandparents house, several states away. You see a younger version of yourself standing outside and smiling. 

Your mouth goes dry.

*[Scroll down]

- Under the image is the text "Don't keep it waiting."

You slam the laptop shut. A fuzzy memory tickles the back of your mind, and suddenly it all clicks into place.

*[You know the church.]

- You don't know how, but you know it. You slam you fist against your desk. "Why can't I...?" You mutter.

The memory refuses to surface, only vague images and feelings. You see yourself inside. You're scared. You're trapped. But that's all you can remember. You hit the desk again, harder. 

"It's right there, so just..." You murmur to yourself. "I was...?"

You found something. It let you out? No. It wouldn't-

*["Everything... Okay...? In here?"]

- It's your coworker. You wave him away, and focus. You escaped. It wants you back. You can see the door opening, but the younger you didn't feel relief. No, they felt... afraid? Why...? You got out so why-

Your coworker grabs your shoulder, "Hey what's-" You jump up from your chair and smack his hand away. You lean on the wall to support yourself, breathing heavy. "What's your problem?!"

Your coworker stares at you, waiting for an answer. You shove your hand into your pocket, searching for the polaroid inside, hoping to calm yourself.

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
    
        {know: You lay out the pieces of the polaroid, all too small to really make anything out. You can't bring youurself to throw it away, instead placing each piece in the small drawer of your desk.<br><br>You'll try to fix this tomorrow, after a good night's sleep.}
    
    - else:
        Error
}

{know: You need to avoid the church. It wants you back, and everything in screams that you cannot go back. That if you do, you won't come out again.}
#STOP: office_ambience, 1 #IMAGE: BusStop
The bus ride home is shorter than it's ever been. You get off at your regular stop.

The church is still there.

*[Take a different path home]
->Walk_Home.Different

*[Take the usual path home]
Tentatively, you walk your usual path home, and try not to look at the church.
->Walk_Home.Usual

= Different
~turn = "walking"
~avoid_church = true
#IMAGE: Stop_Sign
You get off at the same bus stop you normally do. You don't look at the church, and instead turn around and walk up the block. A burning creeps up the back of your neck, almost as if someone is staring you down.
*[Turn around]
->Walk_Home.Turn_Around

*[Walk faster]

- 
#ZOOM: scale(1.25)|inset(0px 0px 5% 5%)
#PLAY: walking_fast_pavement, true, 1
You shove your hand in your pocket and pick up the pace. The corner where you need to turn is so close. The burning sensation grows, and something grabs at your legs. The wind picks up around you.

*[Turn around]
->Walk_Home.Turn_Around

*[Go faster]

- 
~turn = "running"
#ZOOM: scale(1.5) translate(-12%, 16%)|inset(0px 0px 26% 17%)
#STOP: walking_fast_pavement, 0.5 #PLAY: running_pavement, true, 0.5, 1
You break out into a run. You can almost touch the stop sign on the corner. How have you not reached it yet? The burning sensation lessens, replaced with lead weights at your ankles. Your chest feels heavy, like someone has their arms wrapped tightly around you.

You hear something on the wind. A voice?

*[Turn. Around.]
->Walk_Home.Turn_Around

*[Almost. There.]

- 
#ZOOM: scale(2) translate(-12%, 21%)|inset(0px 0px 39% 21%)
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

{know:It's following you. You wipe sweat from your brow.<br><br>It can move.|Was it always this far down the road? This morning you were able to clearly see it from the bus stop...<br><br>You take a breath, and reach into your pocket. The feeling of the worn polaroid calms you. You're being unreasonable. It's just a building. Just a church. A {church_feeling} church.}


*[Continue walking the long way home]

*[Take your usual path]
    {know: You know you shouldn't, but you can't stop yourself.} You try not to look at the church as you walk past. 
    ->Walk_Home.Usual
    
- 
#IMAGE: Stop_Sign #PROP: closed_gates, true
{know:It wants you back, but you refuse to let it have you.|You decide to continue the long way home, hoping the fresh air will ease your mind.}

As soon as you start walking again, the burning sensation flares up again, ten times worse than before, bleeding down your back. 

*[Ignore it]

*[Turn back]
#IMAGE: Chuch_Looming #PROP: closed_gates, false
You stop in your tracks and ball your hands into fists. You spin around to find yourself at the front of the church. Your hands tightly grip the front gates.
->Walk_Home.Stop_Sign

-
#PLAY: walking_fast_pavement, true, 1
#ZOOM: scale(1.5) translate(-12%, 16%)|inset(0px 0px 26% 17%)
You ignore it, and keep going. Each step feels like wading through thick jelly. You can almost touch the stop sign on the corner.

*[Almost. There.]

- 
#ZOOM: scale(2) translate(-12%, 21%)|inset(0px 0px 39% 21%)
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
#IMAGE: Chuch_Looming #PROP: open_gates, false #PROP: closed_gates, true
#PLAY: gate_open
As you pass the front gate, it creaks open. You reach for the image in your pocket. 

{know: You should keep moving.}

*[Investigate]

//On mouse click, change to "investigate
*[(Continue walking home)Investigate]


- 
#IMAGE: Chuch_Looming #PROP: open_gates, false
Against your better judgement, you stop, and look at the church. The gate is open.
{know: You should keep moving. It's waiting for you. It's making the choice easy.| Probably the wind.Probably.}

*[Close the gate]

*[Continue walking home]
->Walk_Home.Lost

- You take a single step onto the property to reach the open gate, and the edges of the dirt path to the church brighten where you step. Small, shining lights line the path. 

{know: A feeling of unnerving calm washes over you. You know you need to leave. You know you need to walk away. But you also know you should keep going. There's no harm in looking.|Motion activated maybe?}

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
#PLAY: footsteps_child_grass, false #STOP: footsteps_child_grass, 3
No sooner than you think it, you hear the sound of little feet and laugher carried on the wind. 

*[Or an animal gets trapped.]
~ temp_bool = false
#PLAY: meow
No sooner than you think it, you hear the sound of growling and meowing on the property. 

- {know:It's the church. You know it's the church. It has to be, but what if- }

{ 
    -temp_bool:
    A child might be in there. You should get them out.
        *["Hey, this isn't a place to play!"]
        -> Walk_Home.Close

        *["That's trespassing, come on out now."]
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
{ know: A feeling of unnerving calm washes over you. You know you need to leave. You know you need to walk away. But you also know you should keep going. There's no harm in looking.| Motion activated maybe?}

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

-{know: You're moving automatically. You want to go home.}

Around halfway up the path, you hear another set of footsteps.

The church door is open and inviting. You can't see inside. 

*[Stop]
~ temp_bool = true

*[Walk faster]
~ temp_bool = false
->Walk_Up_Path.Run

- #STOP: footsteps_player, 0.5 #STOP: footsteps_scary, 0.5, 2
Stopping in your tracks, you wait and listen. You hear nothing, but the hairs on the back of your neck stand up...

Someone is behind you, and they know you know. Your only option is the church or confrontation. Your heart pounds in your chest. {know: It has to be another trick.}

*[Run to the church]
->Walk_Up_Path.Run

*[Confront them]

- 
#DELAY: 2
You take a breath and quickly spin around, ready for whatever may await you, and see...

Nothing. No one's there. You laugh.
{know: The church will do anything to lure you in.| Your mind is playing tricks on you. It was probably the wind.}

{ know: You decide that you've been too close for too long and start for the gate. You think you deserve a long, hot bath after today.| You decide that you've trespassed for long enough, and start for the gate. You think you deserve a long, hot bath after today. }

*[Walk to the gate]

- 
#IMAGE: Chuch_Looming #PROP: open_gates, false
You grab the gate with both hands, and look up at the church one last time. It's quiet and dark. { - know: It lost. }

*[Pull the gate closed]

- 
#PLAY: gate_close #DELAY: 1.73 #PROP: open_gates, true #PROP: closed_gates, false
Just as it slams shut...

#TEXTBOX: text_container_Dark #IMAGE: Default #PROP: closed_gates, true 
~CurrentProp = ""
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

*[It's locked]
-> Locked

= Run
#PLAY: footsteps_player, true #PLAY: footsteps_scary, true
{ 
    - temp_bool: 
    Adrenaline floods your veins, and you break into a sprint. You can't hear anything over the blood pounding in your ears, but you swear you can feel someone trying to grab at your clothing.
    - else:
    {know: Against your better instincts, you pick up the pace, and you hear the footsteps getting closer. Adrenaline floods your veins, and you can't think straight. You start running, and so do they.| You pick up the pace, and you hear the footsteps getting closer. Adrenaline floods your veins, and you can't think straight. You start running, and so do they.}
}

You still cannot see in church. 

*[You're so close to safety]

- #STOP: footsteps_player #STOP: footsteps_scary, 0, 1 #PLAY: door_slam, false, 0, 0.5,  #DELAY: 5 #TEXTBOX: text_container_Dark #IMAGE: Default #PROP: open_gates, true
You slam the door closed and fall into the dark church. You quickly regain your balance, grab the door and slam it closed. You throw your full body weight against it, hoping to hold back whoever was chasing you.

#CLASS: Bang_Short #PLAY: bang_short #DELAY: 2
BANG!

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
        BANG!

        #DELAY: 1.5
        They can't keep this up forever.

        #CLASS: Bang_Short #PLAY: bang_short
        BANG!
        
    - else:
        #DELAY: 1
        "I DON'T HAVE ANY MONEY!" 
    
        #CLASS: Bang_Short #PLAY: bang_short #DELAY: 1.5
        BANG!
    
        #DELAY: 1
        "I DON'T HAVE ANYTHING!"
    
        #CLASS: Bang_Short #PLAY: bang_short
        BANG!
}

*[Wait]

- 
You don't know how long you sit there, holding the door closed, body braced against it. Eventually the banging stops, but you wait longer, just in case.

#PLAY: lock_rattle, false, 0, 0.5
When you feel safe again, you try to open the knob.

*[It's locked]
->Locked

=== Locked ===
#CHECKPOINT: 2, Locked?
Locked? {know: The blood drains from your face as you realize what you've done.}

#PLAY: lock_rattle
You jiggle the handle again. 

*[The door won't budge]

- You don't understand. It can't be locked. {know: |Maybe it got jammed?}

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

*[Again]

*[Stop]
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

*[Again]

*[Stop]
You stop, fall to the floor, and stare at the untouched door in front of you. Your leg throbs from effort. You let out a short, hysterical laugh that could be mistaken a sob as the realization hits you.
->Trapped

- ~ leg = "worst"
Something in you allows you to keep going, even as your leg throbs and it feels like you can barely take in anymore air. 

#CLASS: Kick  #PLAY: door_thud
Thud!

*[You need to get out]

- #CLASS: Kick  #PLAY: door_thud
Thud!

*[Every fiber of your being is telling you to get <i>out.</i>]

- #CLASS: Kick  #PLAY: door_thud
Thud!

*[But the church will not let you]

- #CLASS: Kick  #PLAY: door_thud
Thud!

*[The door does not move]

- You stop, fall to the floor, and stare at the untouched door in front of you. Your leg throbs from effort. You let out a short, hysterical laugh that could be mistaken a sob as the realization hits you.
->Trapped

= Look
#IMAGE: Church_Inside
It's dark, but you can make out vague shapes.

{ know: You know it's useless, but fear overtakes the rational part of your brain. There has to be SOMETHING. | You quickly glance around the church. It's small, but seemingly abandoned. There must be something that was left behind by previous squatters or looters. }

You look everywhere, arms outstretched, blindly feeling around your surroundings. On and under what you imagine are pews, the floor, past the curtain? Into a... cupboard? Closet? As you search, you get the feeling of deja vu. You've done this before.

*[Nothing]

- You go further into the church, up a few steps, feeling the walls as you do, and find a closed door at the end of the hall. It might have what you're looking for.

*[You hope for a crowbar]
~ object = "crowbar"

*[You hope for a screwdriver]
~ object = "screwdriver"

*[You hope for a sledgehammer]
~ object = "sledgehammer"


-
{
- object == "crowbar": 
    You want to pry the door open with it
- object == "screwdriver":
    You want to take the door off it's hinges
- else:
    You want to smash the door down
}<>
{know: . You hope it won't be able to survive that.| . You know it won't be able to survive that.}

#IMAGE: Office_Final
You open the door to find a side office, entirely covered in dust and cobwebs. The adjacent walls were book shelves full of books. The far wall has a desk with a stained glass window above it. {window: You avoid looking at the window. }

{
- object == "crowbar": 
    #ICLASS: Overlay||overlay-spotlight #PROP: item, false #PROP: crowbar, false
}
{
- object == "screwdriver":
    #ICLASS: Overlay||overlay-spotlight #PROP: item, false #PROP: screwdriver, false
}
{
- object == "sledgehammer":
    #ICLASS: Overlay||overlay-spotlight #PROP: item, false #PROP: sledgehammer, false
}
On the desk sits a {object}, illuminated by a red spotlight from the window. It's not covered in dust like rest of the room, as if it has been placed there just for you.

~ room = true

*[Pick up the {object}]
~ temp_bool = false

*[Leave it]
~ temp_bool = true

- 
#PROP: item, true #PROP: sledgehammer, true #PROP: screwdriver, true #PROP: crowbar, true #IMAGE: #ICLASS: Overlay|overlay-spotlight|
{
    - temp_bool:
        { 
        - know: The church is playing with you now. It knows what you wanted, and gave it to you.
        - else: Something tells you that even if you take it, it wouldn't matter. That the door won't budge for you.
        }
    
        #IMAGE: Default
        You return to the front door.
        
        You stare at it. It stares back.
        
        *[Kick in the door]
        ->Locked.Kick
        
    - else:
        You enter the room and pick up the {object}. It weighs heavy in your hands. You tighten your grip on the {object}, and return to the door. { - know: Hopeless or not, you need to try.}
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
#IMAGE: Default
You jam the crowbar in between the door and the wall, at the latch, and pull. 

*[The door groans.]

- #DELAY: 2  
You pull harder, putting all your weight into it. You lean back a bit further and-

#PLAY: crowbar_break #CLASS: Kick #DELAY: 1
Crack!

Half the crowbar is left in your hand. You drop it, but don't hear it hit the ground.

*[The door looks untouched.]
    You stop, fall to the floor, and stare at the untouched door in front of you. You let out a short, hysterical laugh that could be mistaken a sob as the realization hits you.
    -> Trapped

= Screwdriver
#DELAY: 1.5 #IMAGE: Default
You get to work unscrewing the top hinges of the door.

#CLASS: Drop_Screw 0.75 #PLAY: screw_fall_1 
<i>Clink!</i>
#CLASS: Drop_Screw #DELAY: 0.75 #PLAY: screw_fall_2
<i>Clink!</i> 
#CLASS: Drop_Screw #DELAY: 1.5 #PLAY: screw_fall_1
<i>Clink!</i>

#DELAY: 1
The screws fall to the floor. You move to the bottom hinges.

#DELAY: 0.75 #PLAY: screw_fall_2 #CLASS: Drop_Screw
<i>Clink!</i> 
#DELAY: 0.75 #PLAY: screw_fall_1 #CLASS: Drop_Screw
<i>Clink!</i> 
#PLAY: screw_fall_2 #CLASS: Drop_Screw
<i>Clink!</i>

*[That should be the last of them.]

- You grab at the sides and try to lift the door, but it doesn't budge. You frown, and check the hinges. Did you miss one? Even if you did, it should still at least wiggle. 

You check the top.

*[All the screws are intact.]

- "No, no, no, nonononono." You mutter and check the bottom as well.

*[They are all there.]

You drop to the floor, and feel you the screws you heard fall.

You can't find them.

You stop searching, drop the screwdriver and stare at the untouched door in front of you. You let out a short, hysterical laugh that could be mistaken a sob as the realization hits you.
-> Trapped

= Sledgehammer
#IMAGE: Default
You lift up the large hammer and begin to smash it into the door.

#PLAY: door_slam #CLASS: Kick
Thud!

*[It's stronger than you anticipated.]


-#PLAY: door_slam #CLASS: Kick
Thud!

*[It's not working...?]

-#PLAY: door_slam #CLASS: Kick
Thud!

*[The door looks untouched.]
    You stop and drop to the floor, sledgehammer falling to your side, and stare at the untouched door in front of you. You let out a short, hysterical laugh that could be mistaken a sob as the realization hits you.
    ->Trapped

=== Trapped ===
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
#PROP: polaroid, false
You pull the polaroid out from your pocket, hoping to think about better times. It's dark, but you can see enough to make out shapes. You trace the image of your younger self, and the gate behind them with your finger, then the church behind-

Church? 

*[Your mouth goes dry.]

- The image is different. It has changed. Instead of a comforting memory, it has morphed into one you don't know. Something that tickles the back of your brain, but you don't know why.

*[You grip the picture tightly in your hands.]

- The image isn't fake, somehow you know this. The church always felt {church_feeling} in a way you didn't understand why.

#PROP: polaroid, true
The memory refuses to surface, only vague images and feelings. If you close your eyes... You're scared. You're trapped. You're... inside? Inside where-?

Your nails peirce through the image, and your knuckles turn white. Your hands shake as you try to remember when- 

#DELAY: 1.5
<i>Riiiiipppppp</i>
~ photo_ripped = true
The image rips in half.

And it all clicks into place. 

*[You have been here before.]

- 
#DELAY: 1.5
<i>Riiiiipppppp</i>

You don't know how you could have forgotten. How you didn't realize it before. 

#DELAY: 1.5
<i>Riiiiipppppp</i>

You have been here before. You found... something- No. Someone? You can't remember, but <i>you got out.</i>

#DELAY: 1.5
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

{temp_bool: You attempt to stand, but your legs are like jelly, and you fall back to the floor. <>}

 Everything suddenly hits you at once, and you realize how exhausted you are. You can barely see anything. {object != "": You only found the {object} because the church wanted you to.} {temp_bool: You think you should look around after regaining your strength. You don't want to stay in the church any longer than you need to, but pushing past your limits won't help you escape. | You think you should wait until there's some light- any light. }

You rest your head on your knees.

*[Try to sleep]
~ sleep = "sleep"
You probably shouldn't, but it's the quickest way to pass time. And maybe your subconscious will remind you of things your conscious forgot. Or something your conscious doesn't want to remember.

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
- You try to {sleep}. {stay >= 1.5: The hauntingly familiar melody starts again, and the room warms up. | A light melody begins to play, and the room warms up. The lullaby is... familiar.} But it's... different than {stay >=1.5: earlier.| you remember.}

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

- 
#TEXTBOX: text_container_UsedTo
You slowly stand and look around for the source, taking a few steps into the church. You open your mouth, but before any words can leave your lips, cold, unseen hands covers your mouth. You freeze.

"Don't," is whispered into your ear, a woman's voice.

*[Nod]

*[Try to remove the hands]
You claw at your mouth, attempting to grab hands silencing you, and stand up. "Let GO!" 

"You don't... remember..." The hands fall away, and the room goes still. "This is all I can do."

#ICLASS: Overlay||light-above
The hands fall away. The voice goes quiet. The room turns still.
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

- 
The room turns still. Silent.
-> Trapped.Light

= Ignore
You pay it no attention. { sleep == "sleep": It is helping you to fall asleep. | It's comforting, but idly listening will only make you more tired.}

It's a soothing sound, but there's something else there, just underneath, that you can't make out.

*[Listen closer]
-> Trapped.Listen

*[Ignore it]

- { sleep == "sleep": That doesn't matter. The only thing that matters is this lullaby. It's so... | You don't want to admit it, but the sound comforts you in a way you can't describe. It's... reassuring... <br><br> And against your better judgement... }

*[You fall asleep.]

- #ENDING: Sleeping Forever
...
*[But you don't wake up.]
->Credits

= Light
A red light glows from above you.
*[Look at the light.]

- 
#TEXTBOX: glow
The light comes from the window above the door. A stained glass eye staring down at you.

You stagger backward, deeper into the church, an intense pressure pressing down on you. Your chest tightens, and your limbs fill with static. The air becomes heavier. Your mouth goes dry.

You feel...

*[Relief]
~ light_feeling = "relief"

*[Worry]
~ light_feeling = "worry"

*[Confused]
~ light_feeling = "confused"

- 
#REMOVE: glow #TEXTBOX: intense-glow
The back of your throat goes tight as you hold back tears, but you don't know why. 

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

#ICLASS: Overlay|light-above|
{
    - light_feeling == "confused":
        ~temp_string = "confusion is the only thing you can trust."
        
    - light_feeling == "relief":
        ~temp_string = "relief is wrong."
        
    - light_feeling != "confused" and church_feeling != "relief":
        ~temp_string = "worry is a flag that something is very <i>wrong.</i>"
}

{

    - leave_light:
        ~ temp_bool = true
        ~ church_anger += 1
        ~ stay -= 0.5
        #DELAY: 6.5 #REMOVE: intense-glow #TEXTBOX: angry-glow
        You take a heavy step back and pull away from the light. This feeling of { temp_string } This much you know. This much you trust. The rest is the church.
        
        #PLAY: screeching #CLASS: Angry-Screeching 
        An earsplitting shriek pierces through the building. You cover your ears, but it only gets louder and louder the more you block it out. The pressure builds until you can barely stand, the warm bath of the light burns your skin. 
        
        *[You can barely stand it.]
        -> Trapped.Light_Leave
        
    - else:
        #REMOVE: intense-glow #TEXTBOX: leave-glow #PLAY: groaning_happy, false, 0.25 #STOP: groaning_happy, 1.5
        ~ temp_bool = false
        ~ stay += 1
        A satisfied groan reverberates through the building. Slowly, the eye closes, and the red light with it. 

        {
            - light_feeling == "confused":
                ~temp_string = "confused emotions go"
            - else:
                ~temp_string = "{light_feeling} goes"
        }

        #REMOVE: leave-glow
        "N-no!" you scramble forward, chasing the last licks of the light before its gone. The pressure alleviates, and all the { temp_string } with it. The window returns to it's normal, swirling state. 

        With the light gone, you snap back to reality. "Why did I...?" you mutter to yourself. You dig your nails into your hand.
        
       *[Turn away from the window]
        ~ temp_bool = false
        -> Inside


}

= Light_Leave
    #STOP: screeching #REMOVE: angry-glow
    Just as suddenly as it all started, it stops. The eye snaps closed, and the red light disappears with it. The window returns to it's normal, swirling state. 

    The pressure alleviates, the burning stops, and all the { light_feeling == "confused": confused emotions go| {light_feeling} goes} with it.

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
~ haveFlashlight = true
#PROP: flash, false #PLAY: flashlight_on #EFFECT: FlashBeam
It looks battery operated, and gives off enough light to see around you. You should be able to explore with this.

*[Read the note]
->Inside.Note

= Note
#EFFECT: FlashBeam #PROP: flash, true #EFFECT: flashlight #PROP: note, false
The note is from an old piece of parchment. It feels like it could crumple into dust.

#CLASS: end
"Find the heart and <span style="color: \#3f1313">destroy</span> it.<br><br>The church will try to stop you.<br><br>It will do anything to keep you here. Stay out of it's <span style="color: \#3f1313">sight.</span><br><br>Do not become it's next <span style="color: \#3f1313">meal.</span>"

*[Meal...?]
#PROP: note, true #TEXTBOX: text_container_After
You shutter at the thought. You wonder how long you have until it fully digests you.

*[Sight...?]
#PROP: note, true #TEXTBOX: text_container_After
Well.... You glance up at the swirling window.

You remember how the church's sight warped your thoughts and reasoning. { temp_bool_2: How you had to pull yourself out. | How you would have done anything to stay there a little longer.} You cannot let that happen again. If the church sees you again...

*[Heart...?]
#PROP: note, true #TEXTBOX: text_container_After
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

#IMAGE: Church_Inside #CHECKPOINT: 3, You are told to find the heart.
The flashlight gives off enough light for you to see what's near you. You can make out a podium facing some pews, a confessional off to the side, and a some stairs leading up into a longer hallway{object != "":, which you know has a small office to the right}.


#EFFECT: click-move
~ WhereGO = true
You have a goal now. <i>Find and destroy the heart.</i> You don't know where the "heart" of the church is, but if you have to guess it would be.... //(click highlighted image)

*[In the pews (NOTE: You can but I would rather you didn't yet)]
-> Pews_First

*[In the confessional (NOTE: Preferred)]
-> Confessional

*[Somewhere up the stairs (NOTE: You can but I would rather you didn't yet)]
-> Inside.Stairs_First

= Look_For_Heart
#EFFECT: click-move
~ WhereGO = true
TODO: update this based on where we last were and punch up a bit
You have a goal now. <i>Find and destroy the heart.</i> You don't know where the "heart" of the church is, but if you have to guess it would be.... //(click highlighted image)

*[In the pews]
-> Pews

*[In the confessional]
-> Confessional

*[Somewhere up the stairs]
-> Stairs

= Pews_First
//TODO: add in bits about the people reflecting the books?
~ temp_string = ""
~pews = true
{
    - confessional_door_side:
        ~ temp_string += " Another key maybe?"
}

{
    - saw_locks && confessional_door_side:
        ~ temp_string += " Or maybe something to cut the sliding chain?"
    - saw_locks:
        ~ temp_string += " Maybe something to cut the sliding chain?"
}

{
    - number_combo == "":
        ~temp_string += " The code for the combination lock?"
}

{
    - !confessional_door_side || !saw_locks:
        ~temp_string += " You don't know exactly what for. A heart wouldn't really make sense to live in the pews. Maybe you should check the stage."
}
{
    - visited_first:
        ~ visited_first = false
        You make your way to the pews, and begin to search them for anything important.{temp_string}
    
    - else:
        Tentativly, you make your way to the pews. They are empty, and there is no sign of the figures you saw before. You hope it stays that way, while you search them for anything important.{temp_string}

}

There's eight pews, two columns, with four pews each. You seach from front to back, left to right. You feel underneath and the back to make sure nothing is glued or taped to it. You move slowly and methodically, making sure you don't miss anything. 

You don't find much of anything. With a huff you plop onto the last pew you searched, taking a well deserved break. You close your eyes and rub your face. What are you even looking for?

You lean back in your seat, eyes still closed. There's no use sitting here. 

* {visited_first == false} [You should move on with your search.]

= Stairs_First
~temp_bool_3 = false
{
    - leg == "worst":
        ~temp_string = "limp up"
    - else:
        ~temp_string = "climb"
}
{ - room:
    - 0: You {temp_string} the short set of stairs, and notice a door over the last few steps, rather than at the top of the landing. The hall extends to another set of stairs that go both up and down. 
    ~room = 2
    
    - 1: You {temp_string} the short set of stairs.The office door is still there, however, in a different place. Rather than it being at the end of the hall, it sits on wall adjacent to the stairs, hovering over the last few. The hall extends to another set of stairs that go both up and down. 
    
        This was not there last time you were here.
        
        ~room = 2
        
    - 2: You {temp_string} the short set of stairs. The door seems a little a bit shorter than you remember.
    
    - 3: You {temp_string} the short set of stairs. The door is half the height that it used to be. If it were any smaller, you don't think you could fit through it.
    

    - else: You {temp_string} the short set of stairs. The doorway to the office is gone. {room >= 4: You hope you got everythign you needed from it. }{room >= 5: The church destroyed that room. At least you managed to get what you needed from it. Or at least you hope you did.}

}


*[Examine the stairs]
-> Stairs.Examine_Stairs

*{ room <= 3 }[Enter the office]
->Stairs.Office

*[Return to the main body of the church]
->Inside.Look_For_Heart

=== Confessional ===
#IMAGE: Confessional_CloseUp #PROP: curtain_full, false #EFFECT: click-move
{
 - !confessional_door_side && !confessional_door_side:
        You {leg == "worst": carefully} approach the confessional booth. It is a plain, wooden box. The most detail is the lattice work on the door the priest uses to enter and exit. A heavy, dark blue curtain covers the side a sinner would enter to confess. //(click highlighted image)
            ~ WhereGO = true
    - else:
        You approach the confessional booth. {confessional_door_side: } {killed_girl: Your eyes linger on the curtain.}//(click highlighted image)
        ~ WhereGO = true
}

{

    - !confessional_door_side:
        *[Enter throught the door] //door_confessional]
        ->Confessional_Door
        ~ WhereGO = false
}
{
    - !confessional_door_side:
        *[Enter through the curtain]//curtain_confessional]
        ~temp_bool = false
        ->Confessional_Curtain
        ~ WhereGO = false
}

=== Endings ===

= Bad_End_1
*[You close your eyes, and fall into a void of relief and comfort.]
-> Credits

=== Credits ===
<h1>Credits</h1><br>Writing, Design and Code<br>Ren<br><br>Artists<br><a  href="https:\/\/www.instagram.com/clouddancing1995/", target="_blank">Sarah M Casas - @CloudDancing1995</a><br><a href="https:\/\/www.instagram.com/ninak_sketch/", target="_blank">Ninakupenda Gaillard - @ninak_sketch </a><br><a href="https:\/\/www.instagram.com/alma_abyss/", target="_blank">Jada Carey - @Alma_Abyss</a><br><br>Sound Design<br>Joe Bretz/ReverbInTheVoid

+ [Start Game] ->Start
+ [Content Warnings] ->Content_Warnings

=== Content_Warnings ===
<h1>Content Warnings</h1><br><ul><li>Mild gore / dead body descriptions</li><br><li>General Christan/Catholic discomfort</li><br><li>General violence towards player/blood/bodily fluids mention. All through text</li><br><li>Potential child harm/child in distress where player is unable to help</li><br><li>Some demeaning speech yelled at the player from a male character</li></ul>

+ [Start Game] ->Start
+ [Credits] ->Credits














