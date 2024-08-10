(function(storyContent) {

    // Create ink story from the content using inkjs
    var story = new inkjs.Story(storyContent);

    let savePoint = "";
    var nIntervId;
    let textInerval;

    let savedTheme;
    let globalTagTheme;
    let ChoicesID = null;

    //CONTINUE ARROW
    let Continue = document.getElementById("Continue_Arrow")
    let ContinueID = null

    //IMAGES
    let BackgroundImage = document.getElementById("Background Image")

    //INK STORED VARIABLES
    let CurrentImage = "";
    let CurrentProp = "";
    let LoopedAudio = "";
    let hasFlashlight = false;

    //OPTIONS VARIABLES
    let Volume = 100;
    let Mute = false;
    // let Shake = false;
    // let Dim = false;
    let Styling = "";

    //FOR CLICKING CHOICES AS BOXES
    let WhereGO = false;    

    //HISTORY VARIABLE
    let history = window.localStorage.getItem('save-history') == null ? "" : window.localStorage.getItem('save-history')

    //HUGE LIST OF AUDIO OBJECTS FOR ALL OUR AUDIO
    let bus_ambience = new Audio('./Audio/bus_ambience.ogg')
    let office_ambience = new Audio('./Audio/office_ambience.ogg')
    let bang_confessional = new Audio('./Audio/bang_confessional.ogg')
    let bang_normal = new Audio('./Audio/bang_normal.ogg')
    let bang_short = new Audio('./Audio/bang_short.ogg')
    let meow = new Audio('./Audio/meow.ogg')
    let crowbar_break = new Audio('./Audio/crowbar_break.ogg')
    let curtain = new Audio('./Audio/curtain.ogg')
    let door_slam = new Audio('./Audio/door_slam.ogg')
    let door_thud = new Audio('./Audio/door_thud.ogg')
    let email_ding = new Audio('./Audio/email_ding.ogg')
    let flashlight_off = new Audio('./Audio/flashlight_off.ogg')
    let flashlight_on = new Audio('./Audio/flashlight_on.ogg')
    let footsteps_player = new Audio('./Audio/footsteps_player.ogg')
    let footsteps_child_grass = new Audio('./Audio/footsteps_child_grass.ogg')
    let footsteps_scary = new Audio('./Audio/footsteps_scary.ogg')
    let footsteps_squishy = new Audio('./Audio/footsteps_squishy.ogg')
    let gate_close = new Audio('./Audio/gate_close.ogg')
    let gate_open = new Audio('./Audio/gate_open.ogg')
    let groaning_angry = new Audio('./Audio/groaning_angry.ogg')
    let groaning_happy = new Audio('./Audio/groaning_happy.ogg')
    let groaning_normal = new Audio('./Audio/groaning_normal.ogg')
    let honk = new Audio('./Audio/honk.ogg')
    let key_plop = new Audio('./Audio/key_plop.ogg')
    let knocking = new Audio('./Audio/knocking.ogg')
    let leak = new Audio('./Audio/leak.ogg')
    let lock_rattle = new Audio('./Audio/lock_rattle.ogg')
    let running_pavement = new Audio('./Audio/running_pavement.ogg')
    let scanner = new Audio('./Audio/scanner.ogg')
    let screeching = new Audio('./Audio/screeching.ogg')
    let screw_fall_1 = new Audio('./Audio/screw_fall_1.ogg')
    let screw_fall_2 = new Audio('./Audio/screw_fall_2.ogg')
    let walking_wast_pavement = new Audio('./Audio/walking_wast_pavement.ogg')

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
        "door_thud" : door_thud,
        "email_dings" : email_ding,
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
        "key_plop" : key_plop,
        "knocking" : knocking,
        "leak" : leak,
        "lock_rattle" : lock_rattle,
        "running_pavement" : running_pavement,
        "scanner" : scanner,
        "screeching" : screeching,
        "screw_fall_1" : screw_fall_1,
        "screw_fall_2" : screw_fall_2,
        "walking_fast_pavement" : walking_wast_pavement
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
    let StoryCheckpoint = window.localStorage.getItem('save-checkpoint')
    

    var storyContainer = document.querySelector('#story');
    var optionsContainer = document.getElementById('Options Menu');
    var endingsContainer = document.getElementById('Endings Menu');
    var historyContainer = document.getElementById('History Menu');
    var checkpointsContainer = document.getElementById('Checkpoints Menu');
    
    //Main Contatiner that holds past text
    var pastTextContainer;
    
    var textContainer = document.createElement('div')
    storyContainer.appendChild(textContainer);

    var footer = document.getElementById("Flashlight_Button")
    footer.setAttribute("status", "off")

    var outerScrollContainer = document.querySelector('.outerContainer');

    let paragraphText = "";
    var replaceParagraph = null; //box that holds all current text
    var replace_text = ""
    let DelayNextText = 0;
    let CyclingText = null;
    let paragraphElement = null;


    //BEFORE starting the game, ceck for any save data
    CheckSave();

    // page features setup
    setupButtons();
    setUpFooter();

    // Kick off the start of the story!
    
    function SetSaveGame()
    {
        savePoint = story.state.toJson();
        window.localStorage.setItem('save-state', savePoint);   
    }

    function GetSaveGame()
    {
        return window.localStorage.getItem('save-state');
    } 

    function CheckSave()
    {

        if (loadSavePoint())
        {
            savePoint = GetSaveGame();
            // story.state.LoadJson(savePoint)

            //set ink side variables            
            CurrentImage = story.variablesState["CurrentImage"] + "";
            CurrentProp = story.variablesState["CurrentProp"] + "";
            LoopedAudio = story.variablesState["LoopedAudio"] + "";
            hasFlashlight = (story.variablesState["haveFlashlight"] === "true")


            //OPTIONS VARIABLES
            Volume = Number(story.variablesState["Volume"]);
            Mute = (story.variablesState["Mute"].toString() === "true");
            // Shake = (story.variablesState["Shake"].toString() === "true");
            // Dim = (story.variablesState["Dim"].toString() === "true");
            Styling = story.variablesState["Styling"] + "";




            if (!Styling)
            {
                Styling = ""
                story.variablesState["Styling"] = Styling;
            }

            continueStory(1, 500);

        }            
        else
            continueStory(0, 500);
        

    }

    // Main story processing function. Each time this is called it generates
    // all the next content up as far as the next set of choices.
    //first time: 0 == no save, 1 == has save, 2 == has save, reload
    function continueStory(firstTime, delta) {
        var delay = delta;
        DelayNextText = 0;
        replace_text = "";
        CyclingText = null;
        var AudioArray = []

        if  (firstTime == 0)
        {
            console.log("new save")
            SetSaveGame();
        }        

        // Generate story text - loop through available content
        if(story.canContinue) {
            //save on every canContinue

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

                //CHECKPOINT: index, name
                if (splitTag && splitTag.property == "CHECKPOINT") {
                    var temp = {name: "Locked",
                        point: ""}
                    var checkpoint_list = [temp, temp, temp, temp, temp, temp, temp, temp]
                    
                    if (!StoryCheckpoint)
                        StoryCheckpoint = checkpoint_list;

                    array = splitTag.val.split(", ")
                    var temp_save = story.state.toJson();
                    var temp_object = { 
                        name: array[1],
                        index: array[0],
                        point: temp_save
                    }
                    StoryCheckpoint[array[0] - 1] = temp_object
                    StoryCheckpoint = JSON.stringify(StoryCheckpoint);
                    window.localStorage.setItem('save-checkpoint', StoryCheckpoint)

                    setupCheckpoints();
                }
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

                if( splitTag && (splitTag.property == "PLAY" || splitTag.property == "STOP")) {
                    console.log(splitTag)
                    AudioArray.push(splitTag);
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

                //ZOOM: [transform], [clip-path] ((this assumes BG image ONLY))
                if (splitTag && splitTag.property == "ZOOM") {
                    var list = splitTag.val.split('|')
                    var transfrom = list[0];
                    var clip = list[1];

                    ZoomImage(transfrom, clip);
                }
                //ICLASS: elementID, [classes to remove], [classese to add]
                if (splitTag && splitTag.property == "ICLASS") {
                    var list = splitTag.val.split('|')
                    var element = document.getElementById(list[0])

                    if (list[1] !== "")
                        element.classList.remove(list[1])

                    if (list[2] !== "")
                        element.classList.add(list[2])
                       
                }

                // IMAGE: src
                if( splitTag && splitTag.property == "IMAGE" ) {
                    story.variablesState["CurrentImage"] = splitTag.val;
                    
                    FadeImage(splitTag.val)
                }

                if( splitTag && splitTag.property == "PROP" ) {
                    var array = splitTag.val.split(", ")
                                        
                    FadeProp(array[0], array[1])
                }

                if( splitTag && splitTag.property == "EFFECT" ) {
                    if (splitTag.val === "main_area")
                    {
                        WhereGO = true;
                    }                    
                    else if (splitTag.val === "FlashBeam")
                    {
                        var element = document.getElementById("flash beam")

                        if (element.classList.contains("hide"))
                        {
                            element.classList.remove("hide")
                        }
                        else
                        {
                            element.classList.add("hide")
                        }
                    }
                    else if (splitTag.val.includes("flashlight"))
                    {
                        if (story.variablesState["haveFlashlight"].toString() === "true")
                        {
                            if (footer.classList.contains("hide"))
                                footer.classList.remove("hide")

                            if (splitTag.val === "flashlight-on" || footer.getAttribute("status") == "off")
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
                        else
                        {
                            footer.innerHTML = "Turn on"
                            document.getElementById("flashlight").style.display = "none"
                            footer.classList.add("hide")
                            footer.setAttribute("status", "off")
                        }                        
                    }
                }

                // LINK: url
                if( splitTag && splitTag.property == "LINK" ) {
                    window.location.href = splitTag.val;
                }

                // LINKOPEN: url
                if( splitTag && splitTag.property == "LINKOPEN" ) {
                    window.open(splitTag.val);
                }

                // BACKGROUND: src
                if( splitTag && splitTag.property == "BACKGROUND" ) {
                    outerScrollContainer.style.backgroundImage = 'url('+splitTag.val+')';
                }

                // REMOVE: class
                // Effects the text box specifically
                if( paragraphElement && splitTag && splitTag.property == "REMOVE" ) {
                        paragraphElement.classList.remove(splitTag.val);
                        if (Styling.includes(splitTag.val))
                            var index = Styling.indexOf(splitTag.val)
                            Styling = Styling.substring(0, index - 1) + Styling.substring(splitTag.val.length + index)
                            story.variablesState["Styling"] = Styling

                    }

                // TEXTBOX: class
                // Effects the text box specifically
                if( paragraphElement && splitTag && splitTag.property == "TEXTBOX" ) {
                    paragraphElement.classList.add(splitTag.val);
                    Styling += splitTag.val + " "
                    story.variablesState["Styling"] = Styling;

                    if (splitTag.val === "text_container_Dark")
                        document.getElementById("Overlay").classList.remove("hide")
                    else if (splitTag.val === "text_container_UsedTo" || splitTag.val === "text_container_After")
                        document.getElementById("Overlay").classList.remove("hide")
                        document.getElementById("Overlay").classList.add("img_used")
                }

                // CLASS: className
                // Effects the text
                if( splitTag && splitTag.property == "CLASS" ) {
                        customClasses.push(splitTag.val);
                }

                // CLEAR - removes all existing content.
                // RESTART - clears everything and restarts the story from the beginning
                if( tag == "RESTART" ) {
                    restart();
                    return;
                }
            }

            if (!paragraphElement || firstTime > -1)
            {       
                console.log("creating text box")
                //creating the current text box
                paragraphElement = CreateTextBox(paragraphText, customClasses);
                scrollPage(delay, paragraphElement, false);

                //if we are not staring at the begninngin or at a place with choices
                if (story.currentChoices.length <= 0 && firstTime < 0)
                {
                    paragraphElement.addEventListener("click", OnClickEvent);
                    paragraphElement.setAttribute("click_listener", "true")
                }
            }
            else 
            {
                let childElement = paragraphElement.querySelectorAll("p")[0]
                //if our last line didn't have the click listener, read our click listener
                if (paragraphElement.getAttribute("click_listener") == "false"){
                    paragraphElement.addEventListener("click", OnClickEvent);
                    paragraphElement.setAttribute("click_listener", "true")
                }
                
                displayText(paragraphText, childElement, customClasses, delay);
                scrollPage(delay, paragraphElement, true);
            }

            //we are delayed, after our delay add the new text and remove the click listener
            if (DelayNextText > 0)
            {
                paragraphElement.setAttribute("click_listener", "false")
                paragraphElement.removeEventListener("click", OnClickEvent);
                setTimeout(function() { 
                    history += "<br><br>" + paragraphText;
                    window.localStorage.setItem('save-history', history)
                    deleteAfter(paragraphElement.querySelectorAll("p")[0]);
                
                }, DelayNextText);                    
            }

            if (replace_text != "") ClickReplaceText(paragraphElement);

            for (var ii = 0; ii < AudioArray.length; ii++)
            {
                var splitTag = AudioArray[ii];
                // PLAY: src (assumes no looping, fade in or out)
                // PLAY: src, loop, fade in
                // PLAY: src, loop, fade in, delay
                if( splitTag && splitTag.property == "PLAY" ) {
                    
                    // Check if we need to delay or fade in the audio
                    var array;
                    var sound = splitTag.val;
                    var fade = 0;
                    var delay = 500;
                    var loop = false;

                    if (splitTag.val.includes(", ")) // if there are any parameters, use all of them
                    {
                        array = splitTag.val.split(", ")

                        sound = array[0];
                        loop = (array[1] === "true")                     
                        fade = (array.length > 2) ? 30 / (array[2] * 1000): 0;
                        delay  = (array.length > 3) ? (array[3] * 1000) : 500     
                    }

                    if (AudioList[sound])
                        PlayAudio (AudioList[sound], loop, fade, delay);   
                }

                // STOP: src
                // STOP: src, fade out
                // STOP: src, fade out, delay
                else if( splitTag && splitTag.property == "STOP" ) {
                    // Check if we need to delay or fade in the audio
                    var array;
                    var sound = splitTag.val;
                    var fade = 0;
                    var delay = 0;

                    if (splitTag.val.includes(", ")) // if there are any parameters, use all of them
                    {
                        array = splitTag.val.split(", ")

                        sound = array[0];
                        fade = (parseFloat(array[1]) <= 0) ? 0: 30 / (array[1] * 1000);                        
                        delay  = (array.length > 2) ? array[2] * 1000 : 0     
                    }

                    StopAudio (AudioList[sound], fade, delay);                   
                }
            }
        }


        //if there are no choices and no text qued to be delayed, do click stuffs
        if (story.currentChoices.length > 0)
        {
            if (WhereGO)
            {
                var places = document.getElementById("Main Room").children
                story.currentChoices.forEach(function(choice) {
                    for (var ii = 0; ii <= places.length - 1; ii++)
                    {
                        if (choice.text == places[ii].children[0].id)
                        {
                            places[ii].addEventListener("click", function (event){
                                event.preventDefault();

                                //turn eveyone off
                                for (var ii = 0; ii <= places.length - 1; ii++)
                                {
                                    if (!places[ii].classList.contains("hide"))
                                        places[ii].classList.add("hide")
                                }

                                // Tell the story where to go next
                                story.ChooseChoiceIndex(choice.index);

                                // This is where the save button will save from
                                
                                SetSaveGame();

                                history += "<br><br>" + paragraphText;
                                window.localStorage.setItem('save-history', history)

                                WhereGO = false;
                                deleteAfter(paragraphElement.querySelectorAll("p")[0]);
                            });

                            places[ii].classList.remove("hide");
                        }
                    }
                });
            }
            else
            {
                delay = 1500
            if (DelayNextText > 0)
                delay += DelayNextText

            if (ChoicesID == null)
                ChoicesID = setTimeout(function() { CreateChoices(firstTime); }, delay);
            }
            
        }

        // SetSaveGame();
    }

    function FadeImage(src)
    {
        var temp = BackgroundImage.src
        if (temp.includes(src) || !BackgroundImage)
            return;

        CurrentImage = src;
        story.variablesState["CurrentImage"] = CurrentImage
        console.log(CurrentImage)

        BackgroundImage.style.opacity = 0;

        setTimeout(function () {
            BackgroundImage.style.opacity = 1;
            BackgroundImage.style.visibility='visible'
            BackgroundImage.src = `./Images/Backgrounds/${src}.png`;
        } , 501);
             
    }

    function FadeProp(src, isOn)
    {
        var element = document.getElementById(src)

        if (!element)
            return;

        if (isOn === "true")
        {
            
            story.variablesState["CurrentProp"] = (story.variablesState["CurrentProp"].includes(" ")) ? "" : story.variablesState["CurrentProp"].replace(src, "");           
            
            element.style.opacity = 0;
            return
        }
        else 
        {
            if (element.classList.contains("hide"))
                element.classList.remove("hide")
            prob = src;
            element.style.opacity = 1; 

            story.variablesState["CurrentProp"] = (story.variablesState["CurrentProp"] === "") ? src : story.variablesState["CurrentProp"] + " " + src;
        }       

        CurrentProp = story.variablesState["CurrentProp"];   
    }

    function ZoomImage(transform, clip) {
        BackgroundImage.style.transform = transform;
        BackgroundImage.style.clipPath = clip;
    }

    async function PlayAudio(audio, loop, fade, delay)
    {
        console.log("play audio")
        if (audio)
        {
            setTimeout(async function() { 
                if (loop)
                {
                    var index = audio.src.lastIndexOf('/')
                    var end = audio.src.lastIndexOf('.')
                    console.log(audio.src.substring(index, end))
                    story.variablesState["LoopedAudio"] = (audio.src.substring(index + 1, end))
                    audio.loop = true;
                    audio.addEventListener("ended", function(){
                        audio.currentTime = 0;
                        audio.play();                        
                    })
                }
                else
                {
                    audio.loop = false;
                    audio.addEventListener("ended", function(){
                        //do nothing
                    })
                }
                    
                if (fade > 0)
                {  
                    audio.volume = 0
                    nIntervId = setInterval(fadeIn, 30, audio, fade);
                }

                try {
                    await audio.play();
                  } catch (error) {
                    audio.pause();
                    console.log(error)
                  }
                
            }, delay);
        }
        else
            console.error("Audio Error. Could not find: " + audio)
    }

    function StopAudio(audio, fade, delay)
    {
        if (audio)
        {
            if (audio.src == story.variablesState["LoopedAudio"])
                story.variablesState["LoopedAudio"] = null
            setTimeout(function() {
                if (fade > 0)
                {
                    audio.volume = parseInt(Volume) / 100;
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
        var currentVolume = parseInt(Volume) / 100
	    if((audio.volume < (currentVolume)) && (audio.volume + delta < 1)){
   		    audio.volume += delta;
        }
        else{
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

        clearTimeout(ContinueID);

        //add the current text to the big if that contatiner exists
        if (document.getElementById('Current_Text'))
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

            if (paragraphElement != null)
            {
                history += "<br><br>" + paragraphText;
                window.localStorage.setItem('save-history', history)
            }
            
            
            SetSaveGame();      
            deleteAfter(paragraphElement.querySelectorAll("p")[0]);
        }
        else continueStory(-1, 500)
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
            deleteAfter(paragraphElement.querySelectorAll("p")[0]);
        }
        else continueStory(-1, 500)

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
        
        SetSaveGame();

        replaceParagraph.removeEventListener("click", OnChoiceReplaceEvent, true);

        replaceParagraph = null;
        ChoicesID = null;

        // Aaand loop
        continueStory(-1, 5);
    }

    function CreateChoices(firstTime)
    {
        
        // Create HTML choices from ink choices
        for (let ii = 0; ii < story.currentChoices.length; ii++) {

            var choice = story.currentChoices[ii];

            if (choice.text == replace_text)
                return;

            // check if this is click replace text
            let isReplaceChoiceText = ""

            let choice_text = choice.text
            let choice_index = choice.index

            if (firstTime == 1 && ii == 1 && loadSavePoint())
                choice_text = "Continue"

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
            choiceParagraphElement.innerHTML = `<a href='#'>${choice_text}</a>`            
            storyContainer.appendChild(choiceParagraphElement);

            // scroll after the choices are visible
            scrollPage(200, choiceParagraphElement, true);
            // Click on choice
            var choiceAnchorEl = choiceParagraphElement.querySelectorAll("a")[0];

            if (isReplaceChoiceText != "")
            {
                choiceParagraphElement.setAttribute("replace_text", isReplaceChoiceText)
                choiceAnchorEl.addEventListener("click", function(event) {                   

                    ClickReplaceChoiceText(choiceParagraphElement, choice.index, isReplaceChoiceText)
                });

                return;
            }

            if (firstTime == 1 && ii == 1 && loadSavePoint())
            {
                choiceAnchorEl.addEventListener("click", async function(event) {

                    // Don't follow <a> link
                    event.preventDefault();

                    // Remove all existing choices
                    removeAll(".choice");

                    //flashlight
                    if (hasFlashlight)
                    {
                        if (footer.classList.contains("hide"))
                            footer.classList.remove("hide")

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

                    history += paragraphText;
                    window.localStorage.setItem('save-history', history)

                    ChoicesID = null;

                    // Tell the story where to go next
                    story.state.LoadJson(savePoint);
                    paragraphElement = null;
                });
                
                
                

                //reset so it loops properly
                firstTime = 0;
                ii = 0;
            }
            else
            {
                choiceAnchorEl.addEventListener("click", async function(event) {

                        // Don't follow <a> link
                        event.preventDefault();
    
                        // Remove all existing choices
                        removeAll(".choice");
    
                        // Tell the story where to go next
                        story.ChooseChoiceIndex(choice_index);
    
                        // This is where the save button will save from
                        
                        SetSaveGame();
    
                        if (replaceParagraph)
                        {
                            replaceParagraph.removeEventListener("click", OnChoiceReplaceEvent, true);
    
                            replaceParagraph = null;
                        }
    
                        if (choice_text != "Start Game")
                        {
                            history += "<br><br>" + paragraphText;
                            history += "<br><br>" + choice_text;
                            window.localStorage.setItem('save-history', history)
    
                            deleteAfter(paragraphElement.querySelectorAll("p")[0]);
                        }
                        else 
                        {
                            history += paragraphText;
                            window.localStorage.setItem('save-history', history)
                            continueStory(-1, 500)
                        }
    
                        ChoicesID = null;
                    });
            }
        }
    }

    function ClickReplaceChoiceText(element, index, replaceText)
    {
        element.innerHTML = `<a href='#'>${replaceText}</a>`

        var el = element.querySelectorAll("a")[0];
        el.addEventListener("click", async function(event) {

            // Don't follow <a> link
            event.preventDefault();

            // Remove all existing choices
            removeAll(".choice");
            ChoicesID = null;

            // Tell the story where to go next
            story.ChooseChoiceIndex(index);

            // This is where the save button will save from
            
            SetSaveGame();

            //continue
            if (pastTextContainer != null)
                {
                    pastTextContainer.firstChild.innerHTML += "<br><br>" + paragraphText;
                    deleteAfter(paragraphElement.querySelectorAll("p")[0]);
                }
            else continueStory(-1, 500)
        });
    }

    function CreateTextBox(text, customClasses)
    {
        // Create paragraph element (initially hidden)
        var paraElement = document.getElementById("Current_Text");
        var textElement = paraElement.querySelectorAll("p")[0];

        if (!textElement)
        {
            textElement = document.createElement('p')
            textElement.style = "user-select:none;"
            paraElement.insertBefore(textElement, paraElement.firstChild)
        }

        if (Styling !== "")
        {
            var split = Styling.split(" ")
            split.forEach(element => {
                if (element != "")
                    paraElement.classList.add(element);
            });
            
            if (Styling.includes("text_container_Dark"))
                document.getElementById("Overlay").classList.remove("hide")
            else if (Styling.includes("text_container_UsedTo") || Styling.includes("text_container_After"))
                document.getElementById("Overlay").classList.remove("hide")
                document.getElementById("Overlay").classList.add("img_used")
        }
            

        displayText(text, textElement, customClasses, 500);     
        setTimeout(function () {  paraElement.classList.remove("fadeIn") } , 1000);   

        return paraElement;
    }

    function restart() {
        setVisible(".header", true);

        OnRestartOrLoad();
        pastTextContainer = null;     

        story.ResetState();

        // set save point to here
         
        window.localStorage.setItem('save-state', null);  

        continueStory(0, 500);

        outerScrollContainer.scrollTo(0, 0);
    }

    function OnRestartOrLoad()
    {
        history = "";
        window.localStorage.setItem('save-history', history)

        Styling = "";
        story.variablesState["Styling"] = ""
        ZoomImage("unset", "unset")
        document.getElementById("Background Image").className = ""

        hasFlashlight = false;
        story.variablesState["haveFlashlight"] = false

        var temp = {name: "Locked",
            point: ""}
        var checkpoint_list = [temp, temp, temp, temp, temp, temp, temp, temp]
        StoryCheckpoint = checkpoint_list;

        StoryCheckpoint = JSON.stringify(StoryCheckpoint);
        window.localStorage.setItem('save-checkpoint', StoryCheckpoint)
        setupCheckpoints();

        EndingsAchieved = "";
        window.localStorage.setItem('save-endings', EndingsAchieved)

        footer.innerHTML = "Turn on"
        document.getElementById("flashlight").style.display = "none"
        footer.classList.add("hide")
        footer.setAttribute("status", "off")
        document.getElementById("Overlay").classList.add("hide")

        if (!document.getElementById("flash beam").classList.contains("hide"))
        {
            document.getElementById("flash beam").classList.add("hide")
        }

        if (paragraphElement)
            paragraphElement.classList.remove("text_container_Dark", "text_container_UsedTo", "text_container_After")

        FadeImage("Default")
        if (CurrentProp.includes(" "))
        {
            var array = CurrentProp.split(" ")
            array.forEach(index => FadeProp(index, "true"))
        }
        else
            FadeProp(CurrentProp, "true")
    
        removeAll(".choice");
        ChoicesID = null;

         //turn eveyone off
         var places = document.getElementById("Main Room").children
         for (var ii = 0; ii <= places.length - 1; ii++)
         {
            if (!places[ii].classList.contains("hide"))
                places[ii].classList.add("hide")
         }

        
        openOptions(false);
        openHistory(false);
        openEndings(false);
        openCheckpoints(false);
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
        const flash = document.getElementById("flashlight");
        
        flash.style.setProperty( '--cursorXPos', `${event.pageX}px`);
        flash.style.setProperty( '--cursorYPos', `${event.pageY}px`);
    }

    function displayText (text, el, customClasses, delay) {
        el.classList.add("hide")
        el.classList.remove("fadeInBottom"); 
        el.classList.remove("fadeOut"); 

        Continue.classList.add("hidden")
        Continue.classList.remove("fadeOut")

        el.innerHTML = text;


        setTimeout(function() {

            if (customClasses.length > 0)
            {
                for(var i=0; i<customClasses.length; i++)
                    el.classList.add(customClasses[i]);
            }
            else
               el.classList.add("fadeInBottom"); 

            el.classList.remove("hide");

            if (CyclingText)
            {
                let cycle = el.querySelectorAll("a")[0];
                cycle.addEventListener("click", OnClickCycle );
                cycle.addEventListener("mouseleave", AfterClickCycle );
            }           

        }, delay);

        if (customClasses.length <= 0)
            setTimeout(function () {  el.classList.remove("fadeInBottom") } , delay + 1000);

        if (story.currentChoices.length <= 0 && DelayNextText <= 0)
            ContinueID = setTimeout(function () { Continue.classList.add("fadeInBottom"); Continue.classList.remove("hidden") } , 2550);
    }

    async function deleteAfter (el) {
        el.classList.add("fadeOut")

        if (!Continue.classList.contains("hidden"))
        {
            Continue.classList.remove("fadeInBottom")
            Continue.classList.add("fadeOut")
        }

        setTimeout(function() {         
            if (el.classList)
                el.removeAttribute("class")
            continueStory(-1, 500);
        }, 275);
    }

    // Fades in an element after a specified delay
    function scrollPage(delay, el, isChoice) {
        if (!isChoice)
            setTimeout(function() { textContainer.appendChild(el); }, delay);
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
            let savedState = GetSaveGame();
            if (savedState !== "null" && savedState) {
                return true;
            }
        } catch (e) {
            console.debug("Couldn't load save state");
        }
        return false;
    }

    function openOptions(visible)
    {
        if (visible)
        {
            optionsContainer.classList.remove("hidden");
            endingsContainer.classList.add("hidden");
            historyContainer.classList.add("hidden");
            checkpointsContainer.classList.add("hidden");
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
            historyContainer.classList.add("hidden");
            checkpointsContainer.classList.add("hidden");
        }
        else
            endingsContainer.classList.add("hidden");
    }

    function openCheckpoints(visible)
    {
        if (visible)
        {
            checkpointsContainer.classList.remove("hidden");
            optionsContainer.classList.add("hidden");
            historyContainer.classList.add("hidden");
            endingsContainer.classList.add("hidden");            
        }
        else
            checkpointsContainer.classList.add("hidden");
    }

    function openHistory(visible)
    {
        if (visible)
        {
            historyContainer.classList.remove("hidden");
            optionsContainer.classList.add("hidden");
            endingsContainer.classList.add("hidden");
            checkpointsContainer.classList.add("hidden");

            document.getElementById("All_Text").innerHTML = history
            historyContainer.scrollTop = historyContainer.scrollHeight;
        }
        else
            historyContainer.classList.add("hidden");
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
            }
            else
            {
                storyContainer.classList.add("hide")
                openEndings(true);
            }
            
        });

        let historyEl = document.getElementById("history");

        if (historyEl) historyEl.addEventListener("click", function(event) {
            if (storyContainer.classList.contains("hide") && !historyContainer.classList.contains("hidden"))
            {
                storyContainer.classList.remove("hide")
                openHistory(false);                
            }
            else
            {
                storyContainer.classList.add("hide")
                openHistory(true);
            }
            
        });

        let checkpointEl = document.getElementById("checkpoint");

        if (checkpointEl) checkpointEl.addEventListener("click", function(event) {
            if (storyContainer.classList.contains("hide") && !checkpointsContainer.classList.contains("hidden"))
            {
                storyContainer.classList.remove("hide")
                openCheckpoints(false);                
            }
            else
            {
                storyContainer.classList.add("hide")
                openCheckpoints(true);
            }
            
        });

        setupMute()
        // setupShake()
        // setupDimmable()
        setupVolume()
        setupEndings()
        setupCheckpoints()

        if (CurrentImage && CurrentImage !== "")
            BackgroundImage.src = `./Images/Backgrounds/${CurrentImage}.png`;
        else
            BackgroundImage.src = `./Images/Backgrounds/Default.png`;

        if (CurrentProp && CurrentProp !== "")
            FadeProp(CurrentProp, "false")

        if (LoopedAudio && LoopedAudio !== "")
            PlayAudio (AudioList[LoopedAudio], true, 0, 500);

    }

    function setupCheckpoints()
    {
        try {         
            if (StoryCheckpoint) {
                if (typeof(StoryCheckpoint) == "string")
                {
                    StoryCheckpoint = JSON.parse(StoryCheckpoint);
                    var children = document.getElementById("Checkpoints Menu").querySelectorAll("div");

                    if (children)
                    {
                        for (let i = 1; i < children.length; i++) {
                            if (StoryCheckpoint[i-1].name != "Locked")
                            {
                                children[i].innerHTML = `<a href="#">${StoryCheckpoint[i-1].name}</a>`
                                var point = children[i].querySelectorAll("a")[0];
                                var storyPoint = StoryCheckpoint[i-1];
                                point.addEventListener("click", function (event) {
                                    // Don't follow <a> link
                                    event.preventDefault();

                                    //check if we need to kill flashlight or overlay stuffs
                                    if (storyPoint.index <= 1)
                                    {
                                        hasFlashlight = false;
                                        
                                        footer.classList.add("hide")
                                        document.getElementById("Overlay").classList.add("hide")
                                        Styling = "";
                                        story.variablesState["Styling"] = Styling
                                    }
                                    else if (storyPoint.index > 1)
                                    {
                                        document.getElementById("Overlay").classList.remove("hide")
                                        document.getElementById("Overlay").classList.add("img_used")

                                        paragraphElement.classList.add("text_container_After");
                                        Styling += "text_container_After"
                                        story.variablesState["Styling"] = Styling
                                    }


                                    //flick off any flashlight stuffs
                                    footer.innerHTML = "Turn on"
                                    footer.setAttribute("status", "off")
                                    document.getElementById("flashlight").style.display = "none"

                                    // Remove all existing choices
                                    removeAll(".choice");

                                    //load save point and continue
                                    story.state.LoadJson(storyPoint.point)
                                    window.localStorage.setItem('save-state', storyPoint.point);   
                                    paragraphElement = null;
                                    continueStory(-1, 500);
                                })
                            }                                
                            else
                                children[i].innerHTML = "Locked"
                        }
                    } 
                }
            }
            
        } catch (e) {
            console.log(e);
        }      
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
            if (Volume) {
                element.value = Volume
                document.getElementById("rangeValue").innerHTML = Volume;
            }
        } catch (e) {
            console.debug("Couldn't load save state");
        }

        element.addEventListener("change", function(event) {
            let value = element.value;
            Volume = value;
            story.variablesState["Volume"] = Volume;

            onVolumeChange(false);
        });
    }

    function setupMute()
    {
        let element = document.getElementById("Mute_Button");

        try {
            element.setAttribute("status", Mute)
            element.innerHTML = (!Mute) ? "Audio not Muted" : "Audio Muted"

            
        } catch (e) {
            console.debug("Couldn't load save state");
        }

        element.addEventListener("click", function(event) {

            var status = (element.getAttribute("status") === "true")
            if (!status)
            {
                element.setAttribute("status", true)
                element.innerHTML = "Audio Muted"
                Mute = true;
            }
            else
            {
                element.setAttribute("status", false)
                
                element.innerHTML = "Audio not Muted"
                Mute = false;
            }
            
            story.variablesState["Mute"] = element.getAttribute("status")
            onVolumeChange(true)              
        });
    }

    function onVolumeChange(isMuting)
    {
        if (Mute === true || Mute === "true")        
            for (const [key] of Object.entries(AudioList))
            {
                AudioList[key].volume = 0;
            }
        
        else
            for (const [key] of Object.entries(AudioList))
            {
                let newVolume = parseInt(Volume) / 100;
                AudioList[key].volume = newVolume;                
            }
            
            if (isMuting === false)
            {
                meow.pause();
                meow.currentTime = 0;
                meow.play();
            }
                
        
        SetSaveGame()
    }

    // function setupShake()
    // {
    //     let element = document.getElementById("Shake_Button");

    //     try {
    //         element.setAttribute("status", Shake)
    //         element.innerHTML = (!Shake) ? "Text Shake: OFF" : "Text Shake: ON"

    //     } catch (e) {
    //         console.debug("Couldn't load save state");
    //     }

    //     element.addEventListener("click", function(event) {
    //         var status = (element.getAttribute("status") === "true")
    //         if (!status)
    //         {
    //             element.setAttribute("status", true)
    //             element.innerHTML = "Text Shake: ON"
    //         }
    //         else
    //         {
    //             element.setAttribute("status", false)
    //             element.innerHTML = "Text Shake: OFF"
    //         }
            
    //         story.variablesState["Shake"] = element.getAttribute("status") 
    //         Shake = (story.variablesState["Shake"] === "true")      
    //     });
    // }

    // function setupDimmable()
    // {
    //     let element = document.getElementById("Dimmable_Button");

    //     try {
    //         element.setAttribute("status", Dim)
    //         element.innerHTML = (!Dim) ? "Text Effects: OFF" : "Text Effects: ON"
    //     } catch (e) {
    //         console.debug("Couldn't load save state");
    //     }

    //     element.addEventListener("click", function(event) {
    //         var status = (element.getAttribute("status") === "true")
    //         if (!status)
    //             {
    //                 element.setAttribute("status", true)
    //                 element.innerHTML = "Text Effects: ON"
    //             }
    //             else
    //             {
    //                 element.setAttribute("status", false)
    //                 element.innerHTML = "Text Effects: OFF"
    //             }
            
    //         story.variablesState["Dim"] = element.getAttribute("status")
    //         Dim = (story.variablesState["Dim"] === "true")    
    //     });
    // }

})(storyContent);
