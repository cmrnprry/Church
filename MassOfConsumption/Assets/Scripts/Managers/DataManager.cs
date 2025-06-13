using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;

public class DataManager : MonoBehaviour
{
    public static DataManager instance;

    public TMProGlobal HistoryText;
    public List<TMProGlobal> Endings = new List<TMProGlobal>();


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
        //TODO: maybe make this more elegant
        string[] end = name.Split('-');
        SaveSystem.UnlockEnding(index, name);
        Endings[index - 1].text = $"{end[0]}\n<size=50>{end[1]}</size>";
    }

    public void SetHistoryText()
    {
        HistoryText.text = SaveSystem.GetSavedHistory();
    }
}