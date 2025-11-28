using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using DG.Tweening;
using TMPro;


public class SaveUIPageNumber : MonoBehaviour
{
    private Image Outline;
    private TextMeshProUGUI Text;
    private int Index = -1;

    private bool Selected = false;
    [SerializeField] private Color onHover, onSelected, Default;

    public delegate void OnClickEvent(int Index);
    public static event OnClickEvent OnClick;

    public delegate void HoverEvents();

    public static event HoverEvents OnCursorEnter;
    public static event HoverEvents OnCursorExit;

    private void Awake()
    {
        GetValueIfNull();
    }

    public void SetOutlineColor(bool isHover)
    {
        var color = (isHover) ? onHover : Default;

        if (Selected && !isHover)
            color = onSelected;

        GetValueIfNull();
        SetValues(color);

        if (isHover)
            OnCursorEnter?.Invoke();
        else
            OnCursorExit?.Invoke();
    }

    public void IsPageSelected(bool isSelected)
    {
        Selected = isSelected;
        var color = (isSelected) ? onSelected : Default;

        GetValueIfNull();
        SetValues(color);
    }

    public void ClickPage()
    {
        OnClick?.Invoke(Index);
    }

    public void SetPageNumber(int index)
    {
        GetValueIfNull();

        Text.text = (index + 1).ToString();
        Index = index;

        IsPageSelected(index == 0);
    }

    private void SetValues(Color color)
    {
        if (Text != null)
            Text.DOColor(color, 0.1f);

        if (Outline != null)
            Outline.DOColor(color, 0.1f);
    }

    private void GetValueIfNull()
    {
        if (Outline == null)
            Outline = transform.GetChild(0).GetComponent<Image>();

        if (Text == null)
            Text = transform.GetChild(1).GetComponent<TextMeshProUGUI>();
    }
}
