using System;
using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

namespace AYellowpaper.SerializedCollections
{
    public class SettingsHelper : MonoBehaviour
    {
        [SerializedDictionary("Index", "Object Parent")] public SerializedDictionary<int, GameObject> MenuDictionary;
        [SerializeField] private Transform MenuParent, ButtonParent;

        private void OnEnable()
        {
            SelectMenu(0);
            SettingsUIButtonsHelper.OnClick += SelectMenu;
        }

        private void OnDisable()
        {
            SelectMenu(0);
            SettingsUIButtonsHelper.OnClick -= SelectMenu;
        }

        public void SelectMenu(int index)
        {
            for (int i = 0; i < MenuDictionary.Count; i++)
            {
                if (i == index)
                {
                    MenuParent.GetChild(i).gameObject.SetActive(true);
                    SettingsUIButtonsHelper button = ButtonParent.GetChild(i).gameObject.GetComponent<SettingsUIButtonsHelper>();
                    button.IsPageSelected(true);
                }
                else
                {
                    MenuParent.GetChild(i).gameObject.SetActive(false);
                    SettingsUIButtonsHelper button = ButtonParent.GetChild(i).gameObject.GetComponent<SettingsUIButtonsHelper>();
                    button.IsPageSelected(false);
                }
            }
        }
    }
}