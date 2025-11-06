using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using DG.Tweening;

public class OpenDoorHelper : OnOffHelpers
{
    [SerializeField] private List<Image> image;
    [HideInInspector] public bool To_Open = false;
    private float switch_duration = 1;


    private void Start()
    {
    }

    private void OnEnable()
    {
       // TurnOn();
    }

    protected override void TurnOn()
    {
        Image start = To_Open ? image[0] : image[2];
        Image end = To_Open ? image[2] : image[0];
        Sequence sequence_1 = DOTween.Sequence();

        sequence_1.Append(start.DOFade(1, duration)).AppendInterval(5f)
            .Insert(1, start.DOFade(0, switch_duration)).Insert(0.75f, image[1].DOFade(1, switch_duration))
            .Insert(2.25f, image[1].DOFade(0, switch_duration)).Insert(2f, end.DOFade(1, switch_duration));
    }

    protected override void TurnOff()
    {
        image[0].DOFade(0, duration);
        image[1].DOFade(0, duration);
        image[2].DOFade(0, duration).OnComplete(() => { this.gameObject.SetActive(false); });
    }
}