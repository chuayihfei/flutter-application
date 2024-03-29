using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.XR.ARFoundation;
using UnityEngine.UIElements;
using UnityEngine.SceneManagement;
using FlutterUnityIntegration;

public class ImageTracking : MonoBehaviour
{
    private ARTrackedImageManager m_tImageManager;
    private ARSession m_Session;
    public string m_CheckedInPage;

    private UnityMessageManager Manager
    {
        get { return GetComponent<UnityMessageManager>(); }
    }

    private void Awake()
    {
        m_tImageManager = GetComponent<ARTrackedImageManager>();
    }

    private void OnEnable()
    {
        m_tImageManager.trackedImagesChanged += imageChanged;
    }
    private void OnDisable()
    {
        m_tImageManager.trackedImagesChanged -= imageChanged;
    }

    private void imageChanged(ARTrackedImagesChangedEventArgs eventArgs)
    {
        foreach (ARTrackedImage trackedImage in eventArgs.added)
        {
            sendName(trackedImage);
        }

        foreach (ARTrackedImage trackedImage in eventArgs.updated)
        {
            //sendName(trackedImage);
        }

        foreach (ARTrackedImage trackedImage in eventArgs.removed)
        {

        }
    }

    private void sendName(ARTrackedImage trackedImage)
    {
        Manager.SendMessageToFlutter(trackedImage.referenceImage.name);
    }

    public void ResetScene()
    {
        var xrManagerSettings = UnityEngine.XR.Management.XRGeneralSettings.Instance.Manager;
        xrManagerSettings.DeinitializeLoader();
        Debug.Log("Resetting Scene");
        SceneManager.LoadScene(SceneManager.GetActiveScene().name); // loads current scene
        xrManagerSettings.InitializeLoaderSync();
    }
}
