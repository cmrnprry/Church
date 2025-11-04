using System;
using System.Collections;
using System.Collections.Generic;
using AYellowpaper.SerializedCollections;
using Unity.VisualScripting;
using UnityEngine;
using UnityEngine.UI;

public class CursorHelper : MonoBehaviour
{
    private Vector3 mousePosition;
    private readonly Vector3 offset = new Vector3(17, -22, 0);
    private readonly float moveSpeed = 0.5f;
    public List<Sprite> sprites = new List<Sprite>();
    private Image img;
    private Coroutine routine;
    private bool ClickObject = false, ClickText = false, isOpen, isNeutral = true;


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

        SettingsUIButton.OnCursorEnter += OnHoverStart;
        SettingsUIButton.OnCursorExit += OnHoverEnd;

        ToggleSwitchColorChange.OnCursorEnter += OnHoverStart;
        ToggleSwitchColorChange.OnCursorExit += OnHoverEnd;

        SaveUIPageNumber.OnCursorEnter += OnHoverStart;
        SaveUIPageNumber.OnCursorExit += OnHoverEnd;

        GameManager.OnForceBlink += ForceBlink;
        GameManager.OnForceClosed += ForceOpen;
        GameManager.OnForceOpen += ForceClose;
    }

    private void OnDisable()
    {
        LabledButton.OnCursorEnter -= OnHoverStart;
        LabledButton.OnCursorExit -= OnHoverEnd;

        SettingsUIButton.OnCursorEnter -= OnHoverStart;
        SettingsUIButton.OnCursorExit -= OnHoverEnd;

        ToggleSwitchColorChange.OnCursorEnter -= OnHoverStart;
        ToggleSwitchColorChange.OnCursorExit -= OnHoverEnd;

        SaveUIPageNumber.OnCursorEnter -= OnHoverStart;
        SaveUIPageNumber.OnCursorExit -= OnHoverEnd;

        GameManager.OnForceBlink -= ForceBlink;
        GameManager.OnForceClosed -= ForceOpen;
        GameManager.OnForceOpen -= ForceClose;
    }

    private void ForceOpen()
    {
        if (routine != null)
            StopCoroutine(routine);
        routine = StartCoroutine(Open());
        isNeutral = false;
        isOpen = true;
    }

    private void ForceBlink()
    {
        if (routine != null)
            StopCoroutine(routine);

        routine = StartCoroutine(Blink());
    }

    private void ForceClose()
    {
        if (routine != null)
            StopCoroutine(routine);
        routine = StartCoroutine(Close());
    }

    // Update is called once per frame
    void Update()
    {
        mousePosition = Input.mousePosition + offset;
        mousePosition = Camera.main.ScreenToWorldPoint(mousePosition);
        transform.position = Vector2.Lerp(transform.position, mousePosition, moveSpeed);

        if (Input.GetMouseButtonDown(0) && !ClickObject && GameManager.instance.ShouldBlink)
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
        yield return new WaitForSeconds(0.15f);
        img.sprite = sprites[1];

        yield return new WaitForSeconds(0.15f);
        img.sprite = sprites[2];

        yield return new WaitForSeconds(0.35f);
        img.sprite = sprites[3];

        yield return new WaitForSeconds(0.15f);
        img.sprite = sprites[2];

        yield return new WaitForSeconds(0.15f);
        img.sprite = sprites[1];

        yield return new WaitForSeconds(0.15f);
        img.sprite = isNeutral ? sprites[0] : (isOpen ? sprites[3] : sprites[1]);

    }

    IEnumerator Open()
    {
        yield return new WaitForSeconds(0.15f);
        img.sprite = sprites[1];

        yield return new WaitForSeconds(0.15f);
        img.sprite = sprites[2];

        yield return new WaitForSeconds(0.35f);
        img.sprite = sprites[3];
    }

    IEnumerator Close()
    {
        yield return new WaitForSeconds(0.35f);
        img.sprite = sprites[3];

        yield return new WaitForSeconds(0.15f);
        img.sprite = sprites[2];

        yield return new WaitForSeconds(0.15f);
        img.sprite = sprites[1];

        if (!GameManager.instance.ShouldBlink)
        {
            yield return new WaitForSeconds(0.15f);
            img.sprite = sprites[0];
        }
    }

    public void OnHoverEnd()
    {

        img.sprite = isNeutral ? sprites[0] : (isOpen ? sprites[3] : sprites[1]);
        ClickObject = false;
    }

    public void OnHoverStart()
    {
        if (routine != null)
            StopCoroutine(routine);

        img.sprite = sprites[4];
        ClickObject = true;
    }

    public void OnHoverTextBoxEnd()
    {
        img.sprite = isNeutral ? sprites[0] : (isOpen ? sprites[3] : sprites[1]);
        ClickObject = false;
        ClickText = false;
    }

    public void OnHoverTextBoxStart()
    {
        if (GameManager.instance.CanStoryContinue())
        {
            if (routine != null)
                StopCoroutine(routine);
            img.sprite = sprites[4];
            ClickObject = true;
            ClickText = true;
        }
    }
}