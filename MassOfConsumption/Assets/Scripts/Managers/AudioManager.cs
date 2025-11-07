using System;
using System.Collections;
using System.Collections.Generic;
using DG.Tweening;
using UnityEngine;
using UnityEngine.Audio;
using UnityEngine.UI;

namespace AYellowpaper.SerializedCollections
{
    public class AudioManager : MonoBehaviour
    {
        public static AudioManager instance;

        [Header("Settings Volume")]
        public AudioMixer mixer;

        [SerializedDictionary("SFX name", "SFX")]
        public SerializedDictionary<string, AudioClip> SFXDictionary;
        [SerializeField] private AudioSource SFXSource;
        [SerializeField] private Transform SFXParent;
        private Dictionary<string, AudioSource> sources = new Dictionary<string, AudioSource>();

        private void Awake()
        {
            if (instance == null)
                instance = this;
            else
                Destroy(this.gameObject);

            DontDestroyOnLoad(gameObject);
        }

        private void Start()
        {
            GameManager.instance.Story.BindExternalFunction("PlaySFX", (string src, bool loop, float fade_in, float delay) =>
            {
                PlaySFX(src, loop, fade_in, delay);
            });

            GameManager.instance.Story.BindExternalFunction("StopSFX", (string src, float fade_out, float delay) =>
            {
                StopSFX(src, fade_out, delay);
            });
        }

        private void PlaySFX(string src, bool shouldLoop = false, float fadeIn = 0, float delay = 0)
        {
            if (SFXDictionary.ContainsKey(src) && !sources.ContainsKey(src))
            {
                var sfx = Instantiate(SFXSource, SFXParent);
                float kill_time = SFXDictionary[src].length + fadeIn + delay + 0.5f;

                sfx.clip = SFXDictionary[src];
                sfx.loop = shouldLoop;

                if (fadeIn > 0 || delay > 0)
                    StartCoroutine(FadeIn(sfx, fadeIn, delay));
                else
                    sfx.Play();

                //if it's looping, add it to the list, otherwise kill it after the kill timer
                if (shouldLoop)
                    sources.Add(src, sfx);
                else
                    Destroy(sfx.gameObject, kill_time);
            }
            else
                Debug.LogWarning($"Cannot Find SFX: {src}");
        }

        private void StopSFX(string src, float fadeOut = 0, float delay = 0)
        {
            if (SFXDictionary.ContainsKey(src) && sources.ContainsKey(src))
            {
                if (fadeOut > 0 || delay > 0)
                    StartCoroutine(FadeOut(sources[src], fadeOut, delay));
                else
                {
                    sources[src].Stop();
                    Destroy(sources[src].gameObject);
                }

                sources.Remove(src);
            }
        }

        private IEnumerator FadeIn(AudioSource src, float duration = 0, float delay = 0)
        {
            src.volume = 0;
            yield return new WaitForSeconds(delay);

            src.Play();
            src.DOFade(1, duration);
        }

        private IEnumerator FadeOut(AudioSource src, float duration = 0, float delay = 0)
        {
            yield return new WaitForSeconds(delay);

            src.DOFade(0, duration);

            yield return new WaitForSeconds(duration);
            src.Stop();
            Destroy(src.gameObject);
        }

        public void MuteAudio(int value)
        {
            mixer.SetFloat("master", Mathf.Log10(value) * 20);
            SaveSystem.SetAudioVolume(value, Audio.Mute);
        }

        public void AdjustBGM(float value)
        {
            mixer.SetFloat("bgm", Mathf.Log10(value) * 20);
            SaveSystem.SetAudioVolume(value, Audio.BGM);
        }

        public void AdjustSFX(float value)
        {
            mixer.SetFloat("sfx", Mathf.Log10(value) * 20);
            SaveSystem.SetAudioVolume(value, Audio.SFX);
        }
    }
}