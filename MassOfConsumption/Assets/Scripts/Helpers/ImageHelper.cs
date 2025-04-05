using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using DG.Tweening;

public class ImageHelper : MonoBehaviour
{
    private Image image;
    private float duration = 0.5f;

    public GameObject turnon;

    private void Start()
    {
        image = GetComponent<Image>();
    }

    private void OnEnable()
    {
        if (image == null)
            image = GetComponent<Image>();

        image.DOFade(1, duration).OnComplete(() =>
        {
            if (turnon != null)
                turnon.SetActive(true);
        });
    }

    private void OnDisable()
    {
        if (image == null)
            image = GetComponent<Image>();

        image.DOFade(0, duration).OnComplete(() =>
        {
            if (turnon != null)
                turnon.SetActive(false);
        });
    }
}
