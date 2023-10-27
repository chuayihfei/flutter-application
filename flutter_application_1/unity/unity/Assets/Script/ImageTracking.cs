using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.XR.ARFoundation;
using UnityEngine.UIElements;
using UnityEngine.SceneManagement;

public class ImageTracking : MonoBehaviour
{
    private ARTrackedImageManager m_tImageManager;
    public string m_CheckedInPage;


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
            //updateScene(trackedImage);
        }

        foreach (ARTrackedImage trackedImage in eventArgs.updated)
        {
            //updateScene(trackedImage);
        }

        foreach (ARTrackedImage trackedImage in eventArgs.removed)
        {

        }
    }
}
