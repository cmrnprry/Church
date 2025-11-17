using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using DG.Tweening;

public class ImageHelper : OnOffHelpers
{
    private Image image;
    private OnOffHelpers turnoff_OnOff;
    [SerializeField] private float end_alpha = 1;

    private void Start()
    {
        image = GetComponent<Image>();

        if (turnon != null)
            turnoff_OnOff = turnon.GetComponent<OnOffHelpers>();
    }

    private void OnEnable()
    {
        if (image == null)
            image = GetComponent<Image>();

        if (turnon != null)
            turnoff_OnOff = turnon.GetComponent<OnOffHelpers>();
    }

    protected override void TurnOn()
    {
        if (image == null)
            image = GetComponent<Image>();

        image.DOFade(end_alpha, duration).OnPlay(() =>
        {
            if (turnon != null)
            {
                if (turnoff_OnOff == null)
                    turnoff_OnOff = turnon.GetComponent<OnOffHelpers>();

                turnoff_OnOff.FlipVisibility(true);
            }
        });
    }

    protected override void TurnOff()
    {
        if (image == null)
            image = GetComponent<Image>();

        image.DOFade(0, duration).OnPlay(() =>
        {
            if (turnon != null)
            {
                if (turnoff_OnOff == null)
                turnoff_OnOff = turnon.GetComponent<OnOffHelpers>();
                    turnoff_OnOff.FlipVisibility(false);
            }

        }).OnComplete(() =>
        {
            image.gameObject.SetActive(false);
        });
    }
}
