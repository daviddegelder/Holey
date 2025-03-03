using UnityEngine;

public class MultiHide : MonoBehaviour
{
    public GameObject[] objects;
    public bool visible;

    public void Show()
    {
        foreach (var i in objects)
        {
            i.SetActive(true);
        }
    }
    
    public void Hide()
    {
        foreach (var i in objects)
        {
            i.SetActive(false);
        }
    }

    public void SetVisible(bool _visible)
    {
        visible = _visible;
        
        if (visible)
        {
            Show();
        }
        else
        {
            Hide();
        }
    }

    public void Toggle()
    {
        SetVisible(!visible);
    }
}
