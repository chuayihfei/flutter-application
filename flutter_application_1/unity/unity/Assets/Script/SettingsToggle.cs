using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SettingsToggle : MonoBehaviour
{
    [SerializeField]
    GameObject toActive;

    [SerializeField]
    GameObject toInactive1;

    [SerializeField]
    GameObject toInactive2;

    public void activeSetting(string message)
    {
        Debug.Log($"[log]Receieved flutter message: To activate {message}");

        if (!toActive.activeSelf)
            toActive.SetActive(true);
        else
            toActive.SetActive(false);

        toInactive1.SetActive(false);
        toInactive1.SetActive(false);
    }
}
