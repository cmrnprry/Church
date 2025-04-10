using System.Collections;
using System.Collections.Generic;
using AYellowpaper.SerializedCollections;
using UnityEngine;
using UnityEngine.UI;
using DG.Tweening;


public struct MinMax
{
    private float Max;
    private float Min;

    public void SetValue(float max, float min)
    {
        Max = max;
        Min = min;
    }

    public float GetRandomValue()
    {
        return Random.Range(Min, Max);
    }
}

public class BackgroundImage : MonoBehaviour
{
    private MinMax wait;
    private MinMax duration;
    private MinMax value;

    private static readonly int BlurAmount = Shader.PropertyToID("_BlurAmount");
    private Material mat;
    private RectTransform rect;
    private Coroutine coroutine;
    private Sequence class_sequence;
    private Sequence zoom_sequence;

    private void Start()
    {
        DOTween.Init();

        mat = GetComponent<Image>().materialForRendering;
        rect = GetComponent<RectTransform>();
    }

    public void ZoomImage(float scale, Vector2 position, float duration)
    {
        if (zoom_sequence != null && zoom_sequence.IsPlaying())
            zoom_sequence.Kill(true);

        zoom_sequence = DOTween.Sequence();
        
        Vector3 scale_vector = new Vector3(scale, scale, scale);

        zoom_sequence.Append(rect.DOScale(scale_vector, duration))
            .Insert(0, rect.DOAnchorPos(position, duration));
    }

    void BlurEffectCallback()
    {
        class_sequence = DOTween.Sequence();
        
        float dur = duration.GetRandomValue();
        class_sequence.PrependInterval(wait.GetRandomValue()).Append(mat.DOFloat(value.GetRandomValue(), BlurAmount, dur))
            .Append(mat.DOFloat(0, BlurAmount, dur)).OnComplete(BlurEffectCallback);
    }

    public void ApplyClass(string toAdd)
        {
            if (class_sequence != null && class_sequence.IsPlaying())
                class_sequence.Kill(true);
            
            class_sequence = DOTween.Sequence();

            float dur = 0;
            if (toAdd != "NULL")
            {
                switch (toAdd)
                {
                    case "Swimming":
                        //duration of the tween
                        duration.SetValue(.15f, .25f);
                        
                        //value of the tween
                        value.SetValue(5f, 10);
                        
                        //time between Tweens
                        wait.SetValue(2, 3);
                        
                        dur = duration.GetRandomValue();
                        class_sequence.Append(mat.DOFloat(value.GetRandomValue(), BlurAmount, dur))
                            .Append(mat.DOFloat(0, BlurAmount, dur)).OnComplete(BlurEffectCallback);
                        break;
                    case "Swimming-2":
                        //duration of the tween
                        duration.SetValue(0.5f, 1);
                        
                        //value of the tween
                        value.SetValue(10, 20);
                        
                        //time between Tweens
                        wait.SetValue(2, 3);
                        
                        dur = duration.GetRandomValue();
                        class_sequence.Append(mat.DOFloat(value.GetRandomValue() * .1f, BlurAmount, dur))
                            .Append(mat.DOFloat(0, BlurAmount, dur)).OnComplete(BlurEffectCallback);
                        break;
                    case "Swimming-3":
                        //duration of the tween
                        duration.SetValue(1.5f, 3);
                        
                        //value of the tween
                        value.SetValue(20, 40);
                        
                        //time between Tweens
                        wait.SetValue(1, 2);
                        
                        dur = duration.GetRandomValue();
                        class_sequence.Append(mat.DOFloat(value.GetRandomValue() * .1f, BlurAmount, dur))
                            .Append(mat.DOFloat(0, BlurAmount, dur)).OnComplete(BlurEffectCallback);
                        break;
                        break;
                    default:
                        Debug.LogWarning($"Could not add IClass {toAdd} to BackgroundImage.");
                        break;
                }
            }
        }
    }