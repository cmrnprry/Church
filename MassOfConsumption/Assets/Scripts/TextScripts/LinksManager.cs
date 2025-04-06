using System;
using System.Collections;
using System.Collections.Generic;
using AYellowpaper.SerializedCollections;
using Febucci.UI;
using UnityEngine;
using TMPro;
using UnityEngine.EventSystems;

//this object is put on the text object
public class LinksManager : MonoBehaviour, IPointerClickHandler
{
    private TextMeshProUGUI Textbox;
    private RectTransform TextboxRectTransform;
    private int CurrentlyActiveElement;

    private List<string> cycle_text = new List<string>();
    private int cycle_index = 0;
    private string cycle_color = "#a80f0f";
    private string color_default = "#a80f0f";
    private string color_hover = "#3f1313";
    private bool isReplace = false;

    private Camera main_cam;

    public string[] GetCycle()
    {
        return cycle_text.ToArray();
    }

    public int GetIndex()
    {
        return cycle_index;
    }

    private void Start()
    {
        main_cam = Camera.main;
        Textbox = GetComponent<TextMeshProUGUI>();
        TextboxRectTransform = GetComponent<RectTransform>();
    }

    public void SetReplaceData()
    {
        isReplace = true;
    }

    public void SetData(List<string> list)
    {
        cycle_text = list;

        for (int ii = 0; ii < cycle_text.Count; ii++)
        {
            cycle_text[ii] = cycle_text[ii].Trim();
        }
    }

    public void SetDataOnLoad(string[] list, int index)
    {
        cycle_index = index;
        for (int ii = 0; ii < list.Length; ii++)
        {
            cycle_text.Add(list[ii]);
        }
    }

    private void EndHover()
    {
        string next_color = color_default;

        Textbox.text = Textbox.text.Replace(cycle_color, next_color);
        cycle_color = next_color;
    }

    private void OnHover(string keyword, Vector3 mousePos)
    {
        string next_color = color_hover;

        Textbox.text = Textbox.text.Replace(cycle_color, next_color);
        cycle_color = next_color;
    }

    // Callback for handling clicks.
    public void OnPointerClick(PointerEventData eventData)
    {
        var linkIndex = TMP_TextUtilities.FindIntersectingLink(Textbox, Input.mousePosition, main_cam);

        if (linkIndex >= 0 && linkIndex < Textbox.textInfo.linkInfo.Length)
        {
            //var linkId = Textbox.textInfo.linkInfo[linkIndex].GetLinkID();
            UpdateText();
        }
    }

    private void UpdateText()
    {
        string last = Textbox.text;
        if (isReplace)
        {
            GameManager.instance.ReplaceText();
        }
        else
        {
            int next_index = (cycle_index + 1 < cycle_text.Count) ? cycle_index + 1 : 0;
            Textbox.SetText(Textbox.text.Replace(cycle_text[cycle_index], cycle_text[next_index]));
            cycle_index = next_index;
        }

        SaveSystem.SetHistory(SaveSystem.GetHistory().Replace(last, Textbox.text));
    }

    private void Update()
    {
        OnHoverLinkAtMousePosition();
    }

    //adapted code from https://github.com/Maraakis/ChristinaCreatesGames/blob/main/Detect%20hovering%20on%20tagged%20text%20elements/LinkHandlerForTMPTextHover.cs
    private void OnHoverLinkAtMousePosition()
    {
        // For old input system use this, rest stays the same:
        Vector3 mousePosition = new Vector3(Input.mousePosition.x, Input.mousePosition.y, 0);

        bool isIntersectingRectTransform = TMP_TextUtilities.IsIntersectingRectTransform(TextboxRectTransform, mousePosition, main_cam);
        if (!isIntersectingRectTransform)
        {
            if (cycle_color != color_default)
                EndHover();
            return;
        }


        int intersectingLink = TMP_TextUtilities.FindIntersectingLink(Textbox, mousePosition, main_cam);

        if (CurrentlyActiveElement != intersectingLink)
            EndHover();

        if (intersectingLink == -1)
            return;

        TMP_LinkInfo linkInfo = Textbox.textInfo.linkInfo[intersectingLink];

        OnHover(linkInfo.GetLinkID(), mousePosition);
        CurrentlyActiveElement = intersectingLink;
    }

}
