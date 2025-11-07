using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using DG.Tweening;

public class RawImageHelper : OnOffHelpers
{
    private RawImage raw_image;
    private OnOffHelpers turnoff_OnOff;
    [SerializeField] private float end_alpha = 1;

    private void Start()
    {
        raw_image = GetComponent<RawImage>();

        if (turnon != null && turnoff_OnOff == null)
            turnoff_OnOff = turnon.GetComponent<OnOffHelpers>();
    }

    private void OnEnable()
    {
        if (raw_image == null)
            raw_image = GetComponent<RawImage>();

        if (turnon != null && turnoff_OnOff == null)
            turnoff_OnOff = turnon.GetComponent<OnOffHelpers>();
    }

    protected override void TurnOn()
    {
        if (raw_image == null)
            raw_image = GetComponent<RawImage>();

        raw_image.DOFade(end_alpha, duration).OnPlay(() =>
        {
            if (turnon != null && turnoff_OnOff == null)
                turnoff_OnOff = turnon.GetComponent<OnOffHelpers>();

            turnoff_OnOff.FlipVisibility(true);
        });
    }

    protected override void TurnOff()
    {
        if (raw_image == null)
            raw_image = GetComponent<RawImage>();

        raw_image.DOFade(0, duration).OnPlay(() =>
        {
            if (turnon != null && turnoff_OnOff == null)
                turnoff_OnOff = turnon.GetComponent<OnOffHelpers>();

            turnoff_OnOff.FlipVisibility(false);
        });
    }
}
