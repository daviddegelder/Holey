using UnityEngine;

public class FillRenderer : MonoBehaviour
{
    public float scalePerLevel = 0.2f;
    public void SetLevel(int level)
    {
        var scale = scalePerLevel * level;
        transform.localScale = Vector3.one * scale;
    }
}
