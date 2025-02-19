using System;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

public class Puzzle : MonoBehaviour
{
    private Hole[] holes;
    public bool isComplete = false;
    public Animator animator;

    private void Awake()
    {
        holes = GetComponentsInChildren<Hole>();
    }

    private void Update()
    {
        isComplete = true;
        
        foreach (var hole in holes)
        {
            if (hole.fillLevel == 0)
            {
                isComplete = false;
                break;
            }
        }

        if (isComplete)
        {
            animator.SetTrigger("Puzzle Complete");
        }
    }

    private void OnDisable()
    {
        foreach (var hole in holes)
        {
            hole.enabled = false;
        }
    }
    
    private void OnEnable()
    {
        foreach (var hole in holes)
        {
            hole.enabled = true;
        }
    }
}
