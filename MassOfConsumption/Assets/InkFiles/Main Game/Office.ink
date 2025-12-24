=== Office_Area ===

= Enter_From_Encounter

~ Have_Visited += (Enter_Office)
~ Room_State++
-> Office_Choices

= Office
{Have_Visited !? (Enter_Office): {Looked_For_Items: It's the office door from earlier, but it seems shorter than you remember, it now being about the same hight as you. You duck | You hope something useful lies behind, and enter} through the doorway. {Looked_For_Items: The office doesn't look much different from what you saw earlier, though, you can now make out more with the help of your flashlight. | The room seems to be an office, and smells incredibly musty.} It's a tight space with bookshelves lining the side walls, each shelf packed with books and boxes. A desk sits at the far wall, covered in dust and cobwebs, and a stained glass window above it. {Church_Investigation ? (Saw_Windows): You avoid looking at it.} | {Room_State == Half: You open the door and crouch-walk through.} {Room_State == Crawl: You open the door and army crawl through.} Despite the change in door size, the rest of the room remains how you remember it. } #IMAGE: Office



~ Have_Visited += (Enter_Office)
~ Room_State++
-> Office_Choices

= Office_Choices

+{Explore_Office_Bookshelf !? (Check_Desk)}[Dig through the desk]
    ->Office_Area.Desk

+{Explore_Office_Bookshelf !? (Check_Books)}[Browse the bookshelves]
    ->Office_Area.Books

+{Explore_Office_Bookshelf ? (Check_Books) and (!read_mary_book or Book_Knowledge !? (Read_Oldin_Book) or Book_Knowledge !? (Read_Mom_Young_Book) or Book_Knowledge !? (Read_Mom_Old_Book))}[Search through books again]
    {
        - !read_mary_book:
        With no further information, you grab a random book to start reading. The number 1243 is on the cover in thick, gold-colored lettering.

        The first page has the name "Mary" in script. -> Office_Area.Mary_Book
        
        - (Book_Knowledge !? (Read_Mom_Old_Book)) or ((Book_Knowledge !? (Read_Mom_Young_Book) or Book_Knowledge !? (Read_Oldin_Book)) and (Confessional_Encounters ? (Finished_Curtain_Side) or Confessional_Encounters ? (Confessional_DoorSide))):
            {Book_Knowledge !? (Read_Mom_Young_Book): You take another crack at reading through the books. You now have a better idea about what to look for. {Confessional_Encounters ? (Talked_to_Girl): You look for any and every book that matches the story the little girl told you. A sick child that thinks her parents resent her or a father that was a priest. | but you don't know enough about her to even know if you've passed her book or not. {Saw_Locks: You hope that she had also seen the chains and locks you have.}} | {Confessional_Encounters ? (Finished_Door_Side) and Book_Knowledge !? (Read_Oldin_Book):The priest you confessed to didn't tell you a lot, but you think it might be enough to find <i>something</i> in his book.}} After some searching you find a book that seems to match what you're searching for.
    
        * [Read the book]
            {Confessional_Encounters ? (Finished_Curtain_Side) and Book_Knowledge !? (Read_Mom_Young_Book): ->Take_Or_Return.Mom_Young_Book | {Confessional_Encounters ? (Finished_Door_Side) and Book_Knowledge !? (Read_Oldin_Book): ->Take_Or_Return.Olin_Book | {Book_Knowledge !? (Read_Mom_Old_Book): ->Take_Or_Return.Mom_Old_Book}}}
        - else:
            You flip through books, searching to see if anyone else has escaped, but come up empty. You should come back after learning more.
            
                ++{Explore_Office_Bookshelf !? (Check_Desk)}[Dig through the desk]
                     ->Office_Area.Desk
            
                **[Move on with your search]
                    -> Office_Area.Exit_Office_Continue
            -> Office_Choices
    }  

*{visited_state >= 1} [Exit and examine the stairwell]
    #IMAGE: Default
    You exit the office, planning to come back later. <>
    -> Stairs.Examine_Stairs

= Desk
~ Explore_Office_Bookshelf += (Check_Desk)
~ items_obtained += (Simple_Key)

You walk around and plot onto the old desk chair. It groans in protest under your weight. Nothing interesting sits on the desk itself, save for a desk lamp. You flick the on off switch, but nothing happens. {Looked_For_Items: You touch the space where the {Object} had been and wonder if you should have {Took_Item: kept it on you. | taken it.} You silently curse yourself for not doing so. {Saw_Locks and Object == sledgehammer: The {Object} would have made quick work of all the locks upstairs. You make a fist and bang it on the desk in frustration.} | <>}

 You pull open the desk drawers and dig through their contents. Most only contain broken, or otherwise unusable, writing utensils and paper scraps to old to make any text out, but one drawer holds a key.

#PROP: [simple_key true]
The key is {items_obtained ? (Skeleton_Key): about the same size as the one you got before, but much less interesting. It is grey and nondescript, and i| small, grey and nondescript. I}t looks similar to a generic house key. You turn it over in your hands before slipping it into your pocket. {Saw_Locks: It might fit the lock upstairs. | It will probably be useful later.}

-> Office_Choices

= Books
~ Book_Knowledge += (Explored_Books)
~ Explore_Office_Bookshelf += (Check_Books)
You approach the bookshelves. The books all look to be leather bound, and in better condition than the rest of the items littering the shelves. Water-stained boxes and a decaying wooden chest decorate the shelves. #PROP: [simple_key false]

*{Have_Visited ? (Check_Boxes) == false} [Pick through the boxes]
    ~ Explore_Office_Bookshelf += (Check_Boxes)
    You pick through the boxes first, only to find them filled with more books. You grab a random book from the box. <>

*{Have_Visited !? (Check_Chest)} [Investigate the chest]
    ~ Explore_Office_Bookshelf += (Check_Chest)
    You grab the chest, and nearly drop it. The sides are slick with a wet, velvety mold. You wipe your hands on your pants and clench and unclench them, trying to forget the feeling. 
    
    "Gross gross gross gross gross," You say and gingerly pick it up, avoiding as many mold spots as you can. You attempt to open it, only to find it locked. You give it a shake, and hear something thumping around inside.
    
    "Probably just another book..." you mutter. You look through the key hole, but can't see anything.
    -> Open_Chest(->Office_Area.Your_Book)
    

*{Have_Visited ? (Check_Books) == false} [Flip through the books]
    ~ Explore_Office_Bookshelf += (Check_Books)
    You skim the covers of a few books from the closest shelf. You grab a random book from the shelf. <>

- It has no title, but the number 2743 is on the cover in thick, gold-colored lettering. The first page has the name "Mary" in script. A dedication, maybe? You flip to the next page and begin to read. The color immediately drains from your face. 

~ PlayBGM("watched", true, 10, 0)
~ StopSFX("inside", 10, 0)
You jump to the end, and your stomach tightens. You throw the book to the floor, and grab another off it's shelf. 1924, Jeff. 2952, Adrian. 1853, Reed. All the stories are the same: They entered the church, and never left.

*[Finish Mary's book]
    Tentatively, you pick up Mary's book again, and begin to read. <>
    -> Office_Area.Mary_Book

*[Look for your book]
    -> Office_Area.Your_Book

= Mary_Book
~ read_mary_book = true
The start is jarring. Mary is stuck in a storm, and stumbled upon the church while looking for a place to rest. Unlike your experience, this was her first time meeting the church. Her first thought upon seeing it was: <i>Finally, salvation.</i> 

She did not hesitate to take shelter inside. 

Once inside, Mary wanders to the pews. A pastor asks if she's alright. <i>Are you cold, child? Let me turn up the heat.</i> Before she can even speak he drapes a a heavy blanket over her shoulders. <i>Please sit. Rest. I'll play you a beautiful song.</i> 

He leads her to a pew before making his way to the stage and playing the organ. You can't be sure if he played the same melody you heard, but it brought Mary ot tears. No one had been so kind to her before.

The last page details how the beautiful melody lulled her into a deep sleep. How her final breaths were peaceful. How her body melted into wood after she was gone. It doesn't say what happened to the pastor. {Have_Visited ? (Confessional_DoorSide) or Have_Visited ? (Enter_Pews): You wonder if it's the same one you met. }

You close the book, and place it back on the shelf. {Book_Knowledge ? (Saw_Your_Book): Your stomach gurgles, and you wonder how many more of these you can stomach. Too many have the same sad ending. | Your insides twist and turn as you look over all the books that litter the floor, and sit on the shelves. All these books- no. All these <i>people</i> are victims who never got out.}

*{Book_Knowledge !? (Saw_Your_Book)} [Look for your book]
    -> Office_Area.Your_Book

*[Grab the next book]
    ~Explore_Office_Bookshelf += (Check_Books)
    {
        - Have_Visited ? (Confessional_CurtainSide): 
            You yank the book off the shelf, expecting more of the same. You sit up sharply. This person's story goes deeper than a failed escape or instant death. You check the front cover again, taking note that the number on the cover is...
        
            *[2755]
                {
                    - Have_Visited ? (Confessional_DoorSide): 
                        ->Take_Or_Return.Mom_Young_Book
                    - else:
                        ->Take_Or_Return.Mom_Old_Book
                }
                
            *[2750]
                ->Take_Or_Return.Olin_Book
            
        - else: 
            You yank the book off the shelf, expecting more of the same. You sit up sharply. This person's story goes deeper than a failed escape or instant death. You check the front cover again, taking note that the number on the cover is 2755.
            
            {
                - Have_Visited ? (Confessional_DoorSide): 
                    ->Take_Or_Return.Mom_Young_Book
                - else:
                    ->Take_Or_Return.Mom_Old_Book
            }
    }
//2758 == yours

= Your_Book
~ temp Temp_Bool = false

{
    - Explore_Office_Bookshelf ? (Check_Boxes) || Explore_Office_Bookshelf ? (Check_Books):
    
    {
        - Book_Knowledge !? (Saw_Your_Book):
            ~ Book_Knowledge += (Saw_Your_Book)
            ~ Explore_Office_Bookshelf += (Check_Chest)
            You pull book after book off the shelves, looking at the first page for your name, and throwing it to the floor when it's not. When you run out of books, you go through the boxes. 
            
            "Where is it? Where could it possibly be?" You grab the chest, and nearly drop it. The sides are slick with a wet, velvety mold. You wipe your hands on your pants and clench and unclench them, trying to forget the feeling. You give it a shake, and hear something thumping around inside.
            
            You try to open it, but it's locked. "Maybe in here?" you mutter. You look through the key hole, but can't see anything. "It could be..."
    
            -> Open_Chest(->Office_Area.Your_Book)
        - Book_Knowledge ? (Saw_Your_Book):
            ~ Temp_Bool = true
            , and trace the numbers. You look at the first page, anxious to see if this is indeed your book. Your legs turn to jelly and you collapse to the ground. "Oh..." #PROP: [your_book true]
    }
        
        
    - Book_Knowledge !? (Saw_Your_Book) && Explore_Office_Bookshelf ? (Check_Chest):
        ~ Book_Knowledge += (Saw_Your_Book)
        , and trace the numbers. You read the first page, and fall to the ground with a croak "That's... That's not..." #PROP: [your_book true]
}

*[{Temp_Bool: It's <i>your</i> book | The book is about <i>you.</i>}]
    ~ Book_Knowledge += (Read_Start)

- 
~ PlayBGM("watched", true, 10, 0)
~ StopSFX("inside", 10, 0)
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
    ->Office_Area.Unsure(false)

* [Take the book with you]
    ~Book_Knowledge += (Kept_Book)
    ->Take_Or_Return(true)
    
*[Rip out the page]

- 
~ Stay_Tracker -= 0.5
~ PlaySFX("paper_rip_1", false, 0, 0)
You stare at the page, {Stay_Tracker < 2: and without another thought, | hesitating for a moment. You stare at the page with a sour taste in your mouth. You bite the inside of your cheek, and} rip it out. There is a quivering pain in your lower back, but ignore it. You feel a flooding sense of reassurance as you stare at the blank page. Your book is no longer finished. #PROP: [your_book false]

Before you can flip the book closed, you see movement on the page. Your body tenses as you watch ink stain the page and the words reappear. <i>You found peace.</i> You shake your head, {Stay_Tracker < 2: lip curling. | eyes wide.}

*[Rip it out again]

*[Leave it]
    You take a deep breath, and close the book. The church can think what it wants.
    ->Office_Area.Leave_it
- 
~ Stay_Tracker -= 0.5
~ PlaySFX("paper_rip_2", false, 0, 0)
~ PlaySFX("paper_rip_3", false, 0, 0.75)
You rip out the page again, and again, you feel a twitching pain. This time, in your shoulder. {Stay_Tracker < 2: You refuse to let the church win. } And again the ink reappears. {Stay_Tracker < 2: | You grip the book tighter.}

In {Stay_Tracker < 2: frustration | exasperation}, you rip the pages out over and over. With each page ripped comes a new pang of pain, each ache more distressing than the last. The ink reappears each time. You rip and rip and rip the pages until there's only one page left.

Your entire body trembles.

*[Rip it out]

*[Leave it]
    Your hand hovers over the last page, but you pause before ripping it out. Your body is sore, feeling like the day after an intense workout, and your heart pounds erratically. You take a deep breath and close the book. The church can think what it wants. 
    ->Office_Area.Leave_it

- 
~ Book_Knowledge += (Branded)
~ WinAchievement(5)
~ PlaySFX("paper_rip_1", false, 0, 0)
~ PlaySFX("paper_rip_2", false, 0, 0.75)
~ PlaySFX("paper_rip_3", false, 0, 1.5)
You rip out the last page, bracing for a new wave of agony that never comes. You blink, a slight smile on your lips. "What now, huh?" you yell. You won. You beat the church. You— #DELAY: 1.65

~ PlaySFX("climax_long", false, 0, 0)
Your skin tingles just under the surface, similar to a mild sunburn. You lightly slap your arm as it quickly turns into a searing, flaying pain. You scream and drop your book, clawing at the skin, trying to make it stop- ANYTHING to make it stop. Your nails dig into your flesh. Maybe if you removed it all, it would hurt less.

You scratch at your face and neck, tearing small chunks from your skin, distracting your brain for but a moment before the excruciating torment returns. In second of clarity you remember the confessional. Maybe- Maybe if you can get there and repent, this will all stop. 

Rolling onto your stomach, you dig your nails into the wood, pulling yourself along the floor. {Confessional_Encounters ? (Killed_Girl): Is this what {Book_Knowledge ? (Read_Mom_Young_Book): Ophelia | she } felt as she struggled for air? As her nails cracked and broke from the floor? } Your shirt slides up, and you see angry red lines etched in your skin. You pull the collar of your shirt, look down and see more of the same.

*[Apologize]
    "I'm sorry! Please, stop. <i>I'm sorry!</i>" You cry. <>

*[Beg]
    ~ Stay_Tracker += 0.5
    "Please, stop. <i>Please!</i> I'll do <i>anything</i>!" <>

- Your skin bubbles and oozes as the lines reform themselves into form words. Words you have read over and over again. <i>You found peace. You found peace. You found peace. You found peace.</i> "I- I won't do it again!"

Your plea fall on deaf ears as you can only watch the words engrave themselves in your skin, branding you. You curl into the fetal position, abandoning the idea of repenting. You've barely moved. You'd never make it in time. 

Tears leak from your eyes, a cool and soothing as they roll over your bleeding skin. You whimper as the sizzling pain subsides to a biting prickle. You bring your trembling hands to your face. 

Your nails are chipped and broken, and not an inch of your skin in unblemished. The branded words already look healed over, like you've always had them, but a thin sheen of sweat and plasma coats them. Slowly, slowly, you sit up. Your clothing peels off the wooden floor, and you wince.

*[You don't think you'll ever forget that pain]

- 
~ PlayBGM("inside", true, 10, 0)
~ StopSFX("watched", 10, 0)
Your book sits in front of you, and you snatch it from the floor, and hold it to your chest. You don't care about the ending anymore.

->Office_Area.Leave_it

= Leave_it
*[Put the book away]
    ->Take_Or_Return(false)

*[Take the book with you]
    ~Book_Knowledge += (Kept_Book)
    ->Take_Or_Return(true)

= Rip_out_Ophelia
~ Room_State = Destroyed
~ Book_Knowledge += (Ripped_Pages)

~ PlaySFX("screeching", false, 0.5, 0) 
~ PlayBGM("watched", true, 5, 0)
~ StopSFX("inside", 5, 0)
Ensuring you won't forget, you rip the page out of the book. The church lets out a scream as you do, and the room begins to shake. You stuff the page into your pocket, as you try to keep your balance. #EFFECT: Shake_Office

The remaining books on the shelves fall off, and the far book shelf falls over. The room around you is starting to crumble. 

You rush out of the room as fast as you can. Books and boxes littering the floor threaten to trip you as pieces of ceiling drop on you from above. You're about halfway to the door when you hear a sharp snapping sound. A large piece of ceiling falls to your side, just barely missing you.

You push yourself harder{Leg_State >= Limping:, but your leg is refusing to cooperate with you. Each time you foot hits the floor a searing pain shoots up your shin. |.} The door is so close. <i>You're</i> so close. Another cracking from the ceiling. You jerk your head up and see a large chuck barely being held up. If it falls before you get to the door, you'll be trapped inside.


*[Dive for it]
    You plant your leading foot and all but throw yourself at the door. You soar through the doorway and land on the stairs, hard, probably bruising something or worse. <>

*[Keep running]
    {
        -Leg_State >= Limping:
            You try to push your body past it's limit, but your hurt leg gives out on you. You fall, just inches from the doorway, and the large chunk of ceiling lands on you.

            "AAGHGAHGAH!" you let of a cry, wiggling around trying to get away. You feel like a bug that a child skewered with a stick. You know it's hopeless, and yet you still writhe on the ground.
            
            Hoping. Praying.
    
            *[But it's no use.]
                #ENDING: 2, Bad Ending - Crushed
                -> Endings.Bad_End_2
    }
    
    You push you body past its limits, and run faster than you ever have before. Blood drums in your ears as you throw yourself through the doorway and run straight into the hallway wall. You collapse to the ground, heart ready to explode. <>

- You watch as the room collapses in on itself, leaving only a caved in door way behind. {Book_Knowledge !? (Kept_Book, Saw_Your_Book): Something glints in the rubble left behind.}

    "Well that was {Book_Knowledge ? (Branded): stupid}... " you mutter and carefully get to your feet, checking for any lasting damage. You don't feel great but doesn't feel like anything's broken. {Book_Knowledge ? (Branded): You rub your arms where the words are burned into the skin.  |  "Note to self, <i>don't</i> rip anything while in here..."}

*{Book_Knowledge !? (Saw_Your_Book)}[Examine the glinting in the rubble]
    ~Book_Knowledge += (Saw_Your_Book)
    You shine your flashlight over the pile to see a book. 2758. You pick it up and flip it open and immediately close it. It's <i>your</i> book.
    
    **[Read it now]
        ->Read_After_Rubble
    
    **[Take it with you]
        ~Book_Knowledge += (Kept_Book)

*->

- You pat your pocket that holds the page{Book_Knowledge ? (Kept_Book): , and tighten your grip on your book.|.} At least you can remove one more lock with this.
        
        **[Move on with your search]
            -> Exit_Office_Continue

= Read_After_Rubble
~ Book_Knowledge += (Read_Start)
Your read the first few pages, and it details everything you've experienced so far, including the childhood memories you suppressed. There's a handful of blank pages between your childhood experience and current one. Your hands shake and your eyes burn. Is the ending already written? If it is, will reading make a difference?

*[Take the book with you]
    ~ Book_Knowledge += (Kept_Book)
    You hold your book tightly to your chest, and pat your pocket that to make sure the page lies safely within.
        
        **[Move on with your search]
            -> Exit_Office_Continue

*[Flip to the end]
    ~ Book_Knowledge += (Read_End)

-
#CYCLE: prayer, curse, plea, apology
You squeeze your eyes shut and tilt your head back, whisper a @, and flip to the end of the book. You take a deep breath and read the last page. It ends with... 

~ PlayBGM("watched", true, 10, 0)
~ StopSFX("inside", 10, 0)
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
    ->Office_Area.Unsure(false)

* [Take the book with you]
    ~Book_Knowledge += (Kept_Book)
    You hold your book tightly to your chest, and pat your pocket that to make sure the page lies safely within.
        
        **[Move on with your search]
            -> Exit_Office_Continue
    
*[Rip out the page]

- 
~ Stay_Tracker -= 0.5
You stare at the page, {Stay_Tracker < 2: and without another thought, | hesitating for a moment. You stare at the page with a sour taste in your mouth. You bite the inside of your cheek, and} rip it out. There is a quivering pain in your lower back, but ignore it. You feel a flooding sense of reassurance as you stare at the blank page. Your book is no longer finished.

Before you can flip the book closed, you see movement on the page. Your body tenses as you watch ink stain the page and the words reappear. <i>You found peace.</i> You shake your head, {Stay_Tracker < 2: lip curling. | eyes wide.}

*[Rip it out again]

*[Leave it]
    You take a deep breath, and close the book. The church can think what it wants. You decide to take the book with you, just in case. You hold it tightly to your chest, and pat your pocket that to make sure the page lies safely within.
        
        **[Move on with your search]
            ~Book_Knowledge += (Kept_Book)
            -> Exit_Office_Continue
- 
~ Stay_Tracker -= 0.5
You rip out the page again, and again, you feel a twitching pain. This time, in your shoulder. {Stay_Tracker < 2: You refuse to let the church win. } And again the ink reappears. {Stay_Tracker < 2: | You grip the book tighter.}

In {Stay_Tracker < 2: frustration | exasperation}, you rip the pages out over and over. With each page ripped comes a new pang of pain, each ache more distressing than the last. The ink reappears each time. You rip and rip and rip the pages until there's only one page left.

Your entire body trembles.

*[Rip it out]

*[Leave it]
    Your hand hovers over the last page, but you pause before ripping it out. Your body is sore, feeling like the day after an intense workout, and your heart pounds erratically. You take a deep breath and close the book. The church can think what it wants. 
     
    You decide to take the book with you, just in case. You hold it tightly to your chest, and pat your pocket that to make sure the page lies safely within.
        
        **[Move on with your search]
            ~Book_Knowledge += (Kept_Book)
            -> Exit_Office_Continue

- 
~ Book_Knowledge += (Branded)
You rip out the last page, bracing for a new wave of agony that never comes. You blink, a slight smile on your lips. "What now, huh?" you yell. You won. You beat the church. You- #DELAY: 0.5

~ PlaySFX("climax_long", false, 0, 0)
Your skin tingles just under the surface, similar to a mild sunburn. You lightly slap your arm as it quickly turns into a searing, flaying pain. You scream and drop your book, clawing at the skin, trying to make it stop- ANYTHING to make it stop. Your nails dig into your flesh. Maybe if you removed it all, it would hurt less.

You scratch at your face and neck, tearing small chunks from your skin, distracting your brain for but a moment before the excruciating torment returns. In second of clarity you remember the confessional. Maybe- Maybe if you can get there and repent, this will all stop. Rolling onto your stomach, you dig your nails into the wood, pulling yourself along the floor. {Confessional_Encounters ? (Killed_Girl): Is this what {Book_Knowledge ? (Read_Mom_Young_Book): Ophelia | she } felt as she struggled for air? As her nails cracked and broke from the floor? } Your shirt slides up, and you see angry red lines etched in your skin. You pull the collar of your shirt, look down and see more of the same.

*[Apologize]
    "I'm sorry! Please, stop. <i>I'm sorry!</i>" You cry. <>

*[Beg]
    ~ Stay_Tracker += 0.5
    "Please, stop. <i>Please!</i> I'll do <i>anything</i>!" <>

- Your skin bubbles and oozes as the lines reform themselves into form words. Words you have read over and over again. <i>You found peace. You found peace. You found peace. You found peace.</i> "I- I won't do it again!"

Your plea fall on deaf ears as you can only watch the words engrave themselves in your skin, branding you. You curl into the fetal position, abandoning the idea of repenting. You've barely moved. You'd never make it in time. 

Tears leak from your eyes, a cool and soothing as they roll over your bleeding skin.

You whimper as the sizzling pain subsides to a biting prickle. You bring your trembling hands to your face. Your nails are chipped and broken, and not an inch of your skin in unblemished. The branded words already look healed over, like you've always had them, but a thin sheen of sweat and plasma coats them. Slowly, slowly, you sit up. Your clothing peels off the wooden floor, and you wince.

*[You don't think you'll ever forget that pain]

- Your book sits in front of you, and you snatch it from the floor, and hold it to your chest. You don't care about the ending anymore. You decide to take the book with you, just in case. You hold it tightly to your chest, and pat your pocket that to make sure the page lies safely within.
        
*[Move on with your search]
    ~Book_Knowledge += (Kept_Book)
    -> Exit_Office_Continue

= Examine_Office_Area
{Have_Visited !? (Stairs_Up) or Downstairs_State <= None: You walk deeper down the hallway to the stairs. Going up, is a spiral staircase. Going down, is a long set of stairs. You can't see the end of either. {Looked_For_Items: How did you miss this before?} | The stairs are still there, spiraling up into the sky and digging down into the earth.}

+[Go upstairs]
    ->Stairs.Upstairs
    
+[Go downstairs]
    ->Stairs.Downstairs
    
+[Go back to the office]
    You turn around are return to the office door. {Room_State == 3: You frown at the doorway. Was it always that short? } {Room_State == 4: You blink at the doorway. It was definitely not always that shot. You think you would remember needing to army crawl to enter.}

    ->Office_Area.Office



////////// ENDING INTERACTIONS ////////// 

= Unsure(From_Priest)
~ StopAll()
~ PlaySFX("creaking", false, 0, 0)
~ PlayBGM("outside", true, 0.5, 0)
~ Intrusive(4, "It's letting you out?", "")
Confused, you numbly wander back into the main body of the church. You find yourself back by the front door. It creaks open, showing off the moonlit sidewalk of the outside world. #IMAGE: Open_Door #PROP: [Open_Door true], [your_book false]

*[Reach out a hand]
    #EFFECT: IntialSight
    But the church looks at you again, bathing you in the wonderfully {Light_Feeling == relief: pleasant | dizzying } red light. The door stay opens. You feel like... #REMOVE: Intrusive #EFFECT: IntialSight

*[Look away]
    ~Stay_Tracker += 1
    You look at the body of the church behind you. You feel @ about leaving it behind. The eye opens, and looks at you again, bathing you in the wonderfully {Light_Feeling == relief: pleasant | dizzying } red light. The door sways in the wind. You feel like... #CYCLE: conflicted, wary, hesitant #EFFECT: IntialSight #REMOVE: Intrusive

- 

*[Laughing]
    ~ Church_Feeling = "laughing"

*[Crying]
    ~ Church_Feeling = "crying"

- 
~ Intrusive(4, "What do you want?", "")
You're hysterical. Your whole body is heavy and tingling. You take a heavy step toward the door. <i>Is this really what you want?</i> Freedom is only one more step away. <i>{From_Priest: To stay? | To leave?}</i> Your leg glues itself to your the floor. <i>Are you sure?</i> {From_Priest: You swore it, but... | You grab your leg, pulling it forward.}

{
    - From_Priest and Stay_Tracker >= 5:
        The red light intensifies, a comforting pressure. You fall to the floor. Your body is heavy. You don't want to leave it, but you know you have to. You want to. You want...
            
        What do you want? #REMOVE: Intrusive
            
        You stop, and sit back. You stare up at the church window, and it looks back at you.

        ~ Intrusive(2, "To leave?", "")
        ~ Intrusive(6, "To stay?", "")
        What are you fighting so hard for? 

        {finger_pain_pass: You look down at the hand that's missing a finger. | You think about all you've been through. } #REMOVE: Intrusive
                    
        *[You've already given up so much]
            ~ PlaySFX("organ", false, 5, 0)
            The front door closes, and you drift deeper into the church. Organ music begins to play. #PROP: [Open_Door false], [Closed_Door true] 
            
            ~ PlayBGM("inside", true, 5, 0)
            You end up in the pews, just like your book said you would. You sit down, and close your eyes, taking in the church music. When you open them, the pews are filled with people, all turned towards you. It's people you've read about, smiling at you. Welcoming you. #IMAGE: Church_Inside #PROP: [Closed_Door false] 
            
            They begin to sing, hands out stretched for you to take. The music flows through you, and you feel a smile come to your face.
            
            **[Take their hands.]
                #ENDING: 7, Bad? Ending - Finding Peace #EFFECT: remove-glow
                ->Endings.Bad_End_7
                
    - Confessional_Encounters ? (Killed_Girl):
        ~ Intrusive(3, "It's not her", "")
        "You're leaving me?" You stop. It's the little girl{Book_Knowledge ? (Read_Mom_Young_Book): , Ophelia |.} She's crying. "You're leaving me all alone? Again?" #REMOVE: Intrusive
        
        ~ Intrusive(3, "It can't be", "")
        You clench your fists, and feel something in your hand. You look down. It's the piece of ripped curtain. <>
        {
            - Priest_Feeling == guilt:
                ~ Intrusive(3, "Your fault. Your fault.", "")
                Tears well in your eyes, and you fall to your knees, bowing your head, holding the fabric to your face. @ bubbles up inside you. #CYCLE: Guilt, Shame, Remorse
                
                *["I won't."]
                    How could you leave her again? After all she's been through? #REMOVE: Intrusive

                    "Thank goodness." she says, and you feel someone hug you from behind. You look down to see small hands gripping your waist. Not barely visible, ghostly hands, but real ones. Pigmented skin, warm and alive. You feel your resolve weakening the longer you look at her hands. Real hands. Human hands. You turn to hug her back.
            
                    **[No one is there.]
                        ->Office_Area.Sit_Pews
                        
                 *["I'm sorry."]
                    But the guilt is misplaced. You didn't hurt her. You don't even know if she's real. #REMOVE: Intrusive
                    
                    "Yes." You say and fall forward. #EFFECT: remove-glow
                    
                    There's a short shriek of anger, before you hit the cold pavement of the sidewalk. Then it's quiet. You look back, and the church is gone, if it was ever even there.
    
                    **[You stand and dust yourself off]
                        ->Office_Area.End_Game
                
                
            - Priest_Feeling == dread:
                ~ Intrusive(3, "Not real.", "")
                You drop the fabric, and watch it fall to the floor. The crisp outside wind blows into the church, but the fabric does not react to it.
                
                ~ Intrusive(5, "But it could be...", "")
                "It's not real." You mummer, and fix your gaze on the outside. "It's not real."
                
                "But <i>I</i> am." the little girl wails, and something warm slams into your back. "<i>I'm</i> real, so <i>promise</i> you won't leave me alone again!" #REMOVE: Intrusive
                
                ~ Intrusive(5, "Real...?", "")
                ~ Intrusive(5, "She's real.", "")
                ~ Intrusive(5, "Not a trick.", "")
                You look down to see small hands gripping your waist. Not barely visible, ghostly hands, but real ones. Pigmented skin, warm and alive. You feel your resolve weakening the longer you look at her hands. Real hands. Human hands. 
                        
                "I...." you croak.
                
                *["I won't]
                    "I won't." you whimper. If it is real, how could you leave her again? "I promise" #REMOVE: Intrusive

                    "Thank goodness." she says, and squeezes you tighter. You turn to hug her back.
            
                    **[No one is there.]
                        ->Office_Area.Sit_Pews
                        
                *["I'm sorry."]
                    You steel yourself. You don't even know if she's real. #REMOVE: Intrusive
                    
                    "No." You say and fall forward. #EFFECT: remove-glow
                    
                    ~ PlaySFX("groaning_angry", false, 0, 0)
                    There's a short shriek of anger, before you hit the cold pavement of the sidewalk. Then it's quiet. You look back, and the church is gone, if it was ever even there. #IMAGE: Default #PROP: [Open_Door false]
    
                    **[You stand and dust yourself off]
                        ->Office_Area.End_Game
            
            - Priest_Feeling == anger:
                You throw the fabric to the ground. "Do you think this will work the second time?" You {Church_Feeling}.
                
                ~ Intrusive(5, "Fake. Fake. Fake.", "")
                "Don't leave me. <i>Please</i> don't leave me!" she sobs, and something warm slams into your back. "Promise you won't leave!"
                
                You look down to see small hands gripping your waist. Not barely visible, ghostly hands, but real ones. Pigmented skin, warm and alive. You feel your resolve weakening the longer you look at her hands. Real hands. Human hands. #REMOVE: Intrusive
                
                ~ Intrusive(5, "Real...?", "")
                ~ Intrusive(5, "She's real.", "")
                ~ Intrusive(5, "Not a trick.", "")
                "I...." you croak. It's real this time. It's not a trick. 
                
                *["I won't."]
                    Your resolve breaks. "Thank goodness." she says, and squeezes you tighter. You turn to hug her back. #REMOVE: Intrusive
                        
                    **[No one is there.]
                        ->Office_Area.Sit_Pews
                
                *["I have to."]
                    You steel yourself. #REMOVE: Intrusive
                    
                    "No." You say and fall forward. #EFFECT: remove-glow
                    
                    ~ PlaySFX("groaning_angry", false, 0, 0) 
                    There's a short shriek of anger, before you hit the cold pavement of the sidewalk. Then it's quiet. You look back, and the church is gone, if it was ever even there. #IMAGE: Default #PROP: [Open_Door false]
    
                    **[You stand and dust yourself off]
                    ->Office_Area.End_Game
                
        }
        
    - Church_Encounters ? (Was_Coward):
        ~ Intrusive(5, "Coward", "")
        "Coward." You stop. It's the woman who helped you{Ophelia_Related:, Ophelia." |.} "You're just going to leave?"
            
            *[Yes]
                ~ PlaySFX("groaning_angry", false, 0, 0)
                There's a short shriek of anger, before you hit the cold pavement of the sidewalk. Then it's quiet. You look back, and the church is gone, if it was ever even there. #IMAGE: Default #PROP: [Open_Door false] #EFFECT: remove-glow #REMOVE: Intrusive
            
                ***[You stand and dust yourself off]
                    ->Office_Area.End_Game
            
            *[No]
                ~Stay_Tracker += 1
                "I..." You don't know how to answer. You look down at your hands, they're intact. You still have all ten. You ball them into fists. "I..." #REMOVE: Intrusive
    
                ~ Intrusive(5, "She's right", "")
                ~ Intrusive(5, "Not your fault", "")
                "You don't deserve to leave."
                    
                **[She's right]
                    ->Office_Area.Sit_Pews
                    
                **[She's wrong]
                    "I do. You all did." You say and fall forward. #REMOVE: Intrusive #EFFECT: remove-glow
    
                    ~ PlaySFX("groaning_angry", false, 0, 0)
                    There's a short shriek of anger, before you hit the cold pavement of the sidewalk. Then it's quiet. You look back, and the church is gone, if it was ever even there. #IMAGE: Default #PROP: [Open_Door false]
                
                    ***[You stand and dust yourself off]
                        ->Office_Area.End_Game
                        
    - Book_Knowledge ? (Branded):
        ~ Intrusive(6, "You found peace", "")
        The carvings in your skin pulsate the closer you get to the door. You fall to the floor, and begin to crawl. Your body is heavy. Each movement harder than the last. The way out is within your reach. It's just a bit further. The light grows brighter. Your limbs shake.
        
        ~ Intrusive(6, "You found peace", "")
        You grind your teeth and dig your nails into the wood. You can feel the church tracing the writing in your skin. Whispering the words into your ears. You push yourself to your feet, standing before the open door, trying to find to the strength to take the last step.
        
        *[You found peace]
            #REMOVE: Intrusive
            The pain passes, and the brand feels like a comforting hug. The church's words become your own thoughts. <> 
            ->Office_Area.Sit_Pews
            
        *[This isn't peace]
            ~ PlaySFX("groaning_angry", false, 0, 0) 
            How could it be? You throw yourself out the door and onto the sidewalk. There's a short shriek of anger, before you hit the cold pavement of the sidewalk. Then it's quiet. You look back, and the church is gone, if it was ever even there. #IMAGE: Default #PROP: [Open_Door false] #REMOVE: Intrusive #EFFECT: remove-glow
                
            ***[You stand and dust yourself off]
                ->Office_Area.End_Game
            
        
    - else:
        The red light intensifies, a comforting pressure. You fall to the floor, and begin to crawl. Your body is heavy. Each movement harder than the last. The way out is within your reach. It's just a bit further. The light grows brighter. Your limbs shake.
        
        {
            - Church_Encounters ? (Leave_Light):
                You don't want to leave it, but you know you have to. You want to. You want...
            
                What do you want?
            
                You stop, and sit back. You stare up at the church window, and it looks back at you.
                
            {
                - Stay_Tracker >= 2.5:
                    What are you fighting so hard for? #REMOVE: Intrusive
                    
                    {finger_pain_pass: You look down at the hand that's missing a finger. | You think about all you've been through. }
                    
                    *[You've already given up so much.]
                        ->Office_Area.Sit_Pews
                        
                - else:
                    You didn't leave this light until the church decided you could last time, but this time... Your finger tips escape the light, reaching out through the church door. 
                    
                    ~ PlaySFX("groaning_angry", false, 0, 0) 
                    That taste of freedom is all you need. With one last push, you throw yourself out out the door. There's a short shriek of anger, before you hit the cold pavement of the sidewalk. Then it's quiet. You look back, and the church is gone, if it was ever even there. #IMAGE: Default #PROP: [Open_Door false] #EFFECT: remove-glow #REMOVE: Intrusive
        
                    *[You stand and dust yourself off]
                        ->Office_Area.End_Game
            }
            - else:
                You've escaped this light before, and you'll do it again. Your finger tips escape the light, reaching out through the church door. #REMOVE: Intrusive
                
                ~ PlaySFX("groaning_angry", false, 0, 0) 
                That taste of freedom is all you need. With one last push, you throw yourself out out the door. There's a short shriek of anger, before you hit the cold pavement of the sidewalk. Then it's quiet. You look back, and the church is gone, if it was ever even there. #IMAGE: Default #PROP: [Open_Door false] #EFFECT: remove-glow
        
                *[You stand and dust yourself off]
                    ->Office_Area.End_Game
        }
}

= Sit_Pews
~ PlaySFX("organ", false, 5, 0)
The front door closes, and you drift deeper into the church. Organ music begins to play. #PROP: [Open_Door false], [Closed_Door true] #EFFECT: remove-glow #REMOVE: Intrusive

~ StopAll()
~ PlayBGM("inside", true, 5, 0)
You end up in the pews, just like your book said you would. You sit down, and close your eyes, taking in the church music. When you open them, the pews are filled with people, all turned towards you. It's people you've read about, smiling at you. Welcoming you. #IMAGE: Church_Inside #PROP: [Closed_Door false] 

They begin to sing, hands out stretched for you to take. The music flows through you, and you feel a smile come to your face.

*[Take their hands.]
    #ENDING: 7, Bad? Ending - Finding Peace
    ->Endings.Bad_End_7

= End_Game
~ Stay_Tracker = 4.5
That taste of freedom is all you need. With one last push, you throw yourself out out the door. There's a short shriek of anger, before you hit the cold pavement of the sidewalk. Then it's quiet. You look back, and the church is gone, if it was ever even there.

{Stay_Tracker >= 4.5: -> Open_the_Door.Leave(true)}

*[It has been a long night]
    #ENDING: 9, Good Ending - It Has Been a Long, Long Night
    ->Endings.Good_End_9


////////// DOWNSTAIRS INTERACTIONS ////////// 

= Exit_Office_Continue
~ previous_area = Enter_Office
~ current_area = Main_Body 
~ Have_Visited += (Enter_Office)
~ visited_state += 1
~ PlayBGM("inside", true, 30, 0)
~ StopSFX("watched", 5, 0)

{
    - visited_state == 1:
        ->After_First.Side_Room_After
    - visited_state == 2:
        -> After_Second.Stairs_Second
    - else:
        -> Last_Stop.Stairs_Last
}

=== Open_Chest(-> return_to) ===
~temp Temp = false
*{items_obtained ? (Simple_Key)} [Try the simple key]
    ~ broke_key = true
    ~PlaySFX("lock_click_break_1", false, 0, 0)
    ~PlaySFX("key_snap_small", false, 0, 2.25)
    You fish the simple key out of your pocket and try the lock. The key slides in easy enough, but it doesn't want to turn. You jiggle the key, thinking it just needed a little force, and- <i>Clank!</i> 
    
    The key snaps in the lock. The teeth of the key are stuck and warped in the lock. You press the key against the lock, attempting to turn it again and again, thinking maybe if you press hard enough it would suddenly pop open. "God DAMMIT!"
    
    ~PlaySFX("chest_breaking", false, 0, 0)
    You fling the head of the key away from you and hurl the chest to the floor in frustration. The chest crashes to the floor, causing the lid to open with a "pop!" A book with the number 2758 spills on it's cover onto the floor.
    ~temp_string = "if the loss of the key was worth it"

*{items_obtained ? (Skeleton_Key)} [Try the skeleton key]
    ~ Temp = true
    ~PlaySFX("lock_click_open_1", false, 0, 0)
    ~ unlocked_chest = true
    You fish the skeleton key out of your pocket and try the lock. The key slides in, and <i>Click!</i>

    The lid pops open and inside sits a book with the number 2758 on it's cover.
        ~temp_string = "if the loss of the key was worth it"

*[Break the chest]
    ~ Explore_Office_Bookshelf += (Check_Chest, Broke_Chest)
    ~PlaySFX("chest_breaking", false, 0, 0)
    You raise the chest above your head, and hurl it to the floor. The lid pops open, and a book with the number 2758 on it's cover spills onto the floor.
    ~temp_string = "if this is indeed your book"

- You {Temp: take the book from the chest, placing the now empty chest back on the shelf | pick the book up from the ground}<>

->return_to

//if we are here, player HAS to know about their book

=== Take_Or_Return(IsTake) ===
{Book_Knowledge ? (Branded): {IsTake: You tuck the book under your arm. Leaving it behind feels wrong somehow. | You struggle to your feet and shuffle to the bookshelf. You gently place your book on the shelf and slide it back until it hits the wall. You want nothing to do with it anymore.} You... You should do something. Return to your search. Find the heart. Destroy it. Escape. | {IsTake: You tuck the book under your arm. {Book_Knowledge ? (Read_End): You may already know how this could end, or at least, how the <i>church</i> thinks it will end, but something tells you to keep your book with you. {Stay_Tracker >= 2: Just in case something changes.} | You don't want to know how this story ends, but in case you change your mind, you'll have that choice.} | {Book_Knowledge ? (Read_End): You place the book back on the shelf. You know how it ends- Or rather, how the church thinks it will end. | You don't want to know how this story ends, not when there's still something you can do. You put the book back on the shelf.} } {Stay_Tracker < 2: You shouldn't give too much weight to it. That's what the church wants. | You chew your lip{Book_Knowledge ? (Kept_Book): and tighten your grip on it}. } You should do something productive instead of dwelling on it. {Saw_Locks: You remember the woman who helped you. Maybe if you find her book, or someone else's, you can find out what the code to the number lock is. | You should look elsewhere. You look at the books surrounding you. Maybe their stories could help you?}} #PROP: [your_book false]

*{(Explore_Office_Bookshelf !? (Check_Boxes))} [Pick through the boxes]
    ~ Explore_Office_Bookshelf += (Check_Boxes)
    You pick through the boxes first, only to find them filled with more books. <>

*{(Explore_Office_Bookshelf !? (Check_Chest, Broke_Chest))} [Investigate the chest]
    ~ Explore_Office_Bookshelf += (Check_Chest)
    You grab the chest, and nearly drop it. The sides are slick with a wet, velvety mold. You wipe your hands on your pants and clench and unclench them, trying to forget the feeling. 
    
    "Gross gross gross gross gross," You say and gingerly pick it up, avoiding as many mold spots as you can. You attempt to open it, only to find it locked. You give it a shake, and hear something thumping around inside.
    
    "Probably just another book..." you mutter. You look through the key hole, but can't see anything.
    -> Open_Chest(->Office_Area.Your_Book)
    

*{Explore_Office_Bookshelf !? Check_Books} [Flip through the books]
    ~ Explore_Office_Bookshelf += (Check_Books)
    You skim the covers of a few books from the closest shelf. <>

*{Explore_Office_Bookshelf !? (Check_Desk)}[Dig through the desk]
    ->Office_Area.Desk
    
*[Move on with your search]
    -> Office_Area.Exit_Office_Continue
    
- {!read_mary_book: They all resemble {Book_Knowledge ? (Saw_Your_Book): your book. | the other books in the room.} The main difference being the bold number on the cover or spine, and some looking a little older.} From what you can tell, none of the numbers repeat. 

*[{Saw_Locks or Have_Visited ? (Confessional_DoorSide): Look for her book | Read through the books}]

*{Explore_Office_Bookshelf !? (Check_Desk)}[Dig through the desk]
    ->Office_Area.Desk
    
*[Move on with your search]
    -> Office_Area.Exit_Office_Continue

- {Saw_Locks: With the minimal knowledge you have, you skim through as many books as you can. You search and search, {Confessional_Encounters ? (Talked_to_Girl): looking for any and every book that matches the story the little girl told you. A sick child that thinks her parents resent her, a mother that had a sick child, or a father that was a priest. | but you don't know enough about her to even know if you've passed her book or not.} | You pick up a book at random, skimming though them for any relevant or interesting information. {Confessional_Encounters ? (Talked_to_Girl): You try to focus on books that matches the story the little girl told you. A sick child that thinks her parents resent her, a mother that had a sick child, or a father that was a priest. | You read book after book after book, but you don't know what you're looking for.}}

{Saw_Locks: You read book after book, story after story about the victims of the church. | Each story you read all are about victims of the church.} All the stories only describe parts where the victim is in or near the church, so most have gaps{Book_Knowledge ? (Read_Start):, much like your own book}. Many stories mimic your own, but some never knew they were ever in danger. Some attempted to escape, but all of them had the same ending.

{Book_Knowledge ? (Read_End): And much like your own ending, they all find peace. | They never leave.} After reading another dead-end book, you pinch the bridge of your nose and sigh. You're surrounded by a pile of useless books and your eyes are strained from reading in low light.

* [Come back later]
    You have has enough reading, and decide you need to move on. You're sure something in here has the information you want, but blindly reading isn't helping. You'll come back when you know more.
    
    ->Office_Area.Office_Choices
    
* {Confessional_Encounters ? (Finished_Curtain_Side) or Confessional_Encounters ? (Finished_Door_Side) or Book_Knowledge !? (Read_Mom_Old_Book)} [Keep reading]
    You sigh deeply and grab another book. <>
    
- {Confessional_Encounters !? (Finished_Curtain_Side, Finished_Door_Side) and Book_Knowledge !? (Read_Mom_Old_Book): -> Mom_Old_Book | You grab...}

*{Confessional_Encounters ? (Finished_Curtain_Side)} [The wider one] //oldin
    -> Olin_Book

*[The smaller one] //mom
    You choose the smaller book. It's missing some pages, and it looks like they were ripped out. The last few pages are stained with brown-ish spots. <>
    {
        - Confessional_Encounters ? (Finished_Door_Side):
            You flip to the beginning of the book and begin reading.
            -> Mom_Young_Book
        - else:
            You flip to the end, hoping to find some useful information.
            -> Mom_Old_Book
    }
    

= Olin_Book
//CAN ONLY BE READ IF YOU'VE MET DAD
~ Book_Knowledge += (Read_Oldin_Book)
The book you chose is massive. It's thicker than most other books you've read so far, and most of it's pages are full of text instead of blank. This book is from the point of view of a pastor named Olin. He was out of work for a long while, before finding the church. One of his children was sick, so he jumped at the chance for work. Anything to get more money into the family. 

However, as soon as he stepped inside, he refused to leave. The church looked at him and he thought he was receiving revelations from God. Olin accepted it readily. Greedily. Instead of finding peace like many others he— #DELAY: 0.5

"No way..." You mutter, re-reading the next few passages again and again. "He... He became part of the church?"

The reason why his book is so thick, it contains bits and pieces from other's experiences. He was kind to some, cruel to others. The more people resist him, and by extension, the church, the worse he treats them. And right near the end, you read about your own interactions with him.

*[Keep reading]

*[Close the book]
    You snap the book closed and drop it to the floor. You don't want to waste your time. 
    
    **{Explore_Office_Bookshelf !? (Check_Desk)}[Dig through the desk]
        ->Office_Area.Desk

    **{Explore_Office_Bookshelf !? (Check_Books)}[Browse the bookshelves]
        ->Office_Area.Books
        
    **{Confessional_Encounters ? (Finished_Door_Side) or Book_Knowledge !? (Read_Mom_Old_Book)}[Read a different book] //mom
        You grab a smaller book from the pile. It's missing some pages, and it looks like they were ripped out. The last few pages are stained with brown-ish spots. <>
        {
            - Confessional_Encounters ? (Finished_Door_Side):
                You flip to the beginning of the book and begin reading.
                -> Mom_Young_Book
            - else:
                You flip to the end, hoping to find some useful information.
                -> Mom_Old_Book
        }
        
    **[Move on with your search]
        -> Office_Area.Exit_Office_Continue

- You continue to flip through, reading about his run ins with various victims of the church. Through your reading, you catch glimpses of his internal thoughts. {read_mary_book: When he meets Mary,he is reminded of his wife.} Anytime he thinks of his wife, his kids, he wonders if he'll find them here one day. The way Olin speaks, it doesn't sound like he misses them, so much as he is @ that they can't experience the church for themselves. #CYCLE: angry, disappointed, frustrated, sorry

At some point, he finally gets his wish granted. He meets his daughter, all grown up. It was not the happy reunion Olin thought it could be. She cursed and screamed at him, demanding to return what he took from her. { Book_Knowledge ? (Read_Mom_Young_Book): ████. | Her child.} Your heart sinks. 

{Book_Knowledge ? (Read_Mom_Young_Book): You know the rest of this story from reading Ophelia's book. He refuses. She begs. | Olin refuses, and his daughter begs. She pleads. She would do anything.} And then he offers her a trade. If she stays with him, he'll let her child go. And she agrees.

Anger swells inside you and you snap the book closed. You think you hate Olin. You hate him for not choosing his daughter. You hate him for all the people that couldn't escape because of him. You hate him choosing the church.

*[Throw the book]
    You reel back and chuck the book as hard as you can. You aimed for...

*[Close the book]
    You snap the book closed and drop it to the floor. You don't want to waste your time. 
    
    **{Explore_Office_Bookshelf !? (Check_Desk)}[Dig through the desk]
        ->Office_Area.Desk

    **{Explore_Office_Bookshelf !? (Check_Books)}[Browse the bookshelves]
        ->Office_Area.Books
        
    **{Confessional_Encounters ? (Finished_Door_Side) or Book_Knowledge !? (Read_Mom_Old_Book)}[Read a different book] //mom
        You grab a smaller book from the pile. It's missing some pages, and it looks like they were ripped out. The last few pages are stained with brown-ish spots. <>
        {
            - Confessional_Encounters ? (Finished_Door_Side):
                You flip to the beginning of the book and begin reading.
                -> Mom_Young_Book
            - else:
                You flip to the end, hoping to find some useful information.
                -> Mom_Old_Book
        }
        
    **[Move on with your search]
        -> Office_Area.Exit_Office_Continue

- 

*[The window]
    The book sails through the air and crashes through the window.

*[The adjacent bookshelf]
    ~ PlaySFX("door_thud", false, 0, 0)
    It bounces off the shelf with a thud, landing flatly on the ground. The bookshelf shuttered at the impact but nothing more. You stare at the book, thinking it deserves worse.
    
        **[Stomp it]
            ~ PlaySFX("growling", false, 0, 0)
            You jump to your feet and walk over, and kick the book into the desk. It falls to the ground open to a random page. You raise your foot and smash your heel into spine. You grind your heel into it, tearing some of the pages. You grab the book off the ground and chuck it at the window. It crashes through.
        
        **[Leave it]
            You shake your head. You shouldn't waste your time, its not like it would change anything anyway.
            
            ***{Explore_Office_Bookshelf !? (Check_Desk)}[Dig through the desk]
                ->Office_Area.Desk
        
            ***{Explore_Office_Bookshelf !? (Check_Books)}[Browse the bookshelves]
                ->Office_Area.Books
                
            ***{Confessional_Encounters ? (Finished_Door_Side) or Book_Knowledge !? (Read_Mom_Old_Book)}[Read a different book] //mom
                You grab a smaller book from the pile. It's missing some pages, and it looks like they were ripped out. The last few pages are stained with brown-ish spots. <>
                {
                    - Confessional_Encounters ? (Finished_Door_Side):
                        You flip to the beginning of the book and begin reading.
                        -> Mom_Young_Book
                    - else:
                        You flip to the end, hoping to find some useful information.
                        -> Mom_Old_Book
                }
                
            ***[Move on with your search]
                -> Office_Area.Exit_Office_Continue

-
~ PlaySFX("screeching", false, 0, 0)
~ PlayBGM("watched", true, 5, 0)
~ StopSFX("inside", 5, 0)
The church screams and shakes in response. You plug your ears to block out the sound. The window cracks and breaks until it's only a deep black hole. Long spindly arms erupt from the window. #PROP: [Arms true] #EFFECT: Shake_Office #EFFECT: Force_Open

"How DARE you?!" the voice of the pastor bellows. "Who are YOU to- After all I've DONE for you?!"

The remaining books on the shelves fall off, and the far book shelf falls over. The room around you is starting to crumble. You stumble back, eyes fixed on the thing in the window. It pulls itself out, its bulbous body flopping to the ground. Its back limbs slide out the window behind it, folding forward before rotating backwards. It pushes itself up and onto its... feet? Each limb ends with a hand.

*[Run]

*[Run]

*[Run]

- You turn on a heel and dart out of the room as fast as you can. The thing moans and groans, tripping over books and boxes littering the floor. You sneak a glance behind you and the creature falls into the fall. It tetters back to its feet, tilting sideways before a limb shoots out to grab you, landing centimeters away from you.

~PlaySFX("climax_long", false, 0, 0)
It screams again, causing the room to shake and throw you off balence. The ceiling cracks, and pieces begin to fall. A large chunk falls to your right side, just barely missing you.

"I will END you for your INSOLENCE!" it screams, and aims another limb at you.

*[Dodge left]

*[Dodge right]
    ~temp Temp_bool = false
    You throw yourself to the right, and directly into the chunk of celing. It grabs you with multiple hands, two holding your shoulders and two holding your legs. You kick and squirm, biting at the ones on your shoulder. The creature doesn't react as it lifts you above its body. 
    
    "Got you~" it growls, and you see a mouth in the center of its back. {Church_Encounters ? (Finger_Chopped): {finger_pain_pass: "This pain too shall pass." | "Perhaps this time, you will accept the pain."} | "It only hurts a pinch. It will pass, if you let it."}
    
    **[Apologize]
    
    **[Beg]
        ~Temp_bool = true
    --
    "{Temp_bool: Please, let me go! I'll- I'll do anything! | I'm sorry! I- I won't-}" It tightens it's grip. Your mind races, thinkning of what to say. 
    
    ***["I'll stay!"]
        The creature stops, and loosen its grip. "Do you swear it?"
            
            **** {Stay_Tracker >= 2} [Yes] //truth
                ~ Stay_Tracker += 2
                You betray yourself by nodding. 
                
                The creature smiles and laughs. "I have faith in you, ████." It lightly sets you down, and pushes you out of the room. "Go on then, prove it."

                -> Office_Area.Unsure(true)
                
            **** {Stay_Tracker < 2} [Yes] //lie
                ~ Stay_Tracker -= 0.5
                You nod enthusiastically. {Book_Knowledge ? (Kept_Book): With it's grip loosened, you reach down and pull your book out and wave it around. {Book_Knowledge ? (Read_End): "I read the ending, I- I know how it ends." {Book_Knowledge ? (Branded): Your brand pulsates, and you tighten your grip on the book. } | "Would I have kept this otherwise?"} | {Book_Knowledge ? (Read_End): "I read the ending, I- I know how it ends." {Book_Knowledge ? (Branded): Your brand pulsates and you grind your teeth.} | {Confessional_Encounters ? (Accepted_Priest): "I already confessed, remember? You told me yourself that I should..." You dig your nails into your palms.| {Church_Encounters ? (Finger_Chopped): You hold up your bandaged hand, grinding your teeth at the memory. {finger_pain_pass: "It didn't even hurt!" | "I was cleansed already!"} | {Church_Encounters ? (Was_Coward): The creature doesn't have eyes, so you hold down a finger and wave your hand around. "Look! I've already been cleansed." | "I've realized I was wrong about the church. About all of it.!}}}}} You hold your breath, hoping it doesn't realize you're bluffing. 
                
                "Hmm..." it growls. {Book_Knowledge ? (Kept_Book) or Book_Knowledge ? (Read_End) or Church_Encounters ? (Finger_Chopped) or Confessional_Encounters ? (Accepted_Priest): {Book_Knowledge ? (Kept_Book) : It feels around for the book in your hand and traces the numbers on the cover. {Book_Knowledge ? (Read_End): "You even read to the end? {Book_Knowledge ? (Branded): Although, it seems you are still... adjusting." Its hand traces the scars set in your skin. }}  | {Book_Knowledge ? (Read_End): "You even read to the end? {Book_Knowledge ? (Branded): "Although, it seems you are still... adjusting." Its hand traces the scars set in your skin.} | {Church_Encounters ? (Finger_Chopped): A free hand grabs yours and squeezes, feeling for the bandage. You yelp as it pushes against the raw wound.}}} "I am choosing to have faith in you for now, ████." It lightly sets you down, and pushes you out of the room. "Go on then, prove it." -> Oldin_Live(true) | {Church_Encounters ? (Was_Coward): A free hand grabs yours and harshly pushes down on each finger, searching for the missing one. Your knuckles crack and you yelps as it shoves down the last finger until it breaks. You scream in pain. } "I didn't expect her to raise a liar." -> Oldin_Death}
                
            **** {Stay_Tracker < 2} [No] //truth
                "No." The words tumble out before you can think. You can't bring yourself to even lie. 
                
                ~PlaySFX("groaning_angry", false, 0, 0)
                "Disgusting." The creature growls. "I expected better from you, ████."
                
                -> Oldin_Death
            
            **** {Stay_Tracker >= 2} [No] //lie
                ~ Stay_Tracker += 1
                You shake your head, the words refusing to form in your mouth. You <s>should</s> can't stay here. You <s>want to</s> won't stay here.
                
                 "Hmm..." it growls. {Book_Knowledge ? (Kept_Book) or Book_Knowledge ? (Read_End) or Church_Encounters ? (Finger_Chopped) or Confessional_Encounters ? (Accepted_Priest): {Book_Knowledge ? (Kept_Book): The creature thinks for a moment before shaking you. Your book falls to the floor. It picks it up and traces the cover before shoving it back into your hands. | {Church_Encounters ? (Finger_Chopped): It grabs your hand and harshly presses down on your finger stump. {finger_pain_pass: You inhale sharply, but accept the pain like before, and it quickly passes. The creature smiles. | You yelp and pull your hand away. }}} "{Confessional_Encounters ? (Accepted_Priest):I remember your confession. The pain in your voice. With that in mind, }I'm not sure I believe you, ████.{Book_Knowledge ? (Read_End): You even read to the end!} {Book_Knowledge ? (Branded) or finger_pain_pass == false: Although, it seems you are still... adjusting." {Book_Knowledge ? (Branded): Its hand traces the scars set in your skin. } |"} It lightly sets you down, and pushes you out of the room. "Go on then, prove it." -> Oldin_Live(false)  | "It is your loss... ████." -> Oldin_Death}
    
    ***["I have something new to confess!"]
        "I don't believe you." It mutters. -> Oldin_Death

- You regain your balance and push yourself harder{Leg_State >= Limping:, but your leg is refusing to cooperate with you. Each time you foot hits the floor a searing pain shoots up your shin. |.} The door is so close. <i>You're</i> so close. Another cracking from the ceiling. You jerk your head up and see a large chuck barely being held up. If it falls before you get to the door, you'll be trapped inside.

*[Dive for it]
    You plant your leading foot and all but throw yourself at the door. You soar through the doorway and land on the stairs, hard, probably bruising something or worse. <>

*[Keep running]
    {
        -Leg_State >= Limping:
            You try to push your body past it's limit, but your hurt leg gives out on you. You fall, just inches from the doorway, and the large chunk of ceiling lands on you.

            "AAGHGAHGAH!" you let of a cry, wiggling around trying to get away. You feel like a bug that a child skewered with a stick. You know it's hopeless, and yet you still writhe on the ground.
            
            Hoping. Praying.
    
            *[But it's no use.]
                #ENDING: 2, Bad Ending - Crushed
                -> Endings.Bad_End_2
    }
    
    You push you body past its limits, and run faster than you ever have before. Blood drums in your ears as you throw yourself through the doorway and run straight into the hallway wall. You collapse to the ground, heart ready to explode. <>

- 
~ Room_State = Destroyed
You watch as the room collapses in on itself, leaving only a caved in door way behind. The creature screams as it's squished. {Book_Knowledge !? (Saw_Your_Book): Something glints in the rubble left behind.} #EFFECT: Force_Blink

You take a deep breath and stare at 
    
*{Book_Knowledge !? (Kept_Book, Saw_Your_Book)}[Examine the glinting in the rubble]
    ~Book_Knowledge += (Saw_Your_Book)
    You shine your flashlight over the pile to see a book. 2758. You pick it up and flip it open and immediately close it. It's <i>your</i> book.
    
    **[Read it now]
        ->Office_Area.Read_After_Rubble
    
    **[Take it with you]
        ~Book_Knowledge += (Kept_Book)

- You pat your pocket that holds the page{Book_Knowledge ? (Kept_Book): , and tighten your grip on your book.|.} At least you can remove one more lock with this.
        
        **[Move on with your search]
            -> Office_Area.Exit_Office_Continue

= Oldin_Death
~StopAll()
~ PlaySFX("heartbeat", true, 5, 0) 
~ PlaySFX("tinitus", true, 5, 0) 
~ PlaySFX("oldin_death_1", false, 0, 0) 
Before the words can register, it quickly and efficiently twists your limbs and yanks them from your body. Your limbless body falls to the floor with a dull thud, knocking the wind out of you.

Your gasp on the ground, blood from your limbs dripping onto you. The creature lowers them into its mouth. A small squeak escapes from you as you try to get up. You can see your limbs. You know they're not attached. But you try anyway.

~ PlaySFX("oldin_death_2", false, 0, 0) 
"You didn't let it pass." The creature growls, and pushes off the ground with its far legs to flip itself, so it's mouth hovers over you. "Pathetic, little bug." It spits and lowers itself down, mouth gaping.

****[You feel every crunch as its teeth grind your bones]
    ->Endings.Bad_End_13

= Oldin_Live(Said_Yes)
~ Room_State = Destroyed
~PlaySFX("door_thud", false, 0, 0)
The door shuts behind you and melts into the wall. {Said_Yes: You lied, but it still let you go. You don't think you were particularly skilled liar, but... | You said no, but it still let you go. } Your legs tremble and you chew the inside of your cheek.

~PlaySFX("knocking", false, 0, 0)
You run your hand along where the door was and knock. It's solid. {Book_Knowledge !? (Saw_Your_Book): You turn to leave, but a hand grabs you. Something is pessed into your hand. "Don't forget this."}

{
- Book_Knowledge !? (Saw_Your_Book):
    ~Book_Knowledge += (Saw_Your_Book)
    You turn on your flashlight and see it's a book. 2758. You flip it open and immediately close it. It's <i>your</i> book.
    
    **[Read it now]
        ->Office_Area.Read_After_Rubble
    
    **[Take it with you]
        ~Book_Knowledge += (Kept_Book)
        You can read it later. For now, you need to return to your search.
        -> Office_Area.Exit_Office_Continue
        
- else:
    *[Move on with your search]
        -> Office_Area.Exit_Office_Continue
}

= Mom_Young_Book
//CAN ONLY BE READ IF YOU'VE MET MOM
~ Book_Knowledge += (Read_Mom_Young_Book)
You don't get very far before you realize this book is from the perspective of a child. You take a deep breath before continuing. Her name is Ophelia, and she <s>is</s> was turning 10. The passages were very short and all over the place. 

Her experience with the church was scattered between walking by on her way to school. She was a sick child, and her family often prayed for her health. One day, her dad, a pastor, got a new job at the church.

#CYCLE: victim, meal
You stop reading and press your forehead against the pages as you realize who's book you're reading. So it wasn't just the church, but an echo of the past? Or maybe the church wearing the skin of a past @. Either way, {Confessional_Encounters ? (Killed_Girl): the {Priest_Feeling} sticks with you. | you feel sick.}

You continue reading about how she snuck in to find her dad before getting trapped inside. It doesn't explain how she was able to escape, she describes it as "falling down after spinning until you're about to puke". You flip forward to the next passage.

~ StopSFX("watched", 20, 0)
As you read, an ache grows in your heart and your throat tightens. The book becomes heavy in your hands. The passage picks up with Ophelia as an adult, confronting the church. She pounds on the door pleading and crying to "Let ████ out! Take me instead! Give me back my child!" 

*[Rub your eyes]

*[Re-read the passage]

*[Look closer]

- A stabbing pang shoots through your head as you attempt to re-read the name. You rub your temple and finish the page. Ophelia begs until she hears her father's voice, asking if she's finally ready to come home. 

She accepts, but only on the condition he lets ████ out. He agrees and the door opens. She meets her child one last time, pushing them out before the door can close. 

You wipe tears from your eyes, not fully understanding why. You don't know this woman, do you? 

*[You do]
    ~ Ophelia_Related = true
    Yes, you do. She must be the person behind the voice, you are absolutely sure. But something in your bones tells you it's more than that. That Ophelia is- was? - someone important to you. {Book_Knowledge !? (Read_Mom_Old_Book): Either way, you want to finish her book.} <>

*[You don't]
    No, no you don't think so. {Book_Knowledge !? (Read_Mom_Old_Book): Still, you think you owe it to her to continue reading.} <>

- 

{Book_Knowledge ? (Read_Mom_Old_Book): You close the book and trace the number on the cover. | You take deep breaths, and finish her book. Once trapped inside, Ophelia rejected her father and attempted to escape. }
{
    - Book_Knowledge !? (Read_Mom_Old_Book):
        ->Mom_Old_Book
        
    - else:
        *{Explore_Office_Bookshelf !? (Check_Desk)} [Dig through the desk]
            -> Office_Area.Desk
            
        *{Book_Knowledge !? (Saw_Your_Book)} [Look for your book]
            -> Office_Area.Your_Book
        
        *[Move on with your search]
            -> Office_Area.Exit_Office_Continue
}

= Mom_Old_Book
//CAN ALWAYS BE READ
~ Book_Knowledge += (Read_Mom_Old_Book)
~ items_obtained += (Combo)
~ StopSFX("watched", 20, 0)
{Book_Knowledge ? (Read_Mom_Young_Book): | The name on the inside cover is Ophelia, and you gather that it's from the perspective of a mother.} All her thoughts revolved around escaping so she can see her child again. Her actions in the church are spiteful, doing everything she could to hurt it. 

She pulls herself out of the church's sight, and avoids falling into traps it sets for her. She breaks what she can and ignores everything until she finds the stairs to the attic. She climbs the stairs {Have_Visited ? (Stairs_Up): and her experience sounds very similar to your own, a never ending spiral staircase. | and they sound never ending. } But not once did she think of giving up.

She reaches the top and finds a set of locks on a door that has a pulsating red light under it. She fiddles with the locks before pulling out a book, her book from the sound of it, and flipping through it, and entering a code. Your eyes slide down the page a little more and...

~ PlayBGM("inside", true, 20, 0)
{Saw_Locks: "2755, got it!" you exclaim. "Thank you {Book_Knowledge ? (Read_Mom_Young_Book):,Ophelia|}!" | "2755?" {Book_Knowledge ? (Read_Mom_Young_Book): You commit the code to memory, knowing they'll be helpful later. | The numbers don't mean much to you, but you commit them to memory anyway.}} {Have_Visited ? (Stairs_Up): Your next step should be to explore what's up the spiral staircase.}

*[Rip out the page]
    ->Office_Area.Rip_out_Ophelia

*{Explore_Office_Bookshelf !? (Check_Desk)} [Dig through the desk]
    ->Office_Area.Desk
    
*{Book_Knowledge !? (Saw_Your_Book)} [Look for your book]
    -> Office_Area.Your_Book
    
*[Finish Ophelia's book]
    ~ Finish_ophelia = true


- You keep a finger to keep track of the page with the code and finish the book. The number lock pops open, but the key she found doesn't fit and she flings the key over the edge. 

She holds the book and debates throwing it as well, before collapsing and she reads the book again. She re-reads the same passage a few times before fury over takes her and she rips out page after page after page. 

{Book_Knowledge ? (Branded): You wince, knowing what comes next. You read a few passages before slamming the book shut. | Bile rises in your throat as you read the next few passages before you slam the book shut.} You don't need to read what the church did to her.

*[Rip out the code page]
    ->Office_Area.Rip_out_Ophelia

*{Explore_Office_Bookshelf !? (Check_Desk)} [Dig through the desk]
    ->Office_Area.Desk
            
*{Book_Knowledge !? (Saw_Your_Book)} [Look for your book]
    -> Office_Area.Your_Book
  




