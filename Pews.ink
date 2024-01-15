=== Pews ===
{
    - confessional_sin:
        ~ temp_string = "Another key maybe?"
}

{
    - saw_locks:
        ~ temp_string = "Another key maybe?"
}



You make your way to the pews, and begin to search them for anything important. (if:$confessional_sin is true)[Another key maybe?](if:(visited:"Examine the locks"))[Or maybe something to cut the sliding chain? (if:$name is not true )[Maybe the combination code?]](else-if:$confessional_sin is not true or is not (visited:"Examine the locks"))[You don't know exactly what for. A heart wouldn't really make sense to live in the pews. Maybe you should check the stage after.]

There's two columns, with four pews each. You seach from front to back, left to right. You feel underneath and the back to make sure nothing is glues or taped to it. You move slowly and methodically, making sure you don't miss anything. 

You don't find much of anything. With a huff you plop onto the last pew you searched, taking a well deserved break. You close your eyes and rub your face. What are you even looking for?

You lean back in your seat, eyes still closed. There's no use sitting here, [[you should move on with your search.->massstart]]


















-> END