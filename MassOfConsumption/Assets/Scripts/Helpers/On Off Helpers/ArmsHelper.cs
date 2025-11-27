using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using DG.Tweening;

public class ArmsHelper : OnOffHelpers
{
    private List<GameObject> arms;

    private void Start()
    {
        foreach (Transform arm in this.transform)
        {
            arms.Add(arm.gameObject);
        }
    }

    private void OnEnable()
    {

    }

    protected override void TurnOn()
    {
        foreach (var arm in arms)
        {
            arm.gameObject.SetActive(true);
        }
    }

    protected override void TurnOff()
    {
        foreach (var arm in arms)
        {
            arm.gameObject.SetActive(false);
        }
    }
}
