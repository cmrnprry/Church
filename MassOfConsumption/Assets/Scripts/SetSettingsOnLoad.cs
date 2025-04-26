using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class SetSettingsOnLoad : MonoBehaviour
{
    public Toggle full, window;
    public TMP_Dropdown dropdown;
    public TextMeshProUGUI resolution, font, item1, item2;

    public void OnEnable()
    {
        var isfull = SaveSystem.GetFullscreen();
        full.isOn = isfull;
        window.isOn = !isfull;
        dropdown.value = SaveSystem.GetSettingsIndex();
        SetFont();

        TextSettingsData.OnTextFontChange += SetFont;
    }

    private void OnDisable()
    {
        TextSettingsData.OnTextFontChange -= SetFont;
    }

    private void SetFont()
    {
        resolution.font = SaveSystem.GetTextFont();
        font.font = SaveSystem.GetTextFont();
        item1.font = SaveSystem.GetTextFont();
        item2.font = SaveSystem.GetTextFont();
    }
}