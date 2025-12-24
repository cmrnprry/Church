using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using Ink.Runtime;
using TMPro;
using UnityEngine.UI;
using Random = UnityEngine.Random;
using ColorUtility = UnityEngine.ColorUtility;
using DG.Tweening;
using UnityEngine.Rendering.Universal;
using TextAsset = UnityEngine.TextAsset;
using Steamworks;
using UnityEngine.InputSystem;

namespace AYellowpaper.SerializedCollections
{
    public class GameManager : MonoBehaviour
    {
        public static GameManager instance;
        private PlayerActions actions;

        public PlayerActions Actions
        {
            get { return actions; }
        }

        [Header("Ink Data")][SerializeField] private TextAsset InkJsonAsset;
        [HideInInspector] public Story Story { get; private set; }
        private Color text_color;
        private List<string> classes = new List<string>();
        public List<TMP_FontAsset> Fonts = new List<TMP_FontAsset>();
        [SerializeField] private IntrusiveThoughtsManager intrusiveThoughts;
        [SerializeField] private GameObject ClickToContinueButton;
        private bool show_click_continue = false, can_click = false;

        public bool ClickToContinue
        {
            get { return show_click_continue; }
            set
            {
                show_click_continue = value;
                ClickToContinueButton.SetActive(value);
            }
        }

        public bool CanClick
        {
            get { return can_click; }
            set { can_click = value; }
        }

        public void CanClickTextBox(bool value)
        {
            can_click = value;
        }

        private string ContinueText; // next group of text
        private TMProGlobal Current_Textbox; //current textbox
        private float Text_Delay = -1;
        private ReplaceChoice ReplaceData;

        [Header("Text Variables")] private bool texteffects = true;
        private bool visualoverlay = true;

        public bool TextEffects
        {
            get { return texteffects; }
            set
            {
                texteffects = value;
                OnTextEffectFlip?.Invoke(value);
            }
        }

        public bool VisualOverlay
        {
            get { return visualoverlay; }
            set
            {
                visualoverlay = value;
                AllLighting.SetActive(value);
                OnImageEffectFlip?.Invoke(value);
            }
        }

        [Header("Story Objects")]
        [SerializeField]
        private Transform TextParent;

        [SerializeField] private TMProGlobal TextPrefab;
        [SerializeField] private VerticalLayoutGroup ChoiceButtonContainer;
        [SerializeField] private LabledButton ChoiceButtonPrefab;
        [SerializeField] private ScrollRect Scroll;
        [SerializeField] private VerticalLayoutGroup TextContainer;

        [Header("Image Data")]
        [SerializeField] private Animator anim;
        [SerializeField] private Image BackgroundImage;
        [SerializeField] private Transform DefualtImage;
        [SerializeField] private Image FadeMask;
        private BackgroundImage ImageClassData;


        [SerializedDictionary("Background name", "Sprite")]
        public SerializedDictionary<string, Sprite> BackgroundDictionary;

        [SerializedDictionary("Prop name", "Sprite")]
        public SerializedDictionary<string, GameObject> PropDictionary;

        public List<GameObject> clicktomove = new List<GameObject>();


        [Header("Lighting")] public GameObject AllLighting;
        [SerializeField] private Light2D GlobalLight;
        [SerializeField] private Color OutsideLight, DarkLight, UsedToLight, FlashlightOn, FlashlightOff;
        public Toggle Flashlight;

        [SerializedDictionary("Lighting Name", "Light")]
        public SerializedDictionary<string, GameObject> LightingDictionary;

        private Sequence lightingSequence;

        [Header("Auto Play Variables")] private bool autoplay;

        public bool AutoPlay
        {
            get { return autoplay; }
            set { autoplay = value; }
        }

        [Header("Default Variables")]
        private float NextTextDelay = 1.5f; //DEFAULT: N/A    |    AUTOPLAY: Time between two text boxes
        private float ChoiceShowDelay = 0.5f; //DEFAULT && AUTOPLAY: Time for choices to show up
        private float ChunkDelay = 0.5f; //DEFAULT && AUTOPLAY: Time between screen refreshing/deleting previous chunk after clicking choice

        private float AutoScrollDelay = 0.25f; //default time to autoscroll

        [Header("Const Variables")]
        private const float NextText_Delay = 1.5f; //DEFAULT: N/A    |    AUTOPLAY: Time between two text boxes
        private const float ChoiceShow_Delay = 0.5f; //DEFAULT && AUTOPLAY: Time for choices to show up
        private const float Chunk_Delay = 0.5f; //DEFAULT && AUTOPLAY: Time between screen refreshing/deleting previous chunk after clicking choice

