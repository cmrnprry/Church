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

        [SerializedDictionary("SRC", "Data")]
        public SerializedDictionary<string, PlayingAudioData> LoopingPlaying;

        public string[] IntrusiveThoughts;
        public ColorData GlobalColor;
        public bool HasFlashlight;

        //cursor data
        public bool isOpen;
        public bool isNeutral;

        public SlotData()
        {
            InkStory = string.Empty;
            History = string.Empty;
            ImageData = new SavedImageData("Default");

            IntrusiveThoughts = Array.Empty<string>();
            PropDictionary = new SerializedDictionary<string, bool>();
            DisplayedTextDictionary = new SerializedDictionary<int, SavedTextData>();
            LoopingPlaying = new SerializedDictionary<string, PlayingAudioData>();
            GlobalColor = new ColorData(0.8784314f, 0.8078431f, 0.8078431f, 1);
            HasFlashlight = false;
            isOpen = false;
            isNeutral = true;
        }
    }
}

[System.Serializable]
public struct ColorData
{
    [SerializeField] public float r;
    [SerializeField] public float g;
    [SerializeField] public float b;
    [SerializeField] public float a;

    public ColorData (float r, float g, float b, float a)
    {
        this.r = r;
        this.b = b;
        this.g = g;
        this.a = a;
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
        ImageZooms = new ZoomData(-1, new Vector2(-1, -1), -1, -1);
    }

    public void SetImageKey(string key)
    {
        CurrentImageKey = key;
    }

    public void ResetZoom()
    {
        ImageZooms = new ZoomData(-1, new Vector2(-1, -1), -1, -1);
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

[System.Serializable]
public struct PlayingAudioData
{
    public string src;
    public Audio type;
    public bool isLooping;
    public float fade_in, fade_out, delay;

    public PlayingAudioData(string name, Audio t)
    {
        src = name;
        type = t;

        isLooping = true;

        fade_in = 0;
        fade_out = 0;
        delay = 0;
    }

    public PlayingAudioData(string name, Audio t, float f_in, float f_out, float d)
    {
        src = name;
        type = t;

        isLooping = true;

        fade_in = f_in;
        fade_out = f_out;
        delay = d;
    }

    public PlayingAudioData(string name, Audio t, bool loop, float f_in, float f_out, float d)
    {
        src = name;
        type = t;

        isLooping = loop;

        fade_in = f_in;
        fade_out = f_out;
        delay = d;
    }
}

namespace AYellowpaper.SerializedCollections
{
    public class SettingsData
    {
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
        public bool image_overlay;

        public float text_speed;
        public float text_size;

        [SerializedDictionary("Index", "Name")]
        public SerializedDictionary<int, string> EndingsDictionary;

        public SettingsData()
        {
            mostRecentSlot = "";
            isFullScreen = false;
            resolution = new Vector2(1280, 960);
            resolution_index = 0;

            mute = false;
            BGM = 0.5f;
            SFX = 0.5f;

            text_size = 50;
            text_speed = -1;
            font_index = 0;
            autoplay = false;
            visual_overlay = true;
            text_effects = true;
            image_overlay = true;

            EndingsDictionary = new SerializedDictionary<int, string>();

            for (int i = 0; i < 10; i++)
            {
                EndingsDictionary.Add(i + 1, "LOCKED");
            }
        }
    }
}