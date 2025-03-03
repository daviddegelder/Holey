using System;
using System.Linq;
using UnityEngine;

public class PuzzleManager : MonoBehaviour
{
    public Puzzle[] puzzles;
    public int currentPuzzleIndex = 0;
    public Puzzle currentPuzzle;

    private void Start()
    {
        foreach (var puzzle in puzzles)
        {
            puzzle.SetCurrent(false);
        }
        StartPuzzle(0);
    }

    private void Update()
    {
        if (currentPuzzle.IsComplete())
        {
            currentPuzzle.SetCurrent(false);
            StartPuzzle(currentPuzzleIndex + 1);
        }
    }

    private void StartPuzzle(int index)
    {
        currentPuzzleIndex = index % puzzles.Length;
        currentPuzzle = puzzles[currentPuzzleIndex];
        currentPuzzle.SetCurrent(true);
        currentPuzzle.animator.SetTrigger("Puzzle Enter");
    }
}
