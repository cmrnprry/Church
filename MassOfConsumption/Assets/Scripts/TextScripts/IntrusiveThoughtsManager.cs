using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using TMPro;

public class IntrusiveThoughtsManager : MonoBehaviour
{
    [SerializeField] private List<Transform> SpawnPoints;
    [SerializeField] private Transform Parent;
    private List<int> UsedPoints = new List<int>();
    [SerializeField] private GameObject Thought;

    public void SpawnThought(string text, string jump_to)
    {
        if (UsedPoints.Count >= SpawnPoints.Count)
        {
            IncreaseThought();
            return;
        }

        int index = Random.Range(0, SpawnPoints.Count);

        if (UsedPoints.Contains(index))
        {
            SpawnThought(text, jump_to);
            return;
        }

        UsedPoints.Add(index);
        var spawned_thought = Instantiate(Thought, SpawnPoints[index].position, Quaternion.identity, Parent);
        IntrusiveThought intrusive = spawned_thought.GetComponent<IntrusiveThought>();

        intrusive.SetTweens(text);
        intrusive.SetButtonCallback(jump_to);
    }

    public void KillAllThoughts(bool IsFromSave = false)
    {
        foreach (Transform child in Parent)
        {
            IntrusiveThought intrusive = child.gameObject.GetComponent<IntrusiveThought>();
            intrusive.KillAllThoughts();
        }

        UsedPoints.Clear();
        if (!IsFromSave)
        { SaveSystem.SetIntrusiveThroughts(new List<string>()); }
    }

    public void IncreaseThought()
    {
        foreach (Transform child in Parent)
        {
            IntrusiveThought intrusive = child.gameObject.GetComponent<IntrusiveThought>();
            intrusive.IncreaseTweens();
        }
    }
}