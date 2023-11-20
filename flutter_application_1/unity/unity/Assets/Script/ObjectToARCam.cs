using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ObjectToARCam : MonoBehaviour
{
    [SerializeField]
    private Camera ARCamera;

    [SerializeField]
    private GameObject ObjectToRotate;

    // Update is called once per frame
    void Update()
    {
        //Vector3.Angle(new Vector3(0.0f, 0.0f, 1.0f), ARCamera.transform.forward);
        ObjectToRotate.transform.Rotate(new Vector3(0.0f, 1.0f, 0.0f),
            Vector3.Angle(new Vector3(0.0f, 0.0f, 1.0f), ARCamera.transform.forward));
    }
}

