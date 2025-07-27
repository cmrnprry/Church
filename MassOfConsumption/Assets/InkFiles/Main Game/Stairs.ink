=== Stairs ===
~temp_bool_3 = false
{ - room:
    - 0: You {leg == "worst": limp up | climb} the short set of stairs, and notice a door over the last few steps, rather than at the top of the landing. The hall extends to another set of stairs that go both up and down. 
        ~room = 2
    
    - 1: You {leg == "worst": limp up | climb} the short set of stairs.The office door is still there, however, in a different place. Rather than it being at the end of the hall, it sits on wall adjacent to the stairs, hovering over the last few. The hall extends to another set of stairs that go both up and down. 
    
        This was not there last time you were here.
        
        ~room = 2
        
    - 2: You {leg == "worst": limp up | climb} the short set of stairs. The office door seems a little a bit shorter than you remember.
    
    - 3: You {leg == "worst": limp up | climb} the short set of stairs. The office door is half the height that it used to be. If it were any smaller, you don't think you could fit through it. 

    - else: You {leg == "worst": limp up | climb} the short set of stairs. The doorway to the office is gone. {room >= 4: You hope you got everythign you needed from it. }{room >= 5: The church destroyed that room. At least you managed to get what you needed from it. Or at least you hope you did.}

}


*[Examine the stairs]
    -> Stairs.Examine_Stairs

*{ room <= 3 }[Enter the office]
    ->Stairs.Office

*[Return to the main body of the church]
    -> Stairs.Exit_Stairs_Area

