using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;

public class DataManager : MonoBehaviour
{
    public static DataManager instance;

    public TextMeshProUGUI HistoryText;
    public List<TextMeshProUGUI> Endings = new List<TextMeshProUGUI>();
    public List<TextMeshProUGUI> Checkpoints = new List<TextMeshProUGUI>();


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

        index = 1;
        foreach (var item in Checkpoints)
        {
            item.text = SaveSystem.GetCheckpoint(index);
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
        SetHistory();
        int index = 1;
        foreach (var item in Endings)
        {
            item.text = SaveSystem.GetEnding(index);
            index++;
        }

        index = 1;
        foreach (var item in Checkpoints)
        {
            item.text = SaveSystem.GetCheckpoint(index);
            index++;
        }
    }

    public void UnlockCheckpoint(int index, string name)
    {
        //TODO: maybe make this more elegant        
        SaveSystem.UnlockCheckpoint(index, name);
        Endings[index - 1].text = name;
    }

    public void UnlockEnding(int index, string name)
    {
        //TODO: maybe make this more elegant        
        SaveSystem.UnlockEnding(index, name);
        Checkpoints[index - 1].text = name;
    }

    public void SetHistory()
    {
        HistoryText.text = SaveSystem.GetHistory();
    }
}