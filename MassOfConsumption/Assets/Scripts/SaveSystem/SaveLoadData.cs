using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using Ink.Runtime;



public class SaveLoadData : MonoBehaviour
{
    public GameObject overwritePrefab;
    private string slot = "";

    private bool isSaving = false;

    /// <summary>
    /// Called to set / get any save data outside of this file
    /// </summary>
    public delegate void SaveAction();
    public static event SaveAction OnSave;

    public void Awake()
    {

    }

    void OnEnable()
    {
        //VolumeSliderController.OnBGMChange += SetBGMData;
        //VolumeSliderController.OnSFXChange += SetSFXData;
        //VolumeSliderController.OnMasterChange += SetMasterData;
    }

    void OnDisable()
    {
        //VolumeSliderController.OnBGMChange -= SetBGMData;
        //VolumeSliderController.OnSFXChange -= SetSFXData;
        //VolumeSliderController.OnMasterChange -= SetMasterData;
    }

    private void SetMasterData(float value)
    {
        SaveSystem.SetAudioVolume(value, 1);
    }

    private void SetBGMData(float value)
    {
        SaveSystem.SetAudioVolume(value, 2);
    }

    private void SetSFXData(float value)
    {
        SaveSystem.SetAudioVolume(value, 3);
    }

    /// <summary>
    /// checks if the game should be saving or loading content
    /// </summary>
    /// <param name="s">bool that decides if game is saving</param>
    public void CheckIsSaving(bool s)
    {
        isSaving = s;
    }


    /// <summary>
    /// Loads the game data witha  given id
    /// </summary>
    /// <param name="slotID">ID representing a save slot</param>
    private void Load(string slotID)
    {
        SaveSystem.LoadSlotData(slotID);
    }
}

namespace AYellowpaper.SerializedCollections
{
    /// <summary>
    /// class that holds all the data we want to save
    /// </summary>
    public class SlotData
    {
        public string InkStory;
        public string History;

        [SerializedDictionary("index", "text data")]
        public SerializedDictionary<int, SavedTextData> DisplayedTextDictionary;

        [SerializedDictionary("key", "Enabled")]
        public SerializedDictionary<string, bool> BackgroundDictionary;

        [SerializedDictionary("Prop Object", "Enabled")]
        public SerializedDictionary<GameObject, bool> PropDictionary;

        [SerializedDictionary("Index", "Name")]
        public SerializedDictionary<int, string> EndingsDictionary;

        [SerializedDictionary("Index", "Name")]
        public SerializedDictionary<int, string> CheckpointsDictionary;

        public SlotData()
        {
            InkStory = string.Empty;
            History = string.Empty;

            BackgroundDictionary = new SerializedDictionary<string, bool>();
            PropDictionary = new SerializedDictionary<GameObject, bool>();
            EndingsDictionary = new SerializedDictionary<int, string>();
            CheckpointsDictionary = new SerializedDictionary<int, string>();
            DisplayedTextDictionary = new SerializedDictionary<int, SavedTextData>();

            for (int i = 0; i < 10; i++)
            {
                EndingsDictionary.Add(i + 1, "LOCKED");
            }

            for (int i = 0; i < 8; i++)
            {
                CheckpointsDictionary.Add(i + 1, "LOCKED");
            }
        }
    }
}

[System.Serializable]
public struct SavedTextData
{
    public string text;
    public float delay;

    [SerializeField]
    public string[] cycle_text;
    public int cycle_index;

    [SerializeField]
    public string[] class_text;

    public SavedTextData(string t, float d)
    {
        text = t;
        cycle_index = 0;
        delay = d;
        cycle_text = new string[0];
        class_text = new string[0];
    }
}



public class SettingsData
{
    public bool hasSaveData;
    public string mostRecentSlot;

    //AUDIO
    [SerializeField]
    public bool mute;

    [SerializeField]
    public float BGM;

    [SerializeField]
    public float SFX;

    //GAMEPLAY
    [SerializeField]
    public bool autoplay;
    public bool visual_overlay;
    public bool text_effects;
    public float text_speed;
    public float autoplay_speed;

    public SettingsData()
    {
        hasSaveData = false;
        mute = false;
        BGM = 0.5f;
        SFX = 0.5f;
        text_speed = 0.5f;
        autoplay_speed = 0.5f;
        autoplay = false;
        visual_overlay = false;
        text_effects = false;
    }
}