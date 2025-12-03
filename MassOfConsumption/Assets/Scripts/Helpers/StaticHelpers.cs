using DG.Tweening;
using UnityEngine.UI;
using UnityEngine;
using System.Collections;
using TMPro;
using UnityEngine.InputSystem;

namespace AYellowpaper.SerializedCollections
{
    public static class StaticHelpers
    {
        //for Background Image setting
        public static bool LastWasDefault = true;

        //For text increments
        public static bool IsTyping = false;
        public static float TextCharacterDelay = 0.035f; //DEFAULT && AUTOPLAY: Time between characters
        public static float TextPunctuationDelay = 0.5f; //DEFAULT && AUTOPLAY: Delay between punctuation characters

        //For skipping text
        public static bool CurrentlySkipping = false;

        public static void SetBackgroundImage(string key, Sprite sprite, Image[] backgrounds, Animator anim)
        {
            Sequence seq = DOTween.Sequence();
            if (LastWasDefault) //if default background is currently shown
            {
                if (key != "Default") //make sure we want to cahnge to a non-default background
                {
                    anim.enabled = false;
                    backgrounds[2].sprite = sprite;

                    if (key == "Bus Stop")
                        ShiftImage(backgrounds[2]);
                    else
                        ShiftImage(backgrounds[2], false, true);

                    seq.Append(backgrounds[0].DOFade(0, 0.25f)).Insert(0, backgrounds[1].DOFade(0, 0.25f)).OnComplete(() =>
                    {
                        backgrounds[2].DOFade(1, 0.25f);
                    });

                    LastWasDefault = false;
                }
            }
            else //a non-deafult background is shown
            {
                if (key == "Default") //we want to show default background
                {
                    backgrounds[0].sprite = sprite;
                    backgrounds[1].sprite = sprite;

                    backgrounds[2].DOFade(0, 0.25f).OnComplete(() =>
                    {
                        seq.Append(backgrounds[0].DOFade(1, 0.25f)).Insert(0, backgrounds[1].DOFade(1, 0.25f)).OnComplete(
                            () => { anim.enabled = true; });
                    });

                    LastWasDefault = true;
                }
                else //switch to a non-default background
                {
                    backgrounds[2].DOFade(0, 0.25f).OnComplete(() =>
                    {
                        backgrounds[2].sprite = sprite;

                        if (key == "Bus Stop")
                            ShiftImage(backgrounds[2]);
                        else
                            ShiftImage(backgrounds[2], false, true);

                        backgrounds[2].DOFade(1, 0.25f);
                    });

                    LastWasDefault = false;
                }
            }

            SaveSystem.SetCurrentSprite(key.Trim());
        }

        public static void SetProp(string src, bool visibility)
        {
            if (GameManager.instance.PropDictionary.ContainsKey(src))
            {
                var obj = GameManager.instance.PropDictionary[src];
                if (!obj.activeSelf)
                    obj.SetActive(visibility);


                if (obj.TryGetComponent(out OnOffHelpers helper))
                {
                    if (src == "Closed_Door" || src == "Open_Door")
                    {
                        obj.GetComponent<OpenDoorHelper>().To_Open = (src == "Closed_Door") ? false : true;
                    }

                    helper.FlipVisibility(visibility);
                }
                else
                {
                    if (src == "eat_heart" || src == "squeeze_heart")
                        ChoseHand(obj.transform, visibility);
                    else
                    {
                        foreach (Transform child in obj.transform)
                        {
                            if (!child.gameObject.activeSelf)
                                child.gameObject.SetActive(true);

                            if (child.TryGetComponent(out OnOffHelpers child_helper))
                                child_helper.FlipVisibility(visibility);
                        }
                    }

                }

                SaveSystem.SetCurrentProp(src, visibility);
            }
        }

        private static void ChoseHand(Transform parent, bool visibility)
        {
            bool isChopped = GameManager.instance.Story.variablesState["Church_Encounters"].ToString().Contains("Finger_Chopped");
            bool isBranded = GameManager.instance.Story.variablesState["Book_Knowledge"].ToString().Contains("Branded");

            int child_index = (!isBranded && isChopped) ? 1 : 0;
            child_index = (isBranded && isChopped) ? 3 : child_index;
            child_index = (isBranded && !isChopped) ? 2 : child_index;

            if (!parent.GetChild(child_index).gameObject.activeSelf)
                parent.GetChild(child_index).gameObject.SetActive(true);

            if (parent.GetChild(child_index).TryGetComponent(out OnOffHelpers child_helper))
                child_helper.FlipVisibility(visibility);
        }

