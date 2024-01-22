=== Stairs ===
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

= Office
{
    - object != "":
        ~temp_string = "It's the office door from earlier, but it seems shorter than you remember."
    - else:
        ~temp_string = ""
}

{
    - temp_visited:
        ~temp_visited = false
        { - room:

            - 2: You see a door, and duck through the doorway. {temp_string}
            - 3: You see a small door, and crawl through it.
            - else: 
                {object != "": There is no doorway. Where is the door way? You don't have time to think about it. }You run deeper into the hall, and to the stairs. You run half-way down the stairs and wait.
        }
    - else:
        { - room:

            - 2: You duck through the doorway.
            - 3: You crawl through the doorway.
        }
}

{
    - saw_locks:
        ~temp_bool = true
        *[Look for something to break the chain]
        ->Stairs.Desk
        
        *[Look for the combination lock code]
        ->Stairs.Books
    - else:
        ~temp_bool = false
        *[Look through the books]
        ->Stairs.Books

        *[Look through the desk]
        ->Stairs.Desk
}

*[Return to stairwell]
~temp_bool_3 = true
-> Stairs.Exit_Office

= Desk
~saw_desk = true
{
    - temp_bool:
        {
            - object != "" :
                ~temp_string = "You sliently curse yourself. The {object} would have made quick work of all the locks. You kick the desk in frustration."
            - else:
                ~temp_string = ""
        }
        
        You look through the desk drawers for something that could break the chain. They're empty. {temp_string}
        
        
    - else:
        {
            - object != "" :
                ~temp_string = "You sliently curse yourself. The {object} would have made quick work of all the locks. You kick the desk in frustration."
            - else:
                ~temp_string = ""
        }
        
        You go to the desk and look through the drawers of the desk. They're empty. {temp_string}
}


{
    - saw_locks && !saw_books:
        ~temp_bool = true
        *[Look for the combination lock code]
        ->Stairs.Books
    - !saw_locks && !saw_books:
        ~temp_bool = false
        *[Look through the books]
        ->Stairs.Books
}

*[Return to stairwell]
~room += 1
->Stairs.Exit_Office

= Books
~ saw_books = true
You approach the bookshelves. In addition to all the books, water-stained boxes and a decaying wooden chest littered the shelves. You pick through the boxes first, only to find them filled with more books. You grab the chest and try opening it, only to find it to be locked. You give it a shake, and hear something shaking around inside.
        
        "Probably another book..." you mutter. You look through the key hole, but can't see anything.

{
    - key && !key_lock:
        ~temp_bool_2 = false
        ~temp_bool = true
        *[Try the key]
        You fish the key out of yout pocket and try the lock. THe key slides in easy enough, but it doesn't want to turn.
        
        You jiggle the key, and force it to turn. <i>Clank!</i> The key snaps in the lock.
        
        "God DAMMIT!"
        
        You throw the chest to the floor in frustration. The lid pops open, and a book with the number 2758 spills onto the floor.
        ~temp_string = "if the loss of the key was worth it"
        -> Stairs.Your_Book
    - else:
        *[Break the chest]
        ~temp_bool = false
        You raise the chest above your head, and throw it to the floor. The lid pops open, and a book with the number 2758 spills onto the floor.
        ~temp_string = "if this is indeed your book"
        -> Stairs.Your_Book
}

*[Look at the books]

- You put the chest back on the shelf, and grab a random book. It has no title, but the number 2743 is on the cover in thick, gold-colored lettering.

The first page has the name "Mary" in script. A dedication, maybe? You flip to the next page and begin to read. The color almost immediately drains from your face. You jump to the end, and your stomach tightens. You throw the book to the floor, and grab another off it's shelf. 1924, Jeff. 2952, Adrian. 1853, Reed. 

All the stories are the same: They entered the church, and never left.

*[Read Mary's book]
~temp_bool_2 = true

*[Look for your book]
-> Stairs.Your_Book

- 
Tentatively, you pick up Mary's book again, and begin to read.

The start is jarrying. Mary is stuck in a storm, and stumbled upon the church while looking for a place to rest. Her version of the churchUnlike your expereince, this was her first time meeting the church. Her first thought upon seeing it was: <i>Finally, salvation.</i> 

She did not hesitate to take shelter inside. 

Once inside, Mary wanders to the pews. Then a very familiar scene begins to play out: a beautiful melody begins to play and the church warms itself. You can't be sure is the melody is the same you heard, but it brought tears to Mary's eyes. 

The last page details how the beautiful melody lulled her into a sense security. How her final breaths were peacful. How her body melted into wood after she was gone.

You close the book, and place it back on the shelf. Your insides twist and lurch as you look over all the books that litter the floor, and sit on the shelves. All these books- no. All these <i>people</i> are victims who never got out.

{
    - saw_locks:
        ~temp_string = "Look through books for the code"
    - else:
        ~temp_string = "Look through the books for clues"
}

*[Look for your book]
-> Stairs.Your_Book

*[{temp_string}]
->Stairs.Look_For_Book_Clue
 

= Your_Book
{
    - temp_bool_2:
        You pull book after book off the shelves, looking at the first page for your name, and throwing it to the floor when it's not. When you run out of books, you go through the boxes. 
        
        "Where is it? Where could it possibly be?"
        
        You grab the chest, give it a shake, and hear something inside. You try to open it, but it's locked.
        
        "Probably another book..." you mutter. You look through the key hole, but can't see anything. "It could be..."

        {
            - key && !key_lock:
                ~temp_bool_2 = false
                ~temp_bool = true
                *[Try the key]
                You fish the key out of yout pocket and try the lock. THe key slides in easy enough, but it doesn't want to turn.
                
                You jiggle the key, and force it to turn. <i>Clank!</i> The key snaps in the lock.
                
                "God DAMMIT!"
                
                You throw the chest to the floor in frustration. The lid pops open, and a book with the number 2758 spills onto the floor.
                ~temp_string = "if the loss of the key was worth it"
                -> Stairs.Your_Book
            - else:
                *[Break the chest]
                ~ broke_chest = true
                ~temp_bool = false
                You raise the chest above your head, and throw it to the floor. The lid pops open, and a book with the number 2758 spills onto the floor.
                ~temp_string = "if this is indeed your book"
                -> Stairs.Your_Book
        }
    
    - temp_bool:
        You pick up the book, and trace the numbers. You look at the first page, eage to see {temp_string}. "Oh..."
        
        You fall to the ground. It's your book.
    
    - else:
        You pick up the book, and trace the numbers. You read the first page, and fall to the ground with a croak "That's... That's not..." The book is about <i>you.</i>
}

Your read the first few pages, and it detials everything you've expereinced so far, including the childhood memories you supressed. There's blank pages between your childhood expereince and your current one. Your hands shake. Is the ending already written? If it is, will reading make a difference?

*[Flip to the end.]
~temp_bool = true
~read_book = true

*[Put it back.]
~temp_bool = false
~read_book = false
-> Stairs.Put_Back

- With shaking hands, you flip to the end of the book. You take a deep breath and read the last page. It ends with... It ends with you sitting in the pews of the church, happy. You found peace. 

You accepted the church.
    ~ stay += 1

*[You can't belive this.]

- You refuse to accept this. That must be a trick of the church- it has to be.

{
    - stay >= 2.5:
    <i>But does it?</i> Your traitorous mind whispers to you. You think back to everything that's happened. All the good. All the bad. <i>Does the bad really outweigh the good?</i> You want to say yes, but you can't bring yourself to say it. <i>If you had to choose, could you really say that leaving is better? Is that what you really want?</i>

    *[You're not sure.]
        ->Stairs.Unsure
    
    - else:
        You clutch the book tightly in your hands. You cannot accept that ending. Not after everything you've been through.
    *[Put it back.]
        -> Stairs.Put_Back
}

*[Rip out the page]

*[Take the book with you.]
->Stairs.Take_it

- 
~ stay -= 0.5
You stare at the page, and without another thought, rip it out. You feel a throbbing pain in your lower back, but ignore it. You feel a sense of relif as you stare at the blank page, your book is no longer finished.

Then, to your horror, ink stains the page, and the words reappear. <i>You found peace.</i>

*[Rip it out again.]

*[Leave it.]
->Stairs.Leave_it
- 
~ stay -= 0.5
You rip out the page again, and again, you feel a throbbing pain. This time, in your shoulder.

Again the ink reappears. 

In frustration, you rip the pages out over and over. A new part of your body gains a new pain. The ink reappears each time. You rip and rip and rip the pages until there's only one left.

Your entire body aches.

*[Rip out the last page.]

*[Leave it.]
->Stairs.Leave_it

- 
~ branded = true
You rip out the last page. You don't feel a pain this time.

"What now, huh?" you yell. "What...?"

Your skin starts to tingle, which quickly turns into a searing pain. You scream and drop your book, clawing at the pain, trying to make it stop. You stare down at your hands to see angry red lines etched in your skin. You roll up your shirt and see the same thing.

Your skin bubbles and and oozes as these line change their shape to form words. Words you have read over and over again. <i>You found peace. You found peace. You found peace. You found peace.</i>

"No, stop. Stop!" 

Your words fall on deaf ears as you can only watch the words from your book engrave themselves in your skin. You drop to the floor, and curl into the fetal position. Tears leak from your eyes, a soothing comfort as they roll over your bleeding skin. 

You wimper as the branding finishes, every part of your skin prickles. You bring your trembling hands to your face, and they are stained with your blood. Slowly, slowly, you sit up. Your clothing peels over the wooden floor. The branding already looks healed over, but the pain is still fresh.

*[You don't think you'll ever forget that pain.]

- You grab your book off the floor and dust off the cover.

*[Put the book away.]
->Stairs.Put_Back

*[Take the book with you.]
->Stairs.Take_it

= Leave_it
You take a deep breath, and close the book. The church can think what it wants, it doesn't know that this is how it will end. It's just how it <i>thinks</i> it will end.

*[Put the book away.]
->Stairs.Put_Back

*[Take the book with you.]
->Stairs.Take_it

= Take_it
~ keep_book = true
{
    - temp_bool:
        ~ temp_string = "You may already know how this could end, but you take it with you none the less."
    - else:
        ~ temp_string = "You don't want to know how this story ends, but in case you change your mind... "
}


You tuck the book under your arm. {temp_string}

{
    - saw_locks:
        You suddenly rememeber the woman who helped you. Maybe if you find her book, or someone else's, you can find out what the code to the number lock is.
        
    - else:
        You should look elsewhere. You look at the pile of books surrounding you. Maybe their stories could help you?
}

*[Look through the books]
->Stairs.Look_For_Book_Clue
{
    - saw_locks && !saw_desk:
        ~temp_bool = true
        *[Look for something to break the chain lock.]
        ->Stairs.Desk
    - !saw_locks && !saw_desk:
        ~temp_bool = false
        *[Look through the desk]
        ->Stairs.Desk
}

*[Exit the office]
->Stairs.Exit_Office

= Look_For_Book_Clue

{
    - confessional_priest:
        ~ temp_string = "You look through all the books that match the story the little girl told you, searching for a mother that had a sick child, and a father that was a priest."
    - saw_locks:
        ~ temp_string = "You search and seach, but you don't know enough about her to even know if you've passed her book or not."
    - else: 
        ~ temp_string = "You search and seach, but you don't know what you're looking for.<br>After hours of searching, you decide to stop. If the code is in one of these books, you're going about it the wrong way. You decide to look again once you know more."
}

With the minimal knowledge you have, you skim through as many books as you can. {temp_string}

{
    - read_book:
        ~ temp_string = "Much like your own ending, they never leave."
    - else:
        ~ temp_string = "They never leave."
}
{
    - confessional_priest or saw_locks:
        ~ stay += 0.5
        You read book after book, story after story about the victims of the church. Many stories mimick your own, but some never knew they were ever in danger. Some got very close to escaping, but none succeeded. All of them had the same ending. {temp_string} They all find peace.
        
        You're about to give up until you find someone promising: Ophelia.
}
{
    - confessional_priest or saw_locks:
        ~ temp_string = "Read the book."
    - else:
        {
            - !confessional_priest or !saw_locks:
            {
                - saw_locks && !saw_desk:
                    ~temp_bool = true
                    *[Look for something to break the chain lock.]
                    ->Stairs.Desk
                - !saw_locks && !saw_desk:
                    ~temp_bool = false
                    *[Look through the desk]
                    ->Stairs.Desk
            }
        }

        *[Exit the office.]
        ->Stairs.Exit_Office
}

*{confessional_priest or saw_locks}[Read the book.]


-

~name = true
~number_combo = "2755"
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

= Unsure
Confused, you leave the room, and wander numbly back into the main body of the church. You find yourself back by the front door. It creaks open, showing off the moonlit sidewalk of the outside world. 

*[You reach out a hand.]

But the church looks at you again, bathing you in the wonderfully comfortable red light. The door stay open. You feel like...

*[Laughing]
~ feeling = "laugh"

*[Crying]
~ feeling = "cry"

- You're hysterical. Your whole body is heavy and tingling. You take a heavy step toward the door. <i>Is this really what you want?</i> Freedom is only one more step away. <i>To leave?</i> Your legs are glued to your spot on the floor. <i>Are you sure?</i> You grab your leg, pulling it forward.

{
    - name:
        ~temp_string = ", Emily."
    - else:
        ~temp_string = "."
}

{
    - emily_hurt:
        "You're leaving me?" You stop. It's the little girl{temp_string} She's crying. "You're leaving me all alone? Again?"
        
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
                You throw the fabric to the ground. "Do you think this will work the second time?" You {feeling}.
                
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
        {
           - name:
                ~temp_string = ", Ophelia."
            - else:
                ~temp_string = "."
        }
        
        "Coward." You stop. It's the woman who helped you{temp_string} "You're just going to leave?"
        
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
                    
                    {
                        - happy:
                            You look down at the hand that's missing a finger.
                        - else:
                            You think about all you've been through.
                    }
                    
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

- 
*[And find peace.]
->Credits

= Leave
*[It has been a long night.]

- 
*[And you deserve a very long, vey hot, bath.]
->Credits

= Put_Back
{
    - temp_bool:
        ~ temp_string = ""
    - else:
        ~ temp_string = "You don't want to know how this story ends, not when there's still something you can do. "
}

{temp_string}You put the book back on the shelf.

{
    - !temp_bool_3:
        ~ temp_string = " or there might be something in the desk."
    - else:
        ~ temp_string = "."
}

{
    - saw_locks:
        You suddenly rememeber the woman who helped you. Maybe if you find her book, or someone else's, you can find out what the code to the number lock is.
        
    - else:
        You should look elsewhere. You look at the pile of books surrounding you. Maybe their stories could help you?
}

*[Look through the books]

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

*[Exit the office]
->Stairs.Exit_Office

- 

{
    - confessional_priest:
        ~ temp_string = "You look through all the books that match the story the little girl told you, searching for a mother that had a sick child, and a father that was a priest."
    - saw_locks:
        ~ temp_string = "You search and seach, but you don't know enough about her to even know if you've passed her book or not."
    - else: 
        ~ temp_string = "You search and seach, but you don't know what you're looking for.<br>After hours of searching, you decide to stop. If the code is in one of these books, you're going about it the wrong way. You decide to look again once you know more."
}

With the minimal knowledge you have, you skim through as many books as you can. {temp_string}

{
    - read_book:
        ~ temp_string = "Much like your own ending, they never leave."
    - else:
        ~ temp_string = "They never leave."
}
{
    - confessional_priest or saw_locks:
        ~ stay += 0.5
        You read book after book, story after story about the victims of the church. Many stories mimick your own, but some never knew they were ever in danger. Some got very close to escaping, but none succeeded. All of them had the same ending. {temp_string} They all find peace.
        
        You're about to give up until you find someone promising: Ophelia.
}

{
    - confessional_priest or saw_locks:
        ~ temp_string = "Read the book."
    - else:
        ~ temp_string = "Look elsewhere."
}

*[{temp_string}]

-
{
    - !confessional_priest or !saw_locks:
        ->END
}
~name = true
~number_combo = "2755"
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

= Rip_out_Ophelia
#play: screeching, 1 #stop: screeching, 2
Ensuring you won't forget, you rip the page out of the book. The church lets out a scream as you do, and the room begins to shake. You stuff the page into your pocket, as you try to keep your balence.

Whatever books are left on the shelves fall off, and the far book shelf falls over. The room around you is starting to crumble.

*[Run out of the room]
~room = 5
~ rip_page = true

- You make your way out of the room as fast as you can. All the books on the floor make it difficult, but you manage. Once you're about halfway to the door, you hear a sharp snapping sound. A large piece of ceiling falls to your side, just barely missing you.

{
    - leg == "worst":
        ~temp_string = ", but your leg is not cooperating with you You're not moving as fast as you want to"
    - else:
        ~temp_string = ""
}

You push yourself harder{temp_string}. The door is so close. <i>You're</i> so close.

*[One last push]

-
{
    - keep_book:
        ~temp_string = ", and tighen your grib on your book."
    - else:
        ~temp_string = "."
}


{
    - leg == "worst":
        You try to push your body past it's limit, but your hurt leg gives out on you. You fall, just inches from the doorway. You don't have time to get to your feet before a large chunk of ceiling lands on you.

        "AAGHGAHGAH!" you let of a cry, wiggling around trying to get away. You feel like a bug that a child skewered with a stick. You know it's hopeless, and yet you still writhe on the ground.

        Hoping. Praying.

        *[But it's no use.]
        -> Credits
    - else:
        With one last burst of energy, you throw yourself out of the room. You land on the stairs hard, probably bruising something or worse. You watch as the room collapses in on itself, leaving only a caved in door way.

        "Well that was... something..." you mutter and carefully get to your feet, checking for any damage. You don't feel great but deosn't feel like anything's broken. "Note to self, <i>don't</i> rip anything while in here..."

        You pat your pocket that holds the page{temp_string} At least you can remove one more lock with this.
        
        *[Exit the office.]
        ->Stairs.Exit_Office
}

= Examine_Stairs
You walk deeper down the hallway to the stairs. Going up, is a spiral staircase. Going down, is a long set of stairs. You can't see the end of either.

*[Enter the office]
->Stairs.Office

*[Return to the main body of the church]
->Inside.Look_For_Heart

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
~ saw_locks = true
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
        ~temp_string = "You try a few combinations on  the number lock, thinking you can guess code. Trying to enter today's date, the year, your birthday- Anything meaningful set of four numbers you can think of. After a few minutes, you give up. \n"
}
{
    - !key:
        ~temp_string += "You pull at the chain lock, but it's tightly fastened to the door. You grab at the chain itself and pull, thinking the thinner chain might snap under the pressure, but it holds fast."
}
{
    - clippers:
        ~temp_string += "You then try messing with the sliding lock as well, trying to see if there's a trick to it. If there is, you can't figure it out."
}
    
{temp_string}

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

    The flesh, it- it <i>reacted</i> to your touch. Your skin crawls at the thought. You don't think you should go back down there.
    ->Stairs.Turn_Back

- 
#play: 1, squish-squash
<i>You've made it this far, might as well see it it toward the end,<i> you think, and take a deep breath through your mouth. Slowly, you make it to the bottom of the stairs.

<i>Squish</i>

#stop: 3, squish-squash
The tissue is soft under your shoes, making a soft, wet sound with each step. A thick ooze sticks to the bottom of your shoes.

<i>Squelch</i>

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
Underneath the tarp lies a pile of bodies, covered in rotten flesh. Clumps of hair stuck to skulls. An amalgamation of bones fused together. You don't have time to <mourn, pity, pray> for them, your only thought is to get <i>out.</i> On your hands and knees, you search the floor for your light. 

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
{
    - visited_first:
        ->After_First.Side_Room_After
    - else:
        -> After_Second.Stairs_Second
}

= Return_Down
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
{
    - visited_first:
        ->After_First.Side_Room_After
    - else:
        -> After_Second.Stairs_Second
}


= Exit_Office
~room += 1

You exit the office.

*[Examine the stairs]
-> Stairs.Examine_Stairs
*[Enter the office]
->Stairs.Office
*[Return to the main body of the church]
{
    - temp_bool_3:
        ->Inside.Look_For_Heart
    - visited_first:
        ->After_First.Side_Room_After
    - else:
        -> After_Second.Stairs_Second
}


























