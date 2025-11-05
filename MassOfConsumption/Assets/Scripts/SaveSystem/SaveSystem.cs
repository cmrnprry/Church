using UnityEngine;
using Ink.Runtime;
using System.Collections.Generic;
using System.Linq;
using AYellowpaper.SerializedCollections;
using TMPro;
using UnityEngine.TextCore.Text;

public enum Audio { BGM, SFX, Master, Mute }

public static class SaveSystem
{
    // total number of saves in game
    public static bool isSaving = true;
    public static List<string> IntrusiveThoughts = new List<string>();


    //class that holds the stuff we need to save
    private static SlotData slotData = new SlotData();
    private static SettingsData settingsData = new SettingsData();

    // string version of our json data
    private static string slotJson;
    private static string settingsJson;

    /// <summary>
    ///  Called to start loading system when we want to load a save file
    /// </summary>
    public delegate void LoadAction();

    public static event LoadAction OnLoad;

    public static void Init()
    {
        //Check if we have settings data and set it if we do 
        string path = Application.persistentDataPath + "/settings.json";
        if (System.IO.File.Exists(path))
        {
            string json = System.IO.File.ReadAllText(path);
            settingsData = JsonUtility.FromJson<SettingsData>(json);
        }
    }

    public static void Restart()
    {
        slotData = new SlotData();
    }

    public static void SlotInit(SerializedDictionary<string, Sprite> bg, SerializedDictionary<string, GameObject> props,
        Story story)
    {
        slotData.InkStory = story.ToJson();

        foreach (KeyValuePair<string, GameObject> prop in props)
        {
            if (slotData.PropDictionary.ContainsKey(prop.Key))
                continue;

            slotData.PropDictionary.Add(prop.Key, false);
        }
    }

    public static string CheckForSaveData(string slotID)
    {
        string path = Application.persistentDataPath + "/" + slotID + ".json";

        if (System.IO.File.Exists(path))
        {
            // var result = System.IO.File.ReadAllText(path);
            var creation = System.IO.File.GetLastWriteTime(path);
            return creation.ToShortDateString() + " " + creation.ToShortTimeString();
        }

        return null;
    }

    public static bool CheckForData(string slotID)
    {
        string path = Application.persistentDataPath + "/" + slotID + ".json";
        bool isData;
        isData = System.IO.File.Exists(path);
        return isData;
    }

    public static bool HasSaveData()
    {
        if(!string.IsNullOrEmpty(settingsData.mostRecentSlot))
        {
            string path = Application.persistentDataPath + "/" + settingsData.mostRecentSlot + ".json";

            if (System.IO.File.Exists(path))
                return true;
        }



        return false;
    }

    public static string GetLastSave()
    {
        return settingsData.mostRecentSlot;
    }

    public static SlotData GetSlot(string slotID)
    {
        string path = Application.persistentDataPath + "/" + slotID + ".json";

        if (System.IO.File.Exists(path))
        {
            string json = System.IO.File.ReadAllText(path);
            slotData = JsonUtility.FromJson<SlotData>(json);

            return slotData;
        }
        else
        {
            Debug.LogError($"No game to load at slot {slotID}");
        }

        return null;
    }


    /*        FUNCTIONS THAT SAVE TO JSON          */

    public static void SaveSettingsData()
    {
        settingsJson = JsonUtility.ToJson(settingsData);
        System.IO.File.WriteAllText(Application.persistentDataPath + "/settings.json", settingsJson);
    }

    public static void SaveSlotData(string slotID)
    {
        slotJson = JsonUtility.ToJson(slotData);
        System.IO.File.WriteAllText(Application.persistentDataPath + "/" + slotID + ".json", slotJson);
    }

    public static void SaveAllData(string slotID)
    {
        settingsData.mostRecentSlot = slotID;
        SaveSlotData(slotID);
        SaveSettingsData();
    }

    public static void LoadSlotData(string slotID)
    {
        string path = Application.persistentDataPath + "/" + slotID + ".json";

        if (System.IO.File.Exists(path))
        {
            string json = System.IO.File.ReadAllText(path);
            slotData = JsonUtility.FromJson<SlotData>(json);

            OnLoad?.Invoke();
        }
        else
        {
            Debug.LogError($"No game to load at slot {slotID}");
        }
    }

    /*        GETTERS AND SETTERSs          */


    public static bool OnLoadPropData(string key, string slotID = "")
    {
        SlotData temp_data = slotID == "" ? slotData : GetSlot(slotID);

        return temp_data.PropDictionary[key];
    }


