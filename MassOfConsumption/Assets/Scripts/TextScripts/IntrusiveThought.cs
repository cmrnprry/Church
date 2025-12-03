using System.Collections;
using System.Collections.Generic;
using AYellowpaper.SerializedCollections;
using UnityEngine;
using DG.Tweening;
using UnityEngine.Serialization;
using TMPro;
using Ink.Runtime;

public class IntrusiveThought : MonoBehaviour
{
    private RectTransform rect;
    private TextMeshProUGUI text_box;
    private LabledButton button;
    private MinMax wait = new MinMax();
    private MinMax fade_min = new MinMax();
    private MinMax fade_max = new MinMax();
    private MinMax scale_min = new MinMax();
    private MinMax scale_max = new MinMax();
    private Sequence rect_sequence;
    private Sequence text_sequence;

    // Start is called before the first frame update
    void Awake()
    {
        rect = this.GetComponent<RectTransform>();
        button = this.GetComponent<LabledButton>();
        text_box = this.transform.GetChild(0).gameObject.GetComponent<TextMeshProUGUI>();
        wait.SetValue(5, 2.5f);
        fade_min.SetValue(0.75f, 0.25f);
        fade_max.SetValue(1, .6f);
        scale_min.SetValue(1f, .5f);
        scale_max.SetValue(1.75f, 1.25f);
        rect_sequence = DOTween.Sequence();
        text_sequence = DOTween.Sequence();

        rect.localScale = Vector3.one * scale_min.GetRandomValue();
        text_box.alpha = fade_min.GetRandomValue();
    }

    private void OnDestroy()
    {
        if (rect_sequence != null)
            rect_sequence.Kill();

        if (text_sequence != null)
            text_sequence.Kill();
    }

    private void CheckIfNull()
    {
        if (rect == null)
            rect = this.GetComponent<RectTransform>();

        if (button == null)
            button = this.GetComponent<LabledButton>();

        if (text_box == null)
            text_box = this.transform.GetChild(0).gameObject.GetComponent<TextMeshProUGUI>();
    }

    public void SetButtonCallback(string jump_to)
    {

        button.onClick.AddListener(() =>
        {
            if (jump_to == "")
            {
                SaveSystem.SetSavedHistory($"{jump_to}");
                KillAllThoughts();
            }
            else
                GameManager.instance.OnClickIntrusiveThought(text_box.text, jump_to);
        });
    }

    public void SetTweens(string text)
    {
        CheckIfNull();

        text_box.text = text;
        text_box.DOFade(fade_max.GetRandomValue(), 1.5f).SetDelay(wait.GetRandomValue());
        //heartbeat option sequence.PrependInterval(wait.GetRandomValue()).Append(rect.DOScale(1.5f, 0.25f)).Append(rect.DOScale(1f, 0.15f)).Append(rect.DOScale(1.5f, 0.25f)).Append(rect.DOScale(1f, 0.15f)).AppendInterval(wait.GetRandomValue()).SetLoops(-1, LoopType.Yoyo);
        rect_sequence.Append(rect.DOScale(scale_max.GetRandomValue(), wait.GetRandomValue()))
            .SetLoops(-1, LoopType.Yoyo);

        text_sequence.AppendInterval(wait.GetRandomValue())
            .Append(text_box.DOFade(fade_max.GetRandomValue(), wait.GetRandomValue())).SetLoops(-1, LoopType.Yoyo);
    }

    public void IncreaseTweens()
    {
        CheckIfNull();

        rect_sequence.Kill();
        rect_sequence = DOTween.Sequence();

        text_sequence.Kill();
        text_sequence = DOTween.Sequence();

        wait.SetValue(1.5f, 0.5f);

        if (rect != null)
            rect.DOScale(1f, 0.15f);

        DOTweenTMPAnimator anim = new DOTweenTMPAnimator(text_box);

        wait = new MinMax();
        wait.SetValue(1f, 0.1f);

        for (int ii = 0; ii < anim.textInfo.characterCount; ++ii)
        {
            if (!anim.textInfo.characterInfo[ii].isVisible)
                continue;

            if (text_box == null)
                break;

            Vector3 currCharOffset = anim.GetCharOffset(ii);

            rect_sequence
                .Insert(wait.GetRandomValue(),
                    anim.DOPunchCharOffset(ii, currCharOffset + new Vector3(5, 5, 0), 0.15f))
                .SetLoops(-1, LoopType.Yoyo);

            if (Random.Range(1, 10) > 5)
                text_sequence.Insert(wait.GetRandomValue(), anim.DOFadeChar(ii, fade_max.GetRandomValue(), 1f))
                    .SetLoops(-1, LoopType.Yoyo);
        }
    }

    public void KillAllThoughts()
    {
        CheckIfNull();

        if (rect_sequence != null)
            rect_sequence.Kill();

        if (text_sequence != null)
            text_sequence.Kill();

        rect_sequence = DOTween.Sequence();
        text_sequence = DOTween.Sequence();

        ResetIndividualCharacters();

        if (text_box != null)
            text_box.DOFade(0, 0.5f);

        if (rect != null)
            rect.DOScale(1.25f, 0.5f).OnComplete(() => { Destroy(this.gameObject); });
    }

    private void ResetIndividualCharacters()
    {
        CheckIfNull();

        DOTweenTMPAnimator anim = new DOTweenTMPAnimator(text_box);

        for (int ii = 0; ii < anim.textInfo.characterCount; ++ii)
        {
            if (!anim.textInfo.characterInfo[ii].isVisible)
                continue;

            Vector3 currCharOffset = anim.GetCharOffset(ii);

            anim.DOPunchCharOffset(ii, currCharOffset, 0.05f);
            anim.DOFadeChar(ii, 1, 0.05f);
        }
    }
}