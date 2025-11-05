=== TESTING ===
//EXTERNAL PlaySFX_FadeOut(src, loop, fade_in, fade_out, delay)
EXTERNAL PlaySFX(src, loop, fade_in, delay)
EXTERNAL StopSFX(src, fade_out, delay)

EXTERNAL Intrusive(amount, text, jump_to)

#DELAY: 2.5
~ PlaySFX("email_ding", false, 0, 0.5)
Another email with the same subject quickly replaces it. You don't think and delete it again. 

# INTRUSIVE: 3, Click it. Click it., Job.Email_Open
~ PlaySFX("email_ding", false, 0, 0.5)
But yet another takes it's place.
-> END