    /// <summary>
    /// Set the Audio volume
    /// </summary>
    /// <param name="volume">volume of the audio</param>
    /// <param name="type">1 = master, 2 = bgm, 3 = sfx</param>
    public static void SetAudioVolume(float volume, Audio type)
    {
        switch (type)
        {
            case Audio.Mute:
                settingsData.mute = (volume == 0);
                break;

            case Audio.BGM:
                settingsData.BGM = volume;
                break;

            case Audio.SFX:
                settingsData.SFX = volume;
                break;

            default:
                Debug.LogError("Cannot set Settings Audio. Index out of range.");
                return;
        }

        SaveSettingsData();
    }

    public static bool GetMuteValue()
    {
        return settingsData.mute;
    }

    public static float GetAudioVolume(Audio type)
    {
        float volume = 0;
        switch (type)
        {
            case Audio.BGM:
                volume = settingsData.BGM;
                break;

            case Audio.SFX:
                volume = settingsData.SFX;
                break;

            default:
                Debug.LogError("Cannot set Settings Audio. Index out of range.");
                break;
        }

        return volume;
    }

    public static SettingsData GetSettingsData()
    {
        if (settingsData != null)
        {
            return settingsData;
        }

        return null;
    }

    public static void SetCurrentText(SavedTextData text_data, string slotID = "")
    {
        // SlotData temp_data = slotID == "" ? slotData : GetSlot(slotID);

        int length = slotData.DisplayedTextDictionary.Count;
        slotData.DisplayedTextDictionary.Add(length, text_data);

        //SaveSlotData(slotID);
    }

    public static SavedTextData GetCurrentText(int index, string slotID = "")
    {
        SlotData temp_data = slotID == "" ? slotData : GetSlot(slotID);
        return temp_data.DisplayedTextDictionary[index];
    }

    public static int GetCurrentTextLength(string slotID = "")
    {
        SlotData temp_data = slotID == "" ? slotData : GetSlot(slotID);
        return temp_data.DisplayedTextDictionary.Count;
    }

    public static void ClearCurrentTextData(string slotID = "")
    {
        slotData.DisplayedTextDictionary.Clear();
    }

    public static void SetStory(string text, string slotID = "")
    {
        slotData.InkStory = text;
        //SaveSlotData(slotID);
    }

    public static string GetStory(string slotID = "")
    {
        SlotData temp_data = slotID == "" ? slotData : GetSlot(slotID);
        return temp_data.InkStory;
    }

    public static void UnlockEnding(int index, string name)
    {
        settingsData.EndingsDictionary[index] = name;
    }

    public static string GetEnding(int index)
    {
        return settingsData.EndingsDictionary[index];
    }

    public static string GetSavedHistory(string slotID = "")
    {
        SlotData temp_data = slotID == "" ? slotData : GetSlot(slotID);

        return temp_data.History;
    }

    public static void SetSavedHistory(string his)
    {
        slotData.History += his;
    }

    public static void SetFullscreen(bool fullscreen)
    {
        settingsData.isFullScreen = fullscreen;
        SaveSettingsData();
    }

    public static bool GetFullscreen()
    {
        return settingsData.isFullScreen;
    }

    public static void SetResolution(Vector2 resolution, int value)
    {
        settingsData.resolution = resolution;
        settingsData.resolution_index = value;
        SaveSettingsData();
    }

    public static void SetSettingsOnLoad()
    {
        //set screen size
        Screen.SetResolution((int)GetResolution().x, (int)GetResolution().y, GetFullscreen());

        //set audio
        float mute = GetMuteValue() ? 0 : 1;
        AudioManager.instance.AdjustSFX(GetAudioVolume(Audio.SFX));
        AudioManager.instance.AdjustBGM(GetAudioVolume(Audio.BGM));
        AudioManager.instance.MuteAudio((int) mute);

        //set autoplay values
        GameManager.instance.AutoPlay = GetAutoplayValue();
        
        GameManager.instance.VisualOverlay = GetOverlayValue();
        GameManager.instance.TextEffects = GetTextEffectsValue();
        GameManager.instance.DelayTimings = GetTextSpeed();
        SettingsUIData.SetTextSize();
        TMProGlobal.GlobalFontAsset = GetTextFont();
    }

    public static Vector2 GetResolution()
    {
        return settingsData.resolution;
    }

    public static int GetSettingsIndex()
    {
        return settingsData.resolution_index;
    }

    //IMAGE STUFFS


