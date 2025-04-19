using System.Collections;
using System.Collections.Generic;
using AYellowpaper.SerializedCollections;
using UnityEngine;
using UnityEngine.UI;

public class TextSettingsData : MonoBehaviour
{
    [Header("Text Settings")] [SerializeField]
    private Slider TextSpeed_Slider, AutoPlay_Slider, sfxSlider, bgmSlider;

    [SerializeField] private ToggleSwitchColorChange muteToggle, AutoPlayToggle, VisualOverlay, TextEffectsOverlay;

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

        AutoPlay_Slider.value = SaveSystem.GetAutoplaySpeed();
        SetAutoplaySpeedValue(SaveSystem.GetAutoplaySpeed());
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
        GameManager.instance.Default_TextDelay = value;
    }

    public void SetAutoplaySpeedValue(float value)
    {
        SaveSystem.SetAutoplaySpeed(value);
        GameManager.instance.AutoPlay_TextDelay = value;
    }
}