        public static void ShiftImage(Image background, bool wasVisible = false, bool isNonBus = false)
        {
            int pos = wasVisible ? -100 : 100;
            float time = wasVisible ? 0.5f : 0;

            if (isNonBus)
            {
                pos = 0;
                time = 0;
            }

            background.gameObject.GetComponent<RectTransform>().DOAnchorPosX(pos, time);
        }

        public static IEnumerator IncrementText(string text, TMP_Text currentTextbox, ScrollRect Scroll, float AutoScrollDelay, Material Mask)
        {
            IsTyping = true;
            currentTextbox.maxVisibleCharacters = 0;
            currentTextbox.text = text;
            currentTextbox.alpha = 225;
            yield return null;
            Scroll.DOVerticalNormalizedPos(1, AutoScrollDelay);
            Scroll.content.ForceUpdateRectTransforms();

            currentTextbox.ForceMeshUpdate(true);
            TMP_TextInfo textInfo = currentTextbox.textInfo;
            int totalCharacters = textInfo.characterCount;

            int lines = textInfo.lineCount;
            TMP_LineInfo[] lineInfo = textInfo.lineInfo;
            int[] linecharacter = new int[lines];

            int index = 0;
            int counter = 0;
            Mask.DOFloat(GetMaskValue(index), "_Start", 0.15f);
            for (int i = 0; i < totalCharacters; i++)
            {
                if (CurrentlySkipping)
                {
                    IsTyping = false;
                    GameManager.instance.CanClick = false;
                    CurrentlySkipping = false;

                    currentTextbox.maxVisibleCharacters = totalCharacters;
                    Mask.DOFloat(GetMaskValue(lines), "_Start", 0.15f);

                    yield return new WaitForEndOfFrame();
                    yield break;
                }

                if (i == 1)
                {
                    currentTextbox.ForceMeshUpdate(true);
                    lines = textInfo.lineCount;
                    lineInfo = textInfo.lineInfo;
                    linecharacter = new int[lines];

                    for (int ii = 0; ii < lines; ii++)
                    {
                        linecharacter[ii] = lineInfo[ii].characterCount;
                    }
                }

                currentTextbox.maxVisibleCharacters++;
                char character = textInfo.characterInfo[i].character;

                if (character == '.' || character == '?')
                    yield return new WaitForSeconds(TextPunctuationDelay);
                else
                    yield return new WaitForSeconds(TextCharacterDelay);

                if (counter >= linecharacter[index] && i >= 1)
                {
                    index++;
                    counter = 0;
                    Mask.DOFloat(GetMaskValue(index), "_Start", 0.15f);
                }

                counter++;
            }

            IsTyping = false;
            currentTextbox.maxVisibleCharacters = totalCharacters;
            yield return new WaitForEndOfFrame();
        }

        private static float GetMaskValue(int index)
        {
            switch (index)
            {
                case 0:
                    return 0.8f;
                case 1:
                    return 0.75f;
                case 2:
                    return 0.65f;
                case 3:
                    return 0.5f;
                case 4:
                    return 0.35f;
                case 5:
                    return 0.2f;
                default:
                    return 0;
            }
        }

        public static IEnumerator CheckSkip()
        {
            yield return new WaitUntil(() => IsTyping);

            yield return new WaitUntil(() =>
                                                GameManager.instance.Actions.Controls.Continue.triggered || GameManager.instance.CanClick || !IsTyping || CurrentlySkipping);

            if (!IsTyping || CurrentlySkipping)
                yield break;
            yield return new WaitForEndOfFrame();

            CurrentlySkipping = true;
        }

        public static void AddIntrusiveThoughts(int amount, string text, string jump_to, IntrusiveThoughtsManager intrusiveThoughts)
        {
            intrusiveThoughts.IncreaseThought();

            for (int i = 0; i < amount; i++)
                intrusiveThoughts.SpawnThought(text, jump_to);
        }
    }
}