using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using DG.Tweening;

public class ImageHelper : OnOffHelpers
{
    private Image image;

    private void Start()
    {
        image = GetComponent<Image>();
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
            if (turnon != null)
                turnon.GetComponent<OnOffHelpers>().FlipVisibility(true);
        });
    }

    protected override void TurnOff()
    {
        if (image == null)
            image = GetComponent<Image>();

        image.DOFade(0, duration).OnPlay(() =>
        {
            if (turnon != null)
                turnon.GetComponent<OnOffHelpers>().FlipVisibility(false);
        });
    }
}
