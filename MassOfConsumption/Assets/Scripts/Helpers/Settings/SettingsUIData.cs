using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;
using AYellowpaper.SerializedCollections;

public class SettingsUIData : MonoBehaviour
{
    [Header("Text Settings")]
    [SerializeField] private Slider TextSpeed_Slider;
    [SerializeField] private Slider TextSize_Slider;
    [SerializeField] private TMP_Dropdown Font_dropdown;
    [SerializeField] private ToggleSwitchColorChange AutoPlayToggle, TextDirection, LineBoilOverlay, VisualOverlay, TextEffectsOverlay;


    [Header("Audio Settings")]
    [SerializeField] private Slider sfxSlider;
    [SerializeField] private Slider bgmSlider;

    [SerializeField] private ToggleSwitchColorChange muteToggle;

    public delegate void TextSize();
    public static event TextSize OnTextSizeChange;
    public static event TextSize OnTextFontChange;

    [Header("Video Settings")]
    [SerializeField] private Toggle full, window;
    [SerializeField] private TMP_Dropdown Screensize_Dropdown;

    public void OnEnable()
    {
        if (full != null && window != null)
        {
            var isfull = SaveSystem.GetFullscreen();
            full.isOn = isfull;
            window.isOn = !isfull;
        }
        if (Screensize_Dropdown != null)
            Screensize_Dropdown.value = SaveSystem.GetSettingsIndex();

        if (muteToggle != null)
            muteToggle.SetValue(SaveSystem.GetMuteValue());
        if (sfxSlider != null)
            sfxSlider.value = SaveSystem.GetAudioVolume(Audio.SFX);
        if (bgmSlider != null)
            bgmSlider.value = SaveSystem.GetAudioVolume(Audio.BGM);

        if (AutoPlayToggle != null)
        {
            AutoPlayToggle.SetValue(SaveSystem.GetAutoplayValue());
            SetAutoPlay(SaveSystem.GetAutoplayValue());
        }

        if (TextDirection != null)
        {
            TextDirection.SetValue(SaveSystem.GetScrollDir());
            SetScrollDir(SaveSystem.GetScrollDir());
        }


        if (LineBoilOverlay != null)
        {
            LineBoilOverlay.SetValue(SaveSystem.GetLineBoilValue());
            SetLineBoil(SaveSystem.GetLineBoilValue());
        }

        if (VisualOverlay != null)
        {
            VisualOverlay.SetValue(SaveSystem.GetOverlayValue());
            SetOverlayPlay(SaveSystem.GetOverlayValue());
        }


        if (TextEffectsOverlay != null)
        {
            TextEffectsOverlay.SetValue(SaveSystem.GetTextEffectsValue());
            SetTextEffectsPlay(SaveSystem.GetTextEffectsValue());
        }


        if (TextSpeed_Slider != null)
        {
            TextSpeed_Slider.value = SaveSystem.GetTextSpeed();
            SetTextSpeedValue(SaveSystem.GetTextSpeed());
        }


        if (TextSize_Slider != null)
        {
            TextSize_Slider.value = SaveSystem.GetTextSize();
            SetTextSizeValue(SaveSystem.GetTextSize());
        }


        if (Font_dropdown != null)
        {
            Font_dropdown.value = SaveSystem.GetTextFontIndex();
            SetFont(SaveSystem.GetTextFontIndex());
        }

    }

    public void SetAutoPlay(bool value)
    {
        SaveSystem.SetAutoplayValue(value);
        GameManager.instance.AutoPlay = value;
    }

    public void SetScrollDir(bool value)
    {
        SaveSystem.SetScrollDirValue(value);
    }

    public void SetLineBoil(bool value)
    {
        SaveSystem.SetLineBoilValue(value);
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

    public void SetScreenMode(bool isFullScreen)
    {
        var res = SaveSystem.GetResolution();
        Screen.SetResolution((int)res.x, (int)res.y, isFullScreen);

        SaveSystem.SetFullscreen(isFullScreen);
    }

    public void SeScreentResValue(int value)
    {
        var option = Screensize_Dropdown.options[value].text.Split('x');
        var res = new Vector2(int.Parse(option[0].Trim()), int.Parse(option[1].Trim()));
        Screen.SetResolution((int)res.x, (int)res.y, SaveSystem.GetFullscreen());

        SaveSystem.SetResolution(res, value);
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