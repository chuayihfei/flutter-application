using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.AI;
using Unity.XR.CoreUtils;

public class getDistance : MonoBehaviour
{
    [SerializeField]
    private NavigationManager navigationManager;

    [SerializeField]
    private TMP_Text displayRemainingText;

    [SerializeField]
    private XROrigin arOrigin;

    private NavMeshPath path;

    // Update is called once per frame
    void Update()
    {
        path = navigationManager.CalculatedPath;
        //DisplayDistanceRemaining();

        getAngle();
    }

    private float GetPathDistance()
    {
        float distance = 0.0f;

        if (path.status != NavMeshPathStatus.PathInvalid)
        {
            for (int i = 1; i < path.corners.Length; i++)
            {
                distance += Vector3.Distance(path.corners[i - 1], path.corners[i]);
            }
        }

        return distance;
    }

    private void DisplayDistanceRemaining()
    {
        displayRemainingText.text = GetPathDistance().ToString("F2");

        displayRemainingText.text += " m";
    }

    private void getAngle()
    {
        if (path.status != NavMeshPathStatus.PathInvalid)
        {
            float angle = Vector3.Angle(path.corners[1] - arOrigin.Camera.transform.position, arOrigin.Camera.transform.forward);

            displayRemainingText.text = angle.ToString();
            //Debug.Log(angle);

            Debug.DrawLine(arOrigin.transform.position, path.corners[1], Color.blue);
            Debug.DrawRay(arOrigin.transform.position, arOrigin.Camera.transform.forward, Color.red);

            
            if (angle > 40.0f)
            {
                //vibrate until looking at line
                //Handheld.Vibrate();
            }
        }
    }

}
