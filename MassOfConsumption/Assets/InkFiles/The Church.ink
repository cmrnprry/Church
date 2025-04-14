# title: Mass of Consumption
# author: Ren Perry
# sessions: 3
# saves: 5
# load_from_checkpoints

INCLUDE Variables.ink
INCLUDE AfterFirstChoice.ink
INCLUDE Confessional_Door.ink
INCLUDE Confessional_Curtain.ink
INCLUDE Pews.ink
INCLUDE Stairs.ink
INCLUDE End_Game.ink

->Start
=== Start===
<i>Use the options menu to toggle any text or screen effects on or off, and adjust font.</i>

+[Test]
    -> Test
    
+ [Start Game] 
    ->StartGame
    
+ [Skip To...]
    This is for players who have played the main game already, but want to skip to certain areas more quickly. Important questions will be asked to jump to the chosen area.
    
    ++[Return to Main]
        ->Start
    ++[Skip to Investigation]
        ~ skip_counter = 1
        ->Skip 
    ++[Skip to Work]
        ~ skip_counter = 2
        ->Skip 
    ++[Skip to After Work]
        ~ skip_counter = 3
        ->Skip
    ++[Skip to Inside Church]
        ~ skip_counter = 4
        ->Skip

=== Test ===
#EFFECT: intense-glow
The back of your throat goes tight as you hold back tears, but you don't know why. 

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
        
    - light_feeling != "confused" and church_feeling != "relief":
        ~temp_string = "worry is a flag that something is very <i>wrong.</i>"
}

{

    - leave_light:
        ~ temp_bool = true
        ~ church_anger += 1
        ~ stay -= 0.5
        #DELAY: 6.5 #EFFECT: angry-glow
        You take a heavy step back and pull away from the light. This feeling of { temp_string } This much you know. This much you trust. The rest is the church.
        
        #PLAY: screeching #ICLASS: Angry_Screeching #CLASS: Angry_Screeching 
        An earsplitting shriek pierces through the building. You cover your ears, but it only gets louder and louder the more you block it out. The pressure builds until you can barely stand, the warm bath of the light burns your skin. 
        
        *[You can barely stand it.]
        -> Trapped.Light_Leave
        
    - else:
        #EFFECT: leave-glow #PLAY: groaning_happy, false, 0.25 #STOP: groaning_happy, 1.5
        ~ temp_bool = false
        ~ stay += 1
        A satisfied groan reverberates through the building. Slowly, the eye closes, and the red light with it. 

        {
            - light_feeling == "confused":
                ~temp_string = "confused emotions go"
            - else:
                ~temp_string = "{light_feeling} goes"
        }

        "N—no!" you scramble forward, chasing the last licks of the light before its gone. The pressure alleviates, and all the { temp_string } with it. The window returns to it's normal, swirling state. 

        With the light gone, you snap back to reality. "Why did I...?" you mutter to yourself. You dig your nails into your hand.
        
       *[Turn away from the window]
        ~ temp_bool = false
        -> Inside


}

