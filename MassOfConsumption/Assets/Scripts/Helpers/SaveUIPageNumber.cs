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

    private void Awake()
    {
        Outline = transform.GetChild(0).GetComponent<Image>();
        Text = transform.GetChild(1).GetComponent<TextMeshProUGUI>();
    }

    public void SetOutlineColor(bool isHover)
    {
        var color = (isHover) ? onHover : Default;

        if (Selected && !isHover)
            color = onSelected;

        Text.DOColor(color, 0.1f);
        Outline.DOColor(color, 0.1f);
    }

    public void IsPageSelected(bool isSelected)
    {
        Selected = isSelected;
        var color = (isSelected) ? onSelected : Default;

        Text.DOColor(color, 0.1f);
        Outline.DOColor(color, 0.1f);
    }

    public void ClickPage()
    {
        OnClick?.Invoke(Index);
    }

    public void SetPageNumber (int index)
    {
        Text.text = (index + 1).ToString();
        Index = index;

        IsPageSelected(index == 0);
    }
}
