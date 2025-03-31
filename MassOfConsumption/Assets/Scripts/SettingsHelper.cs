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
        }

        private void OnDisable()
        {
            SelectMenu(0);
        }

        public void SelectMenu(int index)
        {
            for (int i = 0; i < MenuDictionary.Count; i++)
            {
                if (i == index)
                {
                    MenuParent.GetChild(i).gameObject.SetActive(true);
                    LabledButton button = ButtonParent.GetChild(index).gameObject.GetComponent<LabledButton>();
                    button.Select();
                }
                else
                {
                    MenuParent.GetChild(i).gameObject.SetActive(false);
                    LabledButton button = ButtonParent.GetChild(index).gameObject.GetComponent<LabledButton>();
                    button.enabled = true;
                }
            }
        }

        private void SelectButton(int index)
        {
            GameObject obj = ButtonParent.GetChild(index).gameObject;
            LabledButton button = obj.GetComponent<LabledButton>();
            Image img = obj.GetComponent<Image>();
            TextMeshProUGUI text = obj.GetComponentInChildren<TextMeshProUGUI>();

            button.Select();

            button.enabled = false;
            img.color = button.colors.selectedColor;
            text.color = button.labelColors.normalColor;
        }
    }
}