using System;
using System.Collections;
using System.Collections.Generic;
using AYellowpaper.SerializedCollections;
using UnityEngine;
using TMPro;
using UnityEngine.EventSystems;

//this object is put on the text object
public class LinksManager : MonoBehaviour, IPointerClickHandler
{
    // URLs to open when links clicked
    private const string HomePageUrl = "https://www.spongehammergames.com/";
    private const string SomeOtherUrl = "https://www.spongehammer.com/";
    private const string DefaultUrl = "https://www.spongehammer.com/";

    //[SerializeField, Tooltip("The UI GameObject having the TextMesh Pro component.")]
    private TextMeshProUGUI Textbox;
    private RectTransform TextboxRectTransform;
    private int CurrentlyActiveElement;
    
    private List<string> cycle_text = new List<string>();
    private int cycle_index = 0;
    private string cycle_color = "red"; 

    public Camera camera;

    public delegate void HoverOnLink(string keyword, Vector3 mousePos);
    public static event HoverOnLink OnHoverEvent;
    
    public delegate void EndOnHover();
    public static event EndOnHover OnEndHoverEvent;
    
    
    private void Start()
    {
        Textbox = GetComponent<TextMeshProUGUI>();
        TextboxRectTransform = GetComponent<RectTransform>();
        
        cycle_text.Add("yes");
        cycle_text.Add("no");
        cycle_text.Add("maybe");

        //SetLinkData(cycle_text, "Temp1");

    }

    private void OnEnable()
    {
        LinksManager.OnHoverEvent += OnHover;
        LinksManager.OnEndHoverEvent += EndHover;
        //GameManager.SetLinkDataEvent += 
    }

    private void OnDisable()
    {
        LinksManager.OnHoverEvent -= OnHover;
        LinksManager.OnEndHoverEvent -= EndHover;
        //GameManager.SetLinkDataEvent -= 
    }

    private void SetLinkData(List<string> cycle_list, string uniqueID)
    {
        this.cycle_text = cycle_list;

        //TODO: this might be a string we pass along rather than getting text from the box
        string temp_text = Textbox.text;
        
        string new_text = $"<color=\"{cycle_color}\"><link=\"{uniqueID}\">{cycle_list[cycle_index]}</link></color>";
        temp_text = temp_text.Replace("@", new_text);

        Textbox.text = temp_text;
    }
    
    private void EndHover()
    {
        string next_color = "red";
        
        Textbox.text = Textbox.text.Replace(cycle_color, next_color);
        cycle_color = next_color;
    }

    private void OnHover(string keyword, Vector3 mousePos)
    {
        string next_color = "blue";
        
        Textbox.text = Textbox.text.Replace(cycle_color, next_color);
        cycle_color = next_color;
    }

    // Callback for handling clicks.
    public void OnPointerClick(PointerEventData eventData)
    {
        // First, get the index of the link clicked. Each of the links in the text has its own index.
        var linkIndex = TMP_TextUtilities.FindIntersectingLink(Textbox, Input.mousePosition, camera);
		
        // As the order of the links can vary easily (e.g. because of multi-language support),
        // you need to get the ID assigned to the links instead of using the index as a base for our decisions.
        // you need the LinkInfo array from the textInfo member of the TextMesh Pro object for that.

        if (linkIndex < Textbox.textInfo.linkInfo.Length)
        {
            var linkId = Textbox.textInfo.linkInfo[linkIndex].GetLinkID();
            // Now finally you have the ID in hand to decide what to do. Don't forget,
            // you don't need to make it act like an actual link, instead of opening a web page,
            // any kind of functions can be called.
            var url = linkId switch
            {
                "TestID1" => HomePageUrl,
                "TestID2" => SomeOtherUrl,
                _ => DefaultUrl
            };
            
            int next_index = (cycle_index + 1 < cycle_text.Count) ? cycle_index + 1 : 0;

            Debug.Log($"URL clicked: linkInfo[{linkIndex}].id={linkId}   ==>   url={url}");
        }
    }

    private void Update()
    {
        OnHoverLinkAtMousePosition();
    }

    //adapted code from https://github.com/Maraakis/ChristinaCreatesGames/blob/main/Detect%20hovering%20on%20tagged%20text%20elements/LinkHandlerForTMPTextHover.cs
    private void OnHoverLinkAtMousePosition()
    {
        // For new input system
        //Vector3 mousePosition = Mouse.current.position.ReadValue();
            
        // For old input system use this, rest stays the same:
        Vector3 mousePosition = new Vector3(Input.mousePosition.x, Input.mousePosition.y, 0);
            
        bool isIntersectingRectTransform = TMP_TextUtilities.IsIntersectingRectTransform(TextboxRectTransform, mousePosition, camera);
        if (!isIntersectingRectTransform)
        {
            if (cycle_color != "red") EndHover(); 
            return;
        }
            

        int intersectingLink = TMP_TextUtilities.FindIntersectingLink(Textbox, mousePosition, camera);

        if (CurrentlyActiveElement != intersectingLink)
            EndHover();//OnEndHoverEvent?.Invoke();
            
        if (intersectingLink == -1)
            return;

        TMP_LinkInfo linkInfo = Textbox.textInfo.linkInfo[intersectingLink];
            
        OnHover(linkInfo.GetLinkID(), mousePosition);
        CurrentlyActiveElement = intersectingLink;
    }
    
}
