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
        DisplayDistanceRemaining();
    }

    private float GetPathDistance()
    {
        float distance = 0.0f;

        if (!navigationManager.ReachedDest)
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

}
