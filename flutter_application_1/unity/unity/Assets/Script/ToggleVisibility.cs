using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ToggleVisibility : MonoBehaviour
{
    [SerializeField]
    private GameObject objectToggle;

    public void Toggle()
    {
        objectToggle.SetActive(!objectToggle.activeSelf);
    }
}
