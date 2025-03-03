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
    private DirectionInput input;

    private void Awake()
    {
        holes = GetComponentsInChildren<Hole>();
        if (animator == null)
        {
            animator = GetComponent<Animator>();
        }
        
        input = FindAnyObjectByType<DirectionInput>();
        
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
        if (!completable && input.GetDirection() != Hole.Direction.Null)
        {
            return true;
        }
        
        return holes.All(hole => hole.fillLevel > 0);
    }

    public void SetCurrent(bool value)
    {
        current = value;
    }

    
    private void SetActive(bool active)
    {
        foreach (var hole in holes)
        {
            hole.enabled = active;
        }
    }

    // wrapper methods because animation events don't allow bool parameters.
    public void Activate()
    {
        SetActive(true);
    }
    public void Deactivate()
    {
        SetActive(false);
    }
}