        private const float TextCharacter_Delay = 0.035f; //DEFAULT && AUTOPLAY: Time between characters
        private const float TextPunctuation_Delay = 0.5f; //DEFAULT && AUTOPLAY: Delay between punctuation characters

        private const float AutoScroll_Delay = 0.25f; //default time to autoscroll
        private const float DefaultShortWait = 0.1f; //default time between a replace choice fade change
        private bool WaitAfterChoice;

        public float DelayTimings
        {
            get { return Math.Abs(SaveSystem.GetTextSpeed()); }
            set { SetDefaultPlayDelay(Math.Abs(value)); }
        }

        private void SetDefaultPlayDelay(float value)
        {
            float normalized = value;

            NextTextDelay = NextText_Delay * normalized;
            ChoiceShowDelay = ChoiceShow_Delay * normalized;
            ChunkDelay = Chunk_Delay * normalized;
            StaticHelpers.TextCharacterDelay = TextCharacter_Delay * normalized;
            StaticHelpers.TextPunctuationDelay = TextPunctuation_Delay * normalized;
            AutoScrollDelay = AutoScroll_Delay * normalized;
        }

        public delegate void VisualEffects(bool isOn);

        public static event VisualEffects OnTextEffectFlip;
        public static event VisualEffects OnImageEffectFlip;

        public delegate void ClickEffects();

        public static event ClickEffects OnForceBlink;
        public static event ClickEffects OnForceOpen;
        public static event ClickEffects OnForceClosed;

        public delegate void AutoSave();
        public static event AutoSave OnAutoSave;


        private void Awake()
        {
            if (instance == null)
                instance = this;
            else
                Destroy(this.gameObject);

            DontDestroyOnLoad(gameObject);

            Story = new Story(InkJsonAsset.text);

            SaveSystem.Init();
            SaveSystem.SlotInit(BackgroundDictionary, PropDictionary, Story);
            actions = new PlayerActions();
        }

        private void Start()
        {
            text_color = TextPrefab.color;
            text_color.a = 1;
            ReplaceData = new ReplaceChoice("", -1);
            ImageClassData = BackgroundImage.gameObject.GetComponent<BackgroundImage>();
            GlobalLight.color = OutsideLight;

            SaveSystem.SetSettingsOnLoad();

            Story.onError += (msg, type) =>
            {
                if (type == Ink.ErrorType.Warning)
                    Debug.LogWarning(msg);
                else
                    Debug.LogError(msg);
            };

            Story.BindExternalFunction("WinAchievement", (int index) =>
            {
                if (SteamManager.Initialized)
                {
                    SteamUserStats.SetAchievement($"ACHIEVEMENT_{index}");
                }
            });

            Story.BindExternalFunction("Intrusive", (int amount, string text, string jump_to) =>
            {
                StaticHelpers.AddIntrusiveThoughts(amount, text, jump_to, intrusiveThoughts);
                SaveSystem.AddIntrusiveThroughts(amount, text, jump_to);
            });

            Story.BindExternalFunction("ZoomImage", (float zoom, string pos, float dur, float delay) =>
            {
                var list = pos.Split(',');
                var xpos = float.Parse(list[0].Trim());
                var ypos = float.Parse(list[1].Trim());
                Vector2 zoom_pos = new Vector2(xpos, ypos);

                var data = new ZoomData(zoom, zoom_pos, dur, delay);

                ImageClassData.ZoomImage(data);
            });

            Actions.Controls.Autoplay.performed += AutoplayHotkey;
        }

        private void OnEnable()
        {
            SaveSlot.OnSave += SetDataOnSave;
            SaveSystem.OnLoad += GetDataOnLoad;
            actions.Enable();
        }

        private void OnDisable()
        {
            SaveSlot.OnSave -= SetDataOnSave;
            SaveSystem.OnLoad -= GetDataOnLoad;
            Actions.Controls.Autoplay.performed -= AutoplayHotkey;
            actions.Disable();
        }

        private void AutoplayHotkey(InputAction.CallbackContext context)
        {
            bool value = !SaveSystem.GetAutoplayValue();
            SaveSystem.SetAutoplayValue(value);
            AutoPlay = value;
        }

        public void SetTextFlow(bool val)
        {
            TextContainer.reverseArrangement = val;
        }

