using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using DG.Tweening;

public class ClickToMoveHelper : MonoBehaviour
{
    private Image img;

    public delegate void HoverEvents();
    public static event HoverEvents OnCursorEnter;
    public static event HoverEvents OnCursorExit;

    private void Start()
    {
        img = GetComponent<Image>();
    }

    public void OnHoverStart()
    {
        OnCursorEnter?.Invoke();
    }

    public void OnHoverEnd()
    {
        OnCursorExit?.Invoke();
    }

    private void OnEnable()
    {
        if (img == null)
            img = GetComponent<Image>();

        img.DOFade(0.54f, 1);
    }
}
