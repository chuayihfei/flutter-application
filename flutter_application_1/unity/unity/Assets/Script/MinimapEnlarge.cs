using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class MinimapEnlarge : MonoBehaviour
{
    [SerializeField]
    private GameObject MapRawImage;

    public void Start()
    {
        //scale larger map to screen size
        float scaleValue = Screen.height / MapRawImage.GetComponent<RectTransform>().rect.height;
        MapRawImage.transform.localScale = new Vector3(scaleValue, scaleValue, 1);
    }

}