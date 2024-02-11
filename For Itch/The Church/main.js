(function(storyContent) {

    // Create ink story from the content using inkjs
    var story = new inkjs.Story(storyContent);

    var savePoint = "";
    var nIntervId;
    let textInerval;

    let savedTheme;
    let globalTagTheme;

    // Global tags - those at the top of the ink file
    // We support:
    //  # theme: dark
    //  # author: Your Name
    var globalTags = story.globalTags;
    if( globalTags ) {
        for(var i=0; i<story.globalTags.length; i++) {
            var globalTag = story.globalTags[i];
            var splitTag = splitPropertyTag(globalTag);

            // THEME: dark
            if( splitTag && splitTag.property == "theme" ) {
                globalTagTheme = splitTag.val;
            }

            // author: Your Name
            else if( splitTag && splitTag.property == "author" ) {
                var byline = document.querySelector('.byline');
                byline.innerHTML = "by "+splitTag.val;
            }
        }
    }

    var storyContainer = document.querySelector('#story');
    
    //Main COntatiner that holds past text
    var pastTextContatiner;
    
    var textContainer = document.createElement('div')
    storyContainer.appendChild(textContainer);
    
    var footer = document.createElement('div')
    var inside = document.createElement('div')
    footer.classList.add("footer");
    inside.classList.add("temp");
    footer.appendChild(inside)

    var outerScrollContainer = document.querySelector('.outerContainer');
    outerScrollContainer.appendChild(footer);

    let paragraphText = "";
    var replaceParagraph = null;
    var replace_text = ""

    // page features setup
    setupTheme(globalTagTheme);
    var hasSave = loadSavePoint();
    setupButtons(hasSave);

    // Set initial save point
    savePoint = story.state.toJson();

    // Kick off the start of the story!
    continueStory(true);

    // Main story processing function. Each time this is called it generates
    // all the next content up as far as the next set of choices.
    function continueStory(firstTime) {

        var paragraphIndex = 0;
        var delay = 200.0;
        var DelayNextText = 0
        replace_text = ""

        if  (!firstTime)
            delay = 500.0;

        // Don't over-scroll past new content
        var previousBottomEdge = firstTime ? 0 : contentBottomEdgeY();

        var paragraphElement;
        if (pastTextContatiner == null && document.getElementsByTagName('p').length > 0)
        {
            pastTextContatiner = document.getElementsByTagName('p')[0];
        }

        // Generate story text - loop through available content
        if(story.canContinue) {
            // Get ink to generate the next paragraph
            paragraphText = story.Continue();
            var tags = story.currentTags;

            // Any special tags included with this line
            var customClasses = [];
            for(var i=0; i<tags.length; i++) {
                var tag = tags[i];

                // Detect tags of the form "X: Y". Currently used for IMAGE and CLASS but could be
                // customised to be used for other things too.
                var splitTag = splitPropertyTag(tag);

                //DELAY: time
                if( splitTag && splitTag.property == "DELAY" ) {
                    DelayNextText = splitTag.val * 1000;
                    var nextText = CreateTextBox(story.Continue(), customClasses);
                    showAfter(DelayNextText, nextText, false);
                }

                // PLAY: delay, src, fade in, loop
                if( splitTag && splitTag.property == "PLAY" ) {
                    
                    // Check if we need to delay or fade in the audio
                    var array;
                    var sound = splitTag.val;

                    if (splitTag.val.includes(", ")) // if there are any parameters, use all of them
                    {
                        array = splitTag.val.split(", ")

                        sound = array[1];
                        
                        this.audio = new Audio("./audio/" + sound + ".ogg");

                        var time = 30 / (array[2] * 1000);

                        //delay playing by array[0] time, then fade in over array[2] seconds to play array[1] sound. set loop using array[3]
                        setTimeout(function() { 
                            if('audio' in this) {
                                this.audio.pause();
                                this.audio.removeAttribute('src');
                                this.audio.load();
                            }

                            this.audio.volume = 0;
                            this.audioLoop.loop = array[3];
                            this.audio.play();

                            nIntervId = setInterval(fadeIn, 30, this.audio, time);
                        
                        }, (array[0] * 1000));
                    }
                    else //otherwise, just play the oneshot
                    {
                        if('audio' in this) {
                            this.audio.pause();
                            this.audio.removeAttribute('src');
                            this.audio.load();
                          }
                          this.audio = new Audio("./audio/" + sound + ".ogg");
                          this.audio.muted = false;
                          this.audioLoop.loop = false;
                          this.audio.play();
                    }
                }

                //TODO
                // STOP: delay, fade out
                else if( splitTag && splitTag.property == "STOP" ) {
                   // Check if we need to delay or fade in the audio
                   var array;
                   var sound = splitTag.val;

                   if (splitTag.val.includes(", ")) // if there are any parameters, use all of them
                   {
                       array = splitTag.val.split(", ")
                       
                       this.audio = new Audio("./audio/" + sound + ".ogg");

                       var time = 30 / (array[1] * 1000);

                       //delay playing by array[0] time, then fade in over array[2] seconds to play array[1] sound.
                       setTimeout(function() { 
                           if('audio' in this) {
                               this.audio.pause();
                               this.audio.removeAttribute('src');
                               this.audio.load();
                           }
                           this.audio.volume = 1;

                           nIntervId = setInterval(fadeOut, 30, this.audio, time);
                       
                       }, (array[0] * 1000));
                   }
                }

                //REPLACE: link, divert
                if (splitTag && splitTag.property == "REPLACE")
                {
                    replace_text = splitTag.val;
                    var indexStart = paragraphText.indexOf("[")
                    var indexEnd= paragraphText.indexOf("]")
                    newString = paragraphText.substring(0, indexStart) + "<a href='#'>" 
                    + paragraphText.substring(indexStart + 1, indexEnd) + "</a>" 
                    + paragraphText.substring(indexEnd + 1);

                    paragraphText = newString;
                }

                // IMAGE: src
                if( splitTag && splitTag.property == "IMAGE" ) {
                    var imageElement = document.createElement('img');
                    imageElement.src = splitTag.val;
                    storyContainer.appendChild(imageElement);

                    showAfter(delay, imageElement, false);
                    delay += 5000.0;
                }

                // LINK: url
                else if( splitTag && splitTag.property == "LINK" ) {
                    window.location.href = splitTag.val;







                    
                }

                // LINKOPEN: url
                else if( splitTag && splitTag.property == "LINKOPEN" ) {
                    window.open(splitTag.val);
                }

                // BACKGROUND: src
                else if( splitTag && splitTag.property == "BACKGROUND" ) {
                    outerScrollContainer.style.backgroundImage = 'url('+splitTag.val+')';
                }

                // CLASS: className
                else if( splitTag && splitTag.property == "CLASS" ) {
                    customClasses.push(splitTag.val);
                }

                // CLEAR - removes all existing content.
                // RESTART - clears everything and restarts the story from the beginning
                else if( tag == "CLEAR" || tag == "RESTART" ) {
                    removeAll("p");
                    removeAll("img");

                    // Comment out this line if you want to leave the header visible when clearing
                    setVisible(".header", false);

                    if( tag == "RESTART" ) {
                        restart();
                        return;
                    }
                }
            }

            if (pastTextContatiner == null)
            {
                paragraphElement = CreateTextBox(paragraphText, customClasses);
                paragraphElement.setAttribute("id", "All_Text");
                showAfter(delay, paragraphElement, false);
            }
            else if (document.getElementsByTagName('p').length == 1)
            {
                paragraphElement = CreateTextBox(paragraphText, customClasses);
                paragraphElement.setAttribute("id", "Current_Text")
                paragraphElement.addEventListener("click", OnClickEvent);
                showAfter(delay, paragraphElement, false);
            }
            else 
            {
                paragraphElement = document.getElementById("Current_Text")
                displayText(paragraphText, paragraphElement);
                showAfter(delay, paragraphElement, true);
            }

            if (replace_text != "") ClickReplaceText(paragraphElement);
        }


        console.log(story.currentChoices.length <= 0)
        //if there are no choices and no text qued to be delayed, do click stuffs
        if (story.currentChoices.length > 0)
        {
            delay = 1500
            if (DelayNextText)
                delay += DelayNextText

            setTimeout(function() { CreateChoices(); }, delay);
        }

        // Extend height to fit
        // We do this manually so that removing elements and creating new ones doesn't
        // cause the height (and therefore scroll) to jump backwards temporarily.
        storyContainer.style.height = contentBottomEdgeY()+"px";

        if( !firstTime )
            scrollDown(previousBottomEdge);

    }

    //On Click to continue a choice
    function OnClickEvent(event)
    {
        //check if there are choices here
        if (story.currentChoices.length > 0)
            return;

        // Don't follow <a> link
        event.preventDefault();

        //add the current text to the big if that contatiner exists
        if (pastTextContatiner != null)
        {
            pastTextContatiner.innerHTML += "<br><br>" + paragraphText;
            deleteAfter(document.getElementById("Current_Text"), false);
        }
        else continueStory(false)
    }

    //ON clikc choice event for clickk replace text
    function OnChoiceReplaceEvent (event)
    {
        // Don't follow <a> link
        event.preventDefault();

        // Remove all existing choices
        removeAll(".choice");

        // Tell the story where to go next
        story.ChooseChoiceIndex(0);

        // This is where the save button will save from
        savePoint = story.state.toJson();

        replaceParagraph.removeEventListener("click", OnChoiceReplaceEvent, true);

        replaceParagraph = null;

        // Aaand loop
        continueStory(true);
    }

    function CreateChoices()
    {
        // Create HTML choices from ink choices
        story.currentChoices.forEach(function(choice) {

            if (choice.text == replace_text)
                return;

            // Create paragraph with anchor element
            var choiceParagraphElement = document.createElement('div');
            choiceParagraphElement.classList.add("choice");
            choiceParagraphElement.innerHTML = `<a href='#'>${choice.text}</a>`
            storyContainer.appendChild(choiceParagraphElement);

            // Fade choice in after a short delay
            showAfter(200, choiceParagraphElement, true);

            // Click on choice
            var choiceAnchorEl = choiceParagraphElement.querySelectorAll("a")[0];
            choiceAnchorEl.addEventListener("click", async function(event) {

                // Don't follow <a> link
                event.preventDefault();

                // Remove all existing choices
                removeAll(".choice");

                // Tell the story where to go next
                story.ChooseChoiceIndex(choice.index);

                // This is where the save button will save from
                savePoint = story.state.toJson();

                if (replaceParagraph)
                {
                    replaceParagraph.removeEventListener("click", OnChoiceReplaceEvent, true);

                    replaceParagraph = null;
                }

                if (pastTextContatiner != null && choice.text != "Start Game")
                {
                    pastTextContatiner.innerHTML += "<br><br>" + paragraphText;
                    deleteAfter(document.getElementById("Current_Text"), true);
                }
                else continueStory(true)
            });
        });
    }

    function CreateTextBox(text, customClasses)
    {
        // Create paragraph element (initially hidden)
        var paragraphElement = document.createElement('p');
        paragraphElement.classList.add("text_container");
        displayText(text, paragraphElement);
        

        // Add any custom classes derived from ink tags
        for(var i=0; i<customClasses.length; i++)
            paragraphElement.classList.add(customClasses[i]);

        return paragraphElement;
    }

    function restart() {
        story.ResetState();

        setVisible(".header", true);

        // set save point to here
        savePoint = story.state.toJson();

        continueStory(true);

        outerScrollContainer.scrollTo(0, 0);
    }

    function ClickReplaceText(paragraph)
    {
        replaceParagraph = paragraph.querySelectorAll("a")[0];
        replaceParagraph.addEventListener("click", OnChoiceReplaceEvent );
    }

    function fadeIn(audio, delta) {
	    if(audio.volume < (1 - delta)){
   		    audio.volume += delta;
        }else{
    	    audio.volume = 1;
            clearInterval(nIntervId)
            nIntervId = null;
        }
    }

    function fadeOut(audio, delta) {
	    if(audio.volume > (0 + delta)){
   		    audio.volume -= delta;
        }else{
    	    audio.volume = 0;
            audio.pause();
            clearInterval(nIntervId)
            nIntervId = null;
        }
    }


    // -----------------------------------
    // Various Helper functions
    // -----------------------------------

    function displayText (text, el) {
        clearInterval(textInerval)
        textInerval = null;


        let array = text.split(" ");
        let index = 0;
        textInerval = setInterval(function() {
            if(index < array.length) {
                el.innerHTML += " " + array[index++];
            }
        }, 150);
    }

    async function deleteAfter (el, isChoice) {
        clearInterval(textInerval)
        textInerval = null;
        let text = el.innerHTML;
        let index = text.length;

        textInerval = setInterval(function() {
            if(index > 0) {
                text = text.substring(0, index - 1);
                el.innerHTML = text;
                index -= 1;
            }

            else continueStory(isChoice)
        }, 10);
    }

    // Fades in an element after a specified delay
    function showAfter(delay, el, isChoice) {
        // el.classList.add("hide");
        // setTimeout(function() { el.classList.remove("hide") }, delay);

        if (!isChoice)
            setTimeout(function() { textContainer.appendChild(el); }, delay);

        setTimeout(function() { storyContainer.style.height = contentBottomEdgeY()+"px"; }, delay);
        setTimeout(function() { scrollDown(contentBottomEdgeY()); }, delay);
    }

    // Scrolls the page down, but no further than the bottom edge of what you could
    // see previously, so it doesn't go too far.
    function scrollDown(previousBottomEdge) {

        // Line up top of screen with the bottom of where the previous content ended
        var target = previousBottomEdge;
        // Can't go further than the very bottom of the page
        var limit = outerScrollContainer.scrollHeight - outerScrollContainer.clientHeight;

        if( target > limit ) target = limit;

        var start = outerScrollContainer.scrollTop;
        var dist = target - start;
        var duration = 300 + 300*dist/100;
        var startTime = null;
        function step(time) {
            if( startTime == null ) startTime = time;
            var t = (time-startTime) / duration;
            var lerp = 3*t*t - 2*t*t*t; // ease in/out
            outerScrollContainer.scrollTo(0, (1.0-lerp)*start + lerp*target);
            if( t < 1 ) requestAnimationFrame(step);
        }
        requestAnimationFrame(step);
    }

    // The Y coordinate of the bottom end of all the story content, used
    // for growing the container, and deciding how far to scroll.
    function contentBottomEdgeY() {
        var bottomElement = storyContainer.lastElementChild;
        return bottomElement ? bottomElement.offsetTop + bottomElement.offsetHeight:0;// + textContainer.offsetHeight : 0;
    }

    // Remove all elements that match the given selector. Used for removing choices after
    // you've picked one, as well as for the CLEAR and RESTART tags.
    function removeAll(selector)
    {
        var allElements = storyContainer.querySelectorAll(selector);
        for(var i=0; i<allElements.length; i++) {
            var el = allElements[i];
            el.parentNode.removeChild(el);
        }
    }

    // Used for hiding and showing the header when you CLEAR or RESTART the story respectively.
    function setVisible(selector, visible)
    {
        var allElements = storyContainer.querySelectorAll(selector);
        for(var i=0; i<allElements.length; i++) {
            var el = allElements[i];
            if( !visible )
                el.classList.add("invisible");
            else
                el.classList.remove("invisible");
        }
    }

    // Helper for parsing out tags of the form:
    //  # PROPERTY: value
    // e.g. IMAGE: source path
    function splitPropertyTag(tag) {
        var propertySplitIdx = tag.indexOf(":");
        if( propertySplitIdx != null ) {
            var property = tag.substr(0, propertySplitIdx).trim();
            var val = tag.substr(propertySplitIdx+1).trim();
            return {
                property: property,
                val: val
            };
        }

        return null;
    }

    // Loads save state if exists in the browser memory
    function loadSavePoint() {

        try {
            let savedState = window.localStorage.getItem('save-state');
            if (savedState) {
                story.state.LoadJson(savedState);
                return true;
            }
        } catch (e) {
            console.debug("Couldn't load save state");
        }
        return false;
    }

    // Detects which theme (light or dark) to use
    function setupTheme(globalTagTheme) {

        // load theme from browser memory
        var savedTheme = "dark";
        try {
            savedTheme = window.localStorage.getItem('theme');
        } catch (e) {
            console.debug("Couldn't load saved theme");
        }

        // Check whether the OS/browser is configured for dark mode
        var browserDark = window.matchMedia("(prefers-color-scheme: dark)").matches;

        if (savedTheme === "dark"
            || (savedTheme == undefined && globalTagTheme === "dark")
            || (savedTheme == undefined && globalTagTheme == undefined && browserDark))
            document.body.classList.add("dark");
    }

    // Used to hook up the functionality for global functionality buttons
    function setupButtons(hasSave) {

        let rewindEl = document.getElementById("rewind");
        if (rewindEl) rewindEl.addEventListener("click", function(event) {
            removeAll("p");
            removeAll("img");
            setVisible(".header", false);
            restart();
        });

        let saveEl = document.getElementById("save");
        if (saveEl) saveEl.addEventListener("click", function(event) {
            try {
                window.localStorage.setItem('save-state', savePoint);
                document.getElementById("reload").removeAttribute("disabled");
                // window.localStorage.setItem('theme', document.body.classList.contains("dark") ? "dark" : "");
            } catch (e) {
                console.warn("Couldn't save state");
            }

        });

        let reloadEl = document.getElementById("reload");
        if (!hasSave) {
            reloadEl.setAttribute("disabled", "disabled");
        }
        reloadEl.addEventListener("click", function(event) {
            if (reloadEl.getAttribute("disabled"))
                return;

            removeAll("p");
            removeAll("img");
            try {
                let savedState = window.localStorage.getItem('save-state');
                if (savedState) story.state.LoadJson(savedState);
            } catch (e) {
                console.debug("Couldn't load save state");
            }
            continueStory(true);
        });

        // let themeSwitchEl = document.getElementById("theme-switch");
        // if (themeSwitchEl) themeSwitchEl.addEventListener("click", function(event) {
        //     document.body.classList.add("switched");
        //     document.body.classList.toggle("dark");
        // });
    }

})(storyContent);
