using Unity.VisualScripting;
using UnityEngine;

public class FillRenderer : MonoBehaviour
{
    public float scalePerLevel = 0.2f;
    public float lerpFactor= 0.1f;
    public SpriteRenderer background;
    public Color backgroundFilledColor;
    
    private float scale;
    private Color backgroundTargetColor;
    
    
    public void SetLevel(int level)
    {
        scale = Mathf.Lerp(scale, scalePerLevel * level, lerpFactor);
        transform.localScale = Vector3.one * scale;

        if (level > 0)
        {
            backgroundTargetColor = backgroundFilledColor;
        }
        else
        {
            backgroundTargetColor = Color.white;
        }

        background.color = Color.Lerp(background.color, backgroundTargetColor, lerpFactor);
    }
}
