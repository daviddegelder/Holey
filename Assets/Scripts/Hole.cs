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
    
    //references
    public FillRenderer fillRenderer;

    private void Start()
    {
        //set_neighbours(neighbours);
    }

    private void Update()
    {
        var inputDirection = get_input_direction();
        if (inputDirection != Direction.Null)
        {
            Flow(inputDirection);
        }
        fillRenderer.SetLevel(fillLevel);
    }
    

    private void Flow(Direction direction)
    {
        if (fillLevel > 0 && has_neighbour(direction))
        {
            fillLevel -= 1;
            get_neighbour(direction).fillLevel += 1;
        }
    }
    
    private Direction get_input_direction()
    {
        Direction direction = Direction.Null;

        if (Input.GetKeyDown(KeyCode.Keypad5)) { direction = Direction.Null; }
        if (Input.GetKeyDown(KeyCode.Keypad8)) { direction = Direction.North; }
        if (Input.GetKeyDown(KeyCode.Keypad6)) { direction = Direction.East; }
        if (Input.GetKeyDown(KeyCode.Keypad2)) { direction = Direction.South; }
        if (Input.GetKeyDown(KeyCode.Keypad4)) { direction = Direction.West; }
        if (Input.GetKeyDown(KeyCode.Keypad9)) { direction = Direction.NorthEast; }
        if (Input.GetKeyDown(KeyCode.Keypad3)) { direction = Direction.SouthEast; }
        if (Input.GetKeyDown(KeyCode.Keypad1)) { direction = Direction.SouthWest; }
        if (Input.GetKeyDown(KeyCode.Keypad7)) { direction = Direction.NorthWest; }

        return direction;
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
