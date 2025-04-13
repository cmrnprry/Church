using UnityEngine;
using System.IO;
using Ink.Runtime;
using UnityEngine.SceneManagement;
using System.Collections.Generic;
using UnityEngine.UI;
using AYellowpaper.SerializedCollections;


public static class SaveSystem
{
    // total number of saves in game
    public static bool isSaving = true;


    //class that holds the stuff we need to save
    public static SlotData slotData = new SlotData();
    public static SettingsData settingsData = new SettingsData();

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
        //Check if we have settings data and sset it if we do 
        string path = Application.persistentDataPath + "/settings.json";
        if (System.IO.File.Exists(path))
        {
            string json = System.IO.File.ReadAllText(path);
            settingsData = JsonUtility.FromJson<SettingsData>(json);
        }
    }

    public static void SlotInit(SerializedDictionary<string, Sprite> bg, SerializedDictionary<string, GameObject> props, Story story)
    {
        slotData.InkStory = story.ToJson();

        foreach (KeyValuePair<string, GameObject> prop in props)
        {
            if (slotData.PropDictionary.ContainsKey(prop.Value))
                continue;
            
            slotData.PropDictionary.Add(prop.Value, false);
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
            var result = System.IO.File.ReadAllText(path);
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

    public static Sprite GetCurrentSprite(string slotID = "")
    {
        SlotData temp_data = slotID == "" ? slotData : GetSlot(slotID);

        Sprite key = null;
        foreach (KeyValuePair<string, bool> pair in temp_data.BackgroundDictionary)
        {
            if (pair.Value)
                return GameManager.instance.BackgroundDictionary[pair.Key];
        }

        return key;
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
}