        private void SetDataOnSave(string ID)
        {
            SaveSystem.SetStory(Story.state.ToJson(), ID);
        }

        private void GetDataOnLoad()
        {
            bool hideChoices = false;
            DeleteOldChoices();
            DeleteOldTextBoxes();
            AudioManager.instance.KillAllAudio();

            foreach (var audio in SaveSystem.GetCurrentAudioPlaying())
            {
                if (audio.type == Audio.BGM)
                {
                    AudioManager.instance.PlayBGM(audio.src, audio.isLooping, audio.fade_in, audio.fade_out);
                }
                else if (audio.type == Audio.SFX)
                {
                    AudioManager.instance.PlaySFX(audio.src, audio.isLooping, audio.fade_in, audio.delay);
                }
            }

            for (int i = 0; i < SaveSystem.GetCurrentTextLength(); i++)
            {
                Current_Textbox = Instantiate(TextPrefab, TextParent, false);
                SavedTextData text_data = SaveSystem.GetCurrentText(i);
                Text_Delay = text_data.delay;

                ContinueText = text_data.text;
                Current_Textbox.text = ContinueText;

                var link = Current_Textbox.gameObject.GetComponent<LinksManager>();

                if (text_data.cycle_text != null && text_data.cycle_text.Length > 0)
                {
                    link.enabled = true;
                    link.SetDataOnLoad(text_data.cycle_text, text_data.cycle_index);
                }

                if (text_data.GetReplaceChoice().hasTextData())
                {
                    link.enabled = true;
                    SetReplaceChoiceData(text_data.GetReplaceChoice().GetText());
                }

                if (text_data.class_text.Length > 0)
                {
                    Current_Textbox.color = text_color;
                    Current_Textbox.text = ContinueText;

                    foreach (var value in text_data.class_text)
                    {
                        Current_Textbox.gameObject.GetComponent<TextObjectEffects>().ApplyClass(value);
                    }
                }

                Current_Textbox.DOColor(text_color, 1.25f);
            }

            Story.state.LoadJson(SaveSystem.GetStory());

            foreach (var story_tag in Story.currentTags)
            {
                if (story_tag.Contains("CLASS"))
                {
                    Scroll.DOVerticalNormalizedPos(1, AutoScrollDelay);
                    Scroll.content.ForceUpdateRectTransforms();
                }

                if (story_tag.Contains("click_move"))
                {
                    ClickToContinue = false;
                    hideChoices = true;
                }

                CycleThroughTags(story_tag.Split(':'));
            }

            if (BackgroundDictionary.ContainsKey(SaveSystem.GetCurrentSpriteKey()))
            {
                var temp = DefualtImage.GetComponentsInChildren<Image>();

                Image[] children = new Image[3];
                children[0] = temp[0];
                children[1] = temp[1];
                children[2] = BackgroundImage;

                StaticHelpers.SetBackgroundImage(SaveSystem.GetCurrentSpriteKey(), BackgroundDictionary[SaveSystem.GetCurrentSpriteKey().Trim()], children, anim);

                var zoomdata = SaveSystem.GetImageZoomData();
                var imageclasses = SaveSystem.GetImageClassData();

                if (ImageClassData == null)
                    ImageClassData = BackgroundImage.gameObject.GetComponent<BackgroundImage>();

                //remove anythign that's currently applied
                ImageClassData.RemoveZoomTweens();
                ImageClassData.RemoveClassTweens();

                if (!zoomdata.IsNull())
                    ImageClassData.ZoomImage(zoomdata);


                if (imageclasses != "NULL" || string.IsNullOrEmpty(imageclasses))
                    ImageClassData.ApplyClass(imageclasses);
            }

            foreach (KeyValuePair<string, GameObject> pair in PropDictionary)
            {
                bool vis = SaveSystem.OnLoadPropData(pair.Key);

                if (pair.Key == "Closed_Door" && SaveSystem.OnLoadPropData("Open_Door"))
                {
                    continue;
                }

                if (vis)
                    StaticHelpers.SetProp(pair.Key, vis);
                else
                    PropDictionary[pair.Key].SetActive(vis);
            }

            intrusiveThoughts.KillAllThoughts(true);
            foreach (string thought in SaveSystem.GetIntrusiveThoughts())
            {
                string[] intusive_list = thought.Split(",");
                int amount = int.Parse(intusive_list[0]);
                string text = intusive_list[1].Trim();
                string jump_to = intusive_list[2].Trim();
                StaticHelpers.AddIntrusiveThoughts(amount, text, jump_to, intrusiveThoughts);
            }

            GlobalLight.color = SaveSystem.GetColorData();

            if (SaveSystem.GetFlashlight())
            {
                Flashlight.gameObject.SetActive(true);
                Flashlight.isOn = true;
            }

            Scroll.DOVerticalNormalizedPos(1, AutoScrollDelay);
            StartCoroutine(AfterLoad(hideChoices));
        }

