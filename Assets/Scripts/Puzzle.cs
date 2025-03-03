using System;
using System.Collections.Generic;
using System.Linq;
using Unity.VisualScripting;
using UnityEngine;

public class Puzzle : MonoBehaviour
{
    private Hole[] holes;
    
    public bool completable = true;
    public Animator animator;
    
    [HideInInspector]
    public bool current = false;

    private void Awake()
    {
        holes = GetComponentsInChildren<Hole>();
        if (animator == null)
        {
            animator = GetComponent<Animator>();
        }
    }

    private void Update()
    {
        if (IsComplete())
        {
            animator.SetTrigger("Puzzle Complete");
        }
    }

    public bool IsComplete()
    {
        if (!completable) return Input.anyKeyDown;
        
        return holes.All(hole => hole.fillLevel > 0);
    }

    public void SetCurrent(bool value)
    {
        current = value;
        SetActive(current);
    }

    public void SetActive(bool active)
    {
        foreach (var hole in holes)
        {
            hole.enabled = active;
        }
    }
}
