using System;
using AYellowpaper.SerializedCollections;
using UnityEngine;
using UnityEngine.UI;
using DG.Tweening;
using Random = UnityEngine.Random;

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

[Serializable]
public struct ZoomData
{
    public float scale;
    public Vector2 position;
    public float duration;

    public ZoomData(float scale, Vector2 position, float duration)
    {
        this.scale = scale;
        this.position = position;
        this.duration = duration;
    }

    public bool IsNull()
    {
        if (scale <= 0 && duration <= 0)
            return true;

        return false;
    }

    public bool CompareData(ZoomData other)
    {
        return (Mathf.Approximately(other.scale, this.scale) && other.position == this.position &&
                Mathf.Approximately(other.duration, this.duration));
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

    private void OnEnable()
    {
        GameManager.OnImageEffectFlip += SetEffectVisibility;
    }

    private void OnDisable()
    {
        GameManager.OnImageEffectFlip -= SetEffectVisibility;
    }

    private void SetEffectVisibility(bool isOn)
    {
        if (isOn)
        {
            if (class_sequence == null || !class_sequence.IsPlaying())
                AddClassTweens();

            if (zoom_sequence == null || !zoom_sequence.IsPlaying())
                AddZoomTweens();
        }
        else
        {
            KillAllTweens();
        }
    }

    private void AddClassTweens()
    {
        var data = SaveSystem.GetImageClassData();
        ApplyClass(data);
    }

    private void AddZoomTweens()
    {
        var data = SaveSystem.GetImageZoomData();
        ZoomImage(data.scale, data.position, data.duration);
    }

    public void ZoomImage(float scale, Vector2 position, float duration = 0.5f)
    {
        var data = new ZoomData(scale, position, duration);
        SaveSystem.AddImageZoomData(data);

        KillZoomTweens();

        if (zoom_sequence == null || !zoom_sequence.active)
            zoom_sequence = DOTween.Sequence();

        if (!GameManager.instance.VisualOverlay)
            return;

        Vector3 scale_vector = new Vector3(scale, scale, scale);

        zoom_sequence.Append(rect.DOScale(scale_vector, duration))
            .Insert(0, rect.DOAnchorPos(position, duration));
    }

    void BlurEffectCallback()
    {
        class_sequence = DOTween.Sequence();

        if (!GameManager.instance.VisualOverlay)
        {
            mat.DOFloat(0, BlurAmount, 0);
            return;
        }

        float dur = duration.GetRandomValue();
        class_sequence.PrependInterval(wait.GetRandomValue())
            .Append(mat.DOFloat(value.GetRandomValue(), BlurAmount, dur))
            .Append(mat.DOFloat(0, BlurAmount, dur)).OnComplete(BlurEffectCallback);
    }

    public void ApplyClass(string toAdd)
    {
        SaveSystem.AddImageClassData(toAdd);

        KillClassTweens();

        if (class_sequence == null || !class_sequence.active)
            class_sequence = DOTween.Sequence();

        if (!GameManager.instance.VisualOverlay)
            return;


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
                case "Angry_Screeching":
                    class_sequence.Append(rect.DOShakePosition(.05f, new Vector3(50, 50, 50), 28, 23))
                        .SetLoops(35, LoopType.Yoyo);
                    break;
                case "stop-1":
                    duration.SetValue(25f, 20);
                    dur = duration.GetRandomValue();
                    class_sequence.Append(rect.DOScale(new Vector3(1.25f, 1.25f, 1.25f), dur))
                        .Insert(0, rect.DOAnchorPosY(-93, dur));
                    break;
                case "stop-2":
                    duration.SetValue(10f, 5);
                    dur = duration.GetRandomValue();
                    class_sequence.Append(rect.DOScale(new Vector3(1.75f, 1.75f, 1.75f), dur))
                        .Insert(0, rect.DOAnchorPosY(-280, 1f));
                    rect.DOShakePosition(0.5f, new Vector3(5, 5, 5), 28, 23).SetLoops(-1, LoopType.Yoyo)
                        .SetDelay(1.05f);
                    break;
                case "stop-3":
                    duration.SetValue(10f, 5);
                    dur = duration.GetRandomValue();
                    class_sequence.Append(rect.DOScale(new Vector3(2.5f, 2.5f, 2.5f), dur))
                        .Insert(0, rect.DOAnchorPosY(-370, 1f));

                    rect.DOShakePosition(0.5f, new Vector3(10, 10, 10), 28, 23).SetLoops(-1, LoopType.Yoyo)
                        .SetDelay(1.05f);
                    break;
                default:
                    Debug.LogWarning($"Could not add IClass {toAdd} to BackgroundImage.");
                    break;
            }
        }
    }


    //KILL TWEENS //


    public void RemoveClassTweens()
    {
        KillClassTweens();
        SaveSystem.ResetImageData();
    }

    public void RemoveZoomTweens()
    {
        ZoomImage(1, Vector2.zero);
        SaveSystem.ResetImageData(true);
    }

    private void KillAllTweens()
    {
        KillZoomTweens();
        rect.DOScale(1, 0);
        rect.DOAnchorPos(Vector2.zero, 0);

        KillClassTweens();
    }

    private void KillZoomTweens()
    {
        if (zoom_sequence != null && zoom_sequence.IsPlaying())
            zoom_sequence.Kill(true);
    }

    private void KillClassTweens()
    {
        if (class_sequence != null && class_sequence.IsPlaying())
            class_sequence.Kill(true);

        rect.DOKill(true);
    }
}