        private IEnumerator AfterLoad(bool hide_choices = false)
        {
            if (Story.canContinue && Text_Delay <= 0)
            {
                if (autoplay)
                    yield return new WaitForSeconds(NextTextDelay);
                else
                {
                    ClickToContinue = true;

                    yield return new WaitUntil(() =>
                                           actions.Controls.Continue.triggered || can_click);

                    ClickToContinue = false;
                    can_click = false;
                }
            }
            else if (Story.currentChoices.Count > 0 && hide_choices)
                yield break;

            if (Text_Delay > 0)
                yield return new WaitForSeconds(Text_Delay);

            DisplayNextLine();
        }

        public void StartGame()
        {
            StartCoroutine(ContinueStory(true));
        }

        private void ReturnToMainMenu()
        {
            SaveSystem.Restart();
            ReplaceData = new ReplaceChoice("", -1);

            text_color = TextPrefab.color;
            text_color.a = 1;
            ReplaceData = new ReplaceChoice("", -1);
            ImageClassData = BackgroundImage.gameObject.GetComponent<BackgroundImage>();
            GlobalLight.color = OutsideLight;
            DeleteOldTextBoxes();
            DeleteOldChoices();

            AudioManager.instance.ResetAudio();

            Story.ChoosePathString("StartGame");

            SaveSystem.Init();
            SaveSystem.SlotInit(BackgroundDictionary, PropDictionary, Story);

            TransistionsAndLoading.instance.ToMainMenu();
        }

        private void DisplayNextLine(bool isStart = false)
        {
            StartCoroutine(ContinueStory(isStart));
        }

        public void ClickedToContinue()
        {
             can_click = true;
        }

        // ReSharper disable Unity. 
        private IEnumerator ContinueStory(bool isStart = false)
        {
            bool hideChoices = false;
            can_click = false;

            Text_Delay = -1;

            if (Story.canContinue)
            {
                if (isStart)
                    yield return new WaitForSeconds(.7f);


                ContinueText = Story.Continue().Trim(); // get next line and remove white space from text

                if (string.IsNullOrWhiteSpace(ContinueText) || string.IsNullOrEmpty(ContinueText))
                {
                    DisplayNextLine(isStart);
                    yield break;
                }

                if (ReplaceData.hasData())
                    yield return new WaitForSeconds(DefaultShortWait + 0.01f);
                else if (WaitAfterChoice)
                    yield return new WaitForSeconds(ChunkDelay);

                WaitAfterChoice = false;
                classes.Clear();

                yield return new WaitForEndOfFrame();

                if (Story.currentTags.Contains("CLEAR"))
                {
                    ClearOutTextBoxes();
                    yield return new WaitForSeconds(AutoScrollDelay + 0.15f);
                }


                Current_Textbox = Instantiate(TextPrefab, TextParent, false);

                if (TextParent.childCount <= 1)
                {
                    FadeMask.materialForRendering.DOFloat(0, "_Start", 0.15f).OnComplete(() =>
                    {
                        FadeMask.gameObject.SetActive(false);
                    });
                }
                else
                    FadeMask.gameObject.SetActive(true);

                foreach (var story_tag in Story.currentTags)
                {
                    if (story_tag.Contains("CLASS"))
                    {
                        Scroll.DOVerticalNormalizedPos(1, AutoScrollDelay);
                        Scroll.content.ForceUpdateRectTransforms();
                    }

                    if (story_tag.Contains("click_move"))
                    {
                        ClickToContinue = false;
                        hideChoices = true;
                    }

                    yield return null;
                    CycleThroughTags(story_tag.Split(':'));
                }

                StartCoroutine(StaticHelpers.CheckSkip());
                yield return StartCoroutine(StaticHelpers.IncrementText(ContinueText, Current_Textbox, Scroll, AutoScrollDelay, FadeMask.materialForRendering));

                //If we are going to replace this text, we don't want to save anything yet. We will do this after a choice click
                if (!ReplaceData.hasTextData())
                {
                    SaveSystem.SetSavedHistory($"{ContinueText}");
                }

                SetSaveDataForTextBox();
            }

            if (Text_Delay > 0)
                yield return new WaitForSeconds(Text_Delay);

            if (Story.canContinue && Text_Delay <= 0)
            {
                if (autoplay)
                    yield return new WaitForSeconds(NextTextDelay);
                else //wait for input to continue
                {
                    can_click = false;
                    ClickToContinue = true;

                    yield return new WaitUntil(() =>
                                           actions.Controls.Continue.triggered || (can_click && !LinksManager.hovering));

                    ClickToContinue = false;
                    can_click = false;
                }
            }
            else if (Story.currentChoices.Count > 0)
            {
                if (hideChoices)
                    yield break;

                ClickToContinue = false;
                can_click = false;

                //auto save
                SetDataOnSave("slot_0");
                OnAutoSave?.Invoke();

                DisplayChoices();
                yield break;
            }
            else if (!Story.canContinue) //game is over
            {
                Debug.Log("GAME OVER");
                ReturnToMainMenu();
                yield break;
            }


            yield return new WaitForFixedUpdate();
            
            DisplayNextLine();
        }