    public static void ResetImageData(bool isZoom = false, string slotID = "")
    {
        SlotData temp_data = slotID == "" ? slotData : GetSlot(slotID);

        if (isZoom)
            temp_data.ImageData.ResetZoom();
        else
            temp_data.ImageData.ResetClasses();
    }

    public static void AddImageClassData(string classData, string slotID = "")
    {
        SlotData temp_data = slotID == "" ? slotData : GetSlot(slotID);
        slotData.ImageData.SetImageClasses(classData);
    }

    public static void AddImageZoomData(ZoomData zoomData, string slotID = "")
    {
        SlotData temp_data = slotID == "" ? slotData : GetSlot(slotID);

        slotData.ImageData.SetImageZooms(zoomData);
    }

    public static string GetImageClassData(string slotID = "")
    {
        SlotData temp_data = slotID == "" ? slotData : GetSlot(slotID);
        return slotData.ImageData.GetImageClasses();
    }

    public static ZoomData GetImageZoomData(string slotID = "")
    {
        SlotData temp_data = slotID == "" ? slotData : GetSlot(slotID);
        return slotData.ImageData.GetImageZooms();
    }

    public static Sprite GetCurrentSprite(string slotID = "")
    {
        SlotData temp_data = slotID == "" ? slotData : GetSlot(slotID);

        return GameManager.instance.BackgroundDictionary[temp_data.ImageData.GetImageKey()];
    }

    public static string GetCurrentSpriteKey(string slotID = "")
    {
        SlotData temp_data = slotID == "" ? slotData : GetSlot(slotID);

        return slotData.ImageData.GetImageKey();
    }

    public static void SetCurrentSprite(string key)
    {
        slotData.ImageData.SetImageKey(key);
    }

    public static void SetCurrentProp(string key, bool value)
    {
        slotData.PropDictionary[key] = value;
    }

    public static void SetColorData(Color color)
    {
        slotData.GlobalColor = new ColorData(color.r, color.b, color.g, color.a);
    }

    public static Color GetColorData()
    {
        return new Color(slotData.GlobalColor.r, slotData.GlobalColor.b, slotData.GlobalColor.g, slotData.GlobalColor.a);
    }

    public static void SetFlashlight(bool has)
    {
        slotData.HasFlashlight = has;
    }

    public static bool GetFlashlight()
    {
        return slotData.HasFlashlight;
    }


    // SETTINGS GETTER AND SETTERS //

    public static string[] GetIntrusiveThoughts(string slotID = "")
    {
        SlotData temp_data = slotID == "" ? slotData : GetSlot(slotID);

        return temp_data.IntrusiveThoughts;
    }

    public static void SetIntrusiveThroughts(List<string> thoughts)
    {
        slotData.IntrusiveThoughts = thoughts.ToArray<string>();
    }

    public static void AddIntrusiveThroughts(int amount, string text, string jump_to, string slotID = "")
    {
        SlotData temp_data = slotID == "" ? slotData : GetSlot(slotID);
        string thought = $"{amount}, {text}, {jump_to}";
        IntrusiveThoughts.Add(thought);

        temp_data.IntrusiveThoughts = IntrusiveThoughts.ToArray<string>();
    }

    public static bool GetAutoplayValue()
    {
        return settingsData.autoplay;
    }

    public static bool GetOverlayValue()
    {
        return settingsData.visual_overlay;
    }

    public static bool GetTextEffectsValue()
    {
        return settingsData.text_effects;
    }

    public static float GetTextSpeed()
    {
        return settingsData.text_speed;
    }
    
    public static float GetTextSize()
    {
        return settingsData.text_size;
    }
    
    public static TMP_FontAsset GetTextFont()
    {
        return GameManager.instance.Fonts[settingsData.font_index];
    }
    
    public static int GetTextFontIndex()
    {
        return settingsData.font_index;
    }

    public static void SetAutoplayValue(bool value)
    {
        settingsData.autoplay = value;
        SaveSettingsData();
    }

    public static void SetOverlayValue(bool value)
    {
        settingsData.visual_overlay = value;
        SaveSettingsData();
    }

    public static void SetTextEffectsValue(bool value)
    {
        settingsData.text_effects = value;
        SaveSettingsData();
    }

    public static void SetTextSpeed(float value)
    {
        settingsData.text_speed = value;
        SaveSettingsData();
    }
    
    public static void SetTextSize(float value)
    {
        settingsData.text_size = value;
        SaveSettingsData();
    }
    
    public static void SetFontIndex(int value)
    {
        settingsData.font_index = value;
        SaveSettingsData();
    }
}