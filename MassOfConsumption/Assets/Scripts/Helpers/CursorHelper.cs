using System;
using System.Collections;
using System.Collections.Generic;
using AYellowpaper.SerializedCollections;
using Unity.VisualScripting;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.InputSystem;

public class CursorHelper : MonoBehaviour
{
    private Vector3 mousePosition;
    private Vector2 contollerVector;
    private readonly Vector3 offset = new Vector3(17, -22, 0);
    private float moveSpeed = 0.5f;
    public List<Sprite> sprites = new List<Sprite>();
    private Image img;
    private Coroutine routine;


    void Start()
    {
        Cursor.visible = false;
        Cursor.lockState = CursorLockMode.None;
        img = GetComponent<Image>();
    }

    private void OnEnable()
    {
        LabledButton.OnCursorEnter += OnHoverStart;
        LabledButton.OnCursorExit += OnHoverEnd;

        LinksManager.OnCursorEnter += OnHoverStart;
        LinksManager.OnCursorExit += OnHoverEnd;

        SettingsUIButton.OnCursorEnter += OnHoverStart;
        SettingsUIButton.OnCursorExit += OnHoverEnd;

        ToggleSwitchColorChange.OnCursorEnter += OnHoverStart;
        ToggleSwitchColorChange.OnCursorExit += OnHoverEnd;

        SaveUIPageNumber.OnCursorEnter += OnHoverStart;
        SaveUIPageNumber.OnCursorExit += OnHoverEnd;

        ClickToMoveHelper.OnCursorEnter += OnHoverStart;
        ClickToMoveHelper.OnCursorExit += OnHoverEnd;

        GameManager.OnForceBlink += ForceBlink;
        GameManager.OnForceClosed += ForceClose;
        GameManager.OnForceOpen += ForceOpen;
    }

    private void OnDisable()
    {
        LabledButton.OnCursorEnter -= OnHoverStart;
        LabledButton.OnCursorExit -= OnHoverEnd;

        LinksManager.OnCursorEnter -= OnHoverStart;
        LinksManager.OnCursorExit -= OnHoverEnd;

        SettingsUIButton.OnCursorEnter -= OnHoverStart;
        SettingsUIButton.OnCursorExit -= OnHoverEnd;

        ToggleSwitchColorChange.OnCursorEnter -= OnHoverStart;
        ToggleSwitchColorChange.OnCursorExit -= OnHoverEnd;

        SaveUIPageNumber.OnCursorEnter -= OnHoverStart;
        SaveUIPageNumber.OnCursorExit -= OnHoverEnd;

        ClickToMoveHelper.OnCursorEnter -= OnHoverStart;
        ClickToMoveHelper.OnCursorExit -= OnHoverEnd;

        GameManager.OnForceBlink -= ForceBlink;
        GameManager.OnForceClosed -= ForceOpen;
        GameManager.OnForceOpen -= ForceClose;
    }

    private void ForceOpen()
    {
        if (routine != null)
            StopCoroutine(routine);

        SaveSystem.SetIsCursorNeutral(false);
        SaveSystem.SetIsCursorOpen(true);

        routine = StartCoroutine(Open());
    }

    private void ForceBlink()
    {
        if (routine != null)
            StopCoroutine(routine);

        SaveSystem.SetIsCursorOpen(false);

        routine = StartCoroutine(Blink());
    }

    private void ForceClose()
    {
        if (routine != null)
            StopCoroutine(routine);

        SaveSystem.SetIsCursorOpen(false);
        SaveSystem.SetIsCursorNeutral(false);

        routine = StartCoroutine(Close());
    }


    // Update is called once per frame
    void Update()
    {
        //if (Gamepad.all.Count <= 0)
        //{
            mousePosition = Input.mousePosition + offset;
            mousePosition = Camera.main.ScreenToWorldPoint(mousePosition);
            transform.position = Vector2.Lerp(transform.position, mousePosition, moveSpeed);
      //      moveSpeed = 0.5f;
        //}
        //else
        //{
        //    contollerVector = GameManager.instance.Actions.Controls.Controller.ReadValue<Vector2>();
        //    transform.Translate(contollerVector * Time.deltaTime * moveSpeed);
        //    Debug.Log(transform.position);
        //    moveSpeed =9f;
        //}


        if (Mouse.current.leftButton.isPressed && img.sprite != sprites[4] && img.sprite != sprites[5] && img.sprite != sprites[6] && GameManager.instance.ShouldBlink)
        {
            if (routine != null)
                StopCoroutine(routine);
            routine = StartCoroutine(Blink());
        }

        if (Cursor.visible)
            Cursor.visible = false;
    }

    IEnumerator Blink()
    {
        int start = SaveSystem.IsCursorOpen() ? 3 : 1;
        yield return new WaitForSeconds(0.1f);
        img.sprite = sprites[start];

        yield return new WaitForSeconds(0.1f);
        img.sprite = sprites[2];

        yield return new WaitForSeconds(0.25f);
        start = SaveSystem.IsCursorOpen() ? 1 : 3;
        img.sprite = sprites[start];

        yield return new WaitForSeconds(0.1f);
        img.sprite = sprites[2];

        yield return new WaitForSeconds(0.1f);
        start = SaveSystem.IsCursorOpen() ? 3 : 1;
        img.sprite = sprites[start];

        yield return new WaitForSeconds(0.1f);
        img.sprite = SaveSystem.IsCursorNeutral() ? sprites[0] : (SaveSystem.IsCursorOpen() ? sprites[3] : sprites[1]);

    }

    IEnumerator Open()
    {
        yield return new WaitForSeconds(0.1f);
        img.sprite = sprites[1];

        yield return new WaitForSeconds(0.1f);
        img.sprite = sprites[2];

        yield return new WaitForSeconds(0.25f);
        img.sprite = sprites[3];
    }

    IEnumerator Close()
    {
        yield return new WaitForSeconds(0.25f);
        img.sprite = sprites[3];

        yield return new WaitForSeconds(0.1f);
        img.sprite = sprites[2];

        yield return new WaitForSeconds(0.1f);
        img.sprite = sprites[1];

        if (!GameManager.instance.ShouldBlink)
        {
            yield return new WaitForSeconds(0.1f);
            img.sprite = sprites[0];
        }
    }

    public void OnHoverEnd()
    {
        img.sprite = SaveSystem.IsCursorNeutral() ? sprites[0] : (SaveSystem.IsCursorOpen() ? sprites[3] : sprites[1]);
    }

    public void OnHoverStart()
    {
        if (routine != null)
            StopCoroutine(routine);

        img.sprite = sprites[4];
    }

    public void OnHoverTextBoxEnd()
    {
        img.sprite = SaveSystem.IsCursorNeutral() ? sprites[0] : (SaveSystem.IsCursorOpen() ? sprites[3] : sprites[1]);
    }

    public void OnHoverTextBoxStart()
    {
        if (GameManager.instance.CanStoryContinue())
        {
            if (routine != null)
                StopCoroutine(routine);
            img.sprite = sprites[4];
        }
    }
}