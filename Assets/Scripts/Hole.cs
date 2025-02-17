using System;
using System.Collections.Generic;
using UnityEngine;

public class Hole : MonoBehaviour
{
    //enums and structs and stuff
    public enum Direction
    {
        North,
        NorthEast,
        East,
        SouthEast,
        South,
        SouthWest,
        West,
        NorthWest,
        Null,
    }
    [System.Serializable] public struct Neighbours
    {
        public Hole north;
        public Hole northEast;
        public Hole east;
        public Hole southEast;
        public Hole south;
        public Hole southWest;
        public Hole west;
        public Hole northWest;
    }

    //private Variables
    private Dictionary<Direction, Hole> neighbourDict;
    
    //public Variables
    public Neighbours neighbours;
    public int fillLevel = 0;

    private void Start()
    {
        //set_neighbours(neighbours);
    }
    }

    private Hole get_neighbour(Direction direction)
    {
        //return neighbourDict[direction];
        return direction switch
        {
            Direction.North     => neighbours.north,
            Direction.NorthEast => neighbours.northEast,
            Direction.East      => neighbours.east,
            Direction.SouthEast => neighbours.southEast,
            Direction.South     => neighbours.south,
            Direction.SouthWest => neighbours.southWest,
            Direction.West      => neighbours.west,
            Direction.NorthWest => neighbours.northWest,
            _ => null
        };
    }

    private bool has_neighbour(Direction direction)
    {
        return get_neighbour(direction) != null;
    }

    private void set_neighbours(Neighbours neighbourStruct)
    {
        neighbourDict[Direction.North]     = neighbourStruct.north;
        neighbourDict[Direction.NorthEast] = neighbourStruct.northEast;
        neighbourDict[Direction.East]      = neighbourStruct.east;
        neighbourDict[Direction.SouthEast] = neighbourStruct.southEast;
        neighbourDict[Direction.South]     = neighbourStruct.south;
        neighbourDict[Direction.SouthWest] = neighbourStruct.southWest;
        neighbourDict[Direction.West]      = neighbourStruct.west;
        neighbourDict[Direction.NorthWest] = neighbourStruct.northWest;

    }
    
    
}