= Office
{have_visited ? (Enter_Office) == false: { object != "": It's the office door from earlier, but it seems shorter than you remember. You | You hope something useful lies behind, and }duck through the doorway. { object != "": The office doesn't look much differnt from what you saw earlier, though, you can now make out more with the help of your flashlight. | The room seems to be an office, and smells incredebly musty. It's a tight space with bookshelves lining the side walls, each shelf packed with books and boxes. A desk sits at the far wall, covered in dust and cobwebs, and a stained glass window above it. {saw_windows: You avoid looking at it.}} | {room == 3: You open the door and crouch-walk through.} {room == 4: You open the door and army crawl through.} Dispite the door size, the rest of the room remains how you remember it. }



*{!saw_desk}[{saw_locks: Look for something to break the chain | Dig through the desk}]
    ~ have_visited += (Enter_Office)
    ->Stairs.Desk

+[{have_visited ? (Enter_Office) == false: {saw_locks: Look for the combination lock code | Browse the bookshelves} | Search through books again}]
    ~ have_visited += (Enter_Office)
    {
        -saw_books:
        {
            - saw_locks or talked_to_girl or finished_confession: 
                You take another crack at reading through the books. You now have a better idea about what to look for. {saw_locks: You search through the books, {talked_to_girl: looking for any and every book that matches the story the little girl told you. A sick child that thinks her parents resent her, a mother that had a sick child, or a father that was a priest. | but you don't know enough about her to even know if you've passed her book or not. You hope that she had also seen the chains and locks you have.} | The priest you confessed to didn't tell you a lot, but you think it might be enough to find <i>something.</i>}
            
                {saw_locks or talked_to_girl or finished_confession: You're about to give up until you find someone promising: {saw_locks: Ophelia. | {talked_to_girl: Emily. |  {finished_confession: Olin. | }}}}
        
                *{saw_locks or talked_to_girl or finished_confession} [Read the book ((UNLESS THE NAME IS OPHELIA, I DID NOT WRITE THIS))]
                    {saw_locks: ->Take_Or_Return.Olpelia_Book | {talked_to_girl: ->Take_Or_Return.Emily_Book | {finished_confession: ->Take_Or_Return.Olin_Book}}}
            - else:
                With no futher information, you grab a random book to start reading. The number 1243 is on the cover in thick, gold-colored lettering.

                The first page has the name "Mary" in script. -> Stairs.Mary_Book
        }
        - else:
            ->Stairs.Books
    }  
            
*[Return to stairwell]
    ~temp_bool_3 = true
    -> Stairs.Exit_Office

= Desk
~ saw_desk = true
~ items_obtained += (Simple_Key)

Nothing interesting sits on the desk itself, save for a desk lamp. You flick the on off switch, but nothing happens. {object != "" : You touch the space where the {object} had been and wonder if you should have {took_object: kept it on you. | taken it.} You sliently curse yourself for not doing so. {saw_locks: The {object} would have made quick work of all the locks upstairs. You make a fist and bang it on the desk in frustraion.} | <>}

You walk around and plot onto the old desk chair. It groans in protest under your weight. You pull open the desk drawers and dig through their contents. Most only contain broken or otherwise unusable writing utencils or paper scraps to old to make any text out, but one drawer holds a small key.

The key is {items_obtained ? (Skeleton_Key): about the same size as the one you got before, but much less interesting. It is grey and nondescript, and i| small, grey and nondescript. I}t looks similar to a generic house key. You slip it into your pocket.
TODO: insert variable to track how you got the key

*{!saw_books}[{saw_locks: Look for the combination lock code | Browse the bookshelves}]
    ->Stairs.Books
            
*[Return to stairwell]
    ~temp_bool_3 = true
    -> Stairs.Exit_Office

= Books
~ saw_books = true
You approach the bookshelves. The books all look to be leather bound, and in better condition than the rest of the items littering the shelves. Water-stained boxes and a decaying wooden chest decorate the shelves. 

*{have_visited ? (Check_Boxes) == false} [Pick through the boxes]
    ~ explore_office_bookshelf += (Check_Boxes)
    You pick through the boxes first, only to find them filled with more books. <>

*{have_visited ? (Check_Chest) == false} [Investigate the chest]
    ~ explore_office_bookshelf += (Check_Chest)
    You grab the chest, and nearly drop it. The sides are slick with a wet, velvety mold. You wipe your hands on your pants and clench and unclench them, trying to forget the feeling. 
    
    "Gross gross gross gross gross," You say and gingerly pick it up, avoiding as many mold spots as you can. You attempt to open it, only to find it locked. You give it a shake, and hear something thumping around inside.
    
    "Probably just another book..." you mutter. You look through the key hole, but can't see anything.
    -> Open_Chest(->Stairs.Your_Book)
    

*{have_visited ? (Check_Books) == false} [Flip through the books]
    ~ explore_office_bookshelf += (Check_Books)
    You skim the covers of a few books from the closest shelf. <>

- You grab a random book. It has no title, but the number 2743 is on the cover in thick, gold-colored lettering. The first page has the name "Mary" in script. A dedication, maybe? You flip to the next page and begin to read. The color almost immediately drains from your face. You jump to the end, and your stomach tightens. You throw the book to the floor, and grab another off it's shelf. 1924, Jeff. 2952, Adrian. 1853, Reed. 

All the stories are the same: They entered the church, and never left.

*[Read Mary's book]
    ~temp_bool_2 = true
    Tentatively, you pick up Mary's book again, and begin to read.
    -> Stairs.Mary_Book

*[Look for your book]
    -> Stairs.Your_Book

= Mary_Book
The start is jarrying. Mary is stuck in a storm, and stumbled upon the church while looking for a place to rest. Unlike your experience, this was her first time meeting the church. Her first thought upon seeing it was: <i>Finally, salvation.</i> 

She did not hesitate to take shelter inside. 

Once inside, Mary wanders to the pews. Then a very familiar scene begins to play out: a beautiful melody begins to play and the church warms itself. You can't be sure is the melody is the same you heard, but it brought tears to Mary's eyes. 

The last page details how the beautiful melody lulled her into a sense security. How her final breaths were peaceful. How her body melted into wood after she was gone.

You close the book, and place it back on the shelf. {know_book: Your stomach gurgles, and you wonder how many more of these you can stomach. Too many have the same sad ending. | You close the book, and place it back on the shelf. Your insides twist and lurch as you look over all the books that litter the floor, and sit on the shelves. All these books- no. All these <i>people</i> are victims who never got out.}

*{!know_book} [Look for your book]
    -> Stairs.Your_Book

*[Grab the next book]
    The number on this one is {~2753. ->Rand_Book(2753)|2755. ->Rand_Book(2753)|2754. ->Rand_Book(2753)} <>

= Your_Book
~ temp Temp_Bool = false

{
    - explore_office_bookshelf ? (Check_Boxes) || explore_office_bookshelf ? (Check_Books):
    
    {
        - !know_book:
            ~ know_book = true
            You pull book after book off the shelves, looking at the first page for your name, and throwing it to the floor when it's not. When you run out of books, you go through the boxes. 
            
            "Where is it? Where could it possibly be?" You grab the chest, give it a shake, and hear something inside. You try to open it, but it's locked. "Maybe in here?" you mutter. You look through the key hole, but can't see anything. "It could be..."
    
            -> Open_Chest(->Stairs.Your_Book)
        - know_book:
            ~ Temp_Bool = true
            , and trace the numbers. You look at the first page, anxious to see if this is indeed your book. Your legs turn to jelly and you collapse to the ground. "Oh..." 
            
    
    }
        
        
    - !know_book && explore_office_bookshelf ? (Check_Chest):
        ~ know_book = true
        , and trace the numbers. You read the first page, and fall to the ground with a croak "That's... That's not..."
}

*[{Temp_Bool: It is your book | The book is about <i>you.</i>}]
    ~read_start_book = true

- 
Your read the first few pages, and it details everything you've expereinced so far, including the childhood memories you supressed. There's a handful of blank pages between your childhood expereince and current one. Your hands shake and your eyes burn. Is the ending already written? If it is, will reading make a difference?

*[Put the book away]
    ->Take_Or_Return(false)

*[Take the book with you]
    ~keep_book = true
    ->Take_Or_Return(true)

*[Flip to the end]
    ~read_end_book = true
    
- 
#CYCLE: prayer, curse, plea, apology
You squeeze your eyes shut and tilt your head back, whisper a @, and flip to the end of the book. You take a deep breath and read the last page. It ends with... 

{stay < 2: "Bullshit." You fling the book away from you and it lands a few feet | "N- No way." You mumble, and drop the book } in front of you. {stay < 2: You stare at the book with glassy eyes and clenched teeth. "I  refuse to even think about-" | You stare at nothing with a tight chest and teary eyes. "I wouldn't..."} You shake your head, and {stay < 2: roughly snatch the book from the ground| gingerly pick the book up off the floor}, re-reading the ending over and over again.

It ends with you sitting in the pews of the church, happy. You found peace. You accepted the church.
    

*{stay >= 2} [If the book was correct about everything else...]
    ~ stay += 1
    <i>Then why wouldn't the ending?</i> <>

*{stay < 2} [This must be a trick]
    You refuse to accept this. That must be a trick of the church— it has to be. <i>But what if it isn't?</i> <>

*[You don't know what to think]
    ~ stay += 0.5
    <i>Why not believe it?</i> <>
- 
Your traitorous mind whispers to you. You think back to everything that's happened. All the good. All the bad. <i>Does the bad really outweigh the good?</i> You want to say yes, but your tounge sits heavy in your mouth. <i>If you had to choose, could you really say that leaving is better? Is that what you really want?</i>

You clutch the book tightly in your hands. {stay < 2: You cannot accept that ending. Not after everything you've been through. | Can you accept this ending? After everything?}

*{stay >= 2} [You're not sure]
    ->Stairs.Unsure

* [Take the book with you]
    ~keep_book = true
    ->Take_Or_Return(true)
    
*[Rip out the page]

- 
~ stay -= 0.5
You stare at the page, {stay < 2: and without another thought, | hesitating for a momment. You stare at the page with a sour taste in your mouth, swallowing hard.  You bite the inside of your cheek, and} rip it out. You feel a quivering pain in your lower back, but ignore it. You feel a flooding sense of relief as you stare at the blank page, your book is no longer finished.

You start to flip the book closed, when you see movement on the page. Your body tenses as you watch ink stain the page and the words reappear. <i>You found peace.</i> You shake your head, {stay < 2: lip curling. | eyes wide.}

*[Rip it out again]

*[Leave it]
    You take a deep breath, and close the book. The church can think what it wants.
    ->Stairs.Leave_it
- 
~ stay -= 0.5
You rip out the page again, and again, you feel a twitching pain. This time, in your shoulder. {stay < 2: You refuse to let the church win. }

Again the ink reappears. {stay < 2: | You grip the book tighter.}

In {stay < 2: frustration | exasperation}, you rip the pages out over and over. A new part of your body gains a new pang of pain, each ache more distressing. The ink reappears each time. You rip and rip and rip the pages until there's only one left.

Your entire body trembles.

*[Rip out the last page]

*[Leave it]
    Your hand hovers over the last page, but you pause before ripping it out. Your body is sore, feeling like the day after an intense workout, and your heart pounds erratically. You take a deep breath and close the book. The church can think what it wants. 
    ->Stairs.Leave_it

- 
~ branded = true
~ visited_first = true
You rip out the last page, bracing for a new wave of agony that never comes. You blink, a slight smile on your lips. "What now, huh?" you yell. You won. You beat the church. You-

Your skin tingles just under the skin, similar to a mild sunburn. You lightly slap your arm, and it quickly turning into a searing pain flaying your skin. You scream and drop your book, clawing at the skin, trying to make it stop- ANYTHING to make it stop. Your nails dig into your flesh. Maybe if you removed it all, it would hurt less.

You scratch at your face and neck, tearing small chunks from your skin, distracting your brain for but a moment before the excruciating pain returns. In second of clarity you remember the confessional. Maybe- Maybe if you can get there and repent, this will all stop. Rolling onto your stomach, you dig your nails into the wood, pulling yourself along the floor. {killed_girl: Is this what {know_name: Emily | she } felt as she struggled for air? As her nails crazcked and broke from the floor? } Your shirt slides up, and you see angry red lines etched in your skin. You pull the collar of your shirt, look down and see more of the same.

*[Apologize]
    "I'm sorry! Please, stop. <i>I'm sorry!</i>" You cry. <>

*[Beg]
    ~ stay += 1
    "Please, stop. <i>Please!</i> I'll do <i>anything</i>!" <>

- Your skin bubbles and oozes as the lines reform themselves into form words. Words you have read over and over again. <i>You found peace. You found peace. You found peace. You found peace.</i> "I- I won't do it again!"

Your words fall on deaf ears as you can only watch the words from your book engrave themselves in your skin, branding you. You curl into the fetal position, abandoning the idea of repenting. You've barely moved. You'd never make it. 

#DELAY: 3.5
Tears leak from your eyes, a soothing comfort as they roll over your bleeding skin. 

You wimper as the sizzling pain slowly subsides to a biting prickling. You bring your trembling hands to your face. Your nails are chipped and broken and not an inch of your skin in unblemished. The branded words already looks healed over, like you've always had them, but a thin sheen of sweat and plasma coats them. Slowly, slowly, you sit up. Your clothing peels over the wooden floor, and you wince.

*[You don't think you'll ever forget that pain]

- Your book sits in front of you, and you snatch it from the floor, and hold it to your chest. You don't care about the ending anymore.

->Stairs.Leave_it

= Leave_it
*[Put the book away]
    ->Take_Or_Return(false)

*[Take the book with you]
    ~keep_book = true
    ->Take_Or_Return(true)

= Rip_out_Ophelia
#PLAY: screeching, 1 #stop: screeching, 2
Ensuring you won't forget, you rip the page out of the book. The church lets out a scream as you do, and the room begins to shake. You stuff the page into your pocket, as you try to keep your balence.

Whatever books are left on the shelves fall off, and the far book shelf falls over. The room around you is starting to crumble.

*[Run out of the room]
~room = 5
~ rip_page = true

- You make your way out of the room as fast as you can. All the books on the floor make it difficult, but you manage. Once you're about halfway to the door, you hear a sharp snapping sound. A large piece of ceiling falls to your side, just barely missing you.

You push yourself harder{leg == "worst": , but your leg is not cooperating with you You're not moving as fast as you want to |}. The door is so close. <i>You're</i> so close.

*[One last push]

-
{
    - leg == "worst":
        You try to push your body past it's limit, but your hurt leg gives out on you. You fall, just inches from the doorway. You don't have time to get to your feet before a large chunk of ceiling lands on you.

        "AAGHGAHGAH!" you let of a cry, wiggling around trying to get away. You feel like a bug that a child skewered with a stick. You know it's hopeless, and yet you still writhe on the ground.

        #ENDING: 2, Bad Ending: Crushed
        Hoping. Praying.

        *[But it's no use.]
        -> END
    - else:
        With one last burst of energy, you throw yourself out of the room. You land on the stairs hard, probably bruising something or worse. You watch as the room collapses in on itself, leaving only a caved in door way.

        "Well that was... something..." you mutter and carefully get to your feet, checking for any damage. You don't feel great but deosn't feel like anything's broken. "Note to self, <i>don't</i> rip anything while in here..."

        You pat your pocket that holds the page{keep_book: , and tighen your grib on your book.|.} At least you can remove one more lock with this.
        
        *[Exit the office.]
        ->Stairs.Exit_Office
}

= Examine_Stairs
{(have_visited ? (Stairs_Up) or have_visited ? (Stairs_Down)) == false: You walk deeper down the hallway to the stairs. Going up, is a spiral staircase. Going down, is a long set of stairs. You can't see the end of either. {object != "": How did you miss this before?} | The stairs are still there, spiraling up into the sky and digging down into the earth.}

+[Go upstairs]
    ->Stairs.Upstairs
    
+[Go downstairs]
    ->Stairs.Downstairs
    
+[Go back]
    You turn around are return to the office door. {room == 3: You frown at the doorway. Was it always that short? } {room == 4: You blink at the doorway. It was definitely not always that shot. You think you would remember needing to army crawl to enter.}

    ++[Enter office]
        ->Stairs.Office
        
    ++[Return to the main body of the church]
        -> Stairs.Exit_Stairs_Area
    

= Exit_Office
~room += 1

You exit the office.

+[Examine the stairs]
    -> Stairs.Examine_Stairs
    
+[Return to the main body of the church]
    -> Stairs.Exit_Stairs_Area



////////// ENDING INTERACTIONS ////////// 

= Unsure
Confused, you leave the room, and wander numbly back into the main body of the church. You find yourself back by the front door. It creaks open, showing off the moonlit sidewalk of the outside world. 

*[You reach out a hand.]

But the church looks at you again, bathing you in the wonderfully comfortable red light. The door stay open. You feel like...

*[Laughing]
~ church_feeling = "laugh"

*[Crying]
~ church_feeling = "cry"

- You're hysterical. Your whole body is heavy and tingling. You take a heavy step toward the door. <i>Is this really what you want?</i> Freedom is only one more step away. <i>To leave?</i> Your legs are glued to your spot on the floor. <i>Are you sure?</i> You grab your leg, pulling it forward.

{
    - emily_hurt:
        "You're leaving me?" You stop. It's the little girl{name: , Emily |.} She's crying. "You're leaving me all alone? Again?"
        
        You clench your fists, and feel something in your hand. You look down. It's the piece of ripped curtain.
        {
            - priest_feeling == "guilt":
                Tears well in your eyes, and you fall to your knees, bowing your head, holding the fabric to your face. <Guilt, Shame, Remorse> bubbles up inside you. 
                
                {
                    - stay >= 1.5:
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
                
            - priest_feeling == "dread":
                You drop the fabric, and watch it fall to the floor. You can feel the crip outside wind blowing into the church, but the fabric does not react to it.
                
                "It's not real." You murmer, and fix your gaze on the outside. "It's not real."
                
                "But <i>I</i> am." the little girl wails, and something warm slams into your back. "<i>I'm</i> real, so <i>promise</i> you won't leave me alone again!"
                
                You look down to see small hands gripping your waist. Not barely visible, ghostly hands, but real ones. Pigmented skin, warm and alive. You feel your resolve weakening the longer you look at her hands. Real hands. Human hands.
                        
                "I...." you croak. It's real this time. It's not a trick. 
                
                {
                    - stay >= 2:
                        "I won't." you wimper. If it is real, how could you leave her again? "I promise"

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
            
            - priest_feeling == "anger":
                You throw the fabric to the ground. "Do you think this will work the second time?" You {church_feeling}.
                
                "Don't leave me. <i>Please</i> don't leave me!" she sobs, and something warm slams into your back. "Promise you won't leave!"
                
                You look down to see small hands gripping your waist. Not barely visible, ghostly hands, but real ones. Pigmented skin, warm and alive. You feel your resolve weakening the longer you look at her hands. Real hands. Human hands.
                        
                "I...." you croak. It's real this time. It's not a trick. 
                
                {
                    - stay >= 2:
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
        
    - coward:
        "Coward." You stop. It's the woman who helped you{name:, Ophelia." |.} "You're just going to leave?"
        
        {
            - stay >= 2.5:
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
            - leave_light:
                You don't want to leave it, but you know you have to. You want to. You want...
            
                What do you want?
            
                You stop, and sit back. You stare up at the church window, and it looks back at you.
                
            {
                - stay >= 2.5:
                    What are you fighting so hard for?
                    
                    {happy: You look down at the hand that's missing a finger. | You think about all you've been through. }
                    
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

They begin to sing, hands out streached for you to take. The music flows through you, and you feel a smile come to your face.

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

= Downstairs
~ temp_bool = false
~ have_visited += (Stairs_Down)
{
    - went_downstairs == 0:
        #PLAY: click-on
        You approach the stairs shine your flashlight down. The walls on either side of the stairs are smooth, but damp. You cannot see the bottom. You take one step down, and deep groan wells up from below.

        You tense, every fiber of your being telling you to not continue down.
    - else:
        #PLAY: click-on
        You approach the stairs again, and swallow. A feeling in your gut is telling you not to go down and further.
}

~ went_downstairs = 1


*[Continue down]

*[Turn back]
    You turn back up the stairs. It doesn't feel right.
    ->Stairs.Turn_Back
-
Cautiously, you take another step down{leg == "worst":, making sure to lean against the railing to take weight off your leg}. And then another. And another. With every step down, your body yells at you more and more to turn back. That something's wrong.

*[Push through]

*[Turn back]
    You hurry back up the stairs, glancing over your shoulder as you do.
    ->Stairs.Turn_Back
- 
~ went_downstairs = 2

About halfway down the steps, the smell of rot hits your nose, so strong you gag. {leg == "worst": You grab the railing with both hands, | You grab the railing to steady yourself,} and retch. The stench is unbareable. 

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
    #PLAY: click-off
    Without a second thought, you rush back up the stairs to the hall. You take a deep refreshing breath of the clean air at the top, and try to make sense of what you just saw. 

    The flesh, it— it <i>reacted</i> to your touch. Your skin crawls at the thought. You don't think you should go back down there.
    ->Stairs.Turn_Back

- 
#PLAY: 1, squish-squash
<i>You've made it this far, might as well see it it toward the end,<i> you think, and take a deep breath through your mouth. Slowly, you make it to the bottom of the stairs.

<i>Squish</i>

#stop: 3, squish-squash
The tissue is soft under your shoes, making a soft, wet sound with each step. A thick ooze sticks to the bottom of your shoes.

<i>Squelch</i>

*[Open the door]
    ->Stairs.In_Basement

= In_Basement
The door opens, and you are assulted by the smell. Your eyes water and you clamp your hand over your nose and mouth. You take a few steps inside, trying to see what's the cause of this god awful smell.

The room is covered in the pink, buldging flesh, thick ooze drips from the ceiling. You pan your flash light around. The room is filled with furniture covered in tarps.

*[Find the source of the smell]

*[Investigate the ooze]
    #DELAY: 1.5
    You walk deeper into the room, deeper into the maze, and approach a place where the ooze consistantly falls from the ceiling. You stick the end of the flashlight into the small pool of it. It's sticky and slippery, much more slime like than ooze.
    
    #PLAY: click-on #PLAY: 1, click-off #PLAY: 1, click-on #PLAY: 1, click-off
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

- Blood rushes to your ears, so loud you can barely think. You need to get out of here- Out of this this slime{temp_bool: . You have the flashlight. |, flashlight be damned.} You blindly try to make your way back to the door.

The ooze being to fall faster. You step in puddles. It falls on you from the ceiling. You cannot wipe it off fast enough. 

*[It's eating through you]

- You wipe off another blob off your shoulder, but something goes with it. Something wet. Something warm. You stop, and reach up to touch your shoulder. Your hand shakes. Your breathing becomes short and shallow.

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
#ENDING: 1, Bad Ending: Melted #DELAY: 2
You keep going, desperatly trying to escape. 

#CLASS: Blur #DELAY: 2
You can't feel your hand anymore.

#DELAY: 2
You trip over yourself, and fall into puddle of the acidic ooze. 

#CLASS: Blur
You can't feel your legs.

*[You can't feel anything.]
->END

= Turn_Back
*[Go upstairs]
    ->Stairs.Upstairs

*[Enter the office]
    ->Stairs.Office

*[Return to the main body of the church]
    -> Stairs.Exit_Stairs_Area


////////// UPSTAIRS INTERACTIONS ////////// 

= Downstairs_Trick
~ went_downstairs = 3
~ visited_first = true
At least until the smell hits you. The smell of rot hits your nose, so strong you gag. {leg == "worst": You grab the railing with both hands, | You grab the railing to steady yourself,} and retch. <>

{went_downstairs >= 2: It was the same ripe smell from before. You swing around to look behind you only to be met with inky blackness. You know you didn't miss the landing, that's impossible. | The stench is unbareable. It smells of old, rotten meat left in the sun. Of putrid sour milk left out for too long. Of rancid fruit left to liquify in the fridge. Did you miss the landing and mistakenly continue down? You swing around to look behind you only to be met with inky blackness.}

*[Retrace your steps]
    Taking a deep breath through your mouth, you start back up the stairs. {went_downstairs >= 2: There's no way you just walked right past the landing like that. There is a gap between the sets of stairs. <i>I would have noticed.<i/>| You could have sworn there was a gap between the set of stairs spiraling up and the set digging down. At least enough to notice when one starts and the other ends.} 
    
    After climbing the stairs up for a few minutes you notice the rail sink and the incline turn sharp. <i>What in the?</i> Shining your flash light up, you see the stairs twist into a tight coil. {took_object || church_teleported: <i>Is the church messing with me?</i> | <i>How did...?</i>} 
    TODO: Check what other variables I should be checking for here and down below
    
    **[Continue to the top]
        <i>Screw it.</i> You think and decide to reach the top. At this point, either the landing never existed or the church is messing with your sense of direction. Either way, you would rather take your chances with whatever the attic hass in store for you rather than the basement. {went_downstairs >= 3: Your skin crawls at the memory of the flesh covering the staircase. } 
        
        You power through the rest of the stairs, only stopping to rest when your limbs refuse to cooperate. At some point, you end up almost fully vertical, treating the stairs as a ladder. Your finger tips burn from gripping the ground so tightly{leg == "worst":, your injured leg screaming from the exertion}. Resting became a risk, fearing that losing any momentum, even for a moment, would cause you to fall back and tumble back to the start.
        
            ->Stairs.Upstairs_Landing(true)
    
    **[Turn around and try again]
        "Third time's the charm," You mutter, turning back down the stairs, methodically checking for the landing after each step. 
        
        A flight or two later, you barely make out a flat platfrom at the edge of your flashlight's range. You don't think and rush down the rest of the stairs, running face first into a door. The scent of rotting flesh hits you a second later.
        
        #CYCLE: mold, fungus, flesh
        You gasp, taking a step back and slipping on something leaking from the door, landing on a squishy mass. It shivers in response to your touch. You yelp, jumping away{went_downstairs >=3:, eyes fixed on the quivering @. |, and see the walls and stairs covered in the same bulbous @.}
        
        In frustration you kick the door{leg == "worst":, then supress a curse as a sharp pain shoots up your leg}. Is this your only option? A rotting basment? You wonder if you can return now that you've made it to the end? Or if you'll end up somewhere worse.
        
        ***[Take your chances with the basement]
            You cover your face with your shirt, and slowly turn open the door. <>
            -> Stairs.In_Basement
        
        ***[Take your chances with the stairs]
            #CYCLE: mold, fungus, flesh #PLAY: 1, squish-squash
            You don't think anything could be worse than the smell eminating from the door in front of you and decide to try climbing the stairs one last time. The @ sticks to your shoes as you step on it, like warm gum. Your lip curls and you hope you can scrape it off later.
            
            #DELAY: 4
            The stentch fades and the substance coating the walls dissipates as you reach the top. You pull yourself out of the stairwell, finding yourself at the landing you were desperately searching for. You could almost kiss the ground.
            
            ****[Rest for a bit]
                ~ went_upstairs = false
                #DELAY: 4
                You collapse to the floor, resting after all the back and forth on the stairs. You close your eyes and lean against the wall. Your body welcomes the much needed break, as you feel some tension release.
                
                TODO: this reads weird!
                "There's no time for this!" A woman's voice, a soft anger, rips through the quiet and freezing hands shove you over the edge of the stairs.
                
                #DELAY: 2
                Your eyes snap open as you pull yourself into a ball, covering your head with your arms. Your whole body tenses as you brace for impact—
                
                ->Stairs.Upstairs_Landing(true)
            
            ****[Enter the office]
                ->Stairs.Office
            
            ****[Return to the main body of the church]
                ~ went_downstairs = 3
                ~ went_upstairs = false
                -> Stairs.Exit_Stairs_Area
            
            
            

= Upstairs
~leg = "worst"
~ went_upstairs = true
#IMAGE: Stairs_Up #PLAY: click-on #EFFECT: Flash-On
You start up the stairs, holding the hand rail as you go. You take a break after about 5 or 6 flights, hoping that you're close to the top, but the top doesn't look any closer. With a huff, you continue up.

Tighter and tighter the stairs spiral. The hand rail sinking lower and lower. The incline becoming steeper and steeper. After a count of 14 flights, you wonder if this is a fruitless effort. Sweat runs down your back, and your legs throb from effort. {leg != "": The leg you tried to kick the door in feels particularly weak.}

*[Give up]
    Shaking your head, you make the journey back down the stairs. Thankfully, going down was much easier than going up. As the hand rail once again rises to sit at a reasonable height and the spiral gradually straightens out, you believe you made the correct choice.
        -> Stairs.Downstairs_Trick

*[Power through]
    
- You power through, only stopping to rest when your limbs refuse to cooperate. 

At some point, you end up almost fully vertical, treating the stairs as a ladder. Your finger tips burn from gripping the ground so tightly{leg == "worst":, your injured leg screaming from the exertion}. Resting became a risk, fearing that losing any momentum, even for a moment, would cause you to fall back and tumble back to the start.

*[<i>How tall is this church?</i>]
    ->Stairs.Upstairs_Landing(false)

= Upstairs_Landing(from_trick)
~ have_visited += (Stairs_Up)
~ visited_first = true
{
    - !from_trick:
        After countless flights of stairs, you make it to the landing, crawling your way onto solid ground.{leg == "worst": Any longer, and you think you may have fallen.} The landing is small and square, maybe only five feet by five feet.
        
        The only thing on the landing is a door. It's old and wooden, much like the rest of the church. It is covered in chains and locks. A metal bar is bolted across the door in a way where you could not pull or push it open, even without the chains. Soft, pulsing, red light peaks out from under it.
    - from_trick:
        And you skid across a wooden floor and crash into a door. You blink rapidly and slowly uncurl yourself, trying to understand where you are and what just happened. That voice sounded similar to the one that gave you your flashlight, but she had a cold anger to her voice. You don't know what you did to attrack her ire, but she must have brought you here for a reason.
        
        You find youself on a small landing, maybe only five feet by five feet. It sharply drops off on the edges. You crawl forwaard to the edge and look down. You find yourself staring down the spiral staircase, it's coils wound much tighter and steeper than you thought possible. You back up from the edge.
        
        Behind you is the door you crashed into. It's old and wooden, much like the rest of the church. It is covered in chains and locks. A metal bar is bolted across the door in a way where you could not pull or push it open, even without the chains. Soft, pulsing, red light peaks out from under it.
}


*[Examine the locks]
    {went_upstairs: You take a closer look at the locks. From what you can tell, there are three main ones, and they all vary slightly | You approach the door, taking a closer look at the various locks and chains blocking it. }
    ~ went_upstairs = true
    ~ saw_locks = true
    
*[Peek through the keyhole]
    You approach the door and peek through the keyhole. You can't make out much, but you can see a small table and something placed upon it. You think that is also the souce of the glowing.
    
    Whatever it is, you assume it must be important. Your hears beats a little faster. The heart, maybe? {went_upstairs: | Is this why she sent you here?}
    
    ~ went_upstairs = true
    
    **[Examine the locks]
        You take a closer look at the locks. From what you can tell, there are three main ones, and they all vary slightly.
        ~ saw_locks = true
    
*{went_upstairs}[Head back down]
    ~ went_upstairs = true
    -> Stairs.Return_Down

- The top lock looks almost like something you'd find in an antique shop, made of heavy iron. It has a small key hole, and looks to be holding the chains together. The chains themselves aren't very think, but are sturdy. {broke_key: You mentally kick yourself for snapping the key earlier. There's a chance it matched this lock. | {items_obtained ? (Skeleton_Key) or items_obtained ? (Combo): Maybe you could...}}

The middle lock seems to be slightly newer. It doesn't require a key, but a four digit number code. It is attched to the metal bar that keeps the knob from turning. Removing this lock would probably allow the door to be opened.
TODO: add bit here about seeing 4 numbers around

The last lock is a sliding chain door that appartments usually have inside to prevent people from forcing their way in. Sliding it all the way to the end makes a smaller deadbolt slide into place, keeping the door unopenable. There is no obvious keyhole.

*{items_obtained ? (Skeleton_Key) && !key_lock}[Try the key you have.]
    -> Stairs.Try_Key

*{items_obtained ? (Clippers) && !clippers_lock}[Use the wire cutters.]
   -> Stairs.Use_Clippers

*{items_obtained ? (Combo) && !number_lock}[Enter {number_lock} into number lock.]
    -> Stairs.Enter_Number

*[Mess with the locks]
    ~ messed_locks = true

*[Head back down]
    -> Stairs.Return_Down

- You try a few combinations on the number lock, thinking you can guess code. Trying to enter today's date, the year, your birthday— Anything meaningful set of four numbers you can think of. After a few minutes, you give up.

You tug at the chain lock, but it's tightly fastened to the door. You grab at the chain itself and pull, thinking the thinner chain might snap under the pressure, but it holds fast. You then try messing with the sliding lock as well, trying to see if there's a trick to it. If there is, you can't figure it out.

*{items_obtained ? (Skeleton_Key) && !key_lock}[Try the key you have.]
    -> Stairs.Try_Key
    
*{items_obtained ? (Clippers) && !clippers_lock}[Use the wire cutters.]
   -> Stairs.Use_Clippers

*{items_obtained ? (Combo) && !number_lock}[Enter {number_lock} into number lock.]
    -> Stairs.Enter_Number

*[Head back down]
    -> Stairs.Return_Down

= Try_Key
~ locks += 1
~ key_lock = true
You fish the key out of your pocket, and try it on the only lock with a key hole. It resists slightly, but after messing with it, you're able to slot it in and turn it. 

#PLAY: groaning-angry, 1 
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
            - items_obtained ? (Clippers) && !clippers_lock:
                *[Use the wire cutters.]
                    -> Stairs.Use_Clippers
        }
        
        {
            - items_obtained ? (Combo) && !number_lock:
                *[Enter {number_lock} into number lock.]
                    -> Stairs.Enter_Number
        }
        
        
        {
            - !messed_locks && locks < 3 && !(items_obtained ? (Combo) || items_obtained ? (Clippers)):
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
    - items_obtained ? (Skeleton_Key) && key_lock:
        *[Try the key you have.]
            -> Stairs.Try_Key
}

{
    - items_obtained ? (Clippers) && !clippers_lock:
        *[Use the wire cutters.]
            -> Stairs.Use_Clippers
}

{
    - items_obtained ? (Combo) && !number_lock:
        *[Enter {number_lock} into number lock.]
            -> Stairs.Enter_Number
}


*[Head back down]
-> Stairs.Return_Down

= Use_Clippers
~ locks += 1
~ key_lock = true
~ temp_string = ""

{
 - finger_chopped:
    ~ temp_string = "You flinch at the sound out the chain snapping, reminded of the sound when you let them take your finger. A dull pain echos through your stump at the memory. "
}

{
 - !key_lock && items_obtained ? (Skeleton_Key):
    ~ temp_string += "You look at the rest of the chains that are held together with the old looking lock. You try the key you found but... Instead, you cut around the lock and then some, until the lock falls."
 - !key_lock && items_obtained ? Skeleton_Key:
    ~ temp_string += "You look at the rest of the chains that are held together with the old looking lock. You could look for a key, but... Instead, you cut around the lock and then some, until the lock falls."
}

You slide the chain lock to the the side, so the extra deadbolt is not blocking the door from opening, and use the small wire cutters you have to break the sliding chain.

#PLAY: cut_chain
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
            - items_obtained ? (Combo) && !number_lock:
                *[Enter {number_lock} into number lock.]
                    -> Stairs.Enter_Number
        }
}



*[Head back down]
-> Stairs.Return_Down

= Enter_Number
~locks += 1
~number_lock = true

{
    - rip_page:
        You pull the page from your pocket. You grab the combination lock and input the numbers 2755, and pull on the lock.
        
        //TODO: Maybe little "game" to input the numbers?
        
        It doesn't open.
        
        You pull it again, thinking it might be stuck. Nothing. You re-read the page. The code is correct, so what could... You read a bit further on and... You feel sick.

        Further down the page, it explains the number. Not a date or some random sequence, the code is differnt for everyone. To open it, you have to use your own number. The number that the church assigned you.
        
        
    - name:
        You pull the page from your pocket. You grab the combination lock and input the numbers 27... 55...? 54...?, and pull on the lock.
        
        //TODO: Maybe little "game" to input the numbers?
        
        It doesn't open.
        
        You pull it again, thinking it might be stuck. Nothing. You're almost positive that was the correct number.
}

{
    - keep_book:
        {
            - rip_page:
                You check the cover of your book again. 2758. With shaking hands, you input the code, and the lock pops open.
            
                You remove the lock from the metal bar, and slide it out of place. 
            - name:
                "Come on.. Think!" You squeeze your eyes shut and try to remember the number from Ophelia's book, but your mind stays blank. You try a few more similar number combinations. 2575? 5275? 2755?
                
                None of them work.
                
                You check the cover of your book again. 2758. With no other options, you use your book number as the code, and the lock pops open.
            
                You remove the lock from the metal bar, and slide it out of place. 
        }
    
    
    - else:
        {
            - rip_page:
                Your book. Of course. The one you left in the office. even without it, you clearly remember the number. 2758. With shaking hands, you input the code, and the lock pops open.
            
                You remove the lock from the metal bar, and slide it out of place. 
            - name:
                "Come on.. Think!" You squeeze your eyes shut and try to remember the number from Ophelia's book, but your mind stays blank. You try a few more similar number combinations. 2575? 5275? 2755?
                
                None of them work.
                
                You can only properly remember your own book number. 2758. With no other options, you use your book number as the code, and the lock pops open.
            
                You remove the lock from the metal bar, and slide it out of place. 
        }
}

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
            - items_obtained ? (Skeleton_Key) && key_lock:
                *[Try the key you have.]
                    -> Stairs.Try_Key
        }
        
        {
            - items_obtained ? (Clippers) && !clippers_lock:
                *[Use the wire cutters.]
                    -> Stairs.Use_Clippers
        }

        *[Head back down]
        -> Stairs.Return_Down
}

= Return_Down
{locks == 1: With one lock down, | {locks == 2: With two locks down,| Unsure of what more you can do,}} you decide to head back down, assuming you can find a way to unlock them down in the church's main body. You turn to go back down, dreading the climb, only to find the staircase has transformed from a dizzyingly steep spiral staircase into a normal single flight of stairs. A short enough flight where you can see the bottom of the landing.

Tentatively, you decend the stairs, ready for it to warp or change at any moment. When you reach the bottom and look back, the stairs are once again a spiral stair case. Shining your flashlight back up, you only see darkness. 

If you weren't sure before, you are now: Behind that door lies the heart.

*[Enter the office]
    ->Stairs.Office

*[Return to the main body of the church]
    -> Stairs.Exit_Stairs_Area

= Upstairs_End
{temp_bool == false: The locked door and soft light from under it are the same. You think you have all the pieces to open it now. {stay >= 2.5: You bounce on the balls of your feet. This is it. You'll be... able to leave soon. Go back to your... normal... life. } {stay < 2.5: You're so close to being free. } }

+ { items_obtained ? (Skeleton_Key) && key_lock } [Use the key.]
    ~ temp_bool = true
    ~ locks += 1
    ~ key_lock = true
    {stay >= 2.5: You fish the key out of your pocket. Your hand shakes as you try to slide it into the hole. You miss a few times before dropping the key to the floor. "Get it together..." You mutter, shaking out your hands before picking up the key and putting it into the lock. }{stay < 2.5: You fish the key out of your pocket, and try it on the only lock with a key hole. } It resists slightly, but with a little force, you're able to turn it. 
    
    #PLAY: groaning-angry, 1 #stop: groaning-angry, 2
    The chains and lock fall to the ground. The church groans angrily in response. 
    
    { - locks:
        - 1: One lock down, two more to go.
        - 2: Two locks down, one more to go.
        - 3: All the locks have been removed.
    }

+ { items_obtained ? (Clippers) && !clippers_lock} [Use the wire cutters.]
    ~ temp_bool = true
    ~ locks += 1
    ~ key_lock = true
    ~ clippers_lock = true

    {
     - !key_lock && items_obtained ? (Skeleton_Key):
        ~ temp_string = "you look at the rest of the chains that are held together with the old looking lock. You try the key you found but... Instead, you cut around the lock and then some, until the lock falls."
     - !key_lock && items_obtained ? Skeleton_Key:
        ~ temp_string = "you look at the rest of the chains that are held together with the old looking lock. You could look for a key, but... Instead, you cut around the lock and then some, until the lock falls."
    }
    
    You slide the chain lock to the the side, so the extra deadbolt is not blocking the door from opening, and use the small wire cutters you have to break the sliding chain.

    #PLAY: cut_chain
    {finger_chopped and happy == false: You flinch at the sound out the chain snapping, reminding you of the sound when you let them take your finger. A dull pain echos through your stump at the memory.} {finger_chopped and happy: You don't flinch at the sound out the chain snapping, but feel a slight smile come to your lips. The stump on your hand aches at the memory, but it's a soothing pain. } {coward: You flinch at the sound out the chain snapping, reminding you of the sound when you let them take her finger. Her cries echo in your ears. }
    
    You shake the memory from your head and {temp_string}

    { 
        - number_lock:
            With two locks removed, all that's left is the number lock.
        - else:
            All the locks have been removed.
    }

+ { items_obtained ? (Combo) && !number_lock} [Enter {number_lock} into number lock.]
    ~ temp_bool = true
    ~ locks += 1
    ~ number_lock = true

    {
        - rip_page:
            You pull the page from your pocket. You grab the combination lock and input the numbers 2755, and pull on the lock.
            
            //TODO: Maybe little "game" to input the numbers?
            
            It doesn't open.
            
            You pull it again, thinking it might be stuck. Nothing. You re-read the page. The code is correct, so what could... You read a bit further on and... You feel sick.
    
            Further down the page, it explains the number. Not a date or some random sequence, the code is differnt for everyone. To open it, you have to use your own number. The number that the church assigned you.
            
            
        - name:
            You pull the page from your pocket. You grab the combination lock and input the numbers 27... 55...? 54...?, and pull on the lock.
            
            //TODO: Maybe little "game" to input the numbers?
            
            It doesn't open.
            
            You pull it again, thinking it might be stuck. Nothing. You're almost positive that was the correct number.
    }
    
    {
        - keep_book:
            {
                - rip_page:
                    You check the cover of your book again. 2758. With shaking hands, you input the code, and the lock pops open.
                
                    You remove the lock from the metal bar, and slide it out of place. 
                - name:
                    "Come on.. Think!" You squeeze your eyes shut and try to remember the number from Ophelia's book, but your mind stays blank. You try a few more similar number combinations. 2575? 5275? 2755?
                    
                    None of them work.
                    
                    You check the cover of your book again. 2758. With no other options, you use your book number as the code, and the lock pops open.
                
                    You remove the lock from the metal bar, and slide it out of place. 
            }
        
        
        - else:
            {
                - rip_page:
                    Your book. Of course. The one you left in the office. even without it, you clearly remember the number. 2758. With shaking hands, you input the code, and the lock pops open.
                
                    You remove the lock from the metal bar, and slide it out of place. 
                - name:
                    "Come on.. Think!" You squeeze your eyes shut and try to remember the number from Ophelia's book, but your mind stays blank. You try a few more similar number combinations. 2575? 5275? 2755?
                    
                    None of them work.
                    
                    You can only properly remember your own book number. 2758. With no other options, you use your book number as the code, and the lock pops open.
                
                    You remove the lock from the metal bar, and slide it out of place. 
            }
    }
    
    { - locks:
        - 1: One lock down, two more to go.
        - 2: Two locks down, one more to go.
        - 3: All the locks have been removed.
    }


- 
{ 
    - locks >= 3:
        *[Open the door.]
        ->Open_the_Door
        
    - else:
        ->Stairs.Upstairs_End
}

= Exit_Stairs_Area
{
    - visited_first:
        ->After_First.Side_Room_After
    - visited_second:
        -> After_Second.Stairs_Second
    - temp_bool_3:
        ->Inside.Look_For_Heart
    - else:
        -> Last_Stop.Stairs_Last
}

=== Open_Chest(-> return_to) ===
*{items_obtained ? (Simple_Key)} [Try the simple key]
    ~ items_obtained -= (Simple_Key)
    ~ found_your_book += (Used_Simple_Key)
    ~ broke_key = true
    You fish the simple key out of your pocket and try the lock. The key slides in easy enough, but it doesn't want to turn. You force the key, thinking it just needed a little force. You jiggle the key, and force it to turn. <i>Clank!</i> 
    
    The key snaps in the lock. The teeth of the key are stuck and warped in the lock. You press the key against the lock, attempting to turn it again and again, thinking maybe if you press hard enough it would suddenly pop open. "God DAMMIT!"
    
    You fling the head of the key away from you and hurl the chest to the floor in frustration. The lid pops open, and a book with the number 2758 spills on it's cover onto the floor.
    ~temp_string = "if the loss of the key was worth it"

*{items_obtained ? (Skeleton_Key)} [Try the skeleton key]
    ~ found_your_book += (Used_Skeleton_Key)
    You fish the skeleton key out of your pocket and try the lock. The key slides in, and <i>Click!</i>
        
    The lid pops open and inside sits a book with the number 2758 on it's cover.
        ~temp_string = "if the loss of the key was worth it"

*[Break the chest]
    ~ found_your_book += (Broke_Chest)
    You raise the chest above your head, and hurl it to the floor. The lid pops open, and a book with the number 2758 on it's cover spills onto the floor.
    ~temp_string = "if this is indeed your book"

- You {found_your_book ? (Used_Skeleton_Key): take the book from the chest, placing the now empty chest back on the shelf| pick the book up from the ground}<>

->return_to

//if we are here, player HAS to know about their book

=== Take_Or_Return(IsTake) ===
{branded: {IsTake: You tuck the book under your arm. Leaving it behind feels wrong somehow. | You struggle to your feet and shuffle to the bookshelf. You gently place your book on the shelf and slide it back until it hits the wall. You want nothing to do with it anymore.} You... You should do something. Return to your search. Find the heart. Destroy it. Escape. | {IsTake: You tuck the book under your arm. {read_end_book: You may already know how this could end, or at least, how the <i>church</i> thinks it will end, but something tells you to keep your book with you. {stay >= 2: Just in case something changes.} | You don't want to know how this story ends, but in case you change your mind, you'll have that choice.} | {read_end_book: You place the book back on the shelf. You know how it ends- Or rather, how the church thinks it will end. | You don't want to know how this story ends, not when there's still something you can do. You put the book back on the shelf.} } {stay < 2: You shouldn't give too much weight to it. That's what the church wants. | You chew your lip{keep_book: and tighten your grip on it}. } You should do something productive instead of dwelling on it. {saw_locks: You remember the woman who helped you. Maybe if you find her book, or someone else's, you can find out what the code to the number lock is. | You should look elsewhere. You look at the books surrounding you. Maybe their stories could help you?}}

*{!(explore_office_bookshelf ? Check_Boxes)} [Pick through the boxes]
    ~ explore_office_bookshelf += (Check_Boxes)
    You pick through the boxes first, only to find them filled with more books. <>

*{!(explore_office_bookshelf ? Check_Chest)} [Investigate the chest]
    ~ explore_office_bookshelf += (Check_Chest)
    You grab the chest, and nearly drop it. The sides are slick with a wet, velvety mold. You wipe your hands on your pants and clench and unclench them, trying to forget the feeling. 
    
    "Gross gross gross gross gross," You say and gingerly pick it up, avoiding as many mold spots as you can. You attempt to open it, only to find it locked. You give it a shake, and hear something thumping around inside.
    
    "Probably just another book..." you mutter. You look through the key hole, but can't see anything.
    -> Open_Chest(->Stairs.Your_Book)
    

*{!(explore_office_bookshelf ? Check_Books)} [Flip through the books]
    ~ explore_office_bookshelf += (Check_Books)
    You skim the covers of a few books from the closest shelf. <>

*{!saw_desk}[{saw_locks: Look for something to break the chain | Dig through the desk}]
    ->Stairs.Desk

*[Exit the office]
    ->Stairs.Exit_Office
    
- They all resemble {know_book: your book. | the other books in the room.} The main difference being the bold number on the cover or spine, and some looking a little older. From what you can tell, none of the numbers repeat. 

*[{saw_locks or talked_to_girl: Look for her book | Read through the books}]

- {saw_locks: With the minimal knowledge you have, you skim through as many books as you can. You search and seach, {talked_to_girl: looking for any and every book that matches the story the little girl told you. A sick child that thinks her parents resent her, a mother that had a sick child, or a father that was a priest. | but you don't know enough about her to even know if you've passed her book or not.} | You pick up a book at random, skimming though them for any relevant or interesting information. {talked_to_girl: You try to focus on books that matches the story the little girl told you. A sick child that thinks her parents resent her, a mother that had a sick child, or a father that was a priest. | You read book after book after book, but you don't know what you're looking for.}}

{saw_locks: You read book after book, story after story about the victims of the church. | Each story you read all are about victims of the church.} All the stories only describe parts where the vicim is in or near the chuch, so most have gaps{read_start_book:, much like your own book}. Many stories mimick your own, but some never knew they were ever in danger. Some attempted to escape, but all of them had the same ending.

{read_end_book: And much like your own ending, they all find peace. | They never leave.} {saw_locks or talked_to_girl or finished_confession: You're about to give up until you find someone promising: {saw_locks: Ophelia. | {talked_to_girl: Emily. |  {finished_confession: Olin. | }}}| After reading another dead-end book, you pinch the bridge of your nose and sigh. You're surrounded by a pile of useless books and your eyes are strained from reading in low light.}

*{saw_locks or talked_to_girl or finished_confession} [Read the book ((UNLESS THE NAME IS OPHELIA, I DID NOT WRITE THIS))]
    {saw_locks: ->Olpelia_Book | {talked_to_girl: ->Emily_Book | {finished_confession: ->Olin_Book}}}

* {!saw_locks or !talked_to_girl or !finished_confession} [Come back later]
    You have has enough reading, and decide you need to move on. You're sure something in here has the information you want, but blindly reading isn't helping. You'll come back when you know more.
    ->Stairs.Exit_Office
    
* {!saw_locks or !talked_to_girl or !finished_confession} [Keep reading]
    You sigh deeply and grab another book. 
    TODO: church gonna look at you again. you're gonna throw a book in frustraion and it's gonna hit the window and the church is gonna be like "ouchie wtf man" and you're gonna be upset again and maybe die

= Olin_Book
TODO
->END

= Emily_Book
TODO
->END

= Olpelia_Book
~name = true
~number_lock = "2755"
You read through her book carefully, learning that her daughter's name is Emily, and that Ophelia followed Emily into the church after she ran inside. 

Ophelia was determined to escape with Emily, and figured out a possible way to exit by destroying the heart of the church. Your heart pounds as you read. She found the same locked door you did. Your eyes slide down the page a little more and...

"2755, got it!" you exclaim. "Thank you, Ophelia!"

*[Rip out the page]
->Stairs.Rip_out_Ophelia

{
    - saw_locks && !temp_bool_3:
        ~temp_bool = true
        *[Look for something to break the chain lock.]
        ->Stairs.Desk
    - !saw_locks && !temp_bool_3:
        ~temp_bool = false
        *[Look through the desk]
        ->Stairs.Desk
}

*[Exit the office.]
->Stairs.Exit_Office

=== Rand_Book(value) ===
You half-heartedly read through it before sitting up sharply. This person's story goes deeper than a failed escape or instant death. You check the front cover again, taking note of the number on the cover before flipping back to the beginning.

*[Read the book closer ((UNLESS THE NAME IS OPHELIA, I DID NOT WRITE THIS))]
    {value == 2755: ->Take_Or_Return.Olpelia_Book | {value == 2754: ->Take_Or_Return.Emily_Book | {value == 2753: ->Take_Or_Return.Olin_Book}}}









