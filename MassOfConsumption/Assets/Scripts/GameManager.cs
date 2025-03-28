using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Ink.Runtime;
using TMPro;
using UnityEngine.UI;
using DG.Tweening;
using UnityEngine.Serialization;

namespace AYellowpaper.SerializedCollections
{
    public class GameManager : MonoBehaviour
    {
        private Story Story;

        [Header("Auto Play Variables")] 
        private bool AutoPlay = false;
        private float AutoPlay_TextDelay = 1.5f; //delay between next piece of text showing up
        private float AutoPlay_ChoiceDelay = .25f; //delay between the next choice group fading in
        private float AutoPlay_FadeOut = .25f; //delay between the next choice group fading in
        private float AutoPlay_TextGroupDelay = .25f; // delay between the next text group fading in

        [Header("Default Variables")] 
        private float DefaultFadeOut = 0.5f; //defualt time to fade out & delete text & choices on screen
        private float DefaultAutoScroll = 0.5f; //default time to autoscroll


        [Header("Ink Data")] [SerializeField] private TextAsset InkJsonAsset;

        [Header("Story Objects")] [SerializeField]
        private Transform TextParent;

        [SerializeField] private TextMeshProUGUI TextField;
        [SerializeField] private VerticalLayoutGroup ChoiceButtonContainer;
        [SerializeField] private LabledButton ChoiceButtonPrefab;
        [SerializeField] private ScrollRect Scroll;

        [Header("Image Data")] 
        private bool WasLastDefault = false;
        [SerializeField] private Animator anim;
        [SerializeField] private Image BackgroundImage;
        [SerializeField] private Transform DefualtImage;
        [SerializedDictionary("Background name", "Sprite")] public SerializedDictionary<string, Sprite> BackgroundDictionary;
        [SerializedDictionary("Prop name", "Sprite")] public SerializedDictionary<string, Sprite> PropDictionary;

        private void Start()
        {
            Story = new Story(InkJsonAsset.text);
        }

        public void StartGame()
        {
            TextField.text = "";
            StartCoroutine(ContinueStory(true));
        }

        private void DisplayNextLine(bool isStart = false)
        {
            StartCoroutine(ContinueStory(isStart));
        }

        private void CycleThroughTags(string[] Tag)
        {
            string key = Tag[0].ToString().Trim();
            switch (key)
            {
                case "IMAGE":
                    SetBackgroundImage(Tag[1]);
                    break;
                default:
                    Debug.LogWarning($"{Tag[0]} with content {Tag[1]} could not be found.");
                    break;
            }

        }

        private void SetBackgroundImage(string key)
        {
            if (WasLastDefault)
            {
                if (key != "Defualt")
                {
                    anim.enabled = false;
                    var children = DefualtImage.GetComponentsInChildren < Image > ();
                    Sequence seq = DOTween.Sequence();
                    
                    seq.Append(children[0].DOFade(0, 0.25f)).Insert(0, children[1].DOFade(0, 0.25f)).OnComplete(() =>
                    {
                        BackgroundImage.sprite = BackgroundDictionary[key.Trim()];
                        BackgroundImage.DOFade(1, 0.25f);
                    });
                    
                    WasLastDefault = false;
                }
            }
            else
            {
                if (key == "Defualt")
                {
                    var children = DefualtImage.GetComponentsInChildren < Image > ();
                    Sequence seq = DOTween.Sequence();
                    
                    children[0].sprite = BackgroundDictionary["Defualt"];
                    children[1].sprite = BackgroundDictionary["Defualt"];

                    BackgroundImage.DOFade(0, 0.25f).OnComplete(() =>
                    {
                        seq.Append(children[0].DOFade(1, 0.25f)).Insert(0, children[1].DOFade(1, 0.25f)).OnComplete(
                            () =>
                            {
                                anim.enabled = true;

                            });
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
                }
            }
        }

        private IEnumerator ContinueStory(bool isStart = false)
        {
            if (Story.canContinue)
            {
                if (!isStart)
                    yield return new WaitForSeconds(AutoPlay ? AutoPlay_TextGroupDelay : 0.2f);
                else
                    yield return new WaitForSeconds(.8f);

                string text = Story.Continue(); // gets next line
                text = text?.Trim(); // removes white space from text

                if (string.IsNullOrWhiteSpace(text) || string.IsNullOrEmpty(text))
                {
                    DisplayNextLine(isStart);
                    yield break;
                }

                bool finishedTags = false;

                foreach (var tag in Story.currentTags)
                {
                    string[] split = Array.Empty<string>();
                    split = tag.Split(':');
                    CycleThroughTags(split);
                }

                //yield return new WaitUntil(() => finishedTags);

                TextMeshProUGUI text_object = Instantiate(TextField, TextParent, false);
                text_object.color = Color.clear;
                text_object.text = isStart ? text : $"<br>{text}";

                yield return new WaitForSeconds(0.01f);

                Scroll.content.ForceUpdateRectTransforms();
                Scroll.DOVerticalNormalizedPos(0, DefaultAutoScroll);
                Scroll.content.ForceUpdateRectTransforms();
            }
            else if (Story.currentChoices.Count > 0)
            {
                DisplayChoices();
                yield break;
            }

            yield return new WaitForSeconds(AutoPlay_TextDelay);
            DisplayNextLine();
        }

        private void DisplayChoices()
        {
            if (ChoiceButtonContainer.GetComponentsInChildren<LabledButton>().Length > 0) DeleteOldChoices();

            for (int i = 0; i < Story.currentChoices.Count; i++) // iterates through all choices
            {
                var choice = Story.currentChoices[i];
                LabledButton button = CreateChoiceButton(choice.text); // creates a choice button
                button.onClick.AddListener(() => OnClickChoiceButton(choice));
            }
        }

        void OnClickChoiceButton(Choice choice)
        {
            Story.ChooseChoiceIndex(choice.index);
            DeleteOldChoices();
            DeleteOldTextBoxes();
            DisplayNextLine();
        }

        void DeleteOldChoices()
        {
            if (ChoiceButtonContainer != null)
            {
                foreach (LabledButton button in ChoiceButtonContainer.GetComponentsInChildren<LabledButton>())
                {
                    var choice_text = button.GetComponentInChildren<TextMeshProUGUI>();

                    Color color = button.colors.pressedColor;
                    choice_text.color = color;

                    ColorUtility.TryParseHtmlString("#0a100d", out color);
                    button.enabled = false;

                    choice_text.DOColor(color, (AutoPlay ? AutoPlay_ChoiceDelay : DefaultFadeOut)).OnComplete(
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
                    Color color = Color.white;
                    ColorUtility.TryParseHtmlString("#E0E0E0", out color);
                    child.DOColor(color, (AutoPlay ? AutoPlay_ChoiceDelay : DefaultFadeOut)).OnComplete(
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

            var color = Color.white;

            Sequence text_fade = DOTween.Sequence();

            ColorUtility.TryParseHtmlString("#a80f0f", out color);
            text_fade.Insert((AutoPlay ? 0.5f : 1f),
                choice_text.DOColor(color, (AutoPlay ? AutoPlay_ChoiceDelay : 0.5f))).OnComplete(
                () => { choiceButton.enabled = true; });


            return choiceButton;
        }
    }
}
