using System;
using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

namespace AYellowpaper.SerializedCollections
{
    public class SettingsButtomsController : MonoBehaviour
    {
        [SerializedDictionary("Index", "Object Parent")] public SerializedDictionary<int, GameObject> MenuDictionary;
        [SerializeField] private Transform MenuParent, ButtonParent;

        private void OnEnable()
        {
            SelectMenu(0);
            SettingsUIButton.OnClick += SelectMenu;
        }

        private void OnDisable()
        {
            SelectMenu(0);
            //Time.timeScale = 1;
            SettingsUIButton.OnClick -= SelectMenu;
        }

        public void SelectMenu(int index)
        {
            for (int i = 0; i < MenuDictionary.Count; i++)
            {
                if (i == index)
                {
                    MenuDictionary[i].SetActive(true);
                    SettingsUIButton button = ButtonParent.GetChild(i).gameObject.GetComponent<SettingsUIButton>();
                    button.IsPageSelected(true);
                }
                else
                {
                    MenuDictionary[i].SetActive(false);
                    SettingsUIButton button = ButtonParent.GetChild(i).gameObject.GetComponent<SettingsUIButton>();
                    button.IsPageSelected(false);
                }
            }
        }
    }
}