        private void SetSaveDataForTextBox()
        {
            //Set Data to be saved
            var text = Current_Textbox.text;
            var replace = ReplaceData.hasTextData() ? ReplaceData : new ReplaceChoice();
            SavedTextData data = new SavedTextData(text, Text_Delay, replace, classes.ToArray());

            var link = Current_Textbox.gameObject.GetComponent<LinksManager>();
            if (link.enabled && data.cycle_text != null && data.cycle_text.Length > 0)
            {
                data.cycle_text = link.GetCycle();
                data.cycle_index = link.GetIndex();
            }

            SaveSystem.SetCurrentText(data);
        }

        private void SetReplaceChoiceData(string value)
        {
            int uniqueID = Random.Range(1, 100);
            string new_text = $"<color=#a80f0f><link=\"{uniqueID}\">{value}</link></color>";
            ContinueText = ContinueText.Replace(value, new_text);

            var linked = Current_Textbox.GetComponent<LinksManager>();
            linked.SetReplaceData();
            linked.enabled = true;
            ReplaceData = new ReplaceChoice(value, uniqueID);
        }

        private void ClearOutTextBoxes()
        {
            SaveSystem.ClearCurrentTextData();
            DeleteOldChoices();
            DeleteOldTextBoxes();
            //DataManager.instance.SetHistoryText();
        }

        private void CycleThroughTags(string[] Tag)
        {
            string key = Tag[0].Trim();
            string value = "";

            if (Tag.Length > 1)
                value = Tag[1].Trim();

            switch (key)
            {
                case "IMAGE": //Sets background image
                    if (value == "Bus Stop Right")
                        StaticHelpers.ShiftImage(BackgroundImage, true);
                    else if (BackgroundDictionary.ContainsKey(value) && SaveSystem.GetCurrentSpriteKey() != value)
                    {
                        var temp = DefualtImage.GetComponentsInChildren<Image>();

                        Image[] children = new Image[3];
                        children[0] = temp[0];
                        children[1] = temp[1];
                        children[2] = BackgroundImage;

                        StaticHelpers.SetBackgroundImage(value, BackgroundDictionary[value.Trim()], children, anim);
                    }

                    break;
                case "PROP": //set what prop is visible on screen

                    string[] prop_list = value.Split(',');
                    char[] separators = new char[] { ' ', '[', ']' };
                    foreach (string prop in prop_list)
                    {
                        string[] p = prop.Split(separators, StringSplitOptions.RemoveEmptyEntries);
                        string src = p[0].Trim();
                        bool visibility = p[1].Trim().ToLower() == "true" ? true : false;

                        if (src == "stairs" && visibility && !SaveSystem.GetOverlayValue())
                            continue;

                        StaticHelpers.SetProp(src, visibility);
                    }

                    break;
                case "DELAY": //delay overrider when next text block shows
                    Text_Delay = float.Parse(value);
                    break;
                case "REPLACE": //on click, replaces text with new text
                    SetReplaceChoiceData(value);
                    break;
                case "ENDING": //unlocks an ending   9, Good Ending: It Has Been a Long, Long Night
                    string[] endings = value.Split(",");
                    DataManager.instance.UnlockEnding(Int32.Parse(endings[0].Trim()), endings[1].Trim());
                    break;
                case "CYCLE": //on click, text cycles through set options
                    string[] cycle_list = value.Split(',');
                    AddCycleText(cycle_list);
                    break;
                case "CLASS": //edits the text (within the textbox)'s visuals
                    classes.Add(value);

                    if (Current_Textbox != null)
                    {
                        Current_Textbox.color = text_color;
                        Current_Textbox.text = ContinueText;
                        Current_Textbox.gameObject.GetComponent<TextObjectEffects>().ApplyClass(value);
                    }

                    break;
                case "ICLASS": //[classes to remove], [classes to add]
                    ImageClassData.ApplyClass(value);
                    break;
                case "EFFECT": //Special effects to happen (flashlight, click to move etc)
                    if (value.Contains("Stair_Light"))
                    {
                        var words = value.Split(',');
                        bool activbe = words[1] == "true";
                        var light = LightingDictionary["Stair_Light"];
                        light.SetActive(activbe);
                    }
                    else
                    {
                        Effects(value);
                    }

                    break;
                case "REMOVE": //removes stuff i dont want
                    if (value.ToLower() == "zoom")
                        ImageClassData.RemoveZoomTweens();
                    else if (value.ToLower() == "iclass")
                        ImageClassData.RemoveClassTweens();
                    else if (value.ToLower() == "intrusive")
                        intrusiveThoughts.KillAllThoughts();
                    break;
                default:
                    Debug.LogWarning($"{Tag[0]} with content {value} could not be found.");
                    break;
            }
        }

