using System;
using System.Linq;
using UnityEngine;

public class PuzzleManager : MonoBehaviour
{
    public Puzzle[] puzzles;
    private int currentPuzzleIndex = 0;
    private Puzzle currentPuzzle;

    private void Start()
    {
        foreach (var puzzle in puzzles)
        {
            puzzle.enabled = false;
        }
        StartPuzzle(0);
    }

    private void Update()
    {
        if (currentPuzzle.isComplete)
        {
            StartPuzzle(currentPuzzleIndex + 1);
        }
    }

    private void StartPuzzle(int index)
    {
        currentPuzzleIndex = index;
        currentPuzzle = puzzles[currentPuzzleIndex];
        currentPuzzle.enabled = true;
        currentPuzzle.animator.SetTrigger("Puzzle Enter");
    }
}
