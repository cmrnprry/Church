using System;
using System.Collections.Generic;
using AYellowpaper.SerializedCollections;
using UnityEngine;
using DG.Tweening;
using Ink.Parsed;
using TMPro;
using UnityEngine.UI;
using Random = UnityEngine.Random;
using Sequence = DG.Tweening.Sequence;

public class TextObjectEffects : MonoBehaviour
{
    private MinMax wait;
    private MinMax duration;
    private MinMax value;
    private TextMeshProUGUI text;
    private RectTransform rect;
    private List<string> classes = new List<string>();


    private Sequence class_sequence;
    private Sequence fade_sequence;

    private void Start()
    {
        DOTween.Init();

        text = GetComponent<TextMeshProUGUI>();
        rect = GetComponent<RectTransform>();
    }

    private void OnEnable()
    {
        GameManager.OnTextEffectFlip += SetTextEffectVisibility;
    }

    private void OnDisable()
    {
        GameManager.OnTextEffectFlip -= SetTextEffectVisibility;
    }

    private void SetTextEffectVisibility(bool isOn)
    {
        if (isOn && (class_sequence == null || !class_sequence.IsPlaying()))
        {
            AddAllTweens();
        }
        else if (!isOn)
        {
            KillAllTweens();
        }
    }

    private void AddAllTweens()
    {
        foreach (var c in classes)
        {
            ApplyClass(c);
        }
    }

    private void KillAllTweens()
    {
        if (class_sequence != null && class_sequence.IsPlaying())
            class_sequence.Kill(true);

        if (fade_sequence != null && fade_sequence.IsPlaying())
            fade_sequence.Kill(true);

        ResetIndividualCharacters();
    }

    private void ResetIndividualCharacters()
    {
        DOTweenTMPAnimator anim = new DOTweenTMPAnimator(text);

        for (int ii = 0; ii < anim.textInfo.characterCount; ++ii)
        {
            if (!anim.textInfo.characterInfo[ii].isVisible) continue;
            Vector3 currCharOffset = anim.GetCharOffset(ii);

            anim.DOPunchCharOffset(ii, currCharOffset, 0);
            anim.DOFadeChar(ii, 1, 0);
        }
    }


