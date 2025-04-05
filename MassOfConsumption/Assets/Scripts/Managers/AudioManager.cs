using System;
using System.Collections;
using System.Collections.Generic;
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
        public Slider sfxSlider, bgmSlider;
        public ToggleSwitchColorChange muteToggle;

        [SerializedDictionary("SFX name", "SFX")]
        public SerializedDictionary<string, AudioClip> SFXDictionary;
        [SerializeField] private AudioSource SFXSource;
        [SerializeField] private Transform SFXParent;
        private List<AudioSource> sources = new List<AudioSource>();

        private void Awake()
        {
            if (instance == null)
                instance = this;
            else
                Destroy(this.gameObject);

            DontDestroyOnLoad(gameObject);
        }

        void Start()
        {
            if (SaveSystem.GetMuteValue())
                muteToggle.SetValue();
            sfxSlider.value = SaveSystem.GetAudioVolume(3);
            bgmSlider.value = SaveSystem.GetAudioVolume(2);
        }

        public void PlaySFX(string src, bool shouldLoop = false, float fadeIn = 0, float delay = 0)
        {
            if (sources.Count > 0)
            {
                for (int i = 0; i < sources.Count; i++)
                {
                    if (sources[i].isPlaying && i + 1 < sources.Count)
                        continue;
                    else if (SFXDictionary.ContainsKey(src))
                        ;
                    {
                        var sfx = Instantiate(SFXSource, SFXParent);
                        sources.Add(sfx);
                        sfx.clip = SFXDictionary[src];
                        sfx.loop = shouldLoop;

                        if (fadeIn > 0 || delay > 0)
                            StartCoroutine(FadeIn(sfx, fadeIn, delay));
                        else
                            sfx.Play();
                        break;
                    }
                }
            }
            else if (SFXDictionary.ContainsKey(src))
                ;
            {
                var sfx = Instantiate(SFXSource, SFXParent);
                sources.Add(sfx);
                sfx.clip = SFXDictionary[src];
                sfx.loop = shouldLoop;

                if (fadeIn > 0 || delay > 0)
                    StartCoroutine(FadeIn(sfx, fadeIn, delay));
                else
                    sfx.Play();
            }
        }

        public void StopSFX(string src, float fadeOut = 0, float delay = 0)
        {
            for (int i = 0; i < sources.Count; i++)
            {
                if (sources[i].isPlaying && sources[i].loop && sources[i].clip.name == src)
                {
                    if (fadeOut > 0 || delay > 0)
                        StartCoroutine(FadeOut(sources[i], fadeOut, delay));
                    else
                    {
                        sources[i].Stop();
                        Destroy(sources[i].gameObject);
                        sources.RemoveAt(i);
                        break;
                    }
                }
                else
                    continue;
            }
        }

        private IEnumerator FadeIn(AudioSource src, float duration = 0, float delay = 0)
        {
            src.volume = 0;
            yield return new WaitForSeconds(delay);

            Mathf.Lerp(0, PlayerPrefs.GetFloat("SFXVolume"), duration);
        }

        private IEnumerator FadeOut(AudioSource src, float duration = 0, float delay = 0)
        {
            yield return new WaitForSeconds(delay);

            Mathf.Lerp(src.volume, 0, duration);

            yield return new WaitForSeconds(duration);
            src.Stop();
            sources.Remove(src);
            Destroy(src.gameObject);
        }

        public void MuteAudio(int value)
        {
            mixer.SetFloat("master", Mathf.Log10(value) * 20);
            SaveSystem.SetAudioVolume(value, 1);
        }

        public void AdjustBGM(float value)
        {
            mixer.SetFloat("bgm", Mathf.Log10(value) * 20);
            SaveSystem.SetAudioVolume(value, 2);
        }

        public void AdjustSFX(float value)
        {
            mixer.SetFloat("sfx", Mathf.Log10(value) * 20);
            SaveSystem.SetAudioVolume(value, 3);
        }
    }
}