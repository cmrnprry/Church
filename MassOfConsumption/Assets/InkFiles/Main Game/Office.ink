=== Office_Area ===

= Office
{Have_Visited !? (Enter_Office): {Looked_For_Items: It's the office door from earlier, but it seems shorter than you remember, it now being about the same hight as you. You duck | You hope something useful lies behind, and enter} through the doorway. {Looked_For_Items: The office doesn't look much different from what you saw earlier, though, you can now make out more with the help of your flashlight. | The room seems to be an office, and smells incredibly musty.} It's a tight space with bookshelves lining the side walls, each shelf packed with books and boxes. A desk sits at the far wall, covered in dust and cobwebs, and a stained glass window above it. {Church_Investigation ? (Saw_Windows): You avoid looking at it.} | {Room_State == Half: You open the door and crouch-walk through.} {Room_State == Crawl: You open the door and army crawl through.} Despite the door size, the rest of the room remains how you remember it. }

~ Have_Visited += (Enter_Office)
~ Room_State++

*{Explore_Office_Bookshelf !? (Check_Desk)}[Dig through the desk]
    ->Office_Area.Desk

+[{Explore_Office_Bookshelf !? (Check_Books): Browse the bookshelves | Search through books again}]
    {
        -Book_Knowledge ? Explored_Books:
        {
            - Saw_Locks or Confessional_Encounters ? (Talked_to_Girl) or Confessional_Encounters ? (Finished_Curtain_Side): 
                You take another crack at reading through the books. You now have a better idea about what to look for. {Saw_Locks: You search through the books, {Confessional_Encounters ? (Talked_to_Girl): looking for any and every book that matches the story the little girl told you. A sick child that thinks her parents resent her, a mother that had a sick child, or a father that was a priest. | but you don't know enough about her to even know if you've passed her book or not. You hope that she had also seen the chains and locks you have.} | The priest you confessed to didn't tell you a lot, but you think it might be enough to find <i>something.</i>}
            
                {Saw_Locks or Confessional_Encounters ? (Talked_to_Girl) or Confessional_Encounters ? (Finished_Curtain_Side): You're about to give up until you find someone promising: {Saw_Locks: Ophelia. | {Confessional_Encounters ? (Talked_to_Girl): Emily. |  {Confessional_Encounters ? (Finished_Curtain_Side): Olin. | }}}}
        
                *{Saw_Locks or Confessional_Encounters ? (Talked_to_Girl) or Confessional_Encounters ? (Finished_Curtain_Side)} [Read the book ((UNLESS THE NAME IS OPHELIA, I DID NOT WRITE THIS))]
                    {Saw_Locks: ->Take_Or_Return.Ophelia_Book | {Confessional_Encounters ? (Talked_to_Girl): ->Take_Or_Return.Emily_Book | {Confessional_Encounters ? (Finished_Curtain_Side): ->Take_Or_Return.Olin_Book}}}
            - else:
                With no further information, you grab a random book to start reading. The number 1243 is on the cover in thick, gold-colored lettering.

                The first page has the name "Mary" in script. -> Office_Area.Mary_Book
        }
        - else:
            ->Office_Area.Books
    }  
            
*[Return to stairwell]
    ~temp_bool_3 = true
    -> Office_Area.Exit_Office

= Desk
~ Explore_Office_Bookshelf += (Check_Desk)
~ items_obtained += (Simple_Key)

You walk around and plot onto the old desk chair. It groans in protest under your weight. Nothing interesting sits on the desk itself, save for a desk lamp. You flick the on off switch, but nothing happens. {Looked_For_Items: You touch the space where the {Object} had been and wonder if you should have {Took_Item: kept it on you. | taken it.} You silently curse yourself for not doing so. {Saw_Locks and Object == sledgehammer: The {Object} would have made quick work of all the locks upstairs. You make a fist and bang it on the desk in frustration.} | <>}

 You pull open the desk drawers and dig through their contents. Most only contain broken, or otherwise unusable, writing utensils and paper scraps to old to make any text out, but one drawer holds a key.

The key is {items_obtained ? (Skeleton_Key): about the same size as the one you got before, but much less interesting. It is grey and nondescript, and i| small, grey and nondescript. I}t looks similar to a generic house key. You turn it over in your hands before sliping it into your pocket. {Saw_Locks: It might fit the lock upstairs. | It will probably be useful later.}

*[{Explore_Office_Bookshelf !? (Check_Books): Browse the bookshelves | Search through books again}]
    -> Office_Area.Books
        
*[Return to stairwell]
    ~temp_bool_3 = true
    -> Office_Area.Exit_Office

= Books
~ Book_Knowledge += (Explored_Books)
You approach the bookshelves. The books all look to be leather bound, and in better condition than the rest of the items littering the shelves. Water-stained boxes and a decaying wooden chest decorate the shelves. 

*{Have_Visited ? (Check_Boxes) == false} [Pick through the boxes]
    ~ Explore_Office_Bookshelf += (Check_Boxes)
    You pick through the boxes first, only to find them filled with more books. You grab a random book from the box. <>

*{Have_Visited ? (Check_Chest) == false} [Investigate the chest]
    ~ Explore_Office_Bookshelf += (Check_Chest)
    You grab the chest, and nearly drop it. The sides are slick with a wet, velvety mold. You wipe your hands on your pants and clench and unclench them, trying to forget the feeling. 
    
    "Gross gross gross gross gross," You say and gingerly pick it up, avoiding as many mold spots as you can. You attempt to open it, only to find it locked. You give it a shake, and hear something thumping around inside.
    
    "Probably just another book..." you mutter. You look through the key hole, but can't see anything.
    -> Open_Chest(->Office_Area.Your_Book)
    

*{Have_Visited ? (Check_Books) == false} [Flip through the books]
    ~ Explore_Office_Bookshelf += (Check_Books)
    You skim the covers of a few books from the closest shelf. You grab a random book from the shelf. <>

- It has no title, but the number 2743 is on the cover in thick, gold-colored lettering. The first page has the name "Mary" in script. A dedication, maybe? You flip to the next page and begin to read. The color immediately drains from your face. You jump to the end, and your stomach tightens. You throw the book to the floor, and grab another off it's shelf. 1924, Jeff. 2952, Adrian. 1853, Reed. 

All the stories are the same: They entered the church, and never left.

*[Finish Mary's book]
    Tentatively, you pick up Mary's book again, and begin to read. <>
    -> Office_Area.Mary_Book

*[Look for your book]
    -> Office_Area.Your_Book

= Mary_Book
The start is jarring. Mary is stuck in a storm, and stumbled upon the church while looking for a place to rest. Unlike your experience, this was her first time meeting the church. Her first thought upon seeing it was: <i>Finally, salvation.</i> 

She did not hesitate to take shelter inside. 

Once inside, Mary wanders to the pews. A pastor asks if she's alright. <i>Are you cold, child? Let me turn up the heat.</i> Before she can even speak he drapes a a heavy blanket over her shoulders. <i>Please sit. Rest. I'll play you a beautiful song.</i> He leads her to a pew before making his way to the stage and playing the organ. You can't be sure if he played the same melody you heard, but it brought Mary ot tears. No one had been so kind to her before.

The last page details how the beautiful melody lulled her into a deep sleep. How her final breaths were peaceful. How her body melted into wood after she was gone. It doesn't say what happened to the pastor. {Have_Visited ? (Confessional_DoorSide) or Have_Visited ? (Enter_Pews): You wonder if it's the same one you met. }

You close the book, and place it back on the shelf. {Book_Knowledge ? (Saw_Your_Book): Your stomach gurgles, and you wonder how many more of these you can stomach. Too many have the same sad ending. | Your insides twist and turn as you look over all the books that litter the floor, and sit on the shelves. All these books- no. All these <i>people</i> are victims who never got out.}

*{Book_Knowledge !? (Saw_Your_Book)} [Look for your book]
    -> Office_Area.Your_Book

*[Grab the next book]
    The number on this one is {~2753. ->Rand_Book(2753)|2755. ->Rand_Book(2753)|2754. ->Rand_Book(2753)} <>

= Your_Book
~ temp Temp_Bool = false

{
    - Explore_Office_Bookshelf ? (Check_Boxes) || Explore_Office_Bookshelf ? (Check_Books):
    
    {
        - Book_Knowledge !? (Saw_Your_Book):
            ~ Book_Knowledge += (Saw_Your_Book)
            You pull book after book off the shelves, looking at the first page for your name, and throwing it to the floor when it's not. When you run out of books, you go through the boxes. 
            
            "Where is it? Where could it possibly be?" You grab the chest, give it a shake, and hear something inside. You try to open it, but it's locked. "Maybe in here?" you mutter. You look through the key hole, but can't see anything. "It could be..."
    
            -> Open_Chest(->Office_Area.Your_Book)
        - Book_Knowledge ? (Saw_Your_Book):
            ~ Temp_Bool = true
            , and trace the numbers. You look at the first page, anxious to see if this is indeed your book. Your legs turn to jelly and you collapse to the ground. "Oh..." 
            
    
    }
        
        
    - Book_Knowledge !? (Saw_Your_Book) && Explore_Office_Bookshelf ? (Check_Chest):
        ~ Book_Knowledge += (Saw_Your_Book)
        , and trace the numbers. You read the first page, and fall to the ground with a croak "That's... That's not..."
}

*[{Temp_Bool: It is your book | The book is about <i>you.</i>}]
    ~ Book_Knowledge += (Read_Start)

- 
Your read the first few pages, and it details everything you've experienced so far, including the childhood memories you suppressed. There's a handful of blank pages between your childhood experience and current one. Your hands shake and your eyes burn. Is the ending already written? If it is, will reading make a difference?

*[Put the book away]
    ->Take_Or_Return(false)

*[Take the book with you]
    ~ Book_Knowledge += (Kept_Book)
    ->Take_Or_Return(true)

*[Flip to the end]
    ~ Book_Knowledge += (Read_End)
    
- 
#CYCLE: prayer, curse, plea, apology
You squeeze your eyes shut and tilt your head back, whisper a @, and flip to the end of the book. You take a deep breath and read the last page. It ends with... 

{Stay_Tracker < 2: "Bullshit." You fling the book away from you and it lands a few feet | "N- No way." You mumble, and drop the book } in front of you. {Stay_Tracker < 2: You stare at the book with glassy eyes and clenched teeth. "I  refuse to even think about-" | You stare at nothing with a tight chest and teary eyes. "I wouldn't..."} You shake your head, and {Stay_Tracker < 2: roughly snatch the book from the ground| gingerly pick the book up off the floor}, re-reading the ending over and over again.

It ends with you sitting in the pews of the church, happy. You found peace. You accepted the church.
    

*{Stay_Tracker >= 2} [If the book was correct about everything else...]
    ~ Stay_Tracker += 1
    <i>Then why wouldn't the ending?</i> <>

*{Stay_Tracker < 2} [This must be a trick]
    You refuse to accept this. That must be a trick of the church— it has to be. <i>But what if it isn't?</i> <>

*[You don't know what to think]
    ~ Stay_Tracker += 0.5
    <i>Why not believe it?</i> <>
- 
Your traitorous mind whispers to you. You think back to everything that's happened. All the good. All the bad. <i>Does the bad really outweigh the good?</i> You want to say yes, but your tongue sits heavy in your mouth. <i>If you had to choose, could you really say that leaving is better? Is that what you really want?</i>

You clutch the book tightly in your hands. {Stay_Tracker < 2: You cannot accept that ending. Not after everything you've been through. | Can you accept this ending? After everything?}

*{Stay_Tracker >= 2} [You're not sure]
    ->Office_Area.Unsure

* [Take the book with you]
    ~Book_Knowledge += (Kept_Book)
    ->Take_Or_Return(true)
    
*[Rip out the page]

- 
~ Stay_Tracker -= 0.5
You stare at the page, {Stay_Tracker < 2: and without another thought, | hesitating for a moment. You stare at the page with a sour taste in your mouth, swallowing hard.  You bite the inside of your cheek, and} rip it out. You feel a quivering pain in your lower back, but ignore it. You feel a flooding sense of relief as you stare at the blank page, your book is no longer finished.

You start to flip the book closed, when you see movement on the page. Your body tenses as you watch ink stain the page and the words reappear. <i>You found peace.</i> You shake your head, {Stay_Tracker < 2: lip curling. | eyes wide.}

*[Rip it out again]

*[Leave it]
    You take a deep breath, and close the book. The church can think what it wants.
    ->Office_Area.Leave_it
- 
~ Stay_Tracker -= 0.5
You rip out the page again, and again, you feel a twitching pain. This time, in your shoulder. {Stay_Tracker < 2: You refuse to let the church win. }

Again the ink reappears. {Stay_Tracker < 2: | You grip the book tighter.}

In {Stay_Tracker < 2: frustration | exasperation}, you rip the pages out over and over. A new part of your body gains a new pang of pain, each ache more distressing. The ink reappears each time. You rip and rip and rip the pages until there's only one left.

Your entire body trembles.

*[Rip out the last page]

*[Leave it]
    Your hand hovers over the last page, but you pause before ripping it out. Your body is sore, feeling like the day after an intense workout, and your heart pounds erratically. You take a deep breath and close the book. The church can think what it wants. 
    ->Office_Area.Leave_it

- 
~ Book_Knowledge += (Branded)
You rip out the last page, bracing for a new wave of agony that never comes. You blink, a slight smile on your lips. "What now, huh?" you yell. You won. You beat the church. You-

Your skin tingles just under the skin, similar to a mild sunburn. You lightly slap your arm, and it quickly turning into a searing pain flaying your skin. You scream and drop your book, clawing at the skin, trying to make it stop- ANYTHING to make it stop. Your nails dig into your flesh. Maybe if you removed it all, it would hurt less.

You scratch at your face and neck, tearing small chunks from your skin, distracting your brain for but a moment before the excruciating pain returns. In second of clarity you remember the confessional. Maybe- Maybe if you can get there and repent, this will all stop. Rolling onto your stomach, you dig your nails into the wood, pulling yourself along the floor. {Confessional_Encounters ? (Killed_Girl): Is this what {Book_Knowledge ? (Know_Emily_Name): Emily | she } felt as she struggled for air? As her nails cracked and broke from the floor? } Your shirt slides up, and you see angry red lines etched in your skin. You pull the collar of your shirt, look down and see more of the same.

*[Apologize]
    "I'm sorry! Please, stop. <i>I'm sorry!</i>" You cry. <>

*[Beg]
    ~ Stay_Tracker += 1
    "Please, stop. <i>Please!</i> I'll do <i>anything</i>!" <>

- Your skin bubbles and oozes as the lines reform themselves into form words. Words you have read over and over again. <i>You found peace. You found peace. You found peace. You found peace.</i> "I- I won't do it again!"

Your words fall on deaf ears as you can only watch the words from your book engrave themselves in your skin, branding you. You curl into the fetal position, abandoning the idea of repenting. You've barely moved. You'd never make it. 

#DELAY: 3.5
Tears leak from your eyes, a soothing comfort as they roll over your bleeding skin. 

You whimper as the sizzling pain slowly subsides to a biting prickling. You bring your trembling hands to your face. Your nails are chipped and broken and not an inch of your skin in unblemished. The branded words already looks healed over, like you've always had them, but a thin sheen of sweat and plasma coats them. Slowly, slowly, you sit up. Your clothing peels over the wooden floor, and you wince.

*[You don't think you'll ever forget that pain]

- Your book sits in front of you, and you snatch it from the floor, and hold it to your chest. You don't care about the ending anymore.

->Office_Area.Leave_it

= Leave_it
*[Put the book away]
    ->Take_Or_Return(false)

*[Take the book with you]
    ~Book_Knowledge += (Kept_Book)
    ->Take_Or_Return(true)

= Rip_out_Ophelia
#PLAY: screeching, 1 #stop: screeching, 2
Ensuring you won't forget, you rip the page out of the book. The church lets out a scream as you do, and the room begins to shake. You stuff the page into your pocket, as you try to keep your balance.

Whatever books are left on the shelves fall off, and the far book shelf falls over. The room around you is starting to crumble.

*[Run out of the room]
~ Room_State = 5
~ Book_Knowledge += (Ripped_Pages)

- You make your way out of the room as fast as you can. All the books on the floor make it difficult, but you manage. Once you're about halfway to the door, you hear a sharp snapping sound. A large piece of ceiling falls to your side, just barely missing you.

You push yourself harder{Leg_State >= Limping: , but your leg is not cooperating with you You're not moving as fast as you want to |}. The door is so close. <i>You're</i> so close.

*[One last push]

-
{
    - Leg_State >= Limping:
        You try to push your body past it's limit, but your hurt leg gives out on you. You fall, just inches from the doorway. You don't have time to get to your feet before a large chunk of ceiling lands on you.

        "AAGHGAHGAH!" you let of a cry, wiggling around trying to get away. You feel like a bug that a child skewered with a stick. You know it's hopeless, and yet you still writhe on the ground.

        #ENDING: 2, Bad Ending: Crushed
        Hoping. Praying.

        *[But it's no use.]
        -> END
    - else:
        With one last burst of energy, you throw yourself out of the room. You land on the stairs hard, probably bruising something or worse. You watch as the room collapses in on itself, leaving only a caved in door way.

        "Well that was... something..." you mutter and carefully get to your feet, checking for any damage. You don't feel great but doesn't feel like anything's broken. "Note to self, <i>don't</i> rip anything while in here..."

        You pat your pocket that holds the page{Book_Knowledge ? (Kept_Book): , and tighten your grip on your book.|.} At least you can remove one more lock with this.
        
        *[Exit the office.]
        ->Office_Area.Exit_Office
}

= Examine_Office_Area
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
        -> Office_Area.Exit_Office_Area_Area
    

= Exit_Office
~Room_State += 1

You exit the office.

+[Examine the stairs]
    -> Office_Area.Examine_Office_Area
    
+[Return to the main body of the church]
    -> Office_Area.Exit_Office_Area_Area



////////// ENDING INTERACTIONS ////////// 

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
        "You're leaving me?" You stop. It's the little girl{Book_Knowledge ? (Know_Emily_Name): , Emily |.} She's crying. "You're leaving me all alone? Again?"
        
        You clench your fists, and feel something in your hand. You look down. It's the piece of ripped curtain.
        {
            - Priest_Feeling == guilt:
                Tears well in your eyes, and you fall to your knees, bowing your head, holding the fabric to your face. <Guilt, Shame, Remorse> bubbles up inside you. 
                
                {
                    - Stay_Tracker >= 1.5:
                        "No." you croak. How could you leave her again? After all she's been through?

                        "Thank goodness." she says, and you feel someone hug you from behind. You turn to hug her back.
                
                        *[No one is there.]
                        ->Office_Area.Sit_Pews
                    - else:
                        But the guilt is misplaced. You didn't hurt her. You don't even know if she's real.
                        
                        "Yes." You say and fall forward.
                        
                        There's a short shriek of anger, before you hit the cold pavement of the sidewalk. Then it's quiet. You look back, and the church is gone, if it was ever even there.
        
                        *[You stand, dust yourself off, and walk home.]
                        ->Office_Area.Leave
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
                        ->Office_Area.Sit_Pews
                        
                    - else:
                        You steel yourself.  You don't even know if she's real.
                        
                        "No." You say and fall forward.
                        
                        There's a short shriek of anger, before you hit the cold pavement of the sidewalk. Then it's quiet. You look back, and the church is gone, if it was ever even there.
        
                        *[You stand, dust yourself off, and walk home.]
                        ->Office_Area.Leave
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
                        ->Office_Area.Sit_Pews
                    - else:
                        You steel yourself.
                        
                        "No." You say and fall forward.
                        
                        There's a short shriek of anger, before you hit the cold pavement of the sidewalk. Then it's quiet. You look back, and the church is gone, if it was ever even there.
        
                        *[You stand, dust yourself off, and walk home.]
                        ->Office_Area.Leave
                }
        }
        
    - Church_Encounters ? (Was_Coward):
        "Coward." You stop. It's the woman who helped you{Book_Knowledge ? (Know_Ophelia_Name):, Ophelia." |.} "You're just going to leave?"
        
        {
            - Stay_Tracker >= 2.5:
                "I..." You don't know how to answer. You look down at your hands, they're intact. You still have all ten. You ball them into fists. "I..."

                "You don't deserve to leave."
                
                *[Maybe she's right...]
                ->Office_Area.Sit_Pews
            - else:
            "Yes." You say and fall forward.
                        
            There's a short shriek of anger, before you hit the cold pavement of the sidewalk. Then it's quiet. You look back, and the church is gone, if it was ever even there.
        
            *[You stand, dust yourself off, and walk home.]
            ->Office_Area.Leave
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
                        ->Office_Area.Sit_Pews
                - else:
                    You didn't leave this light until the church decided you could last time, but this time... Your finger tips escape the light, reaching out through the church door. 
                
                    That taste of freedom is all you need. With one last push, you throw yourself out out the door. There's a short shriek of anger, before you hit the cold pavement of the sidewalk. Then it's quiet. You look back, and the church is gone, if it was ever even there.
        
                    *[You stand, dust yourself off, and walk home.]
                        ->Office_Area.Leave
            }
            - else:
                You've escaped this light before, and you'll do it again. Your finger tips escape the light, reaching out through the church door. 
                
                That taste of freedom is all you need. With one last push, you throw yourself out out the door. There's a short shriek of anger, before you hit the cold pavement of the sidewalk. Then it's quiet. You look back, and the church is gone, if it was ever even there.
        
                *[You stand, dust yourself off, and walk home.]
                ->Office_Area.Leave
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

= Exit_Office_Area_Area
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

=== Open_Chest(-> return_to) ===
~temp Temp = false
*{items_obtained ? (Simple_Key)} [Try the simple key]
    ~ items_obtained -= (Simple_Key)
    ~ broke_key = true
    You fish the simple key out of your pocket and try the lock. The key slides in easy enough, but it doesn't want to turn. You force the key, thinking it just needed a little force. You jiggle the key, and force it to turn. <i>Clank!</i> 
    
    The key snaps in the lock. The teeth of the key are stuck and warped in the lock. You press the key against the lock, attempting to turn it again and again, thinking maybe if you press hard enough it would suddenly pop open. "God DAMMIT!"
    
    You fling the head of the key away from you and hurl the chest to the floor in frustration. The lid pops open, and a book with the number 2758 spills on it's cover onto the floor.
    ~temp_string = "if the loss of the key was worth it"

*{items_obtained ? (Skeleton_Key)} [Try the skeleton key]
    ~ Temp = true
    You fish the skeleton key out of your pocket and try the lock. The key slides in, and <i>Click!</i>
        
    The lid pops open and inside sits a book with the number 2758 on it's cover.
        ~temp_string = "if the loss of the key was worth it"

*[Break the chest]
    You raise the chest above your head, and hurl it to the floor. The lid pops open, and a book with the number 2758 on it's cover spills onto the floor.
    ~temp_string = "if this is indeed your book"

- You {temp: take the book from the chest, placing the now empty chest back on the shelf| pick the book up from the ground}<>

->return_to

//if we are here, player HAS to know about their book

=== Take_Or_Return(IsTake) ===
{Book_Knowledge ? (Branded): {IsTake: You tuck the book under your arm. Leaving it behind feels wrong somehow. | You struggle to your feet and shuffle to the bookshelf. You gently place your book on the shelf and slide it back until it hits the wall. You want nothing to do with it anymore.} You... You should do something. Return to your search. Find the heart. Destroy it. Escape. | {IsTake: You tuck the book under your arm. {Book_Knowledge ? (Read_End): You may already know how this could end, or at least, how the <i>church</i> thinks it will end, but something tells you to keep your book with you. {Stay_Tracker >= 2: Just in case something changes.} | You don't want to know how this story ends, but in case you change your mind, you'll have that choice.} | {Book_Knowledge ? (Read_End): You place the book back on the shelf. You know how it ends- Or rather, how the church thinks it will end. | You don't want to know how this story ends, not when there's still something you can do. You put the book back on the shelf.} } {Stay_Tracker < 2: You shouldn't give too much weight to it. That's what the church wants. | You chew your lip{Book_Knowledge ? (Kept_Book): and tighten your grip on it}. } You should do something productive instead of dwelling on it. {Saw_Locks: You remember the woman who helped you. Maybe if you find her book, or someone else's, you can find out what the code to the number lock is. | You should look elsewhere. You look at the books surrounding you. Maybe their stories could help you?}}

*{!(Explore_Office_Bookshelf ? Check_Boxes)} [Pick through the boxes]
    ~ Explore_Office_Bookshelf += (Check_Boxes)
    You pick through the boxes first, only to find them filled with more books. <>

*{!(Explore_Office_Bookshelf ? Check_Chest)} [Investigate the chest]
    ~ Explore_Office_Bookshelf += (Check_Chest)
    You grab the chest, and nearly drop it. The sides are slick with a wet, velvety mold. You wipe your hands on your pants and clench and unclench them, trying to forget the feeling. 
    
    "Gross gross gross gross gross," You say and gingerly pick it up, avoiding as many mold spots as you can. You attempt to open it, only to find it locked. You give it a shake, and hear something thumping around inside.
    
    "Probably just another book..." you mutter. You look through the key hole, but can't see anything.
    -> Open_Chest(->Office_Area.Your_Book)
    

*{!(Explore_Office_Bookshelf ? Check_Books)} [Flip through the books]
    ~ Explore_Office_Bookshelf += (Check_Books)
    You skim the covers of a few books from the closest shelf. <>

*{Explore_Office_Bookshelf !? (Check_Desk)}[{Saw_Locks: Look for something to break the chain | Dig through the desk}]
    ->Office_Area.Desk

*[Exit the office]
    ->Office_Area.Exit_Office
    
- They all resemble {Book_Knowledge ? (Saw_Your_Book): your book. | the other books in the room.} The main difference being the bold number on the cover or spine, and some looking a little older. From what you can tell, none of the numbers repeat. 

*[{Saw_Locks or Confessional_Encounters ? (Talked_to_Girl): Look for her book | Read through the books}]

- {Saw_Locks: With the minimal knowledge you have, you skim through as many books as you can. You search and search, {Confessional_Encounters ? (Talked_to_Girl): looking for any and every book that matches the story the little girl told you. A sick child that thinks her parents resent her, a mother that had a sick child, or a father that was a priest. | but you don't know enough about her to even know if you've passed her book or not.} | You pick up a book at random, skimming though them for any relevant or interesting information. {Confessional_Encounters ? (Talked_to_Girl): You try to focus on books that matches the story the little girl told you. A sick child that thinks her parents resent her, a mother that had a sick child, or a father that was a priest. | You read book after book after book, but you don't know what you're looking for.}}

{Saw_Locks: You read book after book, story after story about the victims of the church. | Each story you read all are about victims of the church.} All the stories only describe parts where the victim is in or near the church, so most have gaps{Book_Knowledge ? (Read_Start):, much like your own book}. Many stories mimic your own, but some never knew they were ever in danger. Some attempted to escape, but all of them had the same ending.

{Book_Knowledge ? (Read_End): And much like your own ending, they all find peace. | They never leave.} {Saw_Locks or Confessional_Encounters ? (Talked_to_Girl) or Confessional_Encounters ? (Finished_Curtain_Side): You're about to give up until you find someone promising: {Saw_Locks: Ophelia. | {Confessional_Encounters ? (Talked_to_Girl): Emily. |  {Confessional_Encounters ? (Finished_Curtain_Side): Olin. | }}}| After reading another dead-end book, you pinch the bridge of your nose and sigh. You're surrounded by a pile of useless books and your eyes are strained from reading in low light.}

*{Saw_Locks or Confessional_Encounters ? (Talked_to_Girl) or Confessional_Encounters ? (Finished_Curtain_Side)} [Read the book ((UNLESS THE NAME IS OPHELIA, I DID NOT WRITE THIS))]
    {Saw_Locks: ->Ophelia_Book | {Confessional_Encounters ? (Talked_to_Girl): ->Emily_Book | {Confessional_Encounters ? (Finished_Curtain_Side): ->Olin_Book}}}

* {!Saw_Locks or Confessional_Encounters !? (Talked_to_Girl) or Confessional_Encounters !? (Finished_Curtain_Side)} [Come back later]
    You have has enough reading, and decide you need to move on. You're sure something in here has the information you want, but blindly reading isn't helping. You'll come back when you know more.
    ->Office_Area.Exit_Office
    
* {!Saw_Locks or Confessional_Encounters !? (Talked_to_Girl) or Confessional_Encounters !? (Finished_Curtain_Side)} [Keep reading]
    You sigh deeply and grab another book. 
    TODO: church gonna look at you again. you're gonna throw a book in frustration and it's gonna hit the window and the church is gonna be like "ouchie wtf man" and you're gonna be upset again and maybe die

= Olin_Book
TODO
->END

= Emily_Book
TODO
->END

= Ophelia_Book
~ Book_Knowledge += (Know_Ophelia_Name)
You read through her book carefully, learning that her daughter's name is Emily, and that Ophelia followed Emily into the church after she ran inside. 

Ophelia was determined to escape with Emily, and figured out a possible way to exit by destroying the heart of the church. Your heart pounds as you read. She found the same locked door you did. Your eyes slide down the page a little more and...

"2755, got it!" you exclaim. "Thank you, Ophelia!"

*[Rip out the page]
->Office_Area.Rip_out_Ophelia

{
    - Saw_Locks && !temp_bool_3:
        ~temp_bool = true
        *[Look for something to break the chain lock.]
        ->Office_Area.Desk
    - !Saw_Locks && !temp_bool_3:
        ~temp_bool = false
        *[Look through the desk]
        ->Office_Area.Desk
}

*[Exit the office.]
->Office_Area.Exit_Office

=== Rand_Book(value) ===
You half-heartedly read through it before sitting up sharply. This person's story goes deeper than a failed escape or instant death. You check the front cover again, taking note of the number on the cover before flipping back to the beginning.

*[Read the book closer ((UNLESS THE NAME IS OPHELIA, I DID NOT WRITE THIS))]
    {value == 2755: ->Take_Or_Return.Ophelia_Book | {value == 2754: ->Take_Or_Return.Emily_Book | {value == 2753: ->Take_Or_Return.Olin_Book}}}









