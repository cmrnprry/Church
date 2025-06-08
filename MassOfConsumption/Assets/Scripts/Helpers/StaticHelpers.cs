using DG.Tweening;
using UnityEngine.UI;
using UnityEngine;

public static class StaticHelpers
{
    public static bool LastWasDefault = true;

    public static void SetBackgroundImage(string key, Sprite sprite, Image[] backgrounds, Animator anim)
    {
        Sequence seq = DOTween.Sequence();
        if (LastWasDefault) //if default background is currently shown
        {
            if (key != "Defualt") //make sure we want to cahnge to a non-default background
            {
                anim.enabled = false;
                backgrounds[2].sprite = sprite;

                if (key == "Bus Stop")
                    ShiftImage(backgrounds[2]);
                else
                    ShiftImage(backgrounds[2], false, true);

                seq.Append(backgrounds[0].DOFade(0, 0.25f)).Insert(0, backgrounds[1].DOFade(0, 0.25f)).OnComplete(() =>
                {
                    backgrounds[2].DOFade(1, 0.25f);
                });

                LastWasDefault = false;
                SaveSystem.SetCurrentSprite(key.Trim());
            }
        }
        else //a non-deafult background is shown
        {
            if (key == "Defualt") //we want to show default background
            {
                backgrounds[0].sprite = sprite;
                backgrounds[1].sprite = sprite;
                SaveSystem.SetCurrentSprite("Defualt");


                backgrounds[2].DOFade(0, 0.25f).OnComplete(() =>
                {
                    seq.Append(backgrounds[0].DOFade(1, 0.25f)).Insert(0, backgrounds[1].DOFade(1, 0.25f)).OnComplete(
                        () => { anim.enabled = true; });
                });

                LastWasDefault = true;
            }
            else //switch to a non-default background
            {
                backgrounds[2].DOFade(0, 0.25f).OnComplete(() =>
                {
                    backgrounds[2].sprite = sprite;

                    if (key == "Bus Stop")
                        ShiftImage(backgrounds[2]);
                    else
                        ShiftImage(backgrounds[2], false, true);

                    backgrounds[2].DOFade(1, 0.25f);
                });

                LastWasDefault = false;
                SaveSystem.SetCurrentSprite(key.Trim());
            }
        }
    }


    public static void ShiftImage(Image background, bool wasVisible = false, bool isNonBus = false)
    {
        int pos = wasVisible ? -100 : 100;
        float time = wasVisible ? 0.5f : 0;

        if (isNonBus)
        {
            pos = 0;
            time = 0;
        }

        background.gameObject.GetComponent<RectTransform>().DOAnchorPosX(pos, time);
    }












}
