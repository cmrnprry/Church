(function(storyContent) {

    // Create ink story from the content using inkjs
    var story = new inkjs.Story(storyContent);

    var savePoint = "";
    var nIntervId;
    let textInerval;

    let savedTheme;
    let globalTagTheme;
    let hasFlashlight = false;

    //IMAGES
    let BackgroundImage = document.getElementById("Background Image")

    //OPTIONS VARIABLES
    let volume = window.localStorage.getItem('save-volume')
    let mute = window.localStorage.getItem('save-mute')
    let shake = window.localStorage.getItem('save-shake')
    let dim = window.localStorage.getItem('save-dim')
    let scroll = window.localStorage.getItem('save-scroll')

    //HUGE LIST OF AUDIO OBJECTS FOR ALL OUR AUDIO
    let bus_ambience = new Audio('./Audio/ambience-bussy.ogg')
    let office_ambience = new Audio('./Audio/ambience-office.ogg')
    let bang_confessional = new Audio('./Audio/bang-wood-confession.ogg')
    let bang_normal = new Audio('./Audio/bang-wood-door.ogg')
    let bang_short = new Audio('./Audio/bang-wood-door-short.ogg')
    let meow = new Audio('./Audio/cat-meow.ogg')
    let crowbar_break = new Audio('./Audio/crowbar-break.ogg')
    let curtain = new Audio('./Audio/curtain-opening.ogg')
    let door_slam = new Audio('./Audio/door-slam.ogg')
    let dor_thud = new Audio('./Audio/door-thud.ogg')
    let email_ding = new Audio('./Audio/email-ding.ogg')
    let flashlight_off = new Audio('./Audio/flashlight-off.ogg')
    let flashlight_on = new Audio('./Audio/flashlight-on.ogg')
    let footsteps_player = new Audio('./Audio/footsteps-player.ogg')
    let footsteps_child_grass = new Audio('./Audio/footsteps-running-grass-child-barefoot.ogg')
    let footsteps_scary = new Audio('./Audio/footsteps-spooky-v2.ogg')
    let footsteps_squishy = new Audio('./Audio/footsteps-squishy.ogg')
    let gate_close = new Audio('./Audio/gate-close.ogg')
    let gate_open = new Audio('./Audio/gate-open.ogg')
    let groaning_angry = new Audio('./Audio/groaning-angry.ogg')
    let groaning_happy = new Audio('./Audio/groaning-happy.ogg')
    let groaning_normal = new Audio('./Audio/groaning-normal.ogg')
    let honk = new Audio('./Audio/honk.ogg')
    let knocking = new Audio('./Audio/knocking.ogg')
    let leak = new Audio('./Audio/leak.ogg')
    let lock_rattle = new Audio('./Audio/lock-rattle.ogg')
    let running_pavement = new Audio('./Audio/run-pavement-sneaker.ogg')
    let scanner = new Audio('./Audio/scan-documents.ogg')
    let screeching = new Audio('./Audio/screeching-short.ogg')
    let screw_fall_1 = new Audio('./Audio/screw-fall-to-floor-1.ogg')
    let screw_fall_2 = new Audio('./Audio/screw-fall-to-floor-2.ogg')
    let walking_wast_pavement = new Audio('./Audio/walk-fast-pavement-sneaker.ogg')

    // //AUDIO LIST
    const  AudioList = {
        "bus_ambience" : bus_ambience,
        "office_ambience" : office_ambience,
        "bang_confessional" : bang_confessional,
        "bang_normal" : bang_normal,
        "bang_short" : bang_short,
        "meow" : meow,
        "crowbar_break" : crowbar_break,
        "curtain" : curtain,
        "door_slam" : door_slam,
        "door_thud" : dor_thud,
        "email_ding" : email_ding,
        "flashlight_off" : flashlight_off,
        "flashlight_on" : flashlight_on,
        "footsteps_player" : footsteps_player,
        "footsteps_child_grass" : footsteps_child_grass,
        "footsteps_scary" : footsteps_scary,
        "footsteps_squishy" : footsteps_squishy,
        "gate_close" : gate_close,
        "gate_open" : gate_open,
        "groaning_angry" : groaning_angry,
        "groaning_happy" : groaning_happy,
        "groaning_normal" : groaning_normal,
        "honk" : honk,
        "knocking" : knocking,
        "leak" : leak,
        "lock_rattle" : lock_rattle,
        "running_pavement" : running_pavement,
        "scanner" : scanner,
        "screeching" : screeching,
        "screw_fall_1" : screw_fall_1,
        "screw_fall_2" : screw_fall_2,
        "walking_wast_pavement" : walking_wast_pavement
    }

    //ENDINGS
    let ending1 = {
        name: "Melted",
        description: "This is a description.",
        type:"Bad",
        achieved: false
    }
    let ending2 = {
        name: "Crushed",
        description: "This is a description.",
        type:"Bad",
        achieved: false
    }
    let ending3 = {
        name: "Sleeping Forever",
        description: "This is a description.",
        type:"Bad",
        achieved: false
    }
    let ending4 = {
        name: "Why Shouldn't I stay?",
        description: "This is a description.",
        type:"Bad",
        achieved: false
    }
    let ending5 = {
        name: "Finding Solace",
        description: "This is a description.",
        type:"Bad",
        achieved: false
    }
    let ending6 = {
        name: "Eating Forever",
        description: "This is a description.",
        type:"Bad",
        achieved: false
    }
    let ending7 = {
        name: "Finding Peace",
        description: "This is a description.",
        type:"Bad?",
        achieved: false
    }
    let ending8 = {
        name: "What Have You Done?",
        description: "This is a description.",
        type:"???",
        achieved: false
    }
    let ending9 = {
        name: "You Are the Church",
        description: "This is a description.",
        type:"???",
        achieved: false
    }
    let ending10 = {
        name: "It Has Been a Long, Long Night",
        description: "This is a description.",
        type:"Good",
        achieved: false
    }
    const EndingsList = [
        ending1,
        ending2,
        ending3,
        ending4,
        ending5,
        ending6,
        ending7,
        ending8,
        ending9,
        ending10,
    ]

    let EndingsAchieved = window.localStorage.getItem('save-endings')

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
    var endingsContainer = document.getElementById('Endings Menu');
    
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
    setupButtons();
    setUpFooter();

    // Set initial save point
    savePoint = story.state.toJson();

    // Kick off the start of the story!
    continueStory(true);

    // Main story processing function. Each time this is called it generates
    // all the next content up as far as the next set of choices.
    function continueStory(firstTime) {
        var delay = 200.0;
        DelayNextText = 0;
        replace_text = "";
        CyclingText = null;

        if  (!firstTime)
            delay = 500.0;

        // Don't over-scroll past new content
        var previousBottomEdge = firstTime ? 0 : contentBottomEdgeY(outerScrollContainer);

        if (pastTextContainer == null && document.getElementById('All_Text') != pastTextContainer)
        {
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

                //ENDING: name
                if(splitTag && splitTag.property == "ENDING")
                {
                    for (let i = 0; i < EndingsList.length; i++) {
                        if (splitTag.val == EndingsList[i].name)
                        {
                            EndingsAchieved[i] = true;
                            break;
                        }
                    }

                    window.localStorage.setItem('save-endings', JSON.stringify(EndingsAchieved))   
                    setupEndings()
                }

                // PLAY: src (assumes no looping, fade in or out)
                // PLAY: src, loop, fade in
                // PLAY: src, loop, fade in, delay
                if( splitTag && splitTag.property == "PLAY" ) {
                    
                    // Check if we need to delay or fade in the audio
                    var array;
                    var sound = splitTag.val;
                    var fade = 0.5;
                    var delay = 500;
                    var loop = false;

                    if (mute === "false")
                    {
                        if (splitTag.val.includes(", ")) // if there are any parameters, use all of them
                        {
                            array = splitTag.val.split(", ")

                            sound = array[0];
                            loop = array[1]                       
                            fade = 30 / (array[2] * 1000);
                            delay  = (array.length > 3) ? array[3] : 500     
                        }

                        if (AudioList[sound])
                        PlayAudio (AudioList[sound], loop, fade, delay);   
                    } 
                }

                // STOP: src
                // STOP: src, fade out
                // STOP: src, fade out, delay
                else if( splitTag && splitTag.property == "STOP" ) {
                    // Check if we need to delay or fade in the audio
                    var array;
                    var sound = splitTag.val;
                    var fade = 0.5;
                    var delay = 500;

                    if (splitTag.val.includes(", ")) // if there are any parameters, use all of them
                    {
                        array = splitTag.val.split(", ")

                        sound = array[0];
                        fade = 30 / (array[1] * 1000);                        
                        delay  = (array.length > 2) ? array[2] * 1000 : 500     
                    }

                    StopAudio (AudioList[sound], fade, delay);                   
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
                    
                    BackgroundImage.src = `./Images/Backgrounds/${splitTag.val}.png`;
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
                    if (dim !== "false")
                    {    
                        document.getElementById("Current_Text").classList.add(splitTag.val);
                        document.getElementById('All_Text').classList.add(splitTag.val);
                    }
            }

                // CLASS: className
                // Effects the text
                else if( splitTag && splitTag.property == "CLASS" ) {
                    if (shake !== "false")
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
                paragraphElement = CreateTextBox(paragraphText, customClasses);
                paragraphElement.setAttribute("id", "All_Text");
                paragraphElement.classList.add("scrolling")

                scrollPage(delay, paragraphElement, false);
                if (hasSave && firstTime && story.currentChoices.length <= 0)
                {
                    paragraphElement.addEventListener("click", OnClickOneTimeEvent);                    
                }
            }
            else if (document.getElementById('All_Text') && !document.getElementById('Current_Text'))
            {
                //removing css from the all_text
                const temp = document.getElementById('All_Text').firstChild;
                if (temp && temp.classList.length > 0)
                {
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

                if (story.currentChoices.length <= 0)
                    setTimeout(function() { scrollDown(contentBottomEdgeY(outerScrollContainer), outerScrollContainer); }, 750);
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

        if( !firstTime )
            setTimeout(function() { scrollDown(previousBottomEdge, outerScrollContainer); }, 750);

    }

    function PlayAudio(audio, loop, fade, delay)
    {
        if (audio)
        {
            setTimeout(function() { 
                if (loop)
                {
                    audio.loop = true;
                    audio.addEventListener("ended", function(){
                        audio.currentTime = 0;
                        audio.play();
                    })
                }
                    
                if (fade > 0)
                {  
                    audio.volume = 0
                    nIntervId = setInterval(fadeIn, 30, audio, fade);
                }

                audio.play();
            }, delay);
        }
        else
            console.error("Audio Error. Could not find: " + audio)
    }

    function StopAudio(audio, fade, delay)
    {
        if (audio)
        {
            setTimeout(function() {
                if (fade > 0)
                {
                    audio.volume = parseInt(volume) / 100;
                    nIntervId = setInterval(fadeOut, 30, audio, fade);
                }
                    
                else
                {
                    audio.pause();
                    audio.currentTime = 0;
                }
                    
            }, delay);
        }
        else
            console.error("Audio Error. Could not find: " + audio)
    }

    function fadeIn(audio, delta) {
        var currentVolume = parseInt(volume) / 100
	    if((audio.volume < (currentVolume)) && (audio.volume + delta < 1)){
   		    audio.volume += delta;
        }else{
    	    audio.volume = currentVolume;
            clearInterval(nIntervId)
            nIntervId = null;
        }
    }

    function fadeOut(audio, delta) {
	    if((audio.volume > (0)) && (audio.volume - delta > 0)){
   		    audio.volume -= delta;
        }else{
    	    audio.volume = 0;
            audio.pause();
            clearInterval(nIntervId)
            nIntervId = null;
        }
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

        setTimeout(function() { scrollDown(contentBottomEdgeY(outerScrollContainer), outerScrollContainer); }, 500);
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
        
        openOptions(false);
        storyContainer.classList.remove("hide")
    }

    function ClickReplaceText(paragraph)
    {
        replaceParagraph = paragraph.querySelectorAll("a")[0];
        replaceParagraph.addEventListener("click", OnChoiceReplaceEvent );
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
        el.innerHTML = "<br><br>";
        el.removeAttribute("class")

        setTimeout(function() { continueStory(isChoice);}, 100);
    }

    // Fades in an element after a specified delay
    function scrollPage(delay, el, isChoice) {
        if (!isChoice)
            setTimeout(function() { textContainer.appendChild(el); }, delay);

        var element = (document.getElementById('All_Text')) ? document.getElementById('All_Text') : el
        setTimeout(function() { scrollDown(contentBottomEdgeY(element), element); }, 50);
    }

    // Scrolls the page down, but no further than the bottom edge of what you could
    // see previously, so it doesn't go too far.
    function scrollDown(previousBottomEdge, element) {
        if (scroll === "false" && element.id != "All_Text")
            return;

        // Line up top of screen with the bottom of where the previous content ended
        var target = previousBottomEdge;
        // Can't go further than the very bottom of the page
        var limit = element.scrollHeight - element.clientHeight;

        if( target > limit ) target = limit;

        var start = element.scrollTop;
        var dist = target - start;
        var duration = 300 + 300*dist/100;
        var startTime = null;
        function step(time) {
            if( startTime == null ) startTime = time;
            var t = (time-startTime) / duration;
            var lerp = 3*t*t - 2*t*t*t; // ease in/out
            element.scrollTo(0, (1.0-lerp)*start + lerp*target);
            if( t < 1 ) requestAnimationFrame(step);
        }
        requestAnimationFrame(step);
    }

    // The Y coordinate of the bottom end of all the story content, used
    // for growing the container, and deciding how far to scroll.
    function contentBottomEdgeY(element) {
        console.log(element)
        var bottomElement = (element.lastElementChild) ? element.lastElementChild : element ;
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
        {
            optionsContainer.classList.remove("hidden");
            endingsContainer.classList.add("hidden");
        }
        else
            optionsContainer.classList.add("hidden");
    }

    function openEndings(visible)
    {
        if (visible)
        {
            endingsContainer.classList.remove("hidden");
            optionsContainer.classList.add("hidden");
        }
        else
            endingsContainer.classList.add("hidden");
    }

    // Used to hook up the functionality for global functionality buttons
    function setupButtons() {

        let rewindEl = document.getElementById("rewind");
        if (rewindEl) rewindEl.addEventListener("click", function(event) {
            removeAll("p");
            removeAll("img");
            setVisible(".header", false);
            restart();
        });

        let optionsEl = document.getElementById("options");

        if (optionsEl) optionsEl.addEventListener("click", function(event) {
            if (storyContainer.classList.contains("hide") && !optionsContainer.classList.contains("hidden"))
            {
                storyContainer.classList.remove("hide")
                openOptions(false);

                if (document.getElementById("Current_Text"))
                    setTimeout(function() { scrollDown(contentBottomEdgeY(outerScrollContainer), outerScrollContainer); }, 750);
                else
                    setTimeout(function() { scrollDown(0, outerScrollContainer); }, 750);              
            }
            else
            {
                storyContainer.classList.add("hide")
                openOptions(true);
            }
            
        });

        let endingsEl = document.getElementById("endings");

        if (endingsEl) endingsEl.addEventListener("click", function(event) {
            if (storyContainer.classList.contains("hide") && !endingsContainer.classList.contains("hidden"))
            {
                storyContainer.classList.remove("hide")
                openEndings(false);

                if (document.getElementById("Current_Text"))
                    setTimeout(function() { scrollDown(contentBottomEdgeY(outerScrollContainer), outerScrollContainer); }, 750);
                else
                    setTimeout(function() { scrollDown(0, outerScrollContainer); }, 750);     
                
            }
            else
            {
                storyContainer.classList.add("hide")
                openEndings(true);
            }
            
        });

        setupMute()
        setupShake()
        setupDimmable()
        setupVolume()
        setupEndings()
        setupScroll()
    }

    function setupEndings()
    {
        try {         
            if (EndingsAchieved) {
                if (typeof(EndingsAchieved) == "string")
                    EndingsAchieved = JSON.parse(EndingsAchieved);

                for (let i = 0; i < EndingsList.length; i++) {
                    
                    EndingsList[i].achieved = EndingsAchieved[i];
                    
                }
            }
            else
            {
                EndingsAchieved = [false, false, false, false, false, false, false, false, false, false]
                window.localStorage.setItem('save-endings', JSON.stringify(EndingsAchieved))   
            }
        } catch (e) {
            console.log(e);
        }

        let children = document.getElementById("Endings Menu").querySelectorAll("div");
        if (children)
        {
            for (let i = 1; i < children.length; i++) {
                if (EndingsList[i-1].achieved)
                    children[i].innerHTML = `${EndingsList[i-1].type} Ending: ${EndingsList[i-1].name}<br>${EndingsList[i-1].description}`
                else
                    children[i].innerHTML = "Hidden Ending"
            }
        }
        

    }

    function setupVolume()
    {
        let element = document.getElementById("Volume_Button");

        try {            
            if (volume) {
                element.value = volume
                document.getElementById("rangeValue").innerHTML = volume;
            }
        } catch (e) {
            console.debug("Couldn't load save state");
        }

        element.addEventListener("change", function(event) {
            let value = element.value;
            window.localStorage.setItem('save-volume', value);
            volume = window.localStorage.getItem('save-volume')

            onVolumeChange();
        });
    }

    function setupMute()
    {
        let element = document.getElementById("Mute_Button");

        console.log(typeof(mute))
        try {
            if (typeof(mute) === "string") {
                element.setAttribute("status", mute)
                element.innerHTML = (mute === "false") ? "Audio not Muted" : "Audio Muted"

            }
            else
            {
                element.setAttribute("status", false)
                window.localStorage.setItem('save-mute', element.getAttribute("status"));
            }
        } catch (e) {
            console.debug("Couldn't load save state");
        }

        element.addEventListener("click", function(event) {

            var status = (element.getAttribute("status") === "true")
            if (!status)
            {
                element.setAttribute("status", true)
                element.innerHTML = "Audio Muted"
            }
            else
            {
                element.setAttribute("status", false)
                
                element.innerHTML = "Audio not Muted"
            }
            
            window.localStorage.setItem('save-mute', element.getAttribute("status"));
            mute = window.localStorage.getItem('save-mute')
            onVolumeChange()  
        });
    }

    function onVolumeChange()
    {
        if (mute === "true")        
            for (const [key] of Object.entries(AudioList))
            {
                AudioList[key].volume = 0;
            }
        
        else
            for (const [key] of Object.entries(AudioList))
            {
                let newVolume = parseInt(volume) / 100;
                AudioList[key].volume = newVolume;
            }
    }

    function setupScroll()
    {
        let element = document.getElementById("Scroll_Button");

        try {
            if (typeof(scroll) === "string") {
                element.setAttribute("status", scroll)
                element.innerHTML = (scroll === "false") ? "Auto Scroll Page: OFF" : "Auto Scroll Page: ON"

        }
        } catch (e) {
            console.debug("Couldn't load save state");
        }

        element.addEventListener("click", function(event) {
            var status = (element.getAttribute("status") === "true")
            if (!status)
            {
                element.setAttribute("status", true)
                element.innerHTML = "Auto Scroll Page: ON"
            }
            else
            {
                element.setAttribute("status", false)
                element.innerHTML = "Auto Scroll Page: OFF"
            }
            
            window.localStorage.setItem('save-scroll', element.getAttribute("status")); 
            scroll = window.localStorage.getItem('save-scroll')    
        });
    }



    function setupShake()
    {
        let element = document.getElementById("Shake_Button");

        try {
            if (typeof(shake) === "string") {
                element.setAttribute("status", shake)
                element.innerHTML = (shake === "false") ? "Text Shake: OFF" : "Text Shake: ON"

        }
        } catch (e) {
            console.debug("Couldn't load save state");
        }

        element.addEventListener("click", function(event) {
            var status = (element.getAttribute("status") === "true")
            if (!status)
            {
                element.setAttribute("status", true)
                element.innerHTML = "Text Shake: ON"
            }
            else
            {
                element.setAttribute("status", false)
                element.innerHTML = "Text Shake: OFF"
            }
            
            window.localStorage.setItem('save-shake', element.getAttribute("status")); 
            shake = window.localStorage.getItem('save-shake')      
        });
    }

    function setupDimmable()
    {
        let element = document.getElementById("Dimmable_Button");

        try {
            if (typeof(dim) === "string") {
                element.setAttribute("status", dim)
                element.innerHTML = (dim === "false") ? "Text Effects: OFF" : "Text Effects: ON"
            }
        } catch (e) {
            console.debug("Couldn't load save state");
        }

        element.addEventListener("click", function(event) {
            var status = (element.getAttribute("status") === "true")
            if (!status)
                {
                    element.setAttribute("status", true)
                    element.innerHTML = "Text Effects: ON"
                }
                else
                {
                    element.setAttribute("status", false)
                    element.innerHTML = "Text Effects: OFF"
                }
            
            window.localStorage.setItem('save-dim', element.getAttribute("status"));
            dim = window.localStorage.getItem('save-dim')    
        });
    }

})(storyContent);