*[Your eyes don't leave the church]
-> END


=== Skip ===
When you passed the church how did you feel about it?

*[You don't care for it]
    ~church_interest = "care"
    
*[You feel drawn to it]
    ~church_interest = "drawn"

*[You're nauseous just looking at it]
    ~church_interest = "nothing"

- And what emotion did that envoke?

*[Familiar]
    ~church_feeling = "familiar"

*[Uncomfortable]
    ~church_feeling = "uncomfortable"

*[Evocative]
    ~church_feeling = "evocative"

//Go to investigation if chosen
TODO: check what image and audio hould be playing
- {skip_counter == 1:-> Investigate}
    
- Did you investigate the church instead of going to work?

*[Yes]
    What did you do?
        **[Looked at the window]
            -> Investigate.Window
    
        **[Called the number]
            Did you go inside?
            ***[No]
                {skip_counter == 2:-> Job | -> Skip.Skip_AfterWork}
                
            ***[Yes]
                ~ church_teleported = true
                { 
                    - church_interest == "drawn": 
                        ~ stay += 0.5
                        ~ dropped_phone = true
                }
                {skip_counter == 2:-> Job.Teleport | -> Skip.Skip_AfterWork}
        
        **[Went inside]
            ~late_for_work = true
            How did you feel inside?
            
            ***[Disappointed]
                ~ stay += 0.5
                ~ entered_feeling = 0
                {skip_counter == 2:-> Job | -> Skip.Skip_AfterWork}
            
            ***[Satisfied]
                ~ entered_feeling = 1
                {skip_counter == 2:-> Job | -> Skip.Skip_AfterWork}
            
            ***[Anxious]
                ~ entered_feeling = 2
                {skip_counter == 2:-> Job | -> Skip.Skip_AfterWork}
*[No]
    #IMAGE: Default #CHECKPOINT: 1, You arrive at work.
    {skip_counter == 2:-> Job | -> Skip.Skip_AfterWork}


= Skip_AfterWork
-> Walk_Home

= Skip_InsideChurch
-> Locked

=== StartGame ====
There is a church at the end of the street- but there shouldn't be. You saw it when walking home from the bus stop after work. You grew up on this street. You have walked down this road daily. There is not a church at the end of the street.

It was dark when you passed, and you keep telling yourself that your tired brain mistook a constuction site billboard for a church. They must be building one there.

*[It's impossible for a church to spring up overnight.]

- 
# IMAGE: Bus Stop
You pass by again, on your walk to the bus stop this morning, and stop dead in your tracks. There should not be a church, and yet, there it sits. It's small, with white paint peeling, revealing sun-bleached brick underneath. It's windows are intact, but everything else is cracked or crumbling. A faded "FOR SALE" sign attached to its lawn.

#CYCLE: decrepit, worn-down, enigmatic, old
It was not there on the walk to the bus stop yesterday, or the day before- you're sure of it. And a new building wouldn't look so @. You swallow hard.

*[You don't care for it]
    ~church_interest = "care"
    #CYCLE: uncomfortable, interesting, awkward, rough
    The feeling isn't strong, you just know you don't particularly like that there's a church there. Similar to when your grandma would put raisins in her cookies, something you don't mind but wish weren't there. You've always had a... @ relationship with religion, and you haven't step foot in a church since your grandparents dragged you along as a kid. You've seen other churches, but none have made you feel so...
    
*[You feel drawn to it]
    ~church_interest = "drawn"
    #CYCLE: uncomfortable, interesting, awkward, rough
    It's a slight tugging in your gut that pulls you to it. You've always had a... @ relationship with religion, so this attraction puzzles, and to an extent, disturbs, you. You haven't step foot in a church since your grandparents dragged you along as a kid. You've seen other churches, but none have made you feel so...

*[You're nauseous just looking at it]
    ~church_interest = "nothing"
    #CYCLE: uncomfortable, interesting, awkward, rough
    You've never been so repulsed by a building before. You've always had a... @ relationship with religion, but this church makes you want to get in a car and keep driving until the tank runs dry. You haven't step foot in a church since your grandparents dragged you along as a kid. You've seen other churches, but none have made you feel so...
    
- Your stomach churns. You shove your hand in your pocket and rub your thumb over the worn polaroid picture inside. <>

{   church_interest:

    - "care":
        You turn away and attempt to ignore it. Its appearance means nothing.
    
    - "drawn":
        You wonder if you should call the number on the sign.
    
    - "nothing":
        You hope it disappears as quickly a it appeared and pray the bus comes quickly.
}

*[{ church_interest != "care": Quickly c| C}ross the street]

- You mess around on your phone, { church_interest == "drawn": keeping your hands busy and trying to keep yourself from staring at the church. It keeps pulling your eye, like it's always somehow in your periphery. | looking for any information about the church while trying to ignore it. You keep looking up at it, confirming for yourself that it is really there. }

The church feels...

*[Familiar]
    ~church_feeling = "familiar"

*[Uncomfortable]
    ~church_feeling = "uncomfortable"

*[Evocative]
    ~church_feeling = "evocative"

- # PLAY: bus_ambience, true, 2
{   church_interest:

    - "care":
        The bus rolls to a stop in front of you and you're no closer to understanding this {church_feeling} church that spontaneously appeared. You give it one last glance and you wrinkle your nose.
    
    - "drawn":
        The bus rolls to a stop in front of you, and you feel a pang of disappointment now that you can't spend more time with the {church_feeling} church. You give it one last glance, and bite your lip.
    
    - "nothing":
        The bus rolls to an agonizingly slow stop in front of you, and you tap your foot impatiently waiting for an older woman to de-board. You found nothing online about this {church_feeling} church that spontaneously appeared. You give it one last glance, your mouth tasting like pennies.
}

*[Get on the bus]
    -> Bus
    
* [{church_interest != "nothing": Investigate | Confront} the church]
    Curiosity stirs in your chest. {church_interest != "nothing": You { church_interest != "drawn" : want | need} to know more, and it's still early enough where you can catch the next bus if you're quick about it. | You should just go to work, but this church feels like it's taunting you by just sitting there. It's still early enough where you can catch the next bus if you're quick about it.} You don't know if it will still be here after work. You don't know what you're going to do, but you need to do <i>something.</i>
    -> Investigate

=== Investigate
~investigated = true
You pat your pant pockets, pretending that you forgot your pass, and smile sheepishly. The driver rolls her eyes. "I won't tell. Just don't make it a habit." She winks at you.

You shift your weight, and check your watch. Your boss has been watching you like a hawk recently, so maybe this is some divine intervention telling you to not press your luck.

TODO: make these choices a bit stronger
* ["Thanks, that's kind of you."]
    You decide that you don't want to be yelled at today and force a smile. <>
    -> Bus

* ["I should run home, and grab it anyway."]

-  #STOP: bus_ambience, 2
She shrugs, "Whatever you say." She closes the doors and drives off. You let out a breath and steel yourself. You need to be quick about it to avoid a 10 minute scolding later. You look back at the church.

*[The windows catch your eye]
    -> Investigate.Window

*[The number on the "FOR SALE" sign tempts you]
    -> Investigate.Call

*[The slightly ajar door calls out to you]
    -> Investigate.Break_in

= Call
~ called_number = true
You cross the street, typing the number displayed into your phone. {church_interest == "drawn": You hang your arms over the fence as the phone rings. | You turn your back to the church and pace as the phone rings.} 

TODO: SFX for this
<i>Brrring! Brrring!<i/>

You almost drop your phone as you hear the sound of a phone ringing drift from {church_interest == "drawn": in front of you. You | behind you. You turn and } see a silhouette through the front window take a phone off a hook.

"Hello?" the voice is gruff and deep.

*{church_interest != "drawn"} [Hang up]
    You can't hit the "end call" button fast enough, but no matter how many times you press it, the call persists. "We're waiting for you." The voice drifts from your phone, then the line goes dead. The church door creaks open.

*["Hello?"]
    "Ah. It's you. Come in, come in. We're waiting for you." The line goes dead and the church door creaks open.

*{church_interest == "drawn"}[Enter the church]
    ~ church_teleported = true
    ~ dropped_phone = true
    ~ stay += 0.5
    #DELAY: 2.5
    You drop your phone and throw the gate open. You trip over yourself as you run down the path and to the door. You push through the church door and-
    -> Job.Teleport

- The figure place the phone back on the hook and disappears from the window. The door is wide open, inviting you in. {church_interest != "drawn": You shake your head, and take a step back. | You take an unconscious step forward.} 

*[Return to the bus stop]
    You scurry back to the bus stop, and pace until the next bus comes.
    -> Bus

*[Enter the church]
    ~ church_teleported = true
    #DELAY: 2.5
    You {church_interest != "drawn": push | throw} the gate open, {church_interest != "drawn": walking up the path, not entirely sure why you're doing this. | tripping over yourself as you run up the path and to the door.} You enter through the church door and-
    -> Job.Teleport

= Break_in
~ entered_church = true
#DELAY: 2.5
You cross the street and push the gates open. {church_interest == "drawn": You trip over yourself as you run down the path and to the door. {saw_windows: You hear the driver curse and the bus drives off. You know whatever you find is worth being late for work for.} You push through the church door and- | You walk up the path, not entirely sure why you're doing this. {saw_windows: You hear the driver curse and the bus drives off. Work be damned at this point. There's something happening here.} You enter through the church door and- }

You're standing in an old church. The floor boards creek under your weight and everything is covered in a thin layer of dirt and grime. It's empty and dusty and it's- "Just a church?" You finish the sentence out loud. You feel...

* [Disappointed]
    ~ stay += 0.5
    ~ entered_feeling = 0
    You thought it would be more than just... this? You shake your head. {saw_windows: Then what was going on earlier? You glance at the closest window and it's frustratingly static. You rub your eyes and put a reminder in your phone to call the eye doctor after work.| No. This makes sense. Of courses it's just this. Why would it be more?} You slink out of the church, and return to the bus stop. You stare at it, waiting for something to happen that never does, until the bus comes.

* [Satisfied]
    ~ entered_feeling = 1
    #CYCLE: a biblically accurate angel, a face made of birds and flowers, an abstract sunrise, people holding hands, the blood and body of christ
    You spin around taking in every corner. It's just a building. Just a run down wooden box. {saw_windows: You glance at the closest window and it's a static image of vague geometric shapes you think is @. You rub your eyes and put a reminder in your phone to call the eye doctor after work.} You stroll out of the church, and back to the bus stop. You mess around on your phone until the bus comes.

* [Anxious]
    ~ entered_feeling = 2
    #CYCLE: a biblically accurate angel, a face made of birds and flowers, an abstract sunrise, people holding hands, the blood and body of christ
    Something about this feel wrong. Like the church is trying to lull you into a false sense of security. That this is not it's true form. {saw_windows: You glance at the closest window and it's a static image of vague geometric shapes you think is @. You rub your eyes and look again and swear the image shifted.}  You try to shake off the feeling as you leave, and return to the bus stop. You ignore the slimey feeling and mess around on your phone until the bus comes.

-
~ late_for_work = true
It takes an agonizing 20 more minutes for the bus to arrive. You check your Slack messages while you wait and see multiple from your boss. 

#PLAY: email_ding #DELAY: 1.5
"Where are you????"

#PLAY: email_ding #DELAY: 1.5
"This is the 3rd time this month!"

#PLAY: email_ding #DELAY: 1.5
"You can't keep doing this."

#PLAY: email_ding #DELAY: 1.5
"Did you finish my presentation for Project Cypher??"

#PLAY: bus_ambience, true, 2
"You okay, man?" You jump at the voice, not realizing the next bus had arrived. You nod, and fumble with the your wallet to find your ticket. "Come <i>on,</i> man."

*[Board the bus]
    -> Bus

= Window
~saw_windows = true
#ZOOM: 1.5, -242, -121, 1.25 #ICLASS: Swimming
The church's windows are made of stained glass, which isn’t out-of-the-ordinary for the structure. You squint, trying to make out the image on the windows. But no matter how hard you focus, you can't describe the picture on the glass.

#CYCLE: depiction of christ, cross, eye, bird #ZOOM: 2.5, -736, -453, 1 #ICLASS: Swimming-2
The image swims in your vision. Just as you think you've got it, it changes. You think it could be a @. You make a mental note to get your eyes checked on your next day off, whenever that might be.

#DELAY: 2.25 #ZOOM: 5, -1545, -1042, .75 #ICLASS: Swimming-3
Blood thunders in your ears as pressure builds behind your eyes. You strain to—

#DELAY: 1.5 #CLASS: Bus_Honk #PLAY: honk 
HOOOOONNNKK!!

#PLAY: bus_ambience, true, 1 #ZOOM: 1, 0, 0, .5  #ICLASS: NULL
You stumble backwards as the bus swerves, narrowly avoiding you. The driver opens the door and asks if you're alright. You feel yourself nodding, heart pounding. A knot forms in your stomach.

*[Your eyes don't leave the church]

- #CYCLE: blinks, winks
You brush off the driver's questions, and force yourself to stare at that stained glass window until the image focuses into an eye. It @ at you.

*[Go to the church]
    #STOP: bus_ambience, 2
    You ignore the driver's further probing and walk around the bus, pressing a hand against it to steady yourself. The driver continues to shout after you, but you ignore him. <>
    ->Break_in

*[Take a seat]
    You drift to the back of the bus, and sit where you can look at the church through the window.
    -> Bus.Seat
    
*["Do you know when they built that church?"]

- The bus driver gives you a look.

"Is that really important right now?" he says. "Are you alright?"

*["So it was here yesterday?"]

- 
#CYCLE: perturbed, afraid, nervous, tense
You grip his arm as you ask. Your nails dig into his arm and he winces. "I'm going to need you to let go." He looks @. "Do I need to call someone?"

Your eyes dart from him to the church behind him and back. You're losing it. Over a building. You need to calm down. "I'm sorry-" You release the bus driver. "I- I-'m sorry."

*[You scurry to the back of the bus.]
    You find a seat where you can look at the church through the window.
    -> Bus.Seat

=== Bus ===
You board the the bus, and scan your ticket.

* {!investigated} [Take a seat]
    -> Bus.Seat

*["{investigated: By the way d| D}o you know when they built that church?"]

- 
The bus driver looks over her shoulder, then back at you. She frowns.
{late_for_work: "I don't know. Does it matter?" | "Looks older... Maybe 10, 20 years ago?"}

*["So it was here yesterday?"]
    {late_for_work: "Unless they built it yesterday, yeah? Can you just take a seat?" | "I assume as much."} She closes the bus doors.

*["How long have you been working this bus route?"]
    {late_for_work: "Man, just take a seat." | "Too long. You should know, I see you often enough."} She closes the bus doors.

- {late_for_work: You mumble an apology | You nod } and take a seat.
-> Bus.Seat

= Seat
~ temp TempBool = false

#REPLACE: home
You watch the church through the window until it becomes a dot in the distance. Even after it's gone, you still feel on edge. A part of you wants to call out sick and go back home.

*[+home]
    ~ TempBool = true
    ->Bus.home
    
*[You {TempBool: <i>need</i> | want} to forget about the church.]
    #IMAGE: Default #CHECKPOINT: 1, You arrive at work.
    You fear what what will happen if you can't.
    ->Job

= home
You watch the church through the window until it fades into a dot in the distance. Even after it's gone, you still feel on edge. A part of you wants to call out sick and go back to the church. It's waiting for you.

*[You <i>need</i> to forget about the church.]
    # IMAGE: Default #CHECKPOINT: 1, You arrive at work.
    You fear what what will happen if you can't.
    ->Job

=== Job ===
#STOP: bus_ambience, 1 #PLAY: office_ambience, true, 1
{late_for_work: -> Late}
At the office, you get less work done than usual. You find yourself absently doodling and scribbling on scrap paper. Typing nonsense, only to delete it after. Staring blankly into your computer screen.

There is only one thing on your mind, one thing that shouldn't exist but it does. That {church_feeling} church.

You should do something to take your mind off it.

*[Scan some documents]
-> Job.Scan

*[Catch up on emails]
-> Job.Emails

= Late
You find yourself in your boss' office, staring at the floor as her eyes bore into you. She says nothing for a long time, the only sound is the ticking clock and the tapping of her nails against the desk. You chew on the inside of your cheek and pick at your nails as you wait for her to say something- anything. After an eternity, she lets out a long and deep, disappointed sigh.

"Care to explain yourself?" You snap up, and she stares at you, waiting. "You know how I feel about tardiness. And on today of all days too!"
~temp TempBool = false

* [Apologize]
    "I'm sorry. Did I-"
    
* [Make an excuse]
    "The bus was running late and then with traffic-"
    
* [Tell the truth]
    ~ TempBool = true
    "I was at the church by my house and then-"   
    
- "I don't want to hear excuses, I want answers! You're lucky Jenny has an eagle eye and was able to cover for you!" She's not yelling, but loud enough that anyone outside the room could hear. Loud enough that your ear drums warble. You grip the photo in your pocket and clench your jaw. "I swear, you <i>try</i> to make my life harder. I give you the <i>easiest</i> jobs at the company, all you have to do is check your email and print documents. EMAILS. That's something you can monitor on your way in, and YET—"

The whole office was quiet as your boss got louder and louder.

* [Apologize]
    You apologize, but it doesn't seem to matter as she continues to scream at you. <>
    
* [Stay silent]
    She continues to scream at you, not caring that everyone could hear. Some even stared at you through the office windows. <>

* [Go home]
    ~work = 4
    ~ was_fired = true
    You were 40 minutes late for the first time ever. Any other lateness was minutes at best. Why do you need to sit here and be screamed at for a one time occurrence? Your coworker is late everyday and she greets him with a <i>smile.</i> You stand up, and start for the door. "Why are you going?! I'm not done talking!" Her voice rings in your ears.
    
        ** [Flip her off]
            You turn and flip her off. <>
        
        ** [Ignore her]
            You ignore her. <>
            
        --  "You, you- <i>YOU-</i>" She sputters. "You're FIRED!" You flinch, but leave all the same. This job sucked anyway.
            ->Walk_Home

- You sit there and take it. It goes on for 20 more minutes before she tells you that you're "on thin ice" and to "clean up your act if you want to keep your job". You nod and leave her office, returning to your computer. There's an electricity in the air as everyone slowly returns to their tasks. You can hear the whispers.

You should do something to take your mind off it.

*[Scan some documents]
    -> Job.Scan

*[Catch up on emails]
    -> Job.Emails

= Teleport
"Excuse you! Is there something so important that you needed to barge in here?" You blink, confused, and find yourself in a meeting room. Your boss and coworkers all stare at you, a mix of annoyance and confusion. You were just at the church. How did you? "Well?"

*[Apologize]
    "Sorry, I- Sorry." You stumble over your words and look at the floor as you leave, closing the door behind you. 

*["How did I-"]
    Your eyes dart around the room. Is this real? How could-
    
    "Get out!" your boss bellows and you jump. You mumble an apology and look at the floor as you leave, closing the door behind you. 
    
*[Leave without saying anything]
    You say nothing, quickly leaving the room and closing the door behind you.
    
- "Why do I even..." your boss mutters, and you hear snickering from for other coworkers. Your face warms, and you ignore the whispers as you make your way back to your desk.

#PLAY: office_ambience, true, 1
You sink into your chair and lean your head against the desk. You wonder if you're losing it. You <i>were</i> at the church. {called_number: You called the number- You reach into your pocket, {dropped_phone: but find your phone missing. | and check your recent calls. The number its at the top. You place your phone on the desk. } You let out a deep sigh and rub your eyes. You were there. It was real.} 
TODO:check thnis after writing break in.

"Hey, so what the hell was that?" Your boss bangs on your desk. "Hello? You in there?" You snap up, and she stares at you waiting for an answer.
~temp TempBool = false

* [Apologize]
    "I'm sorry. Did I—"
    
* [Make an excuse]
    "I walked into the wrong meeting room by mistake and—"
    
* [Tell the truth]
    ~ TempBool = true
    "I was at the church by my house and then—"   
    
- I don't want to hear excuses, I want answers! You're lucky this was <i>just</i> an internal meeting!" She's not yelling, but loud enough that everyone can hear. You grip the photo in your pocket and clench your jaw. "I swear, you <i>try</i> to make my life harder. I give you the <i>easiest</i> jobs at the company, all you have to do is check your email and print documents. <i>WHY</i> would <i>YOU</i> even be in <i>ANY</i> meetings?!"

The who office was quiet as your boss got louder and louder.

* [Apologize]
    You apologize, but it doesn't seem to matter as she continues to scream at you. <>
    
* [Stay silent]
    She continues to scream at you, not caring that everyone was staring. <>
    
* [Go home]
    ~work = 4
    ~ was_fired = true
    You walked interrupted an internal meeting, and the only person that seems to have an issue is her. Why do you need to sit here and be screamed at for such a minor issue? You stand up, and push past your boss. "Why are you going?! I'm not done talking!" Her voice rings in your ears.
    
        ** [Flip her off]
            You turn and flip her off. <>
        
        ** [Ignore her]
            You ignore her. <>
            
        --  "You, you- <i>YOU-</i>" She sputters. "You're FIRED!" You flinch, but leave all the same. This job sucked anyway.
            ->Walk_Home

- You sit there and take it. It goes on for 10 more minutes before she tells you that you're "on thin ice" and to "clean up your act if you want to keep your job". You nod and turn back to your computer. There's an electricity in the air as everyone slosly returns to their tasks. You can hear the whispers.

You should do something to take your mind off it.

*[Scan some documents]
-> Job.Scan

*[Catch up on emails]
-> Job.Emails

= Scan
~ work = 1
You choose to do something mindless and easy. You grab a stack of papers marketing needs sent out, and head to the machine.

*[Maybe the monotony will take your mind off things.]

- #PLAY: scanner, false, 0.5
You enter a rhythm of placing a page, entering an email, and sending it off. You try to focus on only your actions to prevent your mind from wandering. 

Place page. Enter email. Send it off. Place page. Enter email. Send it off. Place page. Enter email. Send it off. Place page. Enter email. Send it off. Place-

*["Hey- What are you doing?"]

- #STOP: scanner, 1.5
You jump and look up to see a coworker from your department. You don't talk to her often, but she's nice enough. She looks... concerned?

*["Just sending out some scans."]

*["Trying to keep busy."]

- She nods slowly, and picks up one of the papers from your done pile. "And... <i>this</i> is what you're sending out?"

"Yeah, Marketing needed—"

She cuts you off as she starts to read off what's on the page. "'Do you know about the church at the end of the street?" 

The hairs on the back of your neck stand up. {entered_church: When you went in—} {entered_feeling == 2: You were right to be anxious. | It was— was nothing. Your heart pounds {entered_feeling == 0: in excitement. | anxiously.}}

*[<i>It can't be</i>]

- "The church at the end of the street knows me but I don't know it." She continues. Your chest tightens, and you frantically go through the rest of the papers. You know these were marketing reports. "It waits and waits for me to come back. It has gotten impatient."

All the papers repeat what you coworker said. Over and over again. All in neat handwriting. <i>Your</i> handwriting. You clutch the papers tightly, until your knuckles go white and your nails pierce through. <i>When did they change?</i>

"Did you write this?" She purses her lips at you. "Is this your idea of a bad joke?"

No, you didn't write this. You know you didn't. Did the church...? {entered_church: {entered_feeling == 1: No. It was just a normal church. You— You must be losing it. | {entered_feeling == 2: It didn't feel right when you were in there. It must have done something, that much you're sure of, but the question is <i>why?</i> | {entered_feeling == 0: It must have. You knew it had to be more than just an empty building. }}}} {called_number: <i>Why?</i> {church_teleported: You went inside. You— You did what it wanted. So why? | Is this because you didn't go inside? You didn't do what it wanted and now it wants to ruin you?}} 

*["I'm going home early today."]

*["I'm going to work from home for the rest of the day."]

*[Say nothing and leave.]

- ->Walk_Home

= Emails
#PLAY: email_ding, false, 0, 1
You pull up your email and scroll through the new ones, only reading the subject lines for anything that seems important. Meeting invitation, spam, spam, client question, church inquiry, meeting—

Wait. Church inquiry?

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

*[Give in and open it]
    -> Job.Open

- You mark the church email as spam and respond to the client, making sure to CC the correct person they should speak to. You close your email and rub your eyes with the palm of your hands. 

#DELAY: 3
<i>Stop thinking about it.</i> You tell yourself. {entered_church: <i>It's nothing but a church, so why—</i> | {church_teleported: <i>It didn't want you, so why—</i> | {called_number: <i>You can't let it win—</i> }}} 

#PLAY: knocking
"Knock knock, can I talk to you?" You look up to see your manager at your cubicle door, holding a few sheets of paper. They look upset.
~ work = 2

*["Yeah, what's up?"]
    "I'll be quick. Can you explain what your last email meant?" They sound frustrated. "Is it a joke? A prank?"

*["Now's not a good time."]
    "Right..." they say and continue anyway. "Can you explain what your last email meant? Our client is not happy."
    
- 

*["What?"]

*["They sent the email to the wrong department so..."]

- They roll their eyes and drop the papers on your desk. "You're about to lose us our best client!" You pick them up, and your stomach drops. In your hands is are print outs of emails from you to a client. They all say the same text over and over again:

"Do you know about the church at the end of the street? The church at the end of the street knows me but I don't know it. It waits and waits for me to come back. It has gotten impatient."

"Do you understand how this can hurt sales?" They hiss. You clutch the papers until your knuckles go white, and your nails pierce through. "You'd be <i>lucky</i> if I only suspend you for this!"

No, you didn't write this. You know you didn't. Did the church...? {entered_church: {entered_feeling == 1: No. It was just a normal church. You— You must be losing it. | {entered_feeling == 2: It didn't feel right when you were in there. It must have done something, that much you're sure of, but the question is <i>why?</i> | {entered_feeling == 0: It must have. You knew it had to be more than just an empty building. }}}} {church_teleported: <i>It didn't want you, so why—</i> | {called_number: <i>You can't let it win—</i> }}


*["I'm going home early today."]

*[Say nothing and leave.]

- ->Walk_Home

= Delete_Again
#DELAY: 0.5
As you click the button to delete the email—

#PLAY: email_ding, true #STOP: email_ding, 0, 2 #DELAY: 2.5
You get a flurry of new emails. "Church Inquiry. It's waiting. It's impatient. Hurry up. Hurry up. Hurry up."

#PLAY: email_ding, true #STOP: email_ding, 0, 3
You try to delete them, but they just keep coming. "Where are you?" "Come home." "(No Subject. Image Attached Is this a prank? Or is it...

*[Open Email]
    ~ know = true
    You give in, and click the latest email. <>
    -> Job.Open

*[Continue Deleting]
    You don't care who, or what, is doing this. You just want it to stop. {entered_church: {entered_feeling == 1: You almost feel silly thinking it's anything besides a dumb prank. A church- a building - is not emailing you. It was just a normal church. You're just on edge. | For a second you think it's the church before you discard the thought. That'ss not possible.}} {called_number: <i>Why is it...?</i> {church_teleported: You went inside. You- You did what it wanted. So why? | Is this because you didn't go inside? You didn't do what it wanted and now it wants to ruin you?}} 
- 
#PLAY: email_ding, true #DELAY: 1.5
You can't delete them fast enough.

#DELAY: 1.5
They just keep coming. You try to—

#STOP: email_ding
"Hey are you—" A hand grabs your shoulder, and you jump up from your chair, slapping the hand away. 

"Leave me ALONE!" you shout, breathing heavy.

"What's your problem?!" You realize all too late that this was not the church, but your coworker. You stumble over yourself trying to apologize. "We all have rough days but.... What the hell?!"
~work = 3

*["I'm— I'm going home early."]

*[Say nothing and leave.]

- ->Walk_Home

= Open
~ work = 3

- {know: | You click the email.} It shows an image of the church, but in a different place. Not at the end of your street, but near your grandparents house, several states away. You see a younger version of yourself standing outside and grinning. You wore clean church clothes. 

Your mouth goes dry. You went to church when you lived with them, but couldn't be <i>this</i> one. Could it?

*[Scroll down]

- Under the image, the text reads: "Don't keep it waiting."

You slam the laptop shut. A fuzzy memory tickles the back of your mind. Suddenly, everything clicks into place.

*[You know the church]
    ~know = true

- You don't know how, but you know it. You slam you fist against your desk. "Why can't I...?" You mutter. The memory refuses to surface with only vague images and feelings coming to mind. You see yourself inside. You're scared. You're trapped. But that's all you can remember. You hit the desk again, harder. 

"It's right there, so just..." You murmur to yourself. "I was...?" You had found something. And then it let you out? No. It wouldn't- {entered_church: But it did. Today it did too. {entered_feeling == 1: It let you think everything was okay and leave.} | {called_number: It welcomed you in today, {church_teleported: but it sent you away. | so why would it let you out as a child? When it had you? } | Or would it? Maybe it's just playing with you. }}

"Everything... Okay...? In here?" It's your coworker. You wave him away, and focus. You can remember...

* [The escape]
    You can see the door opening, but the younger you didn't feel relief. No, they felt... dread? They had to crawl because their legs shook so badly. The whole time they clutched something in their hand. Something important. They left the item behind as a... Promise? Why? Did you—
    
* [The fear]
    You were terrified. It was dark. So, so dark that even in the memory all you can see is the inky darkness. The younger you curled into a ball and cried until there was nothing left to cry. Then, a warm red light illuminated you, along with a soft melody. And someone reached out...? Were you not—

* [The aftermath]
    Your grandmother wouldn't let you out of her grasp for at least a month after they got you back. There were a lot of cops and doctors and questions. You remember being that every church you saw for a long while was <i>the</i> church. It was following you? Stalking you? When did it stop? When—

TODO: maybe a choice here about how to react?
- "Hey, what's—" Your coworker suddenly grabs your shoulder, and you... smack his hand away, jumping up out of your chair. You lean against the wall to support yourself, breathing heavily as you do, as your coworker snaps. "What's your problem?!"

* ["I— I'm fine!"]
    Your voice is shrill. You force a smile. <>

* ["Why are you here?"]
    You snap at him. You were so close to figuring it all out and he had to come and ruin it all. <>


- Your coworker stares at you is disbelief, and you shove your hand into your pocket, searching for the polaroid inside, hoping to calm yourself, only to find it missing.

~ photo_ripped = true
 "No no no, where...?" You franticly search every pocket, finding them all empty. You look to your desk and find small, ripped pieces of a once comforting memory. "Did I...?"

"Seriously, what's up with you?!" He asks as you gather the pieces in your hands, and begin trying to tape them together, but the pieces are too small. You swallow the lump in your throat, and face your coworker. "Uhhh... You alright?"

*["I'm— I'm going home early."]

*[Say nothing and leave.]

- ->Walk_Home

=== Walk_Home ===
TODO: is work = 4 used anywhere besides yuelled at?
{ work:
    - 1: "Maybe you should take some sick days..." she says, her voice trails off. You nod, and return to your desk to gather your things.
    
    - 2: "I want an apology sent to them within the day, or don't come back at all." They say, as you gather your things. You nod, and they shake their head muttering curses, leaving you alone in the cubicle.
    
    - 3: "Yeah, whatever." He says as he leaves. You quickly start packing up your things.
    
        {photo_ripped: You lay out the pieces of the polaroid, all too small to really make anything out. You can't bring yourself to throw it away, instead placing each piece in the small drawer of your desk. You'll fix this tomorrow, after a good night's sleep.}
        
    - 4: 
        #STOP: office_ambience, 1 # IMAGE: BusStop
        You sit at the bus stop, your boss's words clanging around your head. It's not the first time she's yelled at you before, but this felt worse. You're almost relieved she fired you. The bus comes quickly, and you look forward to having the day to yourself. 
    
        <i>But what about the church?</i> Your stomach {church_interest != "drawn": drops | jumps}. You shake your head. Hopefully it will be gone. Hopefully it got all it wanted from you and moved on. Hopefully.
     
    - else:
        Error
}

TODO: this and the next feel like semi awkward jumps
{know: You need to avoid the church. It wants you back, and everything inside of you screams that you cannot go back— that if you do, you won't come out again.}

#STOP: office_ambience, 1 #IMAGE: BusStop.png
The bus ride home is shorter than it's ever been. You get off at your regular stop. The church is still there. You debate taking a longer way home by walking up and around the block, rather than walking past the front gates of the church.

TODO: why?
* {!church_teleported} [Take the long way home]
    ->Walk_Home.Different

*[Take the usual path home]
    Tentatively, you walk your usual path home, and try not to look at the church.
    ->Walk_Home.Usual

= Call_Grandparents
You dial the number for their landline. You tried to convince them to get cell phones once, but your grandfather staunchly refused, claiming something about them being "addictive cancer boxes" and your grandma agreed. The phone rings a few times before it connects.

"Hello, Candice speaking!" Your grandma's cheery voice is on the other end.

"Hey, it's me. I had a que—" You start, but she cuts you off with an excited gasp.

"George! George! Come here! Our favourite grandchild called!" You hear your grandfather groan, and your grandma scolds him, which leads to more groaning. "Oh, hold on, sweetie." You hear a shuffling as you assume your grandma wass making her way to where your grandfather sat. You scratch at the back of your neck while the burning sensaion grows stronger.

* ["Grandma? There's something important I need to ask you."]
    "Oh, one moment dear. <>

* ["Is now a bad time?"]
    "Oh don't be silly, we're always happy to hear from you. <>

- Say hi to grandpa!" You don't have time to respond before she's already talking again. Something pulls at your leg and you shake it out, but the feeling only grow stronger. "You really should call more. We're not getting any younger you know."

She keeps talking, your grandfather occasionally adding a grunt to agree with her. She's not going to let you get a word in unless you cut her off. You look out at the stop sign on te corner and frown. Shouldn't it be closer by now?

* ["Mhm, but grandma do you know anything about a... church?"]
    The line goes quiet and for a second you think you were disconnected, but then your grandma says quietly, "What church?"
    
    TODO: it follows u to work
    #CYCLE: weird, long, upsetting, troubling
    "It's at the end of my street. I don't particularly... remember it being there before today, but today has been @." You bite your lip. "{know: I saw a picture today of us, all of us, there- At the church I mean. | This sounds crazy but I think it followed me to work. } Do you know anything about it?"

*["Do you know anything about the church by my house?"]
    The line goes quiet and for a second you think you were disconnected, but then your grandma says quietly, "What church?"
    
    TODO: it follows u to work
    #CYCLE: weird, long, upsetting, troubling
    "It's at the end of my street. I don't particularly... remember it being there before today, but today has been @." You bite your lip. "{know: I saw a picture today of us, all of us, there— At the church I mean. | This sounds crazy but I think it followed me to work. } Do you know anything about it?"

- "Have you gone inside it?" It's your grandfather, his voice is rough. "Tell me you haven't. Are you home? You should come here."

* [Say that you have ({entered_church || church_teleported: truth | lie}) ]
    {entered_church: "Yeah but it was just—" | {church_teleported: "Kind of? It's hard to explain—" | "Yeah, but it wasn't—"}}
    
    Your grandma lets out a choked cry and starts to pray. 

* [Say that you haven't ({entered_church || church_teleported: lie | truth})]
    {church_teleported: "Not really? It's hard to explain—" | "No, it looks abandoned so—"}
    
    "Thank God, Jesus, and mother Mary." Your grandma says a prayer. 
    
    TODO: need to get more of the urgency here
- <> The call starts to sound far away. You can hear your grandfather say something, but can't make it out. The closer you get to the corner, the further away your grandparents voice sounds. By the time you finally reach the corner the call goes dead. 

#REPLACE: stop sign.
You reach out and grab the sign with both hands. The burning is gone. Nothing holds you back. Breathing heavily, you smile and look up at the [stop sign.]
    
*[stop sign.]
->Stop_Sign

= Different
~turn = "walking"
~avoid_church = true
# IMAGE: Stop_Sign
You don't look at the church, and instead turn around and walk up the block. A burning creeps up the back of your neck, as if someone is staring you down. {know || called_number: You know what it is. It's not going to let you go again. | {entered_church: {entered_feeling != 0: You're paranoid. It's nothing. }}} {know: You think back to the imgaine of you infront of the church with your grandparents. Maybe you should give them a call{dropped_phone: once you're home and have a working phone}.}

*[Face it]
    ->Walk_Home.Turn_Around

*[Scratch your neck]

* {!dropped_phone && know} [Call grandparents]
    ->Call_Grandparents

- 
#ZOOM: scale(1.25),pos(2,2)
#PLAY: walking_fast_pavement, true, 1
You itch at your neck, trying to ignore the feeling and pick up the pace. The corner where you need to turn is so close. The burning sensation grows, and something grabs at your legs. The wind picks up around you. {know || called_number: You're putting off the inveitable.}


*[It's waiting]
    ->Walk_Home.Turn_Around

*[Shake out your leg]

- 
~turn = "running"
#ZOOM: scale(1.5) translate(-12%, 16%),inset(0px 0px 26% 17%)
#STOP: walking_fast_pavement, 1.5 #PLAY: running_pavement, true, 1.5, 1
You shake out your leg, but the tugging pulls harder. You stumble forward and break into a run. You can almost touch the stop sign on the corner. How have you not reached it yet? The burning sensation lessens, replaced with lead weights at your ankles. Your chest feels heavy, like someone has their arms wrapped tightly around you.

You hear something on the wind. A voice?

*[But it's growing impatient]
    ->Walk_Home.Turn_Around

*[Keep. Going.]

- 
#ZOOM: scale(2) translate(-12%, 21%),inset(0px 0px 39% 21%)
#STOP: running_pavement #REPLACE: stop sign.
You reach out and grab the sign with both hands. The burning is gone. Nothing holds you back. Breathing heavily, you smile and look up at the [stop sign.]
    
*[stop sign.]
->Stop_Sign

= Turn_Around
#ZOOM: unset,unset #STOP: running_pavement #STOP: walking_fast_pavement
You stop {turn}, and ball your fists. All sensations stop.

*[Face the church]

- 
#IMAGE: Chuch_Looming #PROP: closed_gates
You spin around to face it, and find yourself.. in front... of the church? You look up and down the street. You're not any further from the corner, and the bus stop isn't any closer. Then...

{know || called_number || entered_feeling == 0: It's following you. You wipe sweat from your brow.<br><br>It can move.| {entered_church: {entered_feeling != 0: Was it always this far down the road? This morning you were able to clearly see it from the bus stop...<br><br>You take a breath, and reach into your pocket. The feeling of the worn polaroid calms you. You're being unreasonable. It's just a building. Just a church. A {church_feeling} church.}}}

*[Walk past it]
    {know || called_number: You know you shouldn't, but you know it won't let you turn away.} {entered_feeling != 0: You try not to look at the church as you walk past.}
    ->Walk_Home.Usual

= Stop_Sign
#ZOOM: unset,unset #IMAGE: Chuch_Looming #PROP: closed_gates
It looms over you, taller than you remember. Your hands tightly grip the front gates. The door is open. 

{know || called_number: You grimice. | {entered_church: {entered_feeling != 0: But how did it...? You were at...? | A smile crawls to your face.}}}

*[Open the gates]
    #PLAY: gate_open #PROP: closed_gates, true #PROP: open_gates
    You throw the gates open, and the edges of the dirt path to the church brighten, small lights lining the path. Motion activated maybe?

*[Let go]
    #PLAY: gate_open #PROP: closed_gates, true #PROP: open_gates
    You pull your hands from the gate and take a step back. The gate groans as it opens. The edges of the dirt path to the church brighten, small lights lining the path. Motion activated maybe?
- 

*[Take a closer look]

- You take a single step onto the property to reach the open gate, and the edges of the dirt path to the church brighten where you step. Small, shining lights line the path. <>

{know: A feeling of unnerving calm washes over you. You know you need to leave. You know you need to walk away. But you also know you should keep going. There's no harm in looking. | {entered_church: You think you should take a closer look. For nothing else, it will confirm your feelings about the church. {entered_feeling == 1: You know it's nothing, so checking again won't change anything.} | {called_number: {church_teleported: These didn't light up this morning, or maybe you just didn't notice. | It really wants you to come inside. } | Motion activated maybe?}}}

*[Take a closer look]

- You take a step onto the property. The ground is soft, but firm. You crouch down in front of the closest light. They have tiny solar panels on the top. In this position, the lawn is at eye level, but not a single weed crosses onto the soft dirt.

You stand up and trace the path with your eyes, looking for anything that disturbs it.

*[Walk up the path]
    ->Walk_Up_Path

= Usual
#IMAGE: Chuch_Looming #PROP: open_gates #PROP: closed_gates
#PLAY: gate_open
As you pass the front gate, it creaks open. You reach for the image in your pocket. {know: You should keep moving.}

*[Investigate]

//On mouse click, change to "investigate
*[(Continue walking home)Investigate]


- 
#IMAGE: Chuch_Looming #PROP: open_gates
Against your better judgement, you stop, and look at the church. The gate is open. {know: You should keep moving. It's waiting for you. It's making the choice easy. | {called_number: Once again, it invites you inside. | {entered_church: {entered_feeling == 2: The slimey feeling returns as a trickle of sweat slides down your back. | {entered_feeling == 0: Your heart pounds in excitment? fear? Maybe it <i>wasn't</i> just nothing. | It's— It's just a church.}} | Probably the wind blew it open. Probably.}}}

*[Close the gate]

*[Continue walking home]
    ->Walk_Home.Lost

//if we do NOT think it's just a normal church OR we called it && are drawn OR teleported
*{(entered_feeling >= 0 && entered_feeling != 1) || (called_number && (church_teleported || church_interest == "drawn"))}[Go inside]
    -> Walk_Up_Path

- You take a single step onto the property to reach the open gate, and the edges of the dirt path to the church brighten where you step. Small, shining lights line the path. <>

{know: A feeling of unnerving calm washes over you. You know you need to leave. You know you need to walk away. But you also know you should keep going. There's no harm in looking. | {entered_church: You think you should take a closer look. For nothing else, it will confirm your feelings about the church. {entered_feeling == 1: You know it's nothing, so checking again won't change anything.} | {called_number: {church_teleported: These didn't light up this morning, or maybe you just didn't notice. | It really wants you to come inside. } | Motion activated maybe?}}}

*[Take a closer look]

- You take a step onto the property. The ground is soft, but firm. You crouch down in front of the closest light. They have tiny solar panels on the top. In this position, the lawn is at eye level, but not a single weed crosses onto the soft dirt.

You stand up and trace the path with your eyes, looking for anything that disturbs it.

*[Walk up the path.]
->Walk_Up_Path

= Lost
You take a few steps before stopping, and look back at the open gate. You want to go home. You do. But something tells you to close the gate before you do...

*[What if a kid gets lost?]
~ temp_bool = true
#PLAY: footsteps_child_grass #STOP: footsteps_child_grass, 3
No sooner than you think it, you hear the sound of little feet and laugher carried on the wind. 

*[Or an animal gets trapped.]
~ temp_bool = false
#PLAY: meow
No sooner than you think it, you hear the sound of growling and meowing on the property. 

- {know || called_number: It's the church. You know it's the church. It has to be, but what if— | {entered_church: {entered_feeling == 1: For a moment, you think it's the church reading your thoughts. | Is the church reading your thoughts?} {entered_feeling == 2: You shake it off. It's just a coincidence.} {entered_feeling == 1: You know how it sounds, but you can't shake the feeling.} You focus back at the task at hand.}} <>

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

- You take a single step onto the property to reach the open gate, and the edges of the dirt path to the church brighten where you step. Small, shining lights line the path. <>

{know: A feeling of unnerving calm washes over you. You know you need to leave. You know you need to walk away. But you also know you should keep going. There's no harm in looking. | {entered_church: You think you should take a closer look. For nothing else, it will confirm your feelings about the church. {entered_feeling == 1: You know it's nothing, so checking again won't change anything.} | {called_number: {church_teleported: These didn't light up this morning, or maybe you just didn't notice. | It really wants you to come inside. } | Motion activated maybe?}}}

*[Take a closer look]

- You take a step onto the property. The ground is soft, but firm. You crouch down in front of the closest light. They have tiny solar panels on the top. In this position, the lawn is at eye level, but not a single weed crosses onto the soft dirt.

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

- You're moving automatically. {church_interest == "drawn" || entered_feeling == 0: Your heart pounds in your chest. | {know || church_interest == "nothing" || entered_feeling != 0: You want to go home.}} The church door is open and inviting. You can't see inside. 

Around halfway up the path, you hear another set of footsteps.

*[Stop]
    ~ temp_bool = true

*[Ignore it]
    ~ temp_bool = false
    ->Walk_Up_Path.Run

- #STOP: footsteps_player, 0.5 #STOP: footsteps_scary, 0.5, 2
Stopping in your tracks, you wait and listen. You hear nothing, but the hairs on the back of your neck stand up. {know || entered_feeling == 2: It has to be another trick. | {entered_feeling == 0 || church_interest == "drawn":  | {entered_feeling == 1: }}} 
TODO: ^^^^

<s>Something</s> Someone is behind you, and they know you know. Your only choice is the church or confrontation. Your knees lock as your mind race. You must choose.

*[The church]
    ->Walk_Up_Path.Run

*[Confrontation]

- #DELAY: 2
You take a breath and quickly spin around, ready for whatever may await you, and see...

Nothing. No one's there. You laugh.
{know || entered_feeling == 0 || church_teleported: The church will do anything to lure you in.| Your mind is playing tricks on you. It was probably the wind.}

{ know: You decide that you've been too close for too long and start for the gate. You think you deserve a long, hot bath after today.| You decide that you've trespassed for long enough, and start for the gate. You think you deserve a long, hot bath after today. }

*[Walk to the gate]

- 
#IMAGE: Chuch_Looming #PROP: open_gates
You grab the gate with both hands, and look up at the church one last time. It's quiet and dark. { - know: It lost. }

*[Pull the gate closed]

- 
#PLAY: gate_close #DELAY: 1.73 #PROP: open gates #PROP: closed gates
Just as it slams shut...

#EFFECT: LightDark # IMAGE: Default #PROP: closed gates 
~CurrentProp = ""
Everything goes dark.

*[Wait for your eyes adjust]
    #DELAY: 1.5 
    You hold your eyes closed and count to five.
    
    #DELAY: 1 #EFFECT: LightDarktoUsed
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

- #STOP: footsteps_player #STOP: footsteps_scary, 0, 1 #PLAY: door_slam, 0, 0.5,  #DELAY: 5 #EFFECT: LightDark # IMAGE: Default #PROP: open_gates
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

#PLAY: lock_rattle, 0, 0.5
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
# IMAGE: Church_Inside
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

# IMAGE: Office_Final
You open the door to find a side office, entirely covered in dust and cobwebs. The adjacent walls are made of bookshelves, packed full of books and boxes. A desk sits at the far wall with a stained glass window above it.  {saw_windows: You avoid looking at it. }

{
- object == "crowbar": 
    #ICLASS: Overlay,,overlay-spotlight #PROP: item #PROP: crowbar
}
{
- object == "screwdriver":
    #ICLASS: Overlay,,overlay-spotlight #PROP: item #PROP: screwdriver
}
{
- object == "sledgehammer":
    #ICLASS: Overlay,,overlay-spotlight #PROP: item #PROP: sledgehammer
}
On the desk sits a {object}, illuminated by a red spotlight from the window. It's not covered in dust like rest of the room, as if it has been placed there just for you.

~ room = true

*[Pick up the {object}]
~ temp_bool = false

*[Leave it]
~ temp_bool = true

- 
#PROP: item #PROP: sledgehammer #PROP: screwdriver #PROP: crowbar #ICLASS: Overlay,overlay-spotlight,
{
    - temp_bool:
        { 
        - know: The church is playing with you now. It knows what you wanted, and gave it to you.
        - else: Something tells you that even if you take it, it wouldn't matter. That the door won't budge for you.
        }
    
        # IMAGE: Default
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
# IMAGE: Default
You jam the crowbar in between the door and the wall, at the latch, and pull. 

*[The door groans.]

- #DELAY: 2  
You pull harder, putting all your weight into it. You lean back a bit further and—

#PLAY: crowbar_break #CLASS: Kick #DELAY: 1
Crack!

Half the crowbar is left in your hand. You drop it, but don't hear it hit the ground.

*[The door looks untouched.]
    You stop, fall to the floor, and stare at the untouched door in front of you. You let out a short, hysterical laugh that could be mistaken a sob as the realization hits you.
    -> Trapped

= Screwdriver
#DELAY: 1.5 # IMAGE: Default
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
# IMAGE: Default
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
#PROP: polaroid
You pull the polaroid out from your pocket, hoping to think about better times. It's dark, but you can see enough to make out shapes. You trace the image of your younger self, and the gate behind them with your finger, then the church behind—

Church? 

*[Your mouth goes dry.]

- The image is different. It has changed. Instead of a comforting memory, it has morphed into one you don't know. Something that tickles the back of your brain, but you don't know why.

*[You grip the picture tightly in your hands.]

- The image isn't fake, somehow you know this. The church always felt {church_feeling} in a way you didn't understand why.

#PROP: polaroid
The memory refuses to surface, only vague images and feelings. If you close your eyes... You're scared. You're trapped. You're... inside? Inside where—?

Your nails peirce through the image, and your knuckles turn white. Your hands shake as you try to remember when— 

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

You have been here before. You found... something— No. Someone? You can't remember, but <i>you got out.</i>

#DELAY: 1.5
<i>Riiiiipppppp</i>

There is a way out.

<i>Riiiiipppppp</i>

*[You just need to figure out how.]

- 
#EFFECT: LightDarktoUsed
You blink rapidly, shaking yourself out of the memory, and look down at what's left of the image in your hand. Tiny pieces sit in a pile on the ground in front of you. Did you...?

You swallow the lump in your throat and carefully pick up pieces, ensuring you get every little piece. You delicately place them back in your pocket. Once you're out of here, you can fix it.

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

- A low hum echoes through the room, sending a chill across your entire body. That's what the church wants but…

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
#ENDING: 4, Bad Ending: Why Shouldn't I stay?
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
#EFFECT: LightDarktoUsed
You slowly stand and look around for the source, taking a few steps into the church. You open your mouth, but before any words can leave your lips, cold, unseen hands covers your mouth. You freeze.

"Don't," is whispered into your ear, a woman's voice.

*[Nod]

*[Try to remove the hands]
You claw at your mouth, attempting to grab hands silencing you, and stand up. "Let GO!" 

"You don't... remember..." The hands fall away, and the room goes still. "This is all I can do."

#ICLASS: Overlay,,light-above
The hands fall away. The voice goes quiet. The room turns still.
-> Trapped.Light

- "Look up." The hands removes themselves from your mouth, and rest on your shoulders. You do as you're told and turn your gaze up. The window above the door has morphed into a stained glass eye. It's pupil darts around, looking for something. "It looks for you."

You look back down, and the hands disappear behind you. You can feel something cold hovering near you.

You have so many questions.

*["What IS that?"]

*["Who, or what, are you?"]

*["How do I get out?"]

- The voice does not answer, but you know it's still there. You can feel it hovering by your ear.

"This is all I can do for you now. The rest is up to you."

Wind blows around you, and before you stop yourself you call out.

*["Wait!"]

*["The rest? What—!"]

- 
#EFFECT: IntialSight
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

- #ENDING: 3, Bad Ending: Sleeping Forever
...
*[But you don't wake up.]
->Credits

= Light
A red light glows from above you.
*[Look at the light.]

- 
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
#EFFECT: intense-glow
The back of your throat goes tight as you hold back tears, but you don't know why. 

{

    - light_feeling == "relief":
        Is some part of you... happy to be back? Reassured to be back in a place like this? Comforted to be bathed in this light?
    - light_feeling == "confused":
        A flurry of emotions whirl within you, many of which you fail to identify. You know you need to escape this light, but you want to stay for just a bit longer.
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

# ICLASS: Overlay,light-above,
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
        #DELAY: 6.5 #EFFECT: angry-glow
        You take a heavy step back and pull away from the light. This feeling of { temp_string } This much you know. This much you trust. The rest is the church.
        
        #PLAY: screeching #ICLASS: Angry_Screeching #CLASS: Angry_Screeching 
        An earsplitting shriek pierces through the building. You cover your ears, but it only gets louder and louder the more you block it out. The pressure builds until you can barely stand, the warm bath of the light burns your skin. 
        
        *[You can barely stand it.]
        -> Trapped.Light_Leave
        
    - else:
        #EFFECT: leave-glow #PLAY: groaning_happy, false, 0.25 #STOP: groaning_happy, 1.5
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
        "N—no!" you scramble forward, chasing the last licks of the light before its gone. The pressure alleviates, and all the { temp_string } with it. The window returns to it's normal, swirling state. 

        With the light gone, you snap back to reality. "Why did I...?" you mutter to yourself. You dig your nails into your hand.
        
       *[Turn away from the window]
        ~ temp_bool = false
        -> Inside


}

= Light_Leave
    #STOP: screeching #EFFECT: remove-glow
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
#PROP: flash #PLAY: flashlight_on
It looks battery operated, and gives off enough light to see around you. You should be able to explore with this.

*[Read the note]

#EFFECT: flashlight_on #PROP: flash #PROP: note
- The note is from an old piece of parchment. It feels like it could crumple into dust.

"Find the heart and <color: #3f1313>destroy</color> it.<br><br>The church will try to stop you.<br><br>It will do anything to keep you here. Stay out of it's <color: #3f1313>sight.</color><br><br>Do not become it's next <color: #3f1313>meal.</color>"

*[Meal...?]
#PROP: note
You shutter at the thought. You wonder how long you have until it fully digests you.

*[Sight...?]
#PROP: note
Well.... You glance up at the swirling window.

You remember how the church's sight warped your thoughts and reasoning. { temp_bool_2: How you had to pull yourself out. | How you would have done anything to stay there a little longer.} You cannot let that happen again. If the church sees you again...

*[Heart...?]
#PROP: note
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

# IMAGE: Church_Inside #CHECKPOINT: 3, You are told to find the heart.
The flashlight gives off enough light for you to see what's near you. You can make out a podium facing some pews, a confessional off to the side, and a some stairs leading up into a longer hallway{object != "":, which you know has a small office to the right}.


#EFFECT: click_move
~ WhereGO = true
You have a goal now. <i>Find and destroy the heart.</i> You don't know where the "heart" of the church is, but if you have to guess it would be.... (click highlighted image)

*[confessional]
    -> Confessional

*[stairs]
    -> Inside.Stairs_First

*[pews]
    -> Pews_First

= Look_For_Heart
#EFFECT: click_move
~ WhereGO = true
TODO: update this based on where we last were and punch up a bit
You have a goal now. <i>Find and destroy the heart.</i> You don't know where the "heart" of the church is, but if you have to guess it would be.... (click highlighted image)

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
# IMAGE: Confessional_CloseUp #PROP: curtain_full #EFFECT: click_move
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














