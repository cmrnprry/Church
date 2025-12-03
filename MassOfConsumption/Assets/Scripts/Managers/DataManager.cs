using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;
using Steamworks;

public class DataManager : MonoBehaviour
{
    public static DataManager instance;

    [Header("History Turn On")]
    public GameObject History;

    [Header("History Text Info")]
    public TMProGlobal Text_Prefab;
    public VerticalLayoutGroup group;
    public ContentSizeFitter fitter;
    public Transform Parent;
    public List<TMProGlobal> Endings = new List<TMProGlobal>();

    [Header("Images for line boil and flicker")]
    public List<Image> lineboil_images = new List<Image>();
    public List<Image> pewflicker_images = new List<Image>();


    private void Awake()
    {
        if (instance == null)
            instance = this;
        else
            Destroy(this.gameObject);

        DontDestroyOnLoad(gameObject);
    }

    private void Start()
    {
        int index = 1;
        foreach (var item in Endings)
        {
            item.text = SaveSystem.GetEnding(index);
            index++;
        }

        FlipLineBoil(SaveSystem.GetLineBoilValue());
    }

    private void OnEnable()
    {
        SaveSystem.OnLoad += SetDataOnLoad;
    }

    private void OnDisable()
    {
        SaveSystem.OnLoad -= SetDataOnLoad;
    }

    private void SetDataOnLoad()
    {
        SetHistoryText();
        int index = 1;
        foreach (var item in Endings)
        {
            item.text = SaveSystem.GetEnding(index);
            index++;
        }
    }

    public void UnlockEnding(int index, string name)
    {
        string[] end = name.Split('-');
        SaveSystem.UnlockEnding(index, name);
        Endings[index - 1].text = $"{end[0]}\n<size=50>{end[1]}</size>";

        if (SteamManager.Initialized)
        {
            SteamUserStats.SetAchievement($"Ending_{index}");

            if (SaveSystem.FoundAllEndings())
                SteamUserStats.SetAchievement("ACHIEVEMENT_1");
        }

    }

    public void SetHistoryText()
    {
        foreach (Transform chunk in Parent)
        {
            Destroy(chunk.gameObject);
        }

        var chunks = SaveSystem.GetSavedHistory();
        foreach (string chunk in chunks)
        {
            var current = Instantiate(Text_Prefab, Parent, false);
            current.text = chunk;
        }
    }

    public void FlipLineBoil(bool value)
    {
        float strn = value ? 0.005f : 0.0f;
        foreach (Image img in lineboil_images)
        {
            if (img.name == "Overlay")
            {
                strn = value ? 0.015f : 0.0f;
            }
            img.materialForRendering.SetFloat("_Strength", strn);
            img.defaultMaterial.SetFloat("_Strength", strn);
        }

        strn = value ? 0.005f : 0.0f;
        foreach (Image img in pewflicker_images)
        {
            img.materialForRendering.SetFloat("_Strength", strn);
            img.defaultMaterial.SetFloat("_Strength", strn);
        }

    }


}