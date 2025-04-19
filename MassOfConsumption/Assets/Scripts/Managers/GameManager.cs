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

namespace AYellowpaper.SerializedCollections
{
    public class GameManager : MonoBehaviour
    {
        public static GameManager instance;

        [Header("Ink Data")] [SerializeField] private TextAsset InkJsonAsset;
        private Story Story;
        private Color text_color;
        private List<string> classes = new List<string>();

        private string ContinueText; // next group of text
        private TextMeshProUGUI Current_Textbox; //current textbox
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

        [Header("Story Objects")] [SerializeField]
        private Transform TextParent;

        [SerializeField] private TextMeshProUGUI TextPrefab;
        [SerializeField] private VerticalLayoutGroup ChoiceButtonContainer;
        [SerializeField] private LabledButton ChoiceButtonPrefab;
        [SerializeField] private ScrollRect Scroll;

        [Header("Image Data")] private bool WasLastDefault = true;
        [SerializeField] private Animator anim;
        [SerializeField] private Image BackgroundImage;
        [SerializeField] private Transform DefualtImage;
        private BackgroundImage ImageClassData;

        [SerializedDictionary("Background name", "Sprite")]
        public SerializedDictionary<string, Sprite> BackgroundDictionary;

        [SerializedDictionary("Prop name", "Sprite")]
        public SerializedDictionary<string, GameObject> PropDictionary;

        public Toggle Flashlight;
        public GameObject clicktomove;
        public GameObject AllLighting;

        [Header("Lighting")] [SerializeField] private Light2D GlobalLight;
        [SerializeField] private Color OutsideLight, DarkLight, UsedToLight, FlashlightOn, FlashlightOff;

        [SerializedDictionary("Lighting Name", "Light")]
        public SerializedDictionary<string, GameObject> LightingDictionary;

        private Sequence lightingSequence;

        [Header("Auto Play Variables")] 
        private bool autoplay;
        private float autoplay_textdelay = 1.5f; //delay between next piece of text showing up
        public bool AutoPlay
        {
            get { return autoplay; }
            set { autoplay = value; }
        }
        public float AutoPlay_TextDelay
        {
            get { return autoplay_textdelay; }
            set { SetAutoPlayDelay(value); }
        }

        private float AutoPlay_ChoiceDelay = .25f; //delay between the next choice group fading in
        private float AutoPlay_FadeOut = .25f; //delay between the next choice group fading in
        private float AutoPlay_TextGroupDelay = .25f; // delay between the next text group fading in

        private void SetAutoPlayDelay(float value)
        {
            autoplay_textdelay = Math.Abs(value);
            float normalizedTime = autoplay_textdelay / 3.0f;

            AutoPlay_ChoiceDelay = normalizedTime * 0.5f;
            AutoPlay_FadeOut = normalizedTime * 0.5f;
            AutoPlay_TextGroupDelay = normalizedTime * 0.5f;

            if (autoplay)
                DefaultAutoScroll = normalizedTime * 0.5f;
        }

        [Header("Default Variables")]
        private float default_textdelay = 1.5f; //default time between next piece of text showing up

        public float Default_TextDelay
        {
            get { return default_textdelay; }
            set { SetDefaultPlayDelay(value); }
        }

        private void SetDefaultPlayDelay(float value)
        {
            default_textdelay = Math.Abs(value);

            float normalizedTime = autoplay_textdelay / 3.0f;

            Default_ChoiceDelay = normalizedTime * 1f;
            Default_FadeOut = normalizedTime * 1f;
            Default_TextGroupDelay = normalizedTime * 1f;

            if (!autoplay)
                DefaultAutoScroll = normalizedTime * 0.5f;
        }

        private float Default_ChoiceDelay = 0.5f; //default time between next piece of text showing up
        private float Default_FadeOut = 0.5f; //defualt time to fade out & delete text & choices on screen
        private float Default_TextGroupDelay = 0.5f; //defualt time to fade out & delete text & choices on screen

        private float DefaultAutoScroll = 0.25f; //default time to autoscroll
        private const float DefaultShortWait = 0.1f; //default time between a replace choice fade change
        private bool WaitAfterChoice;

        public delegate void VisualEffects(bool isOn);

        public static event VisualEffects OnTextEffectFlip;
        public static event VisualEffects OnImageEffectFlip;


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
        }

