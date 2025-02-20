using System;
using Unity.VisualScripting;
using UnityEngine;

public class FillRenderer : MonoBehaviour
{
    public float scalePerLevel = 0.2f;
    public float lerpFactor= 0.1f;
    public SpriteRenderer background;
    public Color backgroundFilledColor;
    
    private float scale;
    private float targetScale;
    private Color backgroundTargetColor;
    
    
    public void SetLevel(int level)
    {
        targetScale = scalePerLevel * level;

        if (level > 0)
        {
            backgroundTargetColor = backgroundFilledColor;
        }
        else
        {
            backgroundTargetColor = Color.white;
        }
    }

    public void Update()
    {
        background.color = Color.Lerp(background.color, backgroundTargetColor, lerpFactor);
        
        scale = Mathf.Lerp(scale,targetScale , lerpFactor);
        transform.localScale = Vector3.one * scale;
    }
    
}
