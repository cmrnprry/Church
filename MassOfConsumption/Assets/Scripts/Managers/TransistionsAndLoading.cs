using DG.Tweening;
using System.Collections;
using System.Threading.Tasks;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;
using AYellowpaper.SerializedCollections;
using UnityEngine.InputSystem;

public class TransistionsAndLoading : MonoBehaviour
{
    public static TransistionsAndLoading instance;

    [Header("Loading Screen")]
    public Image LoadScreen;
    public GameObject text;
    //public Slider progressBar;

    [Header("Transition Screen")]
    public Image TransitionScreen;
    public GameObject Settings, MainMenu, SaveLoad;
    public LabledButton LoadButton;

    private AsyncOperation loadingOperation;
    private float wait = 0.25f;

    void Awake()
    {
        if (instance == null)
            instance = this;
        else
            Destroy(this.gameObject);
        DontDestroyOnLoad(gameObject);
    }

    void Start()
    {
        CheckForData();
    }

    void CheckForData()
    {
        if (SaveSystem.HasSaveData())
        {
            LoadButton.gameObject.SetActive(true);
            LoadButton.onClick.AddListener(() =>
            {
                Settings.SetActive(false);
                GameManager.instance.Actions.Controls.Pause.performed += ShowSettings;
                GameManager.instance.Actions.Controls.History.performed += ShowHistory;
                GameManager.instance.Actions.Controls.Save.performed += ShowSaveMenu;
                TransitionToMenu(SaveLoad, true);
                SaveSystem.isSaving = false;
            });
        }
    }

    private void OnEnable()
    {
        SaveSystem.PreLoad += CloseSettingsOnLoad;
    }

    private void OnDisable()
    {
        SaveSystem.PreLoad -= CloseSettingsOnLoad;
        GameManager.instance.Actions.Controls.Pause.performed -= ShowSettings;
        GameManager.instance.Actions.Controls.History.performed -= ShowHistory;
        GameManager.instance.Actions.Controls.Save.performed -= ShowSaveMenu;
    }

    public void StartGame(GameObject Menu)
    {
        TransitionScreen.gameObject.SetActive(true);
        Settings.SetActive(false);

        TransitionScreen.DOFade(1, 0.5f).OnComplete(() =>
        {
            MainMenu.SetActive(false);
            Menu.SetActive(true);
            TransitionScreen.DOFade(0, 0.5f).OnComplete(() =>
            {
                TransitionScreen.gameObject.SetActive(false);
                GameManager.instance.Actions.Controls.Pause.performed += ShowSettings;
                GameManager.instance.Actions.Controls.History.performed += ShowHistory;
                GameManager.instance.Actions.Controls.Save.performed += ShowSaveMenu;
            });
        });
    }

    public void QuitGame()
    {
        Application.Quit();
    }

    private void CloseSettingsOnLoad()
    {
        StartCoroutine(WaitToHideSettings());
    }

    private IEnumerator WaitToHideSettings()
    {
        yield return new WaitForSeconds(wait);

        TransitionScreen.gameObject.SetActive(true);
        TransitionScreen.DOFade(1, 0.5f).OnComplete(() =>
        {
            if (!Settings.activeSelf)
                Settings.SetActive(true);

            DataManager.instance.group.enabled = true;
            DataManager.instance.fitter.enabled = true;
            DataManager.instance.History.SetActive(true);

            MainMenu.SetActive(false);
            SaveLoad.SetActive(false);

            TransitionScreen.DOFade(0, 0.5f).OnPlay(() =>
            {
                DataManager.instance.group.enabled = false;
                DataManager.instance.fitter.enabled = false;
                Settings.SetActive(false);
            }).OnComplete(() =>
            {
                TransitionScreen.gameObject.SetActive(false);
                DataManager.instance.History.SetActive(false);
            });
        });

        yield return new WaitForEndOfFrame();



        SaveSystem.InvokeLoad();
    }

    /// <summary>
    /// Transitions to show a menu
    /// </summary>
    /// <param name="Menu">Gameobject we want to view</param>
    public void TransitionToMenu(GameObject Menu)
    {
        MenuTransition(Menu, !Menu.activeSelf);
    }

    public void TransitionToMenu(GameObject Menu, bool shouldShow)
    {
        MenuTransition(Menu, shouldShow);
    }


    public void ShowSettingsButton()
    {
        ShowSettings();
    }
    private void ShowSettings(bool ShowHistoy = false, bool showSave = false)
    {
        DataManager.instance.SetHistoryText();

        TransitionScreen.gameObject.SetActive(true);
        TransitionScreen.DOFade(1, 0.5f).OnComplete(() =>
        {
            if (!Settings.activeSelf)
            {
                Settings.SetActive(true);

                DataManager.instance.group.enabled = true;
                DataManager.instance.fitter.enabled = true;
                DataManager.instance.History.SetActive(true);

                if (ShowHistoy)
                    Settings.GetComponent<SettingsButtomsController>().SelectMenu(3);

                if (showSave)
                    Settings.GetComponent<SettingsButtomsController>().SelectMenu(2);
            }
            else
                Settings.SetActive(false);

            TransitionScreen.DOFade(0, 0.5f).OnPlay(() =>
            {
                if (Settings.activeSelf || ShowHistoy)
                {
                    DataManager.instance.group.enabled = false;
                    DataManager.instance.fitter.enabled = false;
                    DataManager.instance.History.SetActive(false);
                    DataManager.instance.History.SetActive(ShowHistoy);
                }
            }).OnComplete(() =>
            {
                TransitionScreen.gameObject.SetActive(false);
            });
        });
    }

    private void ShowSettings(InputAction.CallbackContext context)
    {
        ShowSettings();
    }

    private void ShowHistory(InputAction.CallbackContext context)
    {
        ShowSettings(true);
    }

    private void ShowSaveMenu(InputAction.CallbackContext context)
    {
        ShowSettings(false, true);
    }

    private void MenuTransition(GameObject Menu, bool shouldShow)
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

    public void ToMainMenu()
    {
        CheckForData();
        TransitionToMenu(MainMenu);
    }


    /// <summary>
    ///Hides menu before load
    /// </summary>
    /// <param name="Menu">Gameobject we want to view</param>
    async Task HideScreen()
    {
        TransitionScreen.gameObject.SetActive(true);
        TransitionScreen.DOFade(1, 1);

        var task = Task.Delay(1500);
        await task;

        print("hideen");
    }

    /// <summary>
    /// Shows the menu after load
    /// </summary>
    async Task ShowScreen()
    {

        TransitionScreen.DOFade(0, 1).OnComplete(() =>
        {
            TransitionScreen.gameObject.SetActive(false);
        });

        var task = Task.Yield();
        await task;

        print("seeing");
    }


}
