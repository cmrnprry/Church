using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using DG.Tweening;
using TMPro;

public class TextObjectEffects : MonoBehaviour
{
    private MinMax wait;
    private MinMax duration;
    private MinMax value;
    private TextMeshProUGUI text;
    
    private Sequence class_sequence;
    
    private void Start()
    {
        DOTween.Init();

        text = GetComponent<TextMeshProUGUI>();
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
                case "Bus_Honk":
                    //duration of the tween
                    duration.SetValue(.15f, .25f);

                    //value of the tween
                    value.SetValue(5f, 10);

                    //time between Tweens
                    wait.SetValue(2, 3);

                    dur = duration.GetRandomValue();
                    // class_sequence.Append(text.DOScale(2, 0.15f));
                    break;
                default:
                    Debug.LogWarning($"Could not add IClass {toAdd} to BackgroundImage.");
                    break;
            }
        }
    }
}