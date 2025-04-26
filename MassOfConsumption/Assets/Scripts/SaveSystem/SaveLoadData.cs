using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
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
        public SavedImageData ImageData;

        [SerializedDictionary("index", "text data")]
        public SerializedDictionary<int, SavedTextData> DisplayedTextDictionary;

        [SerializedDictionary("Prop Object", "Enabled")]
        public SerializedDictionary<string, bool> PropDictionary;

        [SerializedDictionary("Index", "Name")]
        public SerializedDictionary<int, string> EndingsDictionary;

        [SerializedDictionary("Index", "Name")]
        public SerializedDictionary<int, string> CheckpointsDictionary;

        public SlotData()
        {
            InkStory = string.Empty;
            History = string.Empty;
            ImageData = new SavedImageData("Default");
            
            PropDictionary = new SerializedDictionary<string, bool>();
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
public struct SavedImageData
{
    [SerializeField] private string CurrentImageKey;
    [SerializeField] private string ImageClasses;
    [SerializeField] private ZoomData ImageZooms;

    public SavedImageData(string key)
    {
        CurrentImageKey = key;
        ImageClasses = "";
        ImageZooms = new ZoomData(-1, new Vector2(-1, -1), -1);
    }
    
    public void SetImageKey(string key)
    {
        CurrentImageKey = key;
    }

    public void ResetZoom()
    {
        ImageZooms = new ZoomData(-1, new Vector2(-1, -1), -1);
    }
    
    public void ResetClasses()
    {
        ImageClasses = "";
    }
    
    public string GetImageKey()
    {
        return CurrentImageKey;
    }

    public void SetImageClasses(string classes)
    {
        ImageClasses = classes;
    }
    
    public string GetImageClasses()
    {
        return ImageClasses;
    }
    
    public void SetImageZooms(ZoomData classes)
    {
        ImageZooms = classes;
    }
    
    public ZoomData GetImageZooms()
    {
        return ImageZooms;
    }
}

[System.Serializable]
public struct SavedTextData
{
    public string text;
    public float delay;
    [SerializeField] private ReplaceChoice replaceChoice;


    [SerializeField] public string[] cycle_text;
    public int cycle_index;

    [SerializeField] public string[] class_text;

    public SavedTextData(string t, float d, ReplaceChoice r, string[] c)
    {
        text = t;
        cycle_index = 0;
        delay = d;
        cycle_text = Array.Empty<string>();
        class_text = c;
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
        return replacement_text != "" && replacement_index >= 0;
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
    public bool isFullScreen;
    public Vector2 resolution;
    public int resolution_index;
    public int font_index;

    //AUDIO
    public bool mute;
    public float BGM;
    public float SFX;

    //GAMEPLAY
    public bool autoplay;
    public bool visual_overlay;
    public bool text_effects;
    
    public float text_speed;
    public float text_size;

    public SettingsData()
    {
        hasSaveData = false;

        isFullScreen = true;
        resolution = new Vector2(1920, 1440);
        resolution_index = 0;

        mute = false;
        BGM = 0.5f;
        SFX = 0.5f;

        text_size = 50;
        text_speed = -1.5f;
        font_index = 0;
        autoplay = false;
        
        visual_overlay = true;
        text_effects = true;
    }
}