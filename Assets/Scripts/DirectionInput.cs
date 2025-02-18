using UnityEngine;

public class DirectionInput : MonoBehaviour
{
    private Hole.Direction inputDirection = Hole.Direction.Null;
    
    void LateUpdate() {
        inputDirection = Hole.Direction.Null;
    }

    void OnNorth() {     inputDirection = Hole.Direction.North; }
    void OnNorthEast() { inputDirection = Hole.Direction.NorthEast; }
    void OnEast() {      inputDirection = Hole.Direction.East; }
    void OnSouthEast() { inputDirection = Hole.Direction.SouthEast; }
    void OnSouth() {     inputDirection = Hole.Direction.South; }
    void OnSouthWest() { inputDirection = Hole.Direction.SouthWest; }
    void OnWest() {      inputDirection = Hole.Direction.West; }
    void OnNorthWest() { inputDirection = Hole.Direction.NorthWest; }

    public Hole.Direction GetDirection()
    {
        return inputDirection;
    }
    
}
