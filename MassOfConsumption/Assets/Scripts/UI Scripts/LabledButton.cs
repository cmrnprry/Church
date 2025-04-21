using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;
using DG.Tweening;
using UnityEngine.Events;
using UnityEngine.EventSystems;
using UnityEngine.Serialization;

//Code is adapted from NaniNovel and defualt unity button code
[AddComponentMenu("UI/LabeledButton", 30)]
public class LabledButton : Selectable, IPointerClickHandler, ISubmitHandler
{
    public delegate void HoverEvents();
    public static event HoverEvents OnCursorEnter;
    public static event HoverEvents OnCursorExit;
    
    [Serializable]
    /// <summary>
    /// Function definition for a button click event.
    /// </summary>
    public class LabledButtonClickedEvent : UnityEvent {}

    // Event delegates triggered on click.
    [FormerlySerializedAs("onClick")]
    [SerializeField]
    private LabledButtonClickedEvent m_OnClick = new LabledButtonClickedEvent();

    protected LabledButton()
    {}
    
    protected virtual TextMeshProUGUI Label => labelText ? labelText : (labelText = GetComponentInChildren<TextMeshProUGUI>());
    protected virtual ColorBlock LabelColorBlock => labelColors;
    public virtual Color LabelColorMultiplier
    {
        get => labelColorMultiplier; 
        set { labelColorMultiplier = value; DoStateTransition(currentSelectionState, false); }
    }

    [SerializeField] private TextMeshProUGUI labelText;
    [SerializeField] public ColorBlock labelColors = ColorBlock.defaultColorBlock;

    private Color labelColorMultiplier = Color.white;

    protected override void Awake ()
    {
        base.Awake();
        DOTween.Init();
    }

    // ReSharper disable Unity.PerformanceAnalysis
    protected override void DoStateTransition(SelectionState state, bool instant)
    {
        base.DoStateTransition(state, instant);

        if (!Label) return;

        Color tintColor;
        switch (state)
        {
            case SelectionState.Normal:
                tintColor = LabelColorBlock.normalColor;
                break;
            case SelectionState.Highlighted:
                tintColor = LabelColorBlock.highlightedColor;
                break;
            case SelectionState.Pressed:
                tintColor = LabelColorBlock.pressedColor;
                break;
            case SelectionState.Selected:
                tintColor = LabelColorBlock.selectedColor;
                break;
            case SelectionState.Disabled:
                tintColor = LabelColorBlock.disabledColor;
                break;
            default:
                tintColor = Color.white;
                break;
        }

        if (instant)
        {
            Label.color = tintColor * LabelColorBlock.colorMultiplier * LabelColorMultiplier;
        }
        else //if (tintTweener != null)
        {
            Label.DOColor(
                tintColor * LabelColorBlock.colorMultiplier * LabelColorMultiplier, 
                LabelColorBlock.fadeDuration);
        }
    }
    
    public LabledButtonClickedEvent onClick
    {
        get { return m_OnClick; }
        set { m_OnClick = value; }
    }

    private void Press()
    {
        if (!IsActive() || !IsInteractable())
            return;

        UISystemProfilerApi.AddMarker("Button.onClick", this);
        m_OnClick.Invoke();
    }
    
    public virtual void OnPointerClick(PointerEventData eventData)
    {
        if (eventData.button != PointerEventData.InputButton.Left)
            return;

        Press();
    }
    
    public virtual void OnSubmit(BaseEventData eventData)
    {
        Press();

        // if we get set disabled during the press
        // don't run the coroutine.
        if (!IsActive() || !IsInteractable())
            return;

        DoStateTransition(SelectionState.Pressed, false);
        StartCoroutine(OnFinishSubmit());
    }

    private IEnumerator OnFinishSubmit()
    {
        var fadeTime = colors.fadeDuration;
        var elapsedTime = 0f;

        while (elapsedTime < fadeTime)
        {
            elapsedTime += Time.unscaledDeltaTime;
            yield return null;
        }

        DoStateTransition(currentSelectionState, false);
    }
    
    public override void OnPointerEnter(PointerEventData eventData)
    {
        OnCursorEnter?.Invoke();
        base.OnPointerEnter(eventData);
    }
    
    public override void OnPointerExit(PointerEventData eventData)
    {
        OnCursorExit?.Invoke();
        base.OnPointerExit(eventData);
    }
}
