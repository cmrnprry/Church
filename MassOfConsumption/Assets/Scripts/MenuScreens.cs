using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using DG.Tweening;

public class MenuScreens : MonoBehaviour
{
    [Header("Transition Screen")]
    public Image TransitionScreen;
    
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
}
