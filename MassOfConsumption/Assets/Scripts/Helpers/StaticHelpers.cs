using DG.Tweening;
using UnityEngine.UI;
using UnityEngine;
using System.Collections;
using TMPro;

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
        public static bool StillNeedToSkip = true;

        public static void SetBackgroundImage(string key, Sprite sprite, Image[] backgrounds, Animator anim)
        {
            Debug.Log("Current Image is: " + key);
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
                    SaveSystem.SetCurrentSprite(key.Trim());
                }
            }
            else //a non-deafult background is shown
            {
                if (key == "Default") //we want to show default background
                {
                    backgrounds[0].sprite = sprite;
                    backgrounds[1].sprite = sprite;
                    SaveSystem.SetCurrentSprite("Default");


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
                    SaveSystem.SetCurrentSprite(key.Trim());
                }
            }
        }

        public static void SetProp(string src, bool visibility)
        {
            if (GameManager.instance.PropDictionary.ContainsKey(src))
            {
                var obj = GameManager.instance.PropDictionary[src];
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
                    foreach (Transform child in obj.transform)
                    {
                        if (child.TryGetComponent(out OnOffHelpers child_helper))
                            child_helper.FlipVisibility(visibility);
                    }
                }

                SaveSystem.SetCurrentProp(src, visibility);
            }
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

        public static IEnumerator IncrementText(string text, TMP_Text currentTextbox, ScrollRect Scroll, float AutoScrollDelay)
        {
            IsTyping = true;
            currentTextbox.maxVisibleCharacters = 0;
            currentTextbox.text = text;
            currentTextbox.alpha = 225;
            yield return null;

            Scroll.DOVerticalNormalizedPos(0, AutoScrollDelay);
            Scroll.content.ForceUpdateRectTransforms();

            currentTextbox.ForceMeshUpdate();
            TMP_TextInfo textInfo = currentTextbox.textInfo;
            int totalCharacters = textInfo.characterCount;

            for (int i = 0; i < totalCharacters; i++)
            {
                if (CurrentlySkipping)
                {
                    IsTyping = false;
                    currentTextbox.maxVisibleCharacters = totalCharacters;

                    yield return new WaitForEndOfFrame();
                    CurrentlySkipping = false;
                    StillNeedToSkip = true;

                    yield break;
                }

                currentTextbox.maxVisibleCharacters++;
                char character = textInfo.characterInfo[i].character;

                if (character == '.' || character == '?')
                    yield return new WaitForSeconds(TextPunctuationDelay);
                else
                    yield return new WaitForSeconds(TextCharacterDelay);
            }

            IsTyping = false;
            currentTextbox.maxVisibleCharacters = totalCharacters;
            yield return new WaitForEndOfFrame();
        }

        public static IEnumerator CheckSkip()
        {
            yield return new WaitUntil(() => IsTyping);
            yield return new WaitUntil(() =>
                                               (Input.GetButtonDown("Continue") || (Input.GetMouseButtonDown(0) && GameManager.instance.CanClick)) || !IsTyping || CurrentlySkipping);

            if (!IsTyping || CurrentlySkipping)
                yield break;

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