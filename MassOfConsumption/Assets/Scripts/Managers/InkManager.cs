using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;
using AYellowpaper.SerializedCollections;

public class InkManager : MonoBehaviour
{
    public GameObject popup;

    // Start is called before the first frame update
    void Start()
    {
        foreach (string variable in GameManager.instance.Story.variablesState)
        {
            GameManager.instance.Story.ObserveVariable(variable, (string varName, object newValue) =>
            {
                Debug.Log($"{varName} value: {newValue}");
            });
        }
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetKeyDown(KeyCode.LeftControl))
        {
            popup.SetActive(!popup.activeSelf);
        }
    }

    public void SetText(string input) //go [knot] //set [variable] [value]
    {
        Debug.Log(input);
        var array = input.Split(' ');

        string command = array[0];

        switch (command)
        {
            case "go":
                JumpTo(array[1]);
                break;
            case "set":
                SetVariable(array[1], array[2]);
                break;
            default:
                break;
        }
    }


    private void JumpTo(string knot)
    {
        GameManager.instance.Story.ChoosePathString(knot);
    }

    private void SetVariable(string variable, string value)
    {
        int intVal;
        bool boolVal;
        if (int.TryParse(value, out intVal))
        {
            GameManager.instance.Story.variablesState[variable] = intVal;
        }
        else if (bool.TryParse(value, out boolVal))
        {
            GameManager.instance.Story.variablesState[variable] = boolVal;
        }
        else
            GameManager.instance.Story.variablesState[variable] = value;
    }
}
