using DG.Tweening;
using System.Collections;
using System.Threading.Tasks;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;
using AYellowpaper.SerializedCollections;

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
        if (SaveSystem.HasSaveData())
        {
            LoadButton.gameObject.SetActive(true);
            LoadButton.onClick.AddListener(() =>
            {
                TransitionToMenu(SaveLoad, true);
                SaveSystem.isSaving = false;
            });
        }
    }

    private void OnEnable()
    {
        SaveSystem.OnLoad += CloseSettingsOnLoad;
    }

    private void OnDisable()
    {
        SaveSystem.OnLoad -= CloseSettingsOnLoad;
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

        if (Settings.activeSelf)
            TransistionsAndLoading.instance.TransitionToMenu(Settings, false);

        if (MainMenu.activeSelf)
            TransistionsAndLoading.instance.TransitionToMenu(MainMenu, false);

        if (SaveLoad.activeSelf)
            TransistionsAndLoading.instance.TransitionToMenu(SaveLoad, false);
    }
 
    /// <summary>
    /// Transitions to show a menu
    /// </summary>
    /// <param name="Menu">Gameobject we want to view</param>
    public void TransitionToMenu(GameObject Menu)
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

    public void ToMainMenu()
    {
        TransitionToMenu(MainMenu);
    }

    public void TransitionToMenu(GameObject Menu, bool shouldShow)
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
    
    public void ShowSettings()
    {
        TransitionScreen.gameObject.SetActive(true);
        TransitionScreen.DOFade(1, 0.5f).OnComplete(() =>
        {
            Settings.SetActive(true);
            TransitionScreen.DOFade(0, 0.5f).OnComplete(() =>
            {
                TransitionScreen.gameObject.SetActive(false);
            });
        });
    }

}
