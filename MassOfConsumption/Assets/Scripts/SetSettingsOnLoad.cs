using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class SetSettingsOnLoad : MonoBehaviour
{
    public Toggle full, window;
    public TMP_Dropdown dropdown;

    public void OnEnable()
    {
        var isfull = SaveSystem.GetFullscreen();
        full.isOn = isfull;
        window.isOn = !isfull;
        dropdown.value = SaveSystem.GetSettingsIndex();
    }
}