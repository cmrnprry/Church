(function(storyContent) {

    // Create ink story from the content using inkjs
    var story = new inkjs.Story(storyContent);

    var savePoint = "";
    var nIntervId;
    let textInerval;

    let savedTheme;
    let globalTagTheme;
    let hasFlashlight = false;


    //HUGE LIST OF HOWLS FOR ALL OUR AUDIO
    var cat_meow = new Howl({
        src: ['./Audio/cat-meow.ogg'],
        loop: true,
        volume: 1,
        html5:true,
        onend: function() {
          console.log('Finished!');
        },
        onfade: function() {
            console.log("fade finished")
            if (cat_meow.volume == 0)
            {
                cat_meow.stop();
                cat_meow.volume = 1;
            }
        }
      });

    //AUDIO LIST
    const  AudioList = {
        "cat_meow": cat_meow
    }

    // Global tags - those at the top of the ink file
    // We support:
    //  # theme: dark
    //  # author: Your Name
    var globalTags = story.globalTags;
    globalTagTheme = "dark";
    if( globalTags ) {
        for(var i=0; i<story.globalTags.length; i++) {
            var globalTag = story.globalTags[i];
            var splitTag = splitPropertyTag(globalTag);

            // author: Your Name
            if( splitTag && splitTag.property == "author" ) {
                var byline = document.querySelector('.byline');
                byline.innerHTML = "by "+splitTag.val;
            }
        }
    }

    var storyContainer = document.querySelector('#story');
    var optionsContainer = document.getElementById('Options Menu');
    
    //Main Contatiner that holds past text
    var pastTextContainer;
    
    var textContainer = document.createElement('div')
    storyContainer.appendChild(textContainer);

    var footer = document.getElementById("Flashlight_Button")
    footer.setAttribute("status", "off")

    var outerScrollContainer = document.querySelector('.outerContainer');

    let paragraphText = "";
    var replaceParagraph = null;
    var replace_text = ""
    let DelayNextText = 0;
    let CyclingText = null;
    let paragraphElement = null;



    // page features setup
    setupTheme(globalTagTheme);
    var hasSave = loadSavePoint();
    setupButtons(hasSave);
    setUpFooter();

    // Set initial save point
    savePoint = story.state.toJson();

    // Kick off the start of the story!
    continueStory(true);

    // Main story processing function. Each time this is called it generates
    // all the next content up as far as the next set of choices.
    function continueStory(firstTime) {
        console.log(hasSave)
        console.log(firstTime)
        var delay = 200.0;
        DelayNextText = 0;
        replace_text = "";
        CyclingText = null;

        if  (!firstTime)
            delay = 500.0;

        // Don't over-scroll past new content
        var previousBottomEdge = firstTime ? 0 : contentBottomEdgeY();

        if (pastTextContainer == null && document.getElementById('All_Text') != pastTextContainer)
        {
            console.log("getting all text")
            pastTextContainer = document.getElementById('All_Text');
        }

        // Generate story text - loop through available content
        if(story.canContinue) {
            //save on every canContinue
            savePoint = story.state.toJson();
            window.localStorage.setItem('save-state', savePoint);

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
                    DelayNextText = (splitTag.val * 1000) + 1000;
                }

                // PLAY: src (assumes no looping, fade in or out)
                // PLAY: src, fade in
                if( splitTag && splitTag.property == "PLAY" ) {
                    
                    // Check if we need to delay or fade in the audio
                    var array;
                    var sound = splitTag.val;

                    if (splitTag.val.includes(", ")) // if there are any parameters, use all of them
                    {
                        array = splitTag.val.split(", ")

                        sound = array[0];
                        var fadeIn = array[1] * 1000;

                        PlayOrStopAudio (AudioList[sound], true, fadeIn);          
                    }
                    else //otherwise, just play the oneshot
                        PlayOrStopAudio (AudioList[sound], true, 0);
                }

                //TODO
                // STOP: src
                // STOP: src, delay, fade out
                else if( splitTag && splitTag.property == "STOP" ) {
                    // Check if we need to delay or fade in the audio
                    var array;
                    var sound = splitTag.val;

                    if (splitTag.val.includes(", ")) // if there are any parameters, use all of them
                    {
                        
                        array = splitTag.val.split(", ")
                        sound = array[0];
                        var fadeOut = array[1] * 1000;
                        
                        PlayOrStopAudio (AudioList[sound], false, fadeOut);
                    }                    
                    else //otherwise, just play the oneshot
                        PlayOrStopAudio (AudioList[sound], false, 0);
                   
                }

                //CYCLE: style, [word list]
                if (splitTag && splitTag.property == "CYCLE") {
                    var list = splitTag.val.split(', ')

                    // CyclingText = document.createElement('a');
                    CyclingText = true;
                    let style = "";

                    if (list[0] == "Fidget")
                    {
                        style = list[0];
                        list.shift();
                    }

                    paragraphText = paragraphText.slice(0, paragraphText.indexOf('@')) + `<a href=\'#\' class="${style}" Index=0 Cycle=${list}> ${list[0]} </a>` + paragraphText.slice(paragraphText.indexOf('@') + 1);
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

                    scrollPage(delay, imageElement, false);
                    delay += 5000.0;
                }

                if( splitTag && splitTag.property == "EFFECT" ) {
                    if (splitTag.val == "flashlight")
                    {
                        if (!hasFlashlight)
                        {
                            hasFlashlight = true;
                            footer.classList.remove("hidden")
                        }

                        if (footer.getAttribute("status") == "off")
                        {
                            footer.setAttribute("status", "on")
                            document.getElementById("flashlight").style.display = ""             
                            footer.innerHTML = "Turn off"
                        }
                        else
                        {
                            footer.innerHTML = "Turn on"
                            document.getElementById("flashlight").style.display = "none"
                            footer.setAttribute("status", "off")
                        }
                    }
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

                // REMOVE: class
                // Effects the text box specifically
                else if( splitTag && splitTag.property == "REMOVE" ) {
                        document.getElementById("Current_Text").classList.remove(splitTag.val);
                        document.getElementById('All_Text').classList.remove(splitTag.val);
                }

                // TEXTBOX: class
                // Effects the text box specifically
                else if( splitTag && splitTag.property == "TEXTBOX" ) {
                    console.log("here")
                        document.getElementById("Current_Text").classList.add(splitTag.val);
                        document.getElementById('All_Text').classList.add(splitTag.val);
                }

                // CLASS: className
                // Effects the text
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

            if (pastTextContainer == null)
            {
                console.log("no text boxes")
                paragraphElement = CreateTextBox(paragraphText, customClasses);
                paragraphElement.setAttribute("id", "All_Text");

                scrollPage(delay, paragraphElement, false);
                if (hasSave && firstTime && story.currentChoices.length <= 0)
                {
                    console.log("here")
                    paragraphElement.addEventListener("click", OnClickOneTimeEvent);                    
                }
            }
            else if (document.getElementById('All_Text') && !document.getElementById('Current_Text'))
            {
                console.log("adding current text boxes")
                //removing css from the all_text
                const temp = document.getElementById('All_Text').firstChild;
                if (temp && temp.classList.length > 0)
                {
                    console.log(temp)
                    if (temp.innerHTML != "")
                    {
                        temp.classList.remove("fadeInBottom")
                        temp.classList.remove("hide")
                    }
                    
                }                

                //creating the current text box
                paragraphElement = CreateTextBox(paragraphText, customClasses);
                paragraphElement.setAttribute("id", "Current_Text")
                paragraphElement.setAttribute("click_listener", "true")
                paragraphElement.addEventListener("click", OnClickEvent);
                scrollPage(delay, paragraphElement, false);
            }
            else 
            {
                console.log("all text boxes made")
                //all text boxes exist, now populate
                const box = document.getElementById("Current_Text")
                paragraphElement = box.firstChild
                
                //if our last line was delayed, readd our click listener
                if (box.getAttribute("click_listener") == "false"){
                    box.addEventListener("click", OnClickEvent);
                    box.setAttribute("click_listener", "true")
                }

                //we are delayed, after our delay add the new text and remove the click listener
                if (DelayNextText > 0)
                {
                    box.setAttribute("click_listener", "false")
                    box.removeEventListener("click", OnClickEvent);
                    setTimeout(function() { 
                        pastTextContainer.firstChild.innerHTML += "<br><br>" + paragraphText;
                        deleteAfter(document.getElementById("Current_Text").firstChild, false);
                    
                    }, DelayNextText);
                    
                }
                
                displayText(paragraphText, paragraphElement, customClasses, 500);                
                scrollPage(delay, paragraphElement, true);
            }

            if (replace_text != "") ClickReplaceText(paragraphElement);
        }


        //if there are no choices and no text qued to be delayed, do click stuffs
        if (story.currentChoices.length > 0)
        {
            delay = 1500
            if (DelayNextText > 0)
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

    function PlayOrStopAudio(audio, shouldPlay, fade)
    {
        if (audio)
        {
            setTimeout(function() { 
                
                if (shouldPlay) { 
                    var id = audio.play(); 
                    audio.fade(0, 1, fade, id); 
                }
                else { 
                    console.log(fade)

                    var id = audio.play(); 
                    audio.fade(1, 0, fade, id); 
                }
            }, 500);
        }
        else
            console.error("Audio Error. Could not find: " + audio)
    }

    function OnClickCycle(event)
    {
        CyclingText = "clicked"
        // Don't follow <a> link
        event.preventDefault();

        let cycle = paragraphElement.querySelectorAll("a")[0];
        let list = cycle.getAttribute("cycle").split(',');
        let index = parseInt(cycle.getAttribute("index"));

        index += 1;
        if (index >= list.length)
            index = 0;

        cycle.setAttribute("index", index)

        let newText = ""
        newText = list[index]

        cycle.innerHTML = newText;
    }

    function AfterClickCycle(event)
    {
        CyclingText = true
    }

    //On Click to continue a choice
    function OnClickEvent(event)
    {
        //check if there are choices here
        if (story.currentChoices.length > 0 || DelayNextText || CyclingText == "clicked")
            return;

        // Don't follow <a> link
        event.preventDefault();

        //add the current text to the big if that contatiner exists
        if (pastTextContainer != null)
        {
            if (CyclingText)
            {
                var text = paragraphText;
                let start = text.indexOf('<');
                let end = text.indexOf('>');
                text = text.substring(0,start) + text.substring(end + 1);
                paragraphText = text;
                CyclingText = null;
            }

            pastTextContainer.firstChild.innerHTML += "<br><br>" + paragraphText;           
            deleteAfter(document.getElementById("Current_Text").firstChild, false);
        }
        else continueStory(false)
    }

    //On Click to continue IF there was a refresh
    function OnClickOneTimeEvent(event)
    {
        //check if there are choices here
        if (story.currentChoices.length > 0 || DelayNextText || CyclingText == "clicked")
            return;

        // Don't follow <a> link
        event.preventDefault();

        //add the current text to the big if that contatiner exists
        if (pastTextContainer != null)
        {
            if (CyclingText)
            {
                var text = paragraphText;
                let start = text.indexOf('<');
                let end = text.indexOf('>');
                text = text.substring(0,start) + text.substring(end + 1);
                paragraphText = text;
                CyclingText = null;
            }

            pastTextContainer.firstChild.innerHTML += "<br><br>" + paragraphText;           
            deleteAfter(document.getElementById("Current_Text").firstChild, false);
        }
        else continueStory(false)

        document.getElementById('All_Text').removeEventListener("click", OnClickOneTimeEvent);
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
        window.localStorage.setItem('save-state', savePoint);

        replaceParagraph.removeEventListener("click", OnChoiceReplaceEvent, true);

        replaceParagraph = null;

        // Aaand loop
        continueStory(false);
    }

    function CreateChoices()
    {
        // Create HTML choices from ink choices
        story.currentChoices.forEach(function(choice) {

            if (choice.text == replace_text)
                return;

            // check if this is click replace text
            let isReplaceChoiceText = ""
            if (choice.text.startsWith('('))
            {
                var index = choice.text.indexOf(')');
                var shownText = choice.text.substring(1, index);
                isReplaceChoiceText = choice.text.substring(1 + index);
                choice.text = shownText;
            }
                

            // Create paragraph with anchor element
            var choiceParagraphElement = document.createElement('div');
            choiceParagraphElement.classList.add("choice");
            choiceParagraphElement.classList.add("fadeIn");
            choiceParagraphElement.innerHTML = `<a href='#'>${choice.text}</a>`
            storyContainer.appendChild(choiceParagraphElement);

            // scroll after the choices are visible
            scrollPage(200, choiceParagraphElement, true);

            // Click on choice
            var choiceAnchorEl = choiceParagraphElement.querySelectorAll("a")[0];

            if (isReplaceChoiceText != "")
            {
                choiceAnchorEl.addEventListener("click", ClickReplaceChoiceText);
                choiceParagraphElement.setAttribute("replace_text", isReplaceChoiceText)
                choiceParagraphElement.setAttribute("index", choice.index)
                choiceParagraphElement.setAttribute("Id", "Replaceable Text")
                return;
            }

            choiceAnchorEl.addEventListener("click", async function(event) {

                // Don't follow <a> link
                event.preventDefault();

                // Remove all existing choices
                removeAll(".choice");

                // Tell the story where to go next
                story.ChooseChoiceIndex(choice.index);

                // This is where the save button will save from
                savePoint = story.state.toJson();
                window.localStorage.setItem('save-state', savePoint);

                if (replaceParagraph)
                {
                    replaceParagraph.removeEventListener("click", OnChoiceReplaceEvent, true);

                    replaceParagraph = null;
                }

                if (pastTextContainer != null && choice.text != "Start Game")
                {
                    pastTextContainer.firstChild.innerHTML += "<br><br>" + paragraphText;
                    deleteAfter(document.getElementById("Current_Text").firstChild, true);
                }
                else continueStory(true)
            });
        });
    }

    function ClickReplaceChoiceText(event)
    {
        // Don't follow <a> link
        event.preventDefault();

        var element = document.getElementById("Replaceable Text")

        var text = element.getAttribute("replace_text")
        var index = parseInt(element.getAttribute("index"))

        element.innerHTML = `<a href='#'>${text}</a>`

        var el = element.querySelectorAll("a")[0];
        el.removeEventListener("click", ClickReplaceChoiceText);
        el.addEventListener("click", async function(event) {

            // Don't follow <a> link
            event.preventDefault();

            // Remove all existing choices
            removeAll(".choice");

            // Tell the story where to go next
            story.ChooseChoiceIndex(index);

            // This is where the save button will save from
            savePoint = story.state.toJson();
            window.localStorage.setItem('save-state', savePoint);

            //continue
            if (pastTextContainer != null)
                {
                    pastTextContainer.firstChild.innerHTML += "<br><br>" + paragraphText;
                    deleteAfter(document.getElementById("Current_Text").firstChild, true);
                }
            else continueStory(true)
        });
    }

    function CreateTextBox(text, customClasses)
    {
        // Create paragraph element (initially hidden)
        var paragraphElement = document.createElement('div');
        var textElement = document.createElement('p');
        paragraphElement.appendChild(textElement);

        paragraphElement.classList.add("text_container");
        paragraphElement.classList.add("fadeIn");
        displayText(text, textElement, customClasses, 500);

        return paragraphElement;
    }

    function restart() {
        setVisible(".header", true);

        OnRestartOrLoad();
        pastTextContainer = null;

        // set save point to here
        savePoint = story.state.toJson();

        story.ResetState();

        continueStory(true);

        outerScrollContainer.scrollTo(0, 0);
    }

    function OnRestartOrLoad()
    {
        var element = document.getElementById('All_Text')
        if (element)
            element.remove()

        element = document.getElementById('Current_Text')
        if (element)
            element.remove()
    
        removeAll(".choice");
        
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

    function setUpFooter()
    {
        document.body.addEventListener("mousemove", flashlightMouseFollow);
        footer.addEventListener("click", async function(event) {
            // Don't follow <a> link
            event.preventDefault();

            if (footer.getAttribute("status") == "off")
            {
                document.getElementById("flashlight").style.display = ""             
                footer.innerHTML = "Turn off"
                footer.setAttribute("status", "on")
            }
            else if (footer.getAttribute("status") == "on")
            {
                footer.innerHTML = "Turn on"
                document.getElementById("flashlight").style.display = "none"
                footer.setAttribute("status", "off")
            }
            
        });
    }

    function flashlightMouseFollow(event)
    {
        if (footer.getAttribute("status") == "off")
            return;
        
        let x = event.pageX - 250;
        let y = event.pageY - 250;
        document.getElementById("flashlight").style.top = y + "px";  
        document.getElementById("flashlight").style.left = x+ "px";
    }

    function displayText (text, el, customClasses, delay) {
        el.innerHTML = text;
        el.classList.add("hide")

        setTimeout(function() {

            if (customClasses.length > 0)
            {
                for(var i=0; i<customClasses.length; i++)
                    el.classList.add(customClasses[i]);
            }
            else
            {
                el.classList.add("fadeInBottom"); 
            }         

            el.classList.remove("hide");

            if (CyclingText)
            {
                let cycle = el.querySelectorAll("a")[0];
                cycle.addEventListener("click", OnClickCycle );
                cycle.addEventListener("mouseleave", AfterClickCycle );
            }
        }, delay);
        
    }

    async function deleteAfter (el, isChoice) {
        el.innerHTML = "";
        el.removeAttribute("class")

        setTimeout(function() { continueStory(isChoice);}, 100);
    }

    // Fades in an element after a specified delay
    function scrollPage(delay, el, isChoice) {
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
                console.log(story.state.LoadJson(savedState));
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

    function openOptions(visible)
    {
        if (visible)
            optionsContainer.classList.remove("hidden")
        else
            optionsContainer.classList.add("hidden")

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

        let optionsEl = document.getElementById("options");

        if (optionsEl) optionsEl.addEventListener("click", function(event) {
            if (storyContainer.classList.contains("hidden"))
            {
                storyContainer.classList.remove("hidden")
                openOptions(false);
            }
            else
            {
                storyContainer.classList.add("hidden")
                openOptions(true);
            }
            
        });

        // let saveEl = document.getElementById("save");
        // if (saveEl) saveEl.addEventListener("click", function(event) {
        //     try {
        //         window.localStorage.setItem('save-state', savePoint);
        //         document.getElementById("reload").removeAttribute("disabled");
        //         // window.localStorage.setItem('theme', document.body.classList.contains("dark") ? "dark" : "");
        //     } catch (e) {
        //         console.warn("Couldn't save state");
        //     }

        // });

        // let reloadEl = document.getElementById("reload");
        // if (!hasSave) {
        //     reloadEl.setAttribute("disabled", "disabled");
        // }
        // reloadEl.addEventListener("click", function(event) {
        //     if (reloadEl.getAttribute("disabled"))
        //         return;

        //     removeAll("p");
        //     removeAll("img");
            
        //     try {
        //         let savedState = window.localStorage.getItem('save-state');
        //         if (savedState) story.state.LoadJson(savedState);
        //     } catch (e) {
        //         console.debug("Couldn't load save state");
        //     }

        //    OnRestartOrLoad();
        // });

        // let themeSwitchEl = document.getElementById("theme-switch");
        // if (themeSwitchEl) themeSwitchEl.addEventListener("click", function(event) {
        //     document.body.classList.add("switched");
        //     document.body.classList.toggle("dark");
        // });
    }

})(storyContent);
