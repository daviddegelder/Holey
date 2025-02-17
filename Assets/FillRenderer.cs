using UnityEngine;

public class FillRenderer : MonoBehaviour
{
    public float scalePerLevel = 0.2f;
    public float lerpFactor= 0.1f;
    private float scale;
    public void SetLevel(int level)
    {
        scale = Mathf.Lerp(scale, scalePerLevel * level, lerpFactor);
        transform.localScale = Vector3.one * scale;
    }
}
