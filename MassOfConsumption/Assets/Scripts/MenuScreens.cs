using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using DG.Tweening;
using TMPro;
using UnityEngine.SceneManagement;
using UnityEngine.Serialization;

namespace AYellowpaper.SerializedCollections
{
    public class MenuScreens : MonoBehaviour
    {
        [Header("Transition Screen")]
        public Image TransitionScreen;
        public GameObject Settings, MainMenu, SaveLoad;
        public LabledButton LoadButton;
        public TMP_Dropdown Res_dropdown;

        private float wait = 0.25f;

        public void ReloadScene()
        {
            SceneManager.LoadScene(0);
        }

        private void Start()
        {
            if (SaveSystem.HasSaveData())
            {
                LoadButton.gameObject.SetActive(true);
                LoadButton.onClick.AddListener(() =>
                {
                    ShowScreen(SaveLoad, true);
                    SaveSystem.isSaving = false;
                });
            }

        }

        public void StartGame(GameObject Menu)
        {
            TransitionScreen.gameObject.SetActive(true);
            TransitionScreen.DOFade(1, 0.5f).OnComplete(() =>
            {
                MainMenu.SetActive(false);
                Menu.SetActive(true);
                TransitionScreen.DOFade(0, 0.5f).OnComplete(() =>
                {
                    TransitionScreen.gameObject.SetActive(false);
                });
            });
        }

        private void OnEnable()
        {
            SaveSystem.OnLoad += CloseSettingsOnLoad;
        }

        private void OnDisable()
        {
            SaveSystem.OnLoad -= CloseSettingsOnLoad;
        }

        public void QuitGame()
        {
            Application.Quit();
        }

        public void ShowScreen(GameObject Menu)
        {
            TransitionScreen.gameObject.SetActive(true);
            TransitionScreen.DOFade(1, 0.5f).OnComplete(() =>
            {
                Menu.SetActive(!Menu.activeSelf);
                TransitionScreen.DOFade(0, 0.5f).OnComplete(() =>
                {
                    TransitionScreen.gameObject.SetActive(false);
                });
            });
        }

        public void ShowSettings()
        {
            TransitionScreen.gameObject.SetActive(true);
            TransitionScreen.DOFade(1, 0.5f).OnComplete(() =>
            {
                Settings.SetActive(true);
                TransitionScreen.DOFade(0, 0.5f).OnComplete(() =>
                {
                    TransitionScreen.gameObject.SetActive(false);
                    Time.timeScale = 0;
                });
            });
        }

        private void ShowScreen(GameObject Menu, bool shouldShow)
        {
            TransitionScreen.gameObject.SetActive(true);
            TransitionScreen.DOFade(1, 0.5f).OnComplete(() =>
            {
                Menu.SetActive(shouldShow);
                TransitionScreen.DOFade(0, 0.5f).OnComplete(() =>
                {
                    TransitionScreen.gameObject.SetActive(false);
                });
            });
        }

        private void CloseSettingsOnLoad()
        {
            StartCoroutine(WaitToHideSettings());
        }

        private IEnumerator WaitToHideSettings()
        {
            yield return new WaitForSeconds(wait);

            if (Settings.activeSelf)
                ShowScreen(Settings, false);

            if (MainMenu.activeSelf)
                ShowScreen(MainMenu, false);

            if (SaveLoad.activeSelf)
                ShowScreen(SaveLoad, false);
        }

        public void SetScreenMode(bool isFullScreen)
        {
            var res = SaveSystem.GetResolution();
            Screen.SetResolution((int)res.x, (int)res.y, isFullScreen);

            SaveSystem.SetFullscreen(isFullScreen);
        }

        public void SetRes(int value)
        {
            var option = Res_dropdown.options[value].text.Split('x');
            var res = new Vector2(int.Parse(option[0].Trim()), int.Parse(option[1].Trim()));
            Screen.SetResolution((int)res.x, (int)res.y, SaveSystem.GetFullscreen());

            SaveSystem.SetResolution(res, value);
        }
    }
}