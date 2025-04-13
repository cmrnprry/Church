using UnityEngine;
using DG.Tweening;
using TMPro;
using UnityEngine.UI;

public class TextObjectEffects : MonoBehaviour
{
    private MinMax wait;
    private MinMax duration;
    private MinMax value;
    private TextMeshProUGUI text;
    private RectTransform rect;
    
    private Sequence class_sequence;
    
    private void Start()
    {
        DOTween.Init();

        text = GetComponent<TextMeshProUGUI>();
        rect = GetComponent<RectTransform>();
    }
    public void ApplyClass(string toAdd)
    {
        if (class_sequence != null && class_sequence.IsPlaying())
            class_sequence.Kill(true);

        class_sequence = DOTween.Sequence();
        
        if (text == null)
            text = GetComponent<TextMeshProUGUI>();
        
        text.alignment = TextAlignmentOptions.Center;

        if (toAdd != "NULL")
        {
            float size = 50;
            VerticalLayoutGroup layout = this.transform.parent.gameObject.GetComponent<VerticalLayoutGroup>();

            switch (toAdd)
            {
                case "Bus_Honk":
                    text.enableAutoSizing = false;
                    size = text.fontSize;
                    class_sequence.Append(text.DOFontSize(80, 0.2f)).Append(text.DOFontSize(size, 0.1f)).Append(text.DOFontSize(80, 0.2f)).Insert(1.65f, text.DOFontSize(size, 0.1f));
                    break;
                case "Bang_Short":
                    text.enableAutoSizing = false;
                    size = text.fontSize;
                    class_sequence.Append(text.DOFontSize(80, 0.2f)).Append(text.DOFontSize(size, 0.05f)).Append(text.DOFontSize(80, 0.2f)).Append(text.DOFontSize(size, 0.05f)).Append(text.DOFontSize(80, 0.2f)).Insert(1.05f, text.DOFontSize(size, 0.1f));
                    break;
                case "Kick":
                    layout.enabled = false;
                    class_sequence.Append(rect.DOShakePosition(.1f, new Vector3(50, 1, 1), 5)).SetLoops(4, LoopType.Yoyo).OnComplete(() => { layout.enabled = true; });
                    break;
                case "Drop_Screw":
                    layout.enabled = false;
                    class_sequence.Append(rect.DOAnchorPosY(100f, 0.01f)).Append(rect.DOAnchorPosY(-10, 0.15f)).Append(rect.DOAnchorPosY(20f, 0.1f)).Append(rect.DOAnchorPosY(-5, 0.05f)).Append(rect.DOAnchorPosY(2f, 0.25f)).Append(rect.DOAnchorPosY(0f, 0.1f)).OnComplete(() => { layout.enabled = true; });
                    break;
                case "Angry_Screeching":
                    layout.enabled = false;
                    class_sequence.Append(rect.DOShakePosition(.05f, new Vector3(50, 50, 50), 28, 23)).SetLoops(35, LoopType.Yoyo).OnComplete(() => { layout.enabled = true; size = text.fontSize;});
                    break;
                default:
                    Debug.LogWarning($"Could not add IClass {toAdd} to BackgroundImage.");
                    break;
            }
        }
    }
}