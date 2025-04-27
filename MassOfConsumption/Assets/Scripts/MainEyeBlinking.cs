using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MainEyeBlinking : MonoBehaviour
{
    [SerializeField] private Animator main, left, right;
    private MinMax main_wait, left_wait, right_wait;
    private Coroutine main_coroutine, left_coroutine, right_coroutine;

    private void Start()
    {
        main_wait.SetValue(10, 5);
        left_wait.SetValue(15, 5);
        right_wait.SetValue(15, 7);

        main_coroutine = StartCoroutine(MainEyeBlink());
        left_coroutine = StartCoroutine(LeftEyeBlink());
        right_coroutine = StartCoroutine(RightEyeBlink());
    }

    private void OnEnable()
    {
        main_wait.SetValue(15, 10);
        left_wait.SetValue(10, 5);
        right_wait.SetValue(16, 5);

        main_coroutine = StartCoroutine(MainEyeBlink());
        left_coroutine = StartCoroutine(LeftEyeBlink());
        right_coroutine = StartCoroutine(RightEyeBlink());
    }

    private void OnDisable()
    {
        StopCoroutine(main_coroutine);
        StopCoroutine(left_coroutine);
        StopCoroutine(right_coroutine);
    }

    IEnumerator MainEyeBlink()
    {
        yield return new WaitForSecondsRealtime(main_wait.GetRandomValue());

        main.SetTrigger("Toggle");
        yield return null;

        float dur = main.GetCurrentAnimatorStateInfo(0).length;
        
        yield return new WaitForSecondsRealtime(dur);
        main_coroutine = StartCoroutine(MainEyeBlink());
    }

    IEnumerator LeftEyeBlink()
    {
        yield return new WaitForSecondsRealtime(left_wait.GetRandomValue());

        left.SetTrigger("Toggle");
        yield return null;

        float dur = left.GetCurrentAnimatorStateInfo(0).length;
        
        yield return new WaitForSecondsRealtime(dur);
        left_coroutine = StartCoroutine(LeftEyeBlink());
    }

    IEnumerator RightEyeBlink()
    {
        yield return new WaitForSecondsRealtime(right_wait.GetRandomValue());

        right.SetTrigger("Toggle");
        yield return null;

        float dur = right.GetCurrentAnimatorStateInfo(0).length;
        
        yield return new WaitForSecondsRealtime(dur);
        right_coroutine = StartCoroutine(RightEyeBlink());
    }
}