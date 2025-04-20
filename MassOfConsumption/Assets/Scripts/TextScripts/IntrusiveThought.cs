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
    private MinMax fade = new MinMax();
    private MinMax scale = new MinMax();
    private Sequence rect_sequence;
    private Sequence text_sequence;

    // Start is called before the first frame update
    void Awake()
    {
        rect = this.GetComponent<RectTransform>();
        button = this.GetComponent<LabledButton>();
        text_box = this.transform.GetChild(0).gameObject.GetComponent<TextMeshProUGUI>();
        wait.SetValue(5, 2.5f);
        fade.SetValue(1, 0);
        scale.SetValue(1.5f, 0);
        rect_sequence = DOTween.Sequence();
        text_sequence = DOTween.Sequence();
    }

    public void SetButtonCallback(string jump_to)
    {
        button.onClick.AddListener(() => { GameManager.instance.OnClickIntrusiveThought(text_box.text, jump_to); });
    }

    public void SetTweens(string text)
    {
        text_box.text = text;
        text_box.DOFade(fade.GetRandomValue(), 1.5f).SetDelay(wait.GetRandomValue());
        //heartbeat option sequence.PrependInterval(wait.GetRandomValue()).Append(rect.DOScale(1.5f, 0.25f)).Append(rect.DOScale(1f, 0.15f)).Append(rect.DOScale(1.5f, 0.25f)).Append(rect.DOScale(1f, 0.15f)).AppendInterval(wait.GetRandomValue()).SetLoops(-1, LoopType.Yoyo);
        rect_sequence.Append(rect.DOScale(scale.GetRandomValue(), wait.GetRandomValue()))
            .SetLoops(-1, LoopType.Yoyo);

        text_sequence.AppendInterval(wait.GetRandomValue())
            .Append(text_box.DOFade(fade.GetRandomValue(), wait.GetRandomValue())).SetLoops(-1, LoopType.Yoyo);
    }

    public void IncreaseTweens()
    {
        rect_sequence.Kill();
        rect_sequence = DOTween.Sequence();
        
        text_sequence.Kill();
        text_sequence = DOTween.Sequence();

        wait.SetValue(1.5f, 0.5f);
        rect.DOScale(1f, 0.15f);

        DOTweenTMPAnimator anim = new DOTweenTMPAnimator(text_box);

        wait = new MinMax();
        wait.SetValue(1f, 0.1f);

        for (int ii = 0; ii < anim.textInfo.characterCount; ++ii)
        {
            if (!anim.textInfo.characterInfo[ii].isVisible) continue;
            Vector3 currCharOffset = anim.GetCharOffset(ii);

            rect_sequence
                .Insert(wait.GetRandomValue(),
                    anim.DOPunchCharOffset(ii, currCharOffset + new Vector3(5, 5, 0), 0.15f))
                .SetLoops(-1, LoopType.Yoyo);
            
            if (Random.Range(1, 10) > 5)
                text_sequence.Insert(wait.GetRandomValue(), anim.DOFadeChar(ii, fade.GetRandomValue(), 1f))
                    .SetLoops(-1, LoopType.Yoyo);
        }
    }

    public void KillAllThoughts()
    {
        rect_sequence.Kill();
        text_sequence.Kill();

        rect_sequence = DOTween.Sequence();
        text_sequence = DOTween.Sequence();

        ResetIndividualCharacters();
        text_box.DOFade(0, 0.5f);
        rect.DOScale(1.25f, 0.5f).OnComplete(() => { Destroy(this.gameObject); });
    }

    private void ResetIndividualCharacters()
    {
        DOTweenTMPAnimator anim = new DOTweenTMPAnimator(text_box);

        for (int ii = 0; ii < anim.textInfo.characterCount; ++ii)
        {
            if (!anim.textInfo.characterInfo[ii].isVisible) continue;
            Vector3 currCharOffset = anim.GetCharOffset(ii);

            anim.DOPunchCharOffset(ii, currCharOffset, 0);
            anim.DOFadeChar(ii, 1, 0);
        }
    }
}