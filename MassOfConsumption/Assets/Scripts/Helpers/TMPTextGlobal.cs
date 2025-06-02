using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.Events;

public class TMPTextGlobal : TMP_Text
{
    private static TMP_FontAsset _globalFontAsset;
    public static TMP_FontAsset GlobalFontAsset
    {
        get => _globalFontAsset;
        set
        {
            _globalFontAsset = value;
            OnGlobalFontChangedEvent?.Invoke();

        }
    }

    public static UnityEvent OnGlobalFontChangedEvent = new();

    protected override void OnEnable()
    {
        base.OnEnable();

        OnGlobalFontChangedEvent.AddListener(OnGlobalFontChanged);
        OnGlobalFontChanged();
    }

    protected override void OnDisable()
    {
        base.OnDisable();

        OnGlobalFontChangedEvent.RemoveListener(OnGlobalFontChanged);
    }

    void OnGlobalFontChanged()
    {
        if (GlobalFontAsset != null)
        {
            this.font = GlobalFontAsset;
        }

    }
}