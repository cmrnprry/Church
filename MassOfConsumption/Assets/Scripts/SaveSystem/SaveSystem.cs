using UnityEngine;
using Ink.Runtime;
using System.Collections.Generic;
using AYellowpaper.SerializedCollections;


public static class SaveSystem
{
    // total number of saves in game
    public static bool isSaving = true;


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

        foreach (KeyValuePair<string, Sprite> item in bg)
        {
            if (slotData.BackgroundDictionary.ContainsKey(item.Key))
                continue;

            slotData.BackgroundDictionary.Add(item.Key, (item.Key == "Default"));
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
        return System.IO.Directory.GetFiles(Application.persistentDataPath).Length > 1;
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
        settingsData.hasSaveData = true;
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

    public static string GetCurrentSpriteKey(string slotID = "")
    {
        SlotData temp_data = slotID == "" ? slotData : GetSlot(slotID);

        string key = "Default";
        foreach (KeyValuePair<string, bool> pair in temp_data.BackgroundDictionary)
        {
            if (pair.Value)
                return pair.Key;
        }

        return key;
    }

    public static bool OnLoadPropData(string key, string slotID = "")
    {
        SlotData temp_data = slotID == "" ? slotData : GetSlot(slotID);

        return temp_data.PropDictionary[key];
    }

    public static Sprite GetCurrentSprite(string slotID = "")
    {
        SlotData temp_data = slotID == "" ? slotData : GetSlot(slotID);

        foreach (KeyValuePair<string, bool> pair in temp_data.BackgroundDictionary)
        {
            if (pair.Value)
                return GameManager.instance.BackgroundDictionary[pair.Key];
        }

        return null;
    }

    public static void SetCurrentSprite(string key)
    {
        List<string> Keys = new List<string>(slotData.BackgroundDictionary.Keys);
        foreach (string item in Keys)
        {
            slotData.BackgroundDictionary[item] = (item == key);
        }
    }

    /// <summary>
    /// Set the Audio volume
    /// </summary>
    /// <param name="volume">volume of the audio</param>
    /// <param name="type">1 = master, 2 = bgm, 3 = sfx</param>
    public static void SetAudioVolume(float volume, int type)
    {
        switch (type)
        {
            case 1:
                settingsData.mute = (volume == 0);
                break;

            case 2:
                settingsData.BGM = volume;
                break;

            case 3:
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

    public static float GetAudioVolume(int type)
    {
        float volume = 0;
        switch (type)
        {
            case 2:
                volume = settingsData.BGM;
                break;

            case 3:
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

    //BUG: NOT SAVING THE ADD
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

    public static void UnlockEnding(int index, string name, string slotID = "")
    {
        SlotData temp_data = slotID == "" ? slotData : GetSlot(slotID);

        temp_data.EndingsDictionary[index] = name;
    }

    public static string GetEnding(int index, string slotID = "")
    {
        SlotData temp_data = slotID == "" ? slotData : GetSlot(slotID);
        return temp_data.EndingsDictionary[index];
    }

    public static void UnlockCheckpoint(int index, string name, string slotID = "")
    {
        SlotData temp_data = slotID == "" ? slotData : GetSlot(slotID);

        temp_data.CheckpointsDictionary[index] = name;
    }

    public static string GetCheckpoint(int index, string slotID = "")
    {
        SlotData temp_data = slotID == "" ? slotData : GetSlot(slotID);
        return temp_data.CheckpointsDictionary[index];
    }

    public static string GetHistory(string slotID = "")
    {
        SlotData temp_data = slotID == "" ? slotData : GetSlot(slotID);

        return temp_data.History;
    }

    public static void SetHistory(string his)
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
        settingsData.index = value;
        SaveSettingsData();
    }

    public static void SetSettingsOnLoad()
    {
        //set screen size
        Screen.SetResolution((int)GetResolution().x, (int)GetResolution().y, GetFullscreen());
        
        //set audio
        float mute = GetMuteValue() ? 0: 1;
        SetAudioVolume(GetAudioVolume(3), 3);
        SetAudioVolume(GetAudioVolume(2), 2);
        SetAudioVolume(mute, 1);

        //set autoplay values
        SetAutoplayValue(GetAutoplayValue());
        GameManager.instance.AutoPlay = GetAutoplayValue();

        SetOverlayValue(GetOverlayValue());
        GameManager.instance.VisualOverlay = GetOverlayValue();
        
        SetTextEffectsValue(GetTextEffectsValue());
        GameManager.instance.TextEffects = GetTextEffectsValue();

        SetTextSpeed(GetTextSpeed());
        GameManager.instance.Default_TextDelay = GetTextSpeed();
        
        SetAutoplaySpeed(GetAutoplaySpeed());
        GameManager.instance.AutoPlay_TextDelay = GetAutoplaySpeed();
    }

    public static Vector2 GetResolution()
    {
        return settingsData.resolution; 
    }
    
    public static int GetSettingsIndex()
    {
        return settingsData.index; 
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
    
    public static float GetAutoplaySpeed()
    {
        return settingsData.autoplay_speed;
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
    
    public static void SetAutoplaySpeed(float value)
    {
        settingsData.autoplay_speed = value;
        SaveSettingsData();
    }
    
}