        private void Effects(string key)
        {
            switch (key)
            {
                case "BlinkOnClick_True":
                    SaveSystem.SetIsCursorOpen(true);
                    break;
                case "BlinkOnClick_False":
                    SaveSystem.SetIsCursorOpen(false);
                    break;
                case "Force_Blink":
                    CanClick = false;
                    OnForceBlink?.Invoke();
                    break;
                case "Force_Closed":
                    CanClick = false;
                    OnForceClosed?.Invoke();
                    //should_blink = false;
                    break;
                case "Force_Open":
                    CanClick = false;
                    OnForceOpen?.Invoke();
                    break;
                case "flashlight_on":
                    SaveSystem.SetFlashlight(true);
                    if (!Flashlight.gameObject.activeSelf)
                        Flashlight.gameObject.SetActive(true);
                    Flashlight.isOn = true;
                    break;
                case "flashlight_off":
                    Flashlight.isOn = false;
                    break;
                case "flashlight_off_forever":
                    Flashlight.isOn = false;
                    SaveSystem.SetFlashlight(false);
                    Flashlight.gameObject.SetActive(false);
                    break;
                case "click_move_main":
                    ClickToMove(0);
                    break;
                case "click_move_confessional":
                    ClickToMove(1);
                    break;
                case "LightDark":
                    GlobalLight.color = DarkLight;

                    SaveSystem.SetColorData(DarkLight);
                    break;
                case "Shake_Confessional":
                    EffectImages("Confessional");
                    break;
                case "Shake_Office":
                    EffectImages("Office");
                    break;
                case "Remove_Finger":
                    ControlGlow("Finger");
                    break;
                case "IntialSight":
                    ControlGlow("intial");
                    break;
                case "start-glow":
                    ControlGlow("intense");
                    break;
                case "leave-glow":
                    ControlGlow("leave");
                    break;
                case "scream-glow":
                    ControlGlow("scream");
                    break;
                case "stay-glow":
                    ControlGlow("stay");
                    break;
                case "remove-glow":
                    var anim = LightingDictionary["Animator"].GetComponent<Animator>();
                    anim.SetTrigger("End");
                    break;
                case "LightDarktoUsed":
                    DOTween.To(() => GlobalLight.color, color => GlobalLight.color = color, UsedToLight, 6f);
                    SaveSystem.SetColorData(UsedToLight);
                    break;
                case "Default Light":
                    GlobalLight.color = OutsideLight;
                    SaveSystem.SetColorData(OutsideLight);
                    break;
                default:
                    Debug.LogWarning($"Effect {key} could not be found.");
                    break;
            }
        }

