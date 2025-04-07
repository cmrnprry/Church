using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;


public class Temop : MonoBehaviour
{
    private static readonly int BlurAmount = Shader.PropertyToID("_BlurAmount");
    private Material mat;
    public float amount = 0;

    private void Start()
    {
        
    }

    private void OnValidate()
    {
        if (amount >= 0 && amount <= 0.1f)
        {
            mat = GetComponent<Image>().materialForRendering;
            mat.SetFloat(BlurAmount, amount);
            Debug.Log("changing blur amount to: " + amount);
        }
    }
}