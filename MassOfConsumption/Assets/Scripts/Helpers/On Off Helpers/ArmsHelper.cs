using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using DG.Tweening;

public class ArmsHelper : OnOffHelpers
{
    private List<GameObject> arms = new List<GameObject>();

    private void Start()
    {
        foreach (Transform arm in this.transform)
        {
            arms.Add(arm.gameObject);
        }
    }

    private void OnEnable()
    {

    }

    protected override void TurnOn()
    {
        StartCoroutine(TurnOnArms());
    }

    IEnumerator TurnOnArms()
    {
        yield return new WaitForSeconds(1.5f);

        foreach (var arm in arms)
        {
            arm.gameObject.SetActive(true);
            var anim = arm.GetComponent<Animator>();
            yield return new WaitForSeconds(anim.GetCurrentAnimatorClipInfo(0)[0].clip.length);
            arm.GetComponent<SpriteRenderer>().maskInteraction = SpriteMaskInteraction.None;
            Destroy(arm.transform.GetChild(1).gameObject);

            yield return null;

            anim.SetTrigger("Toggle");
        }
        
    }

    protected override void TurnOff()
    {
        foreach (var arm in arms)
        {
            arm.gameObject.SetActive(false);
        }
    }
}