        private void EffectImages(string type)
        {
            if (!SaveSystem.GetOverlayValue())
                return;

            if (type == "Confessional")
            {
                BackgroundImage.gameObject.GetComponent<RectTransform>().DOShakePosition(1.75f, 100, 30, 40).SetEase(Ease.InOutBounce);
                PropDictionary["curtain_full"].GetComponent<RectTransform>().DOShakePosition(1.75f, 100, 30, 40).SetEase(Ease.InOutBounce);
            }
            else if (type == "Office")
            {
                BackgroundImage.gameObject.GetComponent<RectTransform>().DOShakePosition(1.75f, 100, 30, 40).SetEase(Ease.InOutBounce);
            }
        }

        private void ControlGlow(string type)
        {
            if (!SaveSystem.GetOverlayValue())
                return;

            if (type == "Finger")
            {
                var light = LightingDictionary["Finger"].GetComponent<Light2D>();
                DOTween.To(() => light.intensity, value => light.intensity = value, 13, 2).SetEase(Ease.OutSine).OnComplete(() =>
                {
                    DOTween.To(() => light.intensity, value => light.intensity = value, 3, 2).SetEase(Ease.OutSine);
                });
                BackgroundImage.gameObject.GetComponent<RectTransform>().DOShakePosition(3, 100, 30, 40).SetEase(Ease.InOutBounce);
                PropDictionary["Pews"].GetComponent<RectTransform>().DOShakePosition(3, 100, 30, 40).SetEase(Ease.InOutBounce);
            }
            else
            {
                var anim = LightingDictionary["Animator"].GetComponent<Animator>();
                anim.enabled = true;

                if (type == "intense")
                {
                    anim.SetTrigger("Toggle");
                }
                else if (type == "leave")
                {
                    anim.SetTrigger("Leave");
                }
                else if (type == "stay")
                {
                    anim.SetTrigger("Stay");
                }
                else if (type == "scream")
                {
                    anim.SetTrigger("Scream");
                }
                else if (type == "intial")
                {
                    anim.SetTrigger("Restart");
                }
            }

        }

        private void ClickToMove(int Index)
        {
            var move = clicktomove[Index];

            if (ChoiceButtonContainer.GetComponentsInChildren<LabledButton>().Length > 0)
                DeleteOldChoices();

            for (int index = 0; index < move.transform.childCount; index++)
            {
                int i = index;
                var obj = move.transform.GetChild(index);
                var Button = obj.gameObject.GetComponent<Button>();
                Button.onClick.RemoveAllListeners();

                foreach (var choice in Story.currentChoices)
                {
                    if (obj.name.ToLower() == choice.text)
                    {
                        obj.gameObject.SetActive(true);
                        Button.onClick.AddListener(() =>
                        {
                            OnClickChoiceButton(choice);
                            foreach (Transform child in move.transform)
                            {
                                child.gameObject.SetActive(false);
                            }
                        });
                        break;
                    }
                }
            }

            move.SetActive(true);
        }

        private void AddCycleText(string[] cycle_list)
        {
            float uniqueID = Random.Range(1f, 100f);
            string new_text = $"<color=#a80f0f><u><link=\"{uniqueID}\">{cycle_list[0].Trim()}</link></u></color>";
            ContinueText = ContinueText.Replace("@", new_text);

            var linked = Current_Textbox.GetComponent<LinksManager>();
            linked.enabled = true;
            linked.SetData(cycle_list.ToList());
        }

        public void ReplaceText()
        {
            if (ReplaceData.hasData())
            {
                StartCoroutine(ReplaceTextData());
            }
        }

        IEnumerator ReplaceTextData()
        {
            yield return null;
            CanClick = true;

            yield return new WaitForEndOfFrame();

            CanClick = false;

            //delete current text box
            Current_Textbox.DOFade(0, DefaultShortWait).OnComplete(
                () => { Destroy(Current_Textbox.gameObject); });

            //Delete old choices
            DeleteOldChoices();

            yield return new WaitForSeconds(DefaultShortWait * 2);

            //tell the story what our next 
            Story.ChooseChoiceIndex(ReplaceData.GetChoiceIndex());
            LinksManager.hovering = false;
            DisplayNextLine();
        }

        ////////////////////////////////////////////  CHOICES STUFFS ////////////////////////////////////////////

