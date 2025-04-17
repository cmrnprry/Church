using System.Collections;
using System.Collections.Generic;
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
        AutoPlayToggle.SetValue(SaveSystem.GetAutoplayValue());
        VisualOverlay.SetValue(SaveSystem.GetOverlayValue());
        TextEffectsOverlay.SetValue(SaveSystem.GetTextEffectsValue());
        muteToggle.SetValue(SaveSystem.GetMuteValue());

        sfxSlider.value = SaveSystem.GetAudioVolume(3);
        bgmSlider.value = SaveSystem.GetAudioVolume(2);

        TextSpeed_Slider.value = SaveSystem.GetTextSpeed();
        AutoPlay_Slider.value = SaveSystem.GetAutoplaySpeed();
    }

    public void SetAutoPlay(bool value)
    {
        SaveSystem.SetAutoplayValue(value);
    }

    public void SetOverlayPlay(bool value)
    {
        SaveSystem.SetOverlayValue(value);
    }

    public void SetTextEffectsPlay(bool value)
    {
        SaveSystem.SetTextEffectsValue(value);
    }

    public void SetTextSpeedValue(float value)
    {
        SaveSystem.SetTextSpeed(value);
    }

    public void SetAutoplaySpeedValue(float value)
    {
        SaveSystem.SetAutoplaySpeed(value);
    }
}