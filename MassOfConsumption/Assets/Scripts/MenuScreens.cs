using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using DG.Tweening;
using UnityEngine.SceneManagement;

public class MenuScreens : MonoBehaviour
{
    [Header("Transition Screen")]
    public Image TransitionScreen;
    public GameObject Settings, MainMenu;
    public LabledButton LoadButton;

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
            LoadButton.onClick.AddListener(() => SaveSystem.LoadSlotData(SaveSystem.GetLastSave()));
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
    }
}
