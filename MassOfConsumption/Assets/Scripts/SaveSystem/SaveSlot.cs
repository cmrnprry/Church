using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;
using AYellowpaper.SerializedCollections;

public class SaveSlot : MonoBehaviour
{
    private int ID;
    private string slotID;
    private LabledButton button;

    [Header("Data")]
    [SerializeField]
    private Image image;
    [SerializeField]
    private TextMeshProUGUI text;

    public delegate void SlotAction(string ID, SaveSlot slot);
    public static event SlotAction OnTryOverwriteSave;

    public delegate void SaveAction(string ID);
    public static event SaveAction OnSave;

    private void Start()
    {
        button = GetComponent<LabledButton>();
        button.onClick.AddListener(() => SaveLoadData());
    }

    private void OnEnable()
    {
        GameManager.OnAutoSave += AutoSave;
    }

    private void OnDestroy()
    {
        GameManager.OnAutoSave -= AutoSave;
    }

    public void SetUpData(int Index)
    {
        ID = Index;

        slotID = $"slot_{ID}";

        if (SaveSystem.CheckForData(slotID))
        {
            text.text = SaveSystem.CheckForSaveData(slotID);

            image.sprite = SaveSystem.GetCurrentSprite(slotID);
        }
        else
        {
            text.text = (ID == 0) ? String.Format($"Auto Save Slot")  : String.Format($"Slot {ID + 1}");
        }

    }

    private void AutoSave()
    {
        if (slotID != "slot_0")
            return; 

        image.sprite = SaveSystem.GetCurrentSprite();
        SaveSystem.SaveAllData(slotID);
    }

    public void UpdateData()
    {
        OnSave?.Invoke(slotID);
        DateTime DateCurrent = DateTime.Now;
        text.text = String.Format("{0:d} {0:t}", DateCurrent);

        image.sprite = SaveSystem.GetCurrentSprite();

        SaveSystem.SaveAllData(slotID);
    }

    private void SaveLoadData()
    {
        if (SaveSystem.isSaving)
        {
            //if there is save data
            if (SaveSystem.CheckForData(slotID))
            {
                OnTryOverwriteSave.Invoke(slotID, this);
            }
            else
            {
                UpdateData();
            }
        }
        else
        {
            //if there is save data
            if (SaveSystem.CheckForData(slotID))
            {
                SaveSystem.LoadSlotData(slotID);
            }
        }

    }
}