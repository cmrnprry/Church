using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using Ink.Runtime;

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
    [SerializeField] private ReplaceChoice replaceChoice;


    [SerializeField]
    public string[] cycle_text;
    public int cycle_index;

    [SerializeField]
    public string[] class_text;

    public SavedTextData(string t, float d, ReplaceChoice r)
    {
        text = t;
        cycle_index = 0;
        delay = d;
        cycle_text = Array.Empty<string>();
        class_text = Array.Empty<string>();
        replaceChoice = r;
    }

    public ReplaceChoice GetReplaceChoice()
    {
        return replaceChoice;
    }
}

[System.Serializable]
public struct ReplaceChoice
{
    [SerializeField] private string replacement_text;
    [SerializeField] private int replacement_index;

    public ReplaceChoice(string t = "", int d = -1)
    {
        replacement_text = t;
        replacement_index = d;
    }
    
    public ReplaceChoice(string t)
    {
        replacement_text = t;
        replacement_index = -1;
    }

    public string GetText()
    {
        return replacement_text;
    }
    
    public int GetChoiceIndex()
    {
        return replacement_index;
    }
    
    public void SetText(string t)
    {
        replacement_text = t;
    }
    
    public void SetChoiceIndex(int d)
    {
        replacement_index = d;
    }

    public bool hasTextData()
    {
        return !string.IsNullOrEmpty(replacement_text);
    }
    
    public bool hasData()
    {
        return replacement_text != ""  && replacement_index >= 0;
    }
    
    public bool hasChoiceData()
    {
        return replacement_index >= 0;
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