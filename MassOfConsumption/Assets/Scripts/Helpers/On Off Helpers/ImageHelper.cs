using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using DG.Tweening;

public class ImageHelper : OnOffHelpers
{
    private Image image;
    private OnOffHelpers turnoff_OnOff;

    private void Start()
    {
        image = GetComponent<Image>();
        turnoff_OnOff = GetComponent<OnOffHelpers>();
    }

    private void OnEnable()
    {
        if (image == null)
            image = GetComponent<Image>();
    }

    protected override void TurnOn()
    {
        if (image == null)
            image = GetComponent<Image>();

        image.DOFade(1, duration).OnPlay(() =>
        {
            if (turnoff_OnOff != null)
                turnon.GetComponent<OnOffHelpers>();

            turnoff_OnOff.FlipVisibility(true);
        });
    }

    protected override void TurnOff()
    {
        if (image == null)
            image = GetComponent<Image>();

        image.DOFade(0, duration).OnPlay(() =>
        {
            if (turnoff_OnOff != null)
                turnon.GetComponent<OnOffHelpers>();

            turnoff_OnOff.FlipVisibility(false);
        });
    }
}