    public void ApplyClass(string toAdd)
    {
        KillAllTweens();

        if (!classes.Contains(toAdd))
            classes.Add(toAdd);

        if (!GameManager.instance.TextEffects)
            return;

        if (text == null)
            text = GetComponent<TextMeshProUGUI>();

        text.alignment = TextAlignmentOptions.Center;

        if (toAdd != "NULL" || toAdd != "")
        {
            float size = 50;
            VerticalLayoutGroup layout = this.transform.parent.gameObject.GetComponent<VerticalLayoutGroup>();
            
            if (class_sequence == null || !class_sequence.active)
                class_sequence = DOTween.Sequence();
        
            if (fade_sequence == null || !fade_sequence.active)
                fade_sequence = DOTween.Sequence();

            switch (toAdd)
            {
                case "Bus_Honk":
                    text.enableAutoSizing = false;
                    size = text.fontSize;
                    class_sequence.Append(text.DOFontSize(80, 0.2f)).Append(text.DOFontSize(size, 0.1f))
                        .Append(text.DOFontSize(80, 0.2f)).Insert(1.65f, text.DOFontSize(size, 0.1f));
                    break;
                case "Bang_Confessional":
                    text.enableAutoSizing = false;
                    size = text.fontSize;
                    class_sequence.Append(text.DOFontSize(80, 0.25f)).Append(text.DOFontSize(size, 0.09f))
                        .Append(text.DOFontSize(80, 0.25f)).Append(text.DOFontSize(size, 0.09f))
                        .Append(text.DOFontSize(80, 0.25f)).Insert(1.15f, text.DOFontSize(size, 0.1f));
                    break;
                case "Bang_Short":
                    text.enableAutoSizing = false;
                    size = text.fontSize;
                    class_sequence.Append(text.DOFontSize(80, 0.2f)).Append(text.DOFontSize(size, 0.05f))
                        .Append(text.DOFontSize(80, 0.2f)).Append(text.DOFontSize(size, 0.05f))
                        .Append(text.DOFontSize(80, 0.2f)).Insert(1.05f, text.DOFontSize(size, 0.1f));
                    break;
                case "Kick":
                    layout.enabled = false;
                    class_sequence.Append(rect.DOShakePosition(.1f, new Vector3(50, 1, 1), 5))
                        .SetLoops(4, LoopType.Yoyo).OnComplete(() => { layout.enabled = true; });
                    break;
                case "Drop_Screw":
                    layout.enabled = false;
                    class_sequence.Append(rect.DOAnchorPosY(100f, 0.01f)).Append(rect.DOAnchorPosY(-10, 0.15f))
                        .Append(rect.DOAnchorPosY(20f, 0.1f)).Append(rect.DOAnchorPosY(-5, 0.05f))
                        .Append(rect.DOAnchorPosY(2f, 0.25f)).Append(rect.DOAnchorPosY(0f, 0.1f))
                        .OnComplete(() => { layout.enabled = true; });
                    break;
                case "Slide_Down":
                    layout.enabled = false;
                    class_sequence.Append(rect.DOAnchorPosY(100f, 0.01f)).Append(rect.DOAnchorPosY(0, 0.25f))
                        .Append(rect.DOShakeAnchorPos(0.05f, new Vector2(10, 0), 10, 0f))
                        .OnComplete(() => { layout.enabled = true; });
                    break;
                case "Angry_Screeching":
                    layout.enabled = false;
                    class_sequence.Append(rect.DOShakePosition(.05f, new Vector3(50, 50, 50), 28, 23))
                        .SetLoops(35, LoopType.Yoyo).OnComplete(() =>
                        {
                            layout.enabled = true;
                            size = text.fontSize;
                        });
                    break;
                case "Blur":
                    DOTweenTMPAnimator animator = new DOTweenTMPAnimator(text);
                    for (int ii = 0; ii < animator.textInfo.characterCount; ++ii)
                    {
                        if (!animator.textInfo.characterInfo[ii].isVisible) continue;
                        Vector3 currCharOffset = animator.GetCharOffset(ii);
                        class_sequence.Join(animator.DOShakeCharOffset(ii, 0.5f, currCharOffset + new Vector3(3, 3, 0)))
                            .Join(animator.DOFadeChar(ii, 0.25f, 0.5f)).SetLoops(-1, LoopType.Yoyo);
                    }

                    break;
                case "Fidget":
                    DOTweenTMPAnimator fid_anim = new DOTweenTMPAnimator(text);
                    wait = new MinMax();
                    wait.SetValue(1f, 0.1f);
                    for (int ii = 0; ii < fid_anim.textInfo.characterCount; ++ii)
                    {
                        if (!fid_anim.textInfo.characterInfo[ii].isVisible) continue;
                        Vector3 currCharOffset = fid_anim.GetCharOffset(ii);
                        class_sequence
                            .Insert(wait.GetRandomValue(),
                                fid_anim.DOPunchCharOffset(ii, currCharOffset + new Vector3(5, 5, 0), 0.15f))
                            .SetLoops(-1, LoopType.Yoyo);
                    }

                    break;
                case "Blurrier":
                    DOTweenTMPAnimator anim = new DOTweenTMPAnimator(text);
                    wait = new MinMax();
                    wait.SetValue(1f, 0.1f);
                    fade_sequence = DOTween.Sequence();

                    for (int ii = 0; ii < anim.textInfo.characterCount; ++ii)
                    {
                        if (!anim.textInfo.characterInfo[ii].isVisible) continue;
                        Vector3 currCharOffset = anim.GetCharOffset(ii);

                        class_sequence
                            .Insert(wait.GetRandomValue(),
                                anim.DOPunchCharOffset(ii, currCharOffset + new Vector3(3, 3, 0), 0.15f))
                            .SetLoops(-1, LoopType.Yoyo);
                        if (Random.Range(1, 10) > 5)
                            fade_sequence.Insert(wait.GetRandomValue(), anim.DOFadeChar(ii, 0.15f, 1f))
                                .SetLoops(-1, LoopType.Yoyo);
                    }

                    break;
                default:
                    Debug.LogWarning($"Could not add IClass {toAdd} to BackgroundImage.");
                    break;
            }
        }
    }
}