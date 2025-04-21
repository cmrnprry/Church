using UnityEngine;
using UnityEngine.Serialization;
using UnityEngine.UI;
using DG.Tweening;
using UnityEngine.EventSystems;

//Code adapted from https://github.com/Maraakis/ChristinaCreatesGames/tree/main/Toggle%20Switch%20System
public class ToggleSwitchColorChange : ToggleSwitch, IPointerEnterHandler, IPointerExitHandler
{
    [Header("Elements to Recolor")]
    [SerializeField] private Image backgroundImage;
    [SerializeField] private Image handleImage;
        
    [FormerlySerializedAs("recolorBackground")]
    [Space]
    [SerializeField] private bool changeSpriteBackground;
    [SerializeField] private bool recolorHandle;
        
    [Header("Colors")]
    [SerializeField] private Color backgroundColorOff = Color.white;
    [SerializeField] private Color backgroundColorOn = Color.white;
    [SerializeField] private Sprite backgroundImageOff;
    [SerializeField] private Sprite backgroundImageOn;
    [Space]
    [SerializeField] private Color handleColorOff = Color.white;
    [SerializeField] private Color handleColorOn = Color.white;
        
    private bool _isBackgroundImageNotNull;
    private bool _isHandleImageNotNull;
    
    public delegate void HoverEvents();
    public static event HoverEvents OnCursorEnter;
    public static event HoverEvents OnCursorExit;
        
    protected override void OnValidate()
    {
        base.OnValidate();
            
        CheckForNull();
        ChangeColors();
    }

    private void OnEnable()
    {
        transitionEffect += ChangeColors;
    }
        
    private void OnDisable()
    {
        transitionEffect -= ChangeColors;
    }

    protected override void Awake() 
    {
        base.Awake();
            
        CheckForNull();
        ChangeColors();
    }

    private void CheckForNull()
    {
        _isBackgroundImageNotNull = backgroundImage != null;
        _isHandleImageNotNull = handleImage != null;
    }
    
    private void ChangeColors()
    {
        if (changeSpriteBackground && _isBackgroundImageNotNull)
        {
            if (sliderValue >= 1)
            {
                backgroundImage.sprite = backgroundImageOn; 
                backgroundImage.color = backgroundColorOn;
                handleImage.color = handleColorOn;
            }
            else if (sliderValue <= 0)
            {
                backgroundImage.sprite = backgroundImageOff;
                backgroundImage.color = backgroundColorOff;
                handleImage.color = handleColorOff;
            }
        }
            
        //if (recolorHandle && _isHandleImageNotNull)
        //    handleImage.color = Color.Lerp(handleColorOff, handleColorOn, sliderValue); 
    }

    public void OnPointerEnter(PointerEventData eventData)
    {
        OnCursorEnter?.Invoke();
    }

    public void OnPointerExit(PointerEventData eventData)
    {
        OnCursorExit?.Invoke();
    }
}
