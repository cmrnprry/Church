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

    //Tells us if there is ANY save data found for the application
    public static bool hasLoadedData = false;
    public static bool hasSettingsData = false;

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
            hasSettingsData = true;
        }
    }

    public static void SlotInit(SerializedDictionary<string, Sprite> bg, SerializedDictionary<string, GameObject> props, Story story)
    {
        slotData.InkStory = story.ToJson();

        foreach (KeyValuePair<string, GameObject> prop in props)
        {
            slotData.PropDictionary.Add(prop.Value, false);
        }

        foreach (KeyValuePair<string, Sprite> item in bg)
        {
            slotData.BackgroundDictionary.Add(item.Value, (item.Key == "Default"));
        }
    }

    public static string CheckForSaveData(string slotID)
    {
        string path = Application.persistentDataPath + "/" + slotID + ".json";

        if (System.IO.File.Exists(path))
        {
            hasLoadedData = true;
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
        SaveSlotData(slotID);
        SaveSettingsData();
    }

    public static void LoadSlotData(string slotID)
    {
        hasLoadedData = true;
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

    public static Sprite GetCurrentSprite(string slotID = "")
    {
        SlotData temp_data = slotID == "" ? slotData : GetSlot(slotID);

        Sprite sprite = null;
        foreach (KeyValuePair<Sprite, bool> pair in temp_data.BackgroundDictionary)
        {
            if (pair.Value)
                return pair.Key;
        }

        return sprite;
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
    public static void SetCurrentText(string text, string slotID = "")
    {
        SlotData temp_data = slotID == "" ? slotData : GetSlot(slotID);
        int length = temp_data.DisplayedTextDictionary.Count;

        temp_data.DisplayedTextDictionary.Add(length, text);
    }

    public static string GetCurrentText(int index, string slotID = "")
    {
        SlotData temp_data = slotID == "" ? slotData : GetSlot(slotID);
        return temp_data.DisplayedTextDictionary[index];
    }

    public static int GetCurrentTextLength(string slotID = "")
    {
        SlotData temp_data = slotID == "" ? slotData : GetSlot(slotID);
        return temp_data.DisplayedTextDictionary.Count;
    }

    public static void SetStory(string text, string slotID = "")
    {
        SlotData temp_data = slotID == "" ? slotData : GetSlot(slotID);
        temp_data.InkStory = text;
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