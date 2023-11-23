using System.Collections;
using System.Collections.Generic;
using TMPro;
using Unity.XR.CoreUtils;
using UnityEngine;
using UnityEngine.SceneManagement;

public class EnvironmentDropdown : MonoBehaviour
{
    [SerializeField]
    private TMP_Dropdown environmentDropdown;

    public string[] listEnvironments;

    public void SetEnvironment(int selectedValue)
    {
        //do nothing if selected
        if (selectedValue == 0)
            return;

        SceneManager.LoadScene(listEnvironments[selectedValue], LoadSceneMode.Single);
    }
}
