using System.Collections;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class ChoiceTextOnScreen : MonoBehaviour
{
    [SerializeField] LayoutElement layout;

    private void OnEnable()
    {
        OnFontChange();
        SettingsUIData.OnTextFontChange += OnFontChange;
    }

    private void OnDisable()
    {
        SettingsUIData.OnTextFontChange -= OnFontChange;
    }

    void OnFontChange()
    {
        layout.enabled = (SaveSystem.GetTextFontIndex() == 1);
    }
}
