using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;

public class DataManager : MonoBehaviour
{
    public static DataManager instance;

    public TextMeshProUGUI HistoryText;
    public List<Transform> Endings = new List<Transform>();


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
        SetHistory(PlayerPrefs.GetString("History", ""));

        string[] endings = PlayerPrefs.GetString("Endings", "").Split(",");
        for (int i = 0; i < endings.Length; i++)
        {
            int index = Int32.Parse(endings[i].Trim());
            
            //TODO: maybe make this more elegant
            Endings[index].GetChild(0).gameObject.SetActive(false);
            Endings[index].GetChild(1).gameObject.SetActive(true);
        }
    }

    public void UnlockEnding(int index)
    {
        //TODO: maybe make this more elegant
        Endings[index].GetChild(0).gameObject.SetActive(false);
        Endings[index].GetChild(1).gameObject.SetActive(true);
        string temp = $"{index}, {PlayerPrefs.GetString("Endings", "")}";
        
        PlayerPrefs.SetString("Endings", temp);
    }

    public void SetHistory(string his)
    {
        HistoryText.text += his;
        PlayerPrefs.SetString("History", HistoryText.text);
    }
}