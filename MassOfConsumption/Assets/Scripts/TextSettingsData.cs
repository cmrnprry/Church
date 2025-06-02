using System;
using System.Collections;
using System.Collections.Generic;
using AYellowpaper.SerializedCollections;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class TextSettingsData : MonoBehaviour
{
    [Header("Text Settings")] 
    [SerializeField] private Slider TextSpeed_Slider;
    [SerializeField] private Slider TextSize_Slider;
    [SerializeField] private TMP_Dropdown Font_dropdown;
    [SerializeField] private ToggleSwitchColorChange AutoPlayToggle, VisualOverlay, TextEffectsOverlay;

    
    [Header("Audio Settings")]
    [SerializeField] private Slider sfxSlider;
    [SerializeField] private Slider bgmSlider;

    [SerializeField] private ToggleSwitchColorChange muteToggle;

    public delegate void TextSize();
    public static event TextSize OnTextSizeChange;
    public static event TextSize OnTextFontChange;
    
    // Start is called before the first frame update
    void OnEnable()
    {
        muteToggle.SetValue(SaveSystem.GetMuteValue());
        sfxSlider.value = SaveSystem.GetAudioVolume(3);
        bgmSlider.value = SaveSystem.GetAudioVolume(2);

        AutoPlayToggle.SetValue(SaveSystem.GetAutoplayValue());
        SetAutoPlay(SaveSystem.GetAutoplayValue());

        VisualOverlay.SetValue(SaveSystem.GetOverlayValue());
        SetOverlayPlay(SaveSystem.GetOverlayValue());

        TextEffectsOverlay.SetValue(SaveSystem.GetTextEffectsValue());
        SetTextEffectsPlay(SaveSystem.GetTextEffectsValue());

        TextSpeed_Slider.value = SaveSystem.GetTextSpeed();
        SetTextSpeedValue(SaveSystem.GetTextSpeed());
        
        TextSize_Slider.value = SaveSystem.GetTextSize();
        SetTextSizeValue(SaveSystem.GetTextSize());
        
        Font_dropdown.value = SaveSystem.GetTextFontIndex();
        SetFont(SaveSystem.GetTextFontIndex());
    }

    public void SetAutoPlay(bool value)
    {
        SaveSystem.SetAutoplayValue(value);
        GameManager.instance.AutoPlay = value;
    }

    public void SetOverlayPlay(bool value)
    {
        SaveSystem.SetOverlayValue(value);
        GameManager.instance.VisualOverlay = value;
    }

    public void SetTextEffectsPlay(bool value)
    {
        SaveSystem.SetTextEffectsValue(value);
        GameManager.instance.TextEffects = value;
    }

    public void SetTextSpeedValue(float value)
    {
        SaveSystem.SetTextSpeed(value);
        GameManager.instance.DelayTimings = value;
    }
    
    public void SetTextSizeValue(float value)
    {
        SaveSystem.SetTextSize(value);
        OnTextSizeChange?.Invoke();
    }

    public static void SetTextSize()
    {
        OnTextSizeChange?.Invoke();
    }
    
    public void SetFont(int value)
    {
        SaveSystem.SetFontIndex(value);
        OnTextFontChange?.Invoke();
        TMProGlobal.GlobalFontAsset = SaveSystem.GetTextFont();
        TMPTextGlobal.GlobalFontAsset = SaveSystem.GetTextFont();
    }    
}