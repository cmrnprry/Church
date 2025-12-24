using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;

public class SaveLoadUIHelper : MonoBehaviour
{
    public Transform SlotPageParent, PageNumberParent;
    private List<SaveUIPageNumber> PageNumbers = new List<SaveUIPageNumber>();
    private List<GameObject> PageSlots = new List<GameObject>();
    private int Page_Index = 0, Slot_Index = 0;
    [SerializeField] private int Max_Pages = 0;
    [SerializeField] private int Max_Slots = 0;

    [Header("Prefabs")]
    [SerializeField] GameObject PageNumberPreab;
    [SerializeField] GameObject SlotPagePrefab;
    [SerializeField] GameObject AutoSlotPagePrefab;
    [SerializeField] GameObject SaveSlotsPrefab;
    [SerializeField] GameObject OverwriteSaveData;
    [SerializeField] TextMeshProUGUI OverwriteSaveData_Text;

    [Header("Save Load Toggle")]
    [SerializeField] private ToggleSwitchColorChange SaveLoad;


    // Start is called before the first frame update
    void Start()
    {
        for (int i = 0; i < Max_Pages; i++)
        {
            GameObject slot_page = Instantiate(SlotPagePrefab, SlotPageParent);
            PageSlots.Add(slot_page);
            SetSaveSlots(slot_page, (i == 0));

            var page_number = Instantiate(PageNumberPreab, PageNumberParent);
            SaveUIPageNumber page = page_number.GetComponent<SaveUIPageNumber>();

            PageNumbers.Add(page);
            page.SetPageNumber(i);
        }
    }

    private void SetSaveSlots(GameObject Parent, bool isVisible = false)
    {
        for (int i = 0; i < Max_Slots; i++)
        {
            GameObject save_slot = (Slot_Index == 0) ? Instantiate(AutoSlotPagePrefab, Parent.transform) : Instantiate(SaveSlotsPrefab, Parent.transform);
            save_slot.GetComponent<SaveSlot>().SetUpData(Slot_Index);
            Slot_Index++;
        }

        Parent.SetActive(isVisible);
    }

    private void OnEnable()
    {
        SaveUIPageNumber.OnClick += SetPage;
        SaveSlot.OnTryOverwriteSave += OverwriteSave;

        if (SaveLoad != null)
            SaveLoad.ToggleSwitchOnOff(!SaveSystem.isSaving);
    }

    private void OnDisable()
    {
        SaveUIPageNumber.OnClick -= SetPage;
        SaveSlot.OnTryOverwriteSave -= OverwriteSave;
    }

    private void OverwriteSave(string ID, SaveSlot slot)
    {
        var buttons = OverwriteSaveData.GetComponentsInChildren<LabledButton>();
        foreach (var button in buttons)
        {
            if (button.name == "Yes")
            {
                button.onClick.RemoveAllListeners();

                button.onClick.AddListener(() =>
                {
                    Debug.Log(SaveSystem.GetCurrentSprite());
                    slot.UpdateData();
                    OverwriteSaveData.SetActive(false);
                });
            }
        }

        if (OverwriteSaveData_Text != null)
            OverwriteSaveData_Text.text = (ID == "slot_0") ? "This save will be overwritten on the next autosave. <br><br> Continue?" : "This will cause you to overwrite the save. <br><br> Continue?";
        OverwriteSaveData.SetActive(true);
    }

    public void CycleClick(bool isLeft)
    {
        if (!isLeft)
        {
            Page_Index = (Page_Index + 1 >= Max_Pages) ? 0 : Page_Index + 1;
        }
        else
            Page_Index = (Page_Index - 1 <= 0) ? Max_Pages - 1 : Page_Index - 1;

        SwitchPage();
    }

    public void SetPage(int p)
    {
        Page_Index = p;
        SwitchPage();
    }

    private void SwitchPage()
    {
        for (int ii = 0; ii < Max_Pages; ii++)
        {
            PageSlots[ii].SetActive(ii == Page_Index);

            PageNumbers[ii].IsPageSelected(ii == Page_Index);
        }
    }

    public void SetSaving(bool value)
    {
        SaveSystem.isSaving = value;
    }
}
