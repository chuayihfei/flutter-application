using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ToggleVisibility : MonoBehaviour
{
    [SerializeField]
    private GameObject objectToggle;

    public void Toggle(string str)
    {
        Debug.Log($"[log]Receieved flutter message: {str}");
        objectToggle.SetActive(!objectToggle.activeSelf);
    }
}
