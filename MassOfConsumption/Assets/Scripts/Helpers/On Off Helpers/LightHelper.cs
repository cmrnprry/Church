using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering.Universal;
using DG.Tweening;

public class LightHelper : OnOffHelpers
{
    [SerializeField]
    private List<Light2D> lights;

    protected override void TurnOn()
    {
        foreach (Light2D light in lights)
        {
            float intensity = light.intensity;
            light.intensity = 0;
            light.gameObject.SetActive(true);

            DOTween.To(() => light.intensity, value => light.intensity = value, intensity, duration);
        }

    }

    protected override void TurnOff()
    {
        foreach (Light2D light in lights)
        {
            light.gameObject.SetActive(true);

            DOTween.To(() => light.intensity, value => light.intensity = value, 0, duration).OnComplete(() =>
            {
                light.gameObject.SetActive(false);
            });
        }
    }
}