        private void Start()
        {
            text_color = TextPrefab.color;
            text_color.a = 1;
            ReplaceData = new ReplaceChoice("", -1);
            ImageClassData = BackgroundImage.gameObject.GetComponent<BackgroundImage>();
            GlobalLight.color = OutsideLight;

            SaveSystem.SetSettingsOnLoad();
            SaveSystem.SetSettingsOnLoad();
        }

        private void OnEnable()
        {
            SaveSlot.OnSave += SetDataOnSave;
            SaveSystem.OnLoad += GetDataOnLoad;
        }

        private void OnDisable()
        {
            SaveSlot.OnSave -= SetDataOnSave;
            SaveSystem.OnLoad -= GetDataOnLoad;
        }

        private void SetDataOnSave(string ID)
        {
            SaveSystem.SetStory(Story.state.ToJson(), ID);
        }

        private void GetDataOnLoad()
        {
            DeleteOldChoices();
            DeleteOldTextBoxes();

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
                    Current_Textbox.text = $"<br>{ContinueText}";

                    foreach (var value in text_data.class_text)
                    {
                        Current_Textbox.gameObject.GetComponent<TextObjectEffects>().ApplyClass(value);
                    }
                }

                Current_Textbox.DOColor(text_color, 1.25f);
            }

            Story.state.LoadJson(SaveSystem.GetStory());
            SetBackgroundImage(SaveSystem.GetCurrentSpriteKey());

            foreach (KeyValuePair<string, GameObject> pair in PropDictionary)
            {
                PropDictionary[pair.Key].SetActive(SaveSystem.OnLoadPropData(pair.Key));
            }

            Scroll.DOVerticalNormalizedPos(0, DefaultAutoScroll);
            StartCoroutine(AfterLoad());
        }

        private IEnumerator AfterLoad()
        {
            if (Story.canContinue && Text_Delay <= 0)
            {
                if (autoplay)
                    yield return new WaitForSeconds(autoplay_textdelay);
                else
                    yield return new WaitUntil(() => Input.GetButtonDown("Continue"));
            }

            if (Text_Delay > 0)
            {
                yield return new WaitForSeconds(Text_Delay);
                Text_Delay = -1;
            }

            DisplayNextLine();
        }

        public void StartGame()
        {
            StartCoroutine(ContinueStory(true));
        }

        private void DisplayNextLine(bool isStart = false)
        {
            StartCoroutine(ContinueStory(isStart));
        }

        // ReSharper disable Unity.PerformanceAnalysis
        private IEnumerator ContinueStory(bool isStart = false)
        {
            bool hideChoices = false;

            if (Story.canContinue)
            {
                if (isStart)
                    yield return new WaitForSeconds(.7f);

                ContinueText = Story.Continue(); // gets next line
                ContinueText = ContinueText?.Trim(); // removes white space from text

                if (string.IsNullOrWhiteSpace(ContinueText) || string.IsNullOrEmpty(ContinueText))
                {
                    DisplayNextLine(isStart);
                    yield break;
                }

                if (ReplaceData.hasData())
                    yield return new WaitForSeconds(DefaultShortWait + 0.01f);
                else if (WaitAfterChoice)
                    yield return new WaitForSeconds((autoplay ? AutoPlay_FadeOut : Default_FadeOut) + 0.01f);

                WaitAfterChoice = false;
                classes.Clear();
                Current_Textbox = Instantiate(TextPrefab, TextParent, false);

                yield return new WaitForEndOfFrame();

                foreach (var story_tag in Story.currentTags)
                {
                    if (story_tag.Contains("CLASS"))
                    {
                        Scroll.DOVerticalNormalizedPos(0, DefaultAutoScroll);
                        Scroll.content.ForceUpdateRectTransforms();
                    }

                    yield return null;
                    CycleThroughTags(story_tag.Split(':'));

                    if (story_tag.Contains("click_move"))
                        hideChoices = true;
                }

                Current_Textbox.text = $"<br>{ContinueText}";

                //if we have all the replace data, then make sure it comes fast and then reset the replace data
                if (ReplaceData.hasData())
                {
                    Current_Textbox.DOColor(text_color, 0.15f);
                    ReplaceData = new ReplaceChoice("", -1);
                }
                else
                    Current_Textbox.DOColor(text_color, autoplay ? AutoPlay_TextGroupDelay : Default_TextGroupDelay);


                //If we are going to replace this text, we don't want to save anything yet. We will do this after a choice click
                if (!ReplaceData.hasTextData())
                {
                    SaveSystem.SetHistory($"<br><br>{ContinueText}");
                }

                SetSaveDataForTextBox();

                //TODO: check this so the box doesn't jump like how it currently does
                Scroll.DOVerticalNormalizedPos(0, DefaultAutoScroll);
                Scroll.content.ForceUpdateRectTransforms();
            }
            else if (Story.currentChoices.Count > 0)
            {
                DisplayChoices();
                yield break;
            }

            if (Story.canContinue && Text_Delay < 0)
            {
                if (autoplay)
                    yield return new WaitForSeconds(autoplay_textdelay);
                else
                    yield return new WaitUntil(() => Input.GetButtonDown("Continue"));
            }

            if (Text_Delay > 0)
            {
                yield return new WaitForSeconds(Text_Delay);
                Text_Delay = -1;
            }

            if (hideChoices) yield break;

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
            float uniqueID = Random.Range(1f, 100f);
            string new_text = $"<color=#a80f0f><link=\"{uniqueID}\">{value}</link></color>";
            ContinueText = ContinueText.Replace(value, new_text);

            var linked = Current_Textbox.GetComponent<LinksManager>();
            linked.SetReplaceData();
            linked.enabled = true;
            ReplaceData = new ReplaceChoice(value);
        }

        private void CycleThroughTags(string[] Tag)
        {
            string key = Tag[0].Trim();
            string value = Tag[1].Trim();
            switch (key)
            {
                case "IMAGE": //Sets background image
                    SetBackgroundImage(value);
                    break;
                case "PROP": //set what prop is visible on screen
                    var obj = PropDictionary[value];
                    obj.SetActive(!obj.activeSelf);
                    break;
                case "PLAY": //{src, loop, fade in, delay}
                    string[] play_list = value.Split(',');

                    bool play_loop = play_list.Length > 1 ? bool.Parse(play_list[1].Trim()) : false;
                    float play_dur = play_list.Length > 2 ? float.Parse(play_list[2].Trim()) : 0;
                    float play_delay = play_list.Length > 3 ? float.Parse(play_list[3].Trim()) : 0;

                    AudioManager.instance.PlaySFX(play_list[0].Trim(), play_loop, play_dur, play_delay);
                    break;
                case "STOP": //{src, fade out, delay}
                    string[] stop_list = Tag[1].Split(',');

                    float stop_dur = stop_list.Length > 1 ? float.Parse(stop_list[1].Trim()) : 0;
                    float stop_delay = stop_list.Length > 2 ? float.Parse(stop_list[2].Trim()) : 0;

                    AudioManager.instance.StopSFX(stop_list[0].Trim(), stop_dur, stop_delay);
                    break;
                case "DELAY": //delay overrider when next text block shows
                    Text_Delay = float.Parse(value);
                    break;
                case "REPLACE": //on click, replaces text with new text
                    SetReplaceChoiceData(value);
                    break;
                case "CHECKPOINT": //sets a savepoint at specific parts in the story
                    string[] checkpoints = value.Split(",");
                    DataManager.instance.UnlockCheckpoint(Int32.Parse(checkpoints[0].Trim()), checkpoints[1].Trim());
                    break;
                case "ENDING": //unlocks an ending
                    string[] endings = value.Split(",");
                    DataManager.instance.UnlockEnding(Int32.Parse(endings[0].Trim()), endings[1].Trim());
                    break;
                case "CYCLE": //on click, text cycles through set options
                    string[] cycle_list = value.Split(',');
                    AddCycleText(cycle_list);
                    break;
                case "ZOOM": // [scale], [xpos], [ypos]
                    string[] zoom_list = value.Split(",");
                    float zoom = float.Parse(zoom_list[0]);
                    float dur = float.Parse(zoom_list[3]);
                    Vector2 zoom_pos = new Vector2(float.Parse(zoom_list[1]), float.Parse(zoom_list[2]));

                    ImageClassData.ZoomImage(zoom, zoom_pos, dur);
                    break;
                case "TEXTBOX": //edits the textbox visuals
                    break;
                case "CLASS": //edits the text (within the textbox)'s visuals
                    classes.Add(value);
                    Current_Textbox.color = text_color;
                    Current_Textbox.text = $"<br>{ContinueText}";
                    Current_Textbox.gameObject.GetComponent<TextObjectEffects>().ApplyClass(value);
                    break;
                case "ICLASS": //[classes to remove], [classes to add]
                    ImageClassData.ApplyClass(value);
                    break;
                case "EFFECT": //Special effects to happen (flashlight, click to move etc)
                    Effects(value);
                    break;
                case "REMOVE": //removes stuff i dont want
                    if (value == "ZOOM")
                        ImageClassData.RemoveZoomTweens();
                    else if (value == "ICLASS")
                        ImageClassData.RemoveClassTweens();

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
                case "flashlight_on": //TODO: check that it saves
                    if (!Flashlight.gameObject.activeSelf)
                        Flashlight.gameObject.SetActive(true);
                    Flashlight.isOn = true;
                    break;
                case "flashlight_off":
                    Flashlight.isOn = false;
                    break;
                case "click_move":
                    ClickToMove();
                    break;
                case "LightDark":
                    GlobalLight.color = DarkLight;
                    break;
                case "IntialSight":
                    ControlGlow("intial");
                    break;
                case "intense-glow":
                    ControlGlow("intense");
                    break;
                case "angry-glow":
                    ControlGlow("angry");
                    break;
                case "leave-glow":
                    ControlGlow("leave");
                    break;
                case "remove-glow":
                    var red = LightingDictionary["Red Glow"]; //.6-.9
                    var red_light = red.GetComponent<Light2D>();

                    var orange = LightingDictionary["Orange Glow"]; //0.15-1
                    var orange_light = orange.GetComponent<Light2D>();

                    var dark = LightingDictionary["Dark Glow"]; //0-1
                    var dark_light = dark.GetComponent<Light2D>();

                    var onj = LightingDictionary["IntialSight"]; //#EFFECT: IntialSight
                    var intial_light = onj.GetComponent<Light2D>();

                    DOTween.Kill(red_light.falloffIntensity);
                    DOTween.Kill(orange_light.falloffIntensity);
                    DOTween.Kill(dark_light.falloffIntensity);
                    DOTween.Kill(intial_light.intensity);

                    red.SetActive(false);
                    orange.SetActive(false);
                    onj.SetActive(false);
                    break;
                case "LightDarktoUsed":
                    DOTween.To(() => GlobalLight.color, color => GlobalLight.color = color, UsedToLight, 6f);
                    break;
                default:
                    Debug.LogWarning($"Effect {key} could not be found.");
                    break;
            }
        }

        private void ControlGlow(string type)
        {
            if (lightingSequence != null && lightingSequence.IsPlaying())
                lightingSequence.Kill(true);

            lightingSequence = DOTween.Sequence();
            if (lightingSequence.IsPlaying())
                lightingSequence.Complete();


            if (type == "intense")
            {
                IntenseLightCallback();
            }
            else if (type == "angry")
            {
                LeaveLightCallback(true);
            }
            else if (type == "leave")
            {
                LeaveLightCallback();
            }
            else if (type == "intial")
            {
                var onj = LightingDictionary["IntialSight"]; //#EFFECT: IntialSight
                var intial_light = onj.GetComponent<Light2D>();

                if (onj.activeSelf)
                {
                    DOTween.To(() => intial_light.intensity,
                            value => intial_light.intensity = value, 0, 1.5f)
                        .OnComplete(() => { onj.gameObject.SetActive(false); });
                }
                else
                {
                    onj.gameObject.SetActive(true);
                    DOTween.To(() => intial_light.intensity,
                        value => intial_light.intensity = value, 10, .5f);
                }
            }
        }

        void LeaveLightCallback(bool isAngry = false)
        {
            lightingSequence = DOTween.Sequence();

            var red = LightingDictionary["Red Glow"]; //.6-.9
            red.SetActive(true);
            var red_light = red.GetComponent<Light2D>();

            var orange = LightingDictionary["Orange Glow"]; //0.15-1
            orange.SetActive(true);
            var orange_light = orange.GetComponent<Light2D>();

            var dark = LightingDictionary["Dark Glow"]; //0-1
            dark.SetActive(true);
            var dark_light = dark.GetComponent<Light2D>();

            lightingSequence.Append(DOTween.To(() => red_light.intensity,
                value => red_light.intensity = value, 0, 1.75f)).Insert(0,
                DOTween.To(() => orange_light.intensity,
                    ov => orange_light.intensity = ov, 0, 1.75f)).Insert(0,
                DOTween.To(() => dark_light.intensity,
                    dv => dark_light.intensity = dv, 0, 1.75f)).AppendInterval(5f).OnComplete(() =>
            {
                if (isAngry)
                {
                    red_light.intensity = 1;
                    orange_light.intensity = 1;
                    dark_light.intensity = 1;
                    AngryLightCallback();
                }
                else
                {
                    DOTween.Kill(red_light.falloffIntensity);
                    DOTween.Kill(orange_light.falloffIntensity);
                    DOTween.Kill(dark_light.falloffIntensity);

                    red.SetActive(true);
                    orange.SetActive(true);
                    dark.SetActive(true);
                }
            });
        }

        void AngryLightCallback()
        {
            var red = LightingDictionary["Red Glow"]; //.6-.9
            red.SetActive(true);
            var red_light = red.GetComponent<Light2D>();
            float red_end = 0.75f;
            red_light.falloffIntensity = 0.9f;

            var orange = LightingDictionary["Orange Glow"]; //0.15-1
            orange.SetActive(true);
            var orange_light = orange.GetComponent<Light2D>();
            float orange_end = 0.15f;
            orange_light.falloffIntensity = 1f;

            var dark = LightingDictionary["Dark Glow"]; //0-1
            dark.SetActive(true);
            var dark_light = dark.GetComponent<Light2D>();
            float dark_end = 0f;
            dark_light.falloffIntensity = 1f;

            MinMax duration = new MinMax();
            duration.SetValue(0.5f, 0.75f);

            DOTween.Kill(red_light.falloffIntensity);
            DOTween.Kill(orange_light.falloffIntensity);
            DOTween.Kill(dark_light.falloffIntensity);


            DOTween.To(() => red_light.falloffIntensity,
                    value => red_light.falloffIntensity = value, red_end, duration.GetRandomValue())
                .SetLoops(-1, LoopType.Yoyo);

            DOTween.To(() => orange_light.falloffIntensity,
                    ov => orange_light.falloffIntensity = ov, orange_end, duration.GetRandomValue())
                .SetLoops(-1, LoopType.Yoyo);

            DOTween.To(() => dark_light.falloffIntensity,
                    dv => dark_light.falloffIntensity = dv, dark_end, duration.GetRandomValue())
                .SetLoops(-1, LoopType.Yoyo);
        }

        void IntenseLightCallback()
        {
            var red = LightingDictionary["Red Glow"]; //.6-.9
            red.SetActive(true);
            var red_light = red.GetComponent<Light2D>();
            float red_end = (red_light.falloffIntensity >= 0.9f) ? 0.75f : 0.9f;

            var orange = LightingDictionary["Orange Glow"]; //0.15-1
            orange.SetActive(true);
            var orange_light = orange.GetComponent<Light2D>();
            float orange_end = (orange_light.falloffIntensity >= 1f) ? 0.15f : 1f;

            var dark = LightingDictionary["Dark Glow"]; //0-1
            dark.SetActive(true);
            var dark_light = dark.GetComponent<Light2D>();
            float dark_end = (dark_light.falloffIntensity >= 1f) ? 0f : 1f;

            MinMax duration = new MinMax();
            duration.SetValue(1.5f, 2);

            DOTween.To(() => red_light.falloffIntensity,
                    value => red_light.falloffIntensity = value, red_end, duration.GetRandomValue())
                .SetLoops(-1, LoopType.Yoyo);

            DOTween.To(() => orange_light.falloffIntensity,
                    ov => orange_light.falloffIntensity = ov, orange_end, duration.GetRandomValue())
                .SetLoops(-1, LoopType.Yoyo);

            DOTween.To(() => dark_light.falloffIntensity,
                    dv => dark_light.falloffIntensity = dv, dark_end, duration.GetRandomValue())
                .SetLoops(-1, LoopType.Yoyo);
        }

        private void ClickToMove()
        {
            clicktomove.SetActive(true);

            if (ChoiceButtonContainer.GetComponentsInChildren<LabledButton>().Length > 0)
                DeleteOldChoices();

            for (int index = 0; index < clicktomove.transform.childCount; index++)
            {
                int i = index;
                var Button = clicktomove.transform.GetChild(index).gameObject.GetComponent<Button>();
                Button.onClick.AddListener(() => OnClickChoiceButton(Story.currentChoices[i]));
            }
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

        private void SetBackgroundImage(string key)
        {
            if (WasLastDefault)
            {
                if (key != "Defualt")
                {
                    anim.enabled = false;
                    var children = DefualtImage.GetComponentsInChildren<Image>();
                    BackgroundImage.sprite = BackgroundDictionary[key.Trim()];
                    Sequence seq = DOTween.Sequence();

                    seq.Append(children[0].DOFade(0, 0.25f)).Insert(0, children[1].DOFade(0, 0.25f)).OnComplete(() =>
                    {
                        BackgroundImage.DOFade(1, 0.25f);
                    });

                    WasLastDefault = false;
                    SaveSystem.SetCurrentSprite(key.Trim());
                }
            }
            else
            {
                if (key == "Defualt")
                {
                    var children = DefualtImage.GetComponentsInChildren<Image>();
                    Sequence seq = DOTween.Sequence();

                    children[0].sprite = BackgroundDictionary["Defualt"];
                    children[1].sprite = BackgroundDictionary["Defualt"];
                    SaveSystem.SetCurrentSprite("Defualt");


                    BackgroundImage.DOFade(0, 0.25f).OnComplete(() =>
                    {
                        seq.Append(children[0].DOFade(1, 0.25f)).Insert(0, children[1].DOFade(1, 0.25f)).OnComplete(
                            () => { anim.enabled = true; });
                    });

                    WasLastDefault = true;
                }
                else
                {
                    BackgroundImage.DOFade(0, 0.25f).OnComplete(() =>
                    {
                        BackgroundImage.sprite = BackgroundDictionary[key.Trim()];
                        BackgroundImage.DOFade(1, 0.25f);
                    });

                    WasLastDefault = false;
                    SaveSystem.SetCurrentSprite(key.Trim());
                }
            }
        }

        public void ReplaceText()
        {
            if (ReplaceData.hasData())
            {
                //delete current text box
                Current_Textbox.DOFade(0, DefaultShortWait).OnComplete(
                    () => { Destroy(Current_Textbox.gameObject); });

                //Delete old choices
                DeleteOldChoices();

                //tell the story what our next 
                Story.ChooseChoiceIndex(ReplaceData.GetChoiceIndex());
                DisplayNextLine();
            }
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
            var choice_text = button.GetComponentInChildren<TextMeshProUGUI>();
            if (choice_text.text == replace)
            {
                OnClickChoiceButton(choice);
            }
            else
            {
                choice_text.text = replace;
            }
        }

        void OnClickChoiceButton(Choice choice)
        {
            //if we have replace data, but don't click the replace button
            if (ReplaceData.hasData())
            {
                SaveSystem.SetHistory($"<br><br>{ContinueText}");
                SetSaveDataForTextBox();
                ReplaceData = new ReplaceChoice("", -1);
            }

            WaitAfterChoice = true;
            SaveSystem.SetHistory($"<br><br>{choice.text}");
            SaveSystem.ClearCurrentTextData();
            Story.ChooseChoiceIndex(choice.index);
            DeleteOldChoices();
            DeleteOldTextBoxes();
            DisplayNextLine();
            DataManager.instance.SetHistory();
        }

        void DeleteOldChoices()
        {
            if (clicktomove.activeSelf)
                clicktomove.SetActive(false);

            if (ChoiceButtonContainer != null)
            {
                foreach (LabledButton button in ChoiceButtonContainer.GetComponentsInChildren<LabledButton>())
                {
                    var choice_text = button.GetComponentInChildren<TextMeshProUGUI>();
                    button.enabled = false;

                    choice_text.DOFade(0, (autoplay ? AutoPlay_ChoiceDelay : Default_ChoiceDelay)).OnComplete(
                        () => { Destroy(button.gameObject); });
                }
            }
        }

        void DeleteOldTextBoxes()
        {
            if (TextParent != null)
            {
                foreach (var child in TextParent.GetComponentsInChildren<TextMeshProUGUI>())
                {
                    child.DOFade(0, (autoplay ? AutoPlay_FadeOut : Default_FadeOut)).OnComplete(
                        () => { Destroy(child.gameObject); });
                }
            }
        }

        LabledButton CreateChoiceButton(string text)
        {
            // creates the button from a prefab
            LabledButton choiceButton = Instantiate(ChoiceButtonPrefab, ChoiceButtonContainer.transform, false);

            // sets text on the button
            var choice_text = choiceButton.GetComponentInChildren<TextMeshProUGUI>();
            choice_text.text = text;

            Sequence text_fade = DOTween.Sequence();

            ColorUtility.TryParseHtmlString("#a80f0f", out var color);
            text_fade.Insert((autoplay ? 0.5f : 1f),
                choice_text.DOColor(color, (autoplay ? AutoPlay_ChoiceDelay : Default_ChoiceDelay))).OnComplete(
                () => { choiceButton.enabled = true; });

            return choiceButton;
        }
    }
}