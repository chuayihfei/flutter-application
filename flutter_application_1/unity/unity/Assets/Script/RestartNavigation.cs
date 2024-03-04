using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.XR.ARFoundation;

public class RestartNavigation : MonoBehaviour
{
    [SerializeField]
    private ARSession session;

    public void RestartCurrentMap(string message)
    {
        Debug.Log($"[log]: Recieved message to {message}");
        SceneManager.LoadScene(SceneManager.GetActiveScene().name); // loads current scene
        session.Reset();
    }
}
