using System;
using System.Collections;
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

        private string ContinueText; // next group of text
        private TextMeshProUGUI Current_Textbox; //current textbox
        private float Text_Delay = -1;
        private ReplaceChoice ReplaceData;

        [Header("Auto Play Variables")] private bool AutoPlay = false;
        private float AutoPlay_TextDelay = 1.5f; //delay between next piece of text showing up
        private float AutoPlay_ChoiceDelay = .25f; //delay between the next choice group fading in
        private float AutoPlay_FadeOut = .25f; //delay between the next choice group fading in
        private float AutoPlay_TextGroupDelay = .25f; // delay between the next text group fading in

        [Header("Default Variables")]
        private const float DefaultTextGroupDelay = 1.25f; //default time between next piece of text showing up

        private const float DefaultChoiceGroupDelay = 0.5f; //default time between next piece of text showing up
        private const float DefaultFadeOut = 0.5f; //defualt time to fade out & delete text & choices on screen
        private const float DefaultAutoScroll = 0.5f; //default time to autoscroll
        private const float DefaultShortWait = 0.1f; //default time between a replace choice fade change
        private bool WaitAfterChoice = false;

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

        [Header("Lighting")] 
        [SerializeField] private Light2D GlobalLight;
        [SerializeField] private Color OutsideLight, DarkLight, UsedToLight, FlashlightOn, FlashlightOff;
        [SerializedDictionary("Lighting Name", "Light")]
        public SerializedDictionary<string, GameObject> LightingDictionary;
        
        
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

                Current_Textbox.DOColor(text_color, 1.25f);
            }

            Story.state.LoadJson(SaveSystem.GetStory());
            SetBackgroundImage(SaveSystem.GetCurrentSpriteKey());
            Scroll.DOVerticalNormalizedPos(0, DefaultAutoScroll);
            StartCoroutine(AfterLoad());
        }

        private IEnumerator AfterLoad()
        {
            if (Story.canContinue && Text_Delay <= 0)
            {
                if (AutoPlay)
                    yield return new WaitForSeconds(AutoPlay_TextDelay);
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
                    yield return new WaitForSeconds((AutoPlay ? AutoPlay_FadeOut : DefaultFadeOut) + 0.01f);

                WaitAfterChoice = false;
                Current_Textbox = Instantiate(TextPrefab, TextParent, false);
                
                yield return new WaitForEndOfFrame();
                
                foreach (var story_tag in Story.currentTags)
                {
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
                    Current_Textbox.DOColor(text_color, AutoPlay ? AutoPlay_TextGroupDelay : DefaultTextGroupDelay);


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
                if (AutoPlay)
                    yield return new WaitForSeconds(AutoPlay_TextDelay);
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
            SavedTextData data = new SavedTextData(text, Text_Delay, replace);

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
                    Current_Textbox.gameObject.GetComponent<TextObjectEffects>().ApplyClass(value);
                    break;
                case "ICLASS": //[classes to remove], [classes to add]
                    ImageClassData.ApplyClass(value);
                    break;
                case "REMOVE": //removes text box visuals
                    break;
                case "EFFECT": //Special effects to happen (flashlight, click to move etc)
                    Effects(value);
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
                case "flashlight_on":
                    if (!Flashlight.gameObject.activeSelf)
                        Flashlight.gameObject.SetActive(true);
                    Flashlight.isOn = true;
                    break;
                case "flashlight_off":
                    Flashlight.isOn = false;
                    break;
                case "click_move":
                    ClickToMove();
                    clicktomove.SetActive(true);
                    break;
                case "LightDark":
                    GlobalLight.color = DarkLight;
                    break;
                case "IntialSight":
                    var onj = LightingDictionary["IntialSight"];
                    onj.SetActive(!onj.activeSelf);
                    break;
                case "LightDarktoUsed":
                    DOTween.To(()=>GlobalLight.color, color => GlobalLight.color = color, UsedToLight, 6f);
                    break;
                default:
                    Debug.LogWarning($"Effect {key} could not be found.");
                    break;
            }
        }

        private void ClickToMove()
        {
            if (ChoiceButtonContainer.GetComponentsInChildren<LabledButton>().Length > 0)
                DeleteOldChoices();

            int index = 0;
            foreach (GameObject child in clicktomove.transform)
            {
                var Button = child.GetComponent<Button>();
                Button.onClick.AddListener(() => OnClickChoiceButton(Story.currentChoices[index]));
                index++;
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

                LabledButton button = CreateChoiceButton(choice.text); // creates a choice button
                button.onClick.AddListener(() => OnClickChoiceButton(choice));
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

                    choice_text.DOFade(0, (AutoPlay ? AutoPlay_ChoiceDelay : DefaultFadeOut)).OnComplete(
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
                    child.DOFade(0, (AutoPlay ? AutoPlay_FadeOut : DefaultFadeOut)).OnComplete(
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
            text_fade.Insert((AutoPlay ? 0.5f : 1f),
                choice_text.DOColor(color, (AutoPlay ? AutoPlay_ChoiceDelay : DefaultChoiceGroupDelay))).OnComplete(
                () => { choiceButton.enabled = true; });

            return choiceButton;
        }
    }
}