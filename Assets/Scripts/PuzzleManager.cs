using System;
using System.Linq;
using Unity.VisualScripting;
using UnityEngine;
using UnityEngine.SceneManagement;

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
            puzzle.Deactivate();
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
        if (index >= puzzles.Length)
        {
            End();
            return;
        }
        currentPuzzleIndex = index;
        currentPuzzle = puzzles[currentPuzzleIndex];
        currentPuzzle.SetCurrent(true);
        currentPuzzle.animator.SetTrigger("Puzzle Enter");
    }

    private void End()
    {
        var scene = SceneManager.GetActiveScene().buildIndex;
        SceneManager.LoadScene(scene);
    }
}
