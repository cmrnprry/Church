using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public abstract class OnOffHelpers : MonoBehaviour
{
    protected float duration = 0.5f;

    [SerializeField]
    protected GameObject turnon;

    public void FlipVisibility(bool visible)
    {
        if (!visible)
            TurnOff();
        else
            TurnOn();
    }

    protected abstract void TurnOn();

    protected abstract void TurnOff();
}