        private void DisplayChoices()
        {
            if (ChoiceButtonContainer.GetComponentsInChildren<LabledButton>().Length > 0)
                DeleteOldChoices();

            for (int i = 0; i < Story.currentChoices.Count; i++) // iterates through all choices
            {
                var choice = Story.currentChoices[i];
                if (ReplaceData.hasTextData() && choice.text == ReplaceData.GetText())
                {
                    ReplaceData.SetChoiceIndex(choice.index);
                    continue;
                }

                if (choice.text[0] == '(')
                {
                    string visible = choice.text.Substring(1, choice.text.IndexOf(')') - 1).Trim();
                    string replace = choice.text.Substring(choice.text.IndexOf(')') + 1).Trim();
                    LabledButton replace_button = CreateChoiceButton(visible); // creates a choice button
                    replace_button.onClick.AddListener(() => OnReplaceChoiceButton(choice, replace, replace_button));

                    continue;
                }

                LabledButton button = CreateChoiceButton(choice.text); // creates a choice button
                button.onClick.AddListener(() => OnClickChoiceButton(choice));
            }
        }

        void OnReplaceChoiceButton(Choice choice, string replace, LabledButton button)
        {
            var choice_text = button.GetComponentInChildren<TMProGlobal>();
            if (choice_text.text == replace)
            {
                OnClickChoiceButton(choice);
            }
            else
            {
                choice_text.text = replace;
            }
        }

        private void OnClickChoiceButton(Choice choice)
        {
            //if we have replace data, but don't click the replace button
            if (ReplaceData.hasData())
            {
                SaveSystem.SetSavedHistory($"{ContinueText}");
                SetSaveDataForTextBox();
                ReplaceData = new ReplaceChoice("", -1);
            }

            WaitAfterChoice = true;
            SaveSystem.SetSavedHistory($"<color=#a80f0f>{choice.text}</color>");
            SaveSystem.ClearCurrentTextData();
            Story.ChooseChoiceIndex(choice.index);
            DeleteOldChoices();
            DeleteOldTextBoxes();
            DisplayNextLine();
        }

        public void OnClickIntrusiveThought(string thought, string path)
        {
            WaitAfterChoice = true;
            intrusiveThoughts.KillAllThoughts();
            SaveSystem.SetSavedHistory($"{thought}");
            SaveSystem.ClearCurrentTextData();
            Story.ChoosePathString(path);

            DeleteOldChoices();
            DeleteOldTextBoxes();

            Invoke("DisplayNextLine", 0.15f);
        }

        void DeleteOldChoices()
        {
            foreach (var item in clicktomove)
            {
                if (item.activeSelf)
                    item.SetActive(false);
            }


            if (ChoiceButtonContainer != null)
            {
                foreach (LabledButton button in ChoiceButtonContainer.GetComponentsInChildren<LabledButton>())
                {
                    var choice_text = button.GetComponentInChildren<TMProGlobal>();
                    var choice_image = button.GetComponent<Image>();
                    button.enabled = false;

                    choice_image.DOFade(0, ChoiceShowDelay);
                    choice_text.DOFade(0, ChoiceShowDelay).OnComplete(
                        () => { Destroy(button.gameObject); });
                }
            }
        }

        void DeleteOldTextBoxes(bool ignoreRecent = false)
        {
            if (TextParent != null)
            {
                var children = TextParent.GetComponentsInChildren<TMProGlobal>();
                int length = ignoreRecent ? children.Length - 1 : children.Length;
                for (int i = 0; i < length; i++)
                {
                    var child = children[i];
                    child.DOFade(0, AutoScrollDelay).OnComplete(
                        () => { Destroy(child.gameObject); });
                }
            }
        }

        LabledButton CreateChoiceButton(string text)
        {
            // creates the button from a prefab
            LabledButton choiceButton = Instantiate(ChoiceButtonPrefab, ChoiceButtonContainer.transform, false);

            // sets text on the button
            var choice_text = choiceButton.GetComponentInChildren<TMProGlobal>();
            choice_text.text = text;

            Sequence text_fade = DOTween.Sequence();

            ColorUtility.TryParseHtmlString("#a80f0f", out var color);
            text_fade.Insert((autoplay ? 0.5f : 1f),
                choice_text.DOColor(color, ChoiceShowDelay)).OnComplete(
                () => { if (choiceButton != null) choiceButton.enabled = true; });

            return choiceButton;
        }

        public bool CanStoryContinue()
        {
            return Story.canContinue || Story.currentChoices.Count > 0;
        }

        public void HandleScroll(float value)
        {
            if (FadeMask.gameObject.activeSelf)
            {
                value = Mathf.Clamp(value, 0f, 0.8f);

                FadeMask.materialForRendering.DOFloat(value, "_Start", 0.15f);
            }

        }
    }
}