using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using DG.Tweening;
using TMPro;

public class SettingsUIButton : MonoBehaviour
{
    private Image Background;
    private TextMeshProUGUI Text;
    public int Index = -1;

    private bool Selected = false;
    [SerializeField] private Color Red, Accent, Light, Dark;

    public delegate void HoverEvents();

    public static event HoverEvents OnCursorEnter;
    public static event HoverEvents OnCursorExit;

    public delegate void OnClickEvent(int Index);

    public static event OnClickEvent OnClick;

    private void Awake()
    {
        Background = GetComponent<Image>();
        Text = transform.GetChild(0).GetComponent<TextMeshProUGUI>();
    }

    public void OnHover(bool isHover)
    {
        Color text_color = (isHover) ? Light : Dark;
        Color image_color = (isHover) ? Red : Light;

        if (Selected && !isHover)
        {
            text_color = Light;
            image_color = Accent;
        }

        Text.DOColor(text_color, 0.1f);
        Background.DOColor(image_color, 0.1f);

        if (isHover)
            OnCursorEnter?.Invoke();
        else
            OnCursorExit?.Invoke();
    }

    public void IsPageSelected(bool isSelected)
    {
        Selected = isSelected;

        Color text_color = (isSelected) ? Light : Dark;
        Color image_color = (isSelected) ? Accent : Light;

        Text.DOColor(text_color, 0.1f);
        Background.DOColor(image_color, 0.1f);
    }

    public void ClickPage()
    {
        OnClick?.Invoke(Index);
    }
}