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

        [SerializedDictionary("BGM name", "BGM")]
        public SerializedDictionary<string, AudioClip> BGMDictionary;
        [SerializeField] private AudioSource BGMSource;
        [SerializeField] private Transform BGMParent;

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

            GameManager.instance.Story.BindExternalFunction("PlayBGM", (string src, bool loop, float fade_in, float fade_out) =>
            {
                PlayBGM(src, loop, fade_in, fade_out);
            });

            GameManager.instance.Story.BindExternalFunction("StopAll", () =>
            {
                KillAllAudio();
            });


            PlayBGM("generic", true, 1);
        }

        public void ResetAudio()
        {
            KillAllAudio();
            PlayBGM("generic", true, 1);
        }

        public void PlayBGM(string src, bool shouldLoop = false, float fadeIn = 0, float fade_out = 0)
        {
            if (BGMDictionary.ContainsKey(src) && !sources.ContainsKey(src))
            {
                var bgm = Instantiate(BGMSource, BGMParent);
                float kill_time = BGMDictionary[src].length + fadeIn + fade_out + 0.5f;

                bgm.clip = BGMDictionary[src];
                bgm.loop = shouldLoop;

                if (fadeIn > 0 || fade_out > 0)
                    StartCoroutine(FadeIn(bgm, fadeIn, fade_out, true));
                else
                    bgm.Play();

                //if it's looping, add it to the list, otherwise kill it after the kill timer
                if (shouldLoop)
                {
                    sources.Add(src, bgm);
                    var data = new PlayingAudioData(src, Audio.BGM, fadeIn, fade_out, 0);
                    SaveSystem.AddCurrentAudioPlaying(data);
                }
                else if (fade_out <= 0)
                    Destroy(bgm.gameObject, kill_time);
            }
            else
                Debug.LogWarning($"Cannot Find BGM: {src}");
        }

        public void PlaySFX(string src, bool shouldLoop = false, float fadeIn = 0, float delay = 0)
        {
            if (src == "leak")
            {
                var rand = UnityEngine.Random.Range(1, 6);
                src = $"leak_{rand}";
            }

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
                {
                    sources.Add(src, sfx);
                    var data = new PlayingAudioData(src, Audio.SFX, fadeIn, 0, delay);
                    SaveSystem.AddCurrentAudioPlaying(data);
                }
                else
                    Destroy(sfx.gameObject, kill_time);
            }
            else
                Debug.LogWarning($"Cannot Find SFX: {src}");
        }

        private void StopSFX(string src, float fadeOut = 0, float delay = 0)
        {
            if ((SFXDictionary.ContainsKey(src) || BGMDictionary.ContainsKey(src)) && sources.ContainsKey(src))
            {
                if (fadeOut > 0 || delay > 0)
                    StartCoroutine(FadeOut(sources[src], fadeOut, delay));
                else if (sources[src] != null)
                {
                    sources[src].Stop();
                    Destroy(sources[src].gameObject);
                }

                sources.Remove(src);
                SaveSystem.RemoveCurrentAudioPlaying(src);
            }
        }

        public void KillAllAudio()
        {
            var copy = sources;
            foreach (KeyValuePair<string, AudioSource> src in copy)
            {
                if (sources[src.Key] != null)
                {
                    sources[src.Key].DOFade(0, 0.5f).SetEase(Ease.InSine).OnComplete(() =>
                    {
                        Destroy(sources[src.Key].gameObject);
                        sources.Remove(src.Key);
                    });

                }

                SaveSystem.RemoveCurrentAudioPlaying(src.Key);
            }
        }

        private IEnumerator FadeIn(AudioSource src, float duration = 0, float delay = 0, bool isBGM = false)
        {
            src.volume = 0;
            if (!isBGM)
                yield return new WaitForSeconds(delay);

            if (src != null)
            {
                src.Play();
                src.DOFade(1, duration).SetEase(Ease.InSine);
            }


            if (isBGM && delay > 0)
            {
                yield return new WaitForSeconds(duration);
                StartCoroutine(FadeOut(src, delay));
            }

        }

        private IEnumerator FadeOut(AudioSource src, float duration = 0, float delay = 0)
        {
            yield return new WaitForSeconds(delay);

            if (src != null)
                src.DOFade(0, duration).SetEase(Ease.InSine);

            yield return new WaitForSeconds(duration);

            if (src != null)
            {
                src.Stop();
                Destroy(src.gameObject);
            }
        }

        public void MuteAudio(float value)
        {
            if (value == 0)
                value = 0.001f;

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