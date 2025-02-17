using System.Collections.Generic;
using UnityEngine;

public class Hole : MonoBehaviour
{
    public enum Direction{
        North,
        NorthWest,
        West,
        SouthWest,
        South,
        SouthEast,
        East,
        NorthEast
    }

    public Dictionary<Direction, Hole> neighbours;
    
}
