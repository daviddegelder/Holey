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
    
    private bool current = false;
    private bool active = false;
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
        if (!active) return false;
        
        if (!completable && input.GetDirection() != Hole.Direction.Null){
            return true;
        }
        
        if (holes.Length == 0) return false;
        return holes.All(hole => hole.fillLevel > 0);
    }

    public void SetCurrent(bool value)
    {
        current = value;
    }

    
    private void SetActive(bool value)
    {
        active = value;
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
