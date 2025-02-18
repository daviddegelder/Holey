using System;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

public class Puzzle : MonoBehaviour
{
    private Hole[] holes;
    private bool isComplete = false;
    public Animator animator;

    private void Start()
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
}
