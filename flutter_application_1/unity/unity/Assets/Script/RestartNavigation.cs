using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.XR.ARFoundation;

public class RestartNavigation : MonoBehaviour
{
    [SerializeField]
    private ARSession session;

    public void RestartCurrentMap()
    {
        SceneManager.LoadScene(SceneManager.GetActiveScene().name); // loads current scene
        session.Reset();